#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters. Must pass 2 parameters:"
    echo "First parameter indicates build steps to skip as follows:"
    echo "libs      - To skip building libraries before deploying"
    echo "services  - To skip building services before deploying"
    echo "conductor - To skip building conductor before deploying"
    echo "all       - To skip all building including the deployable itself"
    echo "none      - To include all steps in the build"
    echo -e "E.g. to skip all building and just package and deploy, pass param 1 as libs-services-conductor\n"

    echo "Second parameter indicates mode as follows:"
    echo "bbbuild-ecs           - Will commit to bitbucket which will do a build and deploy in ECS to run at https://<reponame>-<branchname>.jini.rocks/ (note that param 1 is ignored for this option)"
    echo "localbuild-ecs        - Will build locally and deploy in ECS to run at https://<reponame>-<branchname>.jini.rocks/"
    echo "localbuild-push       - Will build locally and push to ECR"
    echo "localbuild-run        - Will build locally and run without hot reloads. Can be accessed over https://<something>.backdraft.jini.rocks/ as printed out after startup"
    echo "localtest             - Will build and test the deployable locally"
    exit 1
fi


SKIP=$1
MODE=$2
export SKIPTLS=true
build () {
    /tmp/bitbucket_pipeline_service $SKIP
}


case $MODE in

  bbbuild-ecs)
    git add --all
    echo -n "Please enter a description for this commit:"
    read MSG
    git commit -m"$MSG"
    ;;

  localbuild-ecs)
    export REPO=eclipse    
    build
    ;;

  localbuild-push)
    export REPO=eclipse    
    export ECRURL=831776913662.dkr.ecr.eu-west-1.amazonaws.com
    export SKIPECS=true
    build
    ;;

  localtest)
    export REPO=""
    build
    ;;

  run)
    export REPO=""
    if [ "$HC_DISABLED" = "" ]; then
        export HC_DISABLED=false
    fi
    export NON_PROD=true
    if [ "$SKIPJAEGER" != "true" ]; then
        if [ "$JAEGERNAME" = "" ]; then
            export JAEGERNAME=Eclipse
        fi
        if [ "$JAEGERHOSTPORT" = "" ]; then
            export JAEGERHOSTPORT=localhost:6831
            JAEGERRUNNING=$(docker ps | grep jaegertracing)
            if [ "$JAEGERRUNNING" = "" ]; then
                echo "Starting Jaeger"
                docker run -d --net=host jaegertracing/all-in-one:latest
            fi
            echo "Local Jaeger is running so you can see traces at http://localhost:16686/"
            fi
    fi

    /tmp/quarkus_run.sh true
    ;;


  localbuild-run)
    export REPO=""
    if [ "$HC_DISABLED" = "" ]; then
        export HC_DISABLED=false
    fi
    export NON_PROD=true
    if [ "$SKIPJAEGER" != "true" ]; then
        if [ "$JAEGERNAME" = "" ]; then
            export JAEGERNAME=Eclipse
        fi
        if [ "$JAEGERHOSTPORT" = "" ]; then
            export JAEGERHOSTPORT=localhost:6831
            JAEGERRUNNING=$(docker ps | grep jaegertracing)
            if [ "$JAEGERRUNNING" = "" ]; then
                echo "Starting Jaeger"
                docker run -d --net=host jaegertracing/all-in-one:latest
            fi
            echo "Local Jaeger is running so you can see traces at http://localhost:16686/"
	    fi    
    fi
    build
    if [ $? -ne 0 ]; then
        echo "Build failure"
        exit 1
    fi
    curl -s -o /tmp/quarkus_run.sh https://jg-public.s3-eu-west-1.amazonaws.com/quarkus_run; chmod +x /tmp/quarkus_run.sh

    /tmp/quarkus_run.sh true
    ;;

  *)
    echo "Invalid mode $MODE";
    exit 1;
    ;;
esac

