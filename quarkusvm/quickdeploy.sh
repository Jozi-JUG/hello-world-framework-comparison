export EXTRAOPTS="-Xmx2G -DHC_DISABLED=true"
export SKIPJAEGER=true
export MVNPARAMS="-DskipTests"
export LISTENPORT=8001
export TLSLISTENPORT=8444
export DBTYPE=none
export NOJSONLOGGING=ignore
./deploy.sh libs-services-conductor localbuild-run
