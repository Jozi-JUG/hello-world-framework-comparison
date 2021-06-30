#!/bin/bash

run=1
trap shutdown SIGHUP SIGINT SIGTERM SIGABRT SIGUSR1 SIGUSR2 SIGQUIT
function shutdown {
run=0
}
ulimit -n 10000
DURATION=2
CONC=100

for i in {1..10}
do
if [ $run = 1 ]; then

    
    wrk -d$DURATION -t5 -c$CONC "http://localhost:9001/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(jps|grep quarkusvm|awk '{print $1}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Quarkus HS     : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"

    wrk -d$DURATION -t5 -c$CONC "http://localhost:9002/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(jps|grep springboot|awk '{print $1}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "SpringBoot HS  : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"

    wrk -d$DURATION -t5 -c$CONC "http://localhost:9004/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(jps|grep micronaut|awk '{print $1}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Micronaut HS   : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"


    wrk -d$DURATION -t5 -c$CONC "http://localhost:9005/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(ps -ef|grep quarkusnative | grep -v grep| awk '{print $2}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Quarkus Native : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"

    wrk -d$DURATION -t5 -c$CONC "http://localhost:9006/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(jps|grep helidon|awk '{print $1}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Helidon HS     : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"
	
  	wrk -d$DURATION -t5 -c$CONC "http://localhost:9007/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(jps|grep springaot|awk '{print $1}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Spring AOT     : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"

    wrk -d$DURATION -t5 -c$CONC "http://localhost:9008/" > /tmp/wrk
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.$1f" "$RPS")
    PID=$(ps -ef|grep springnative|grep -v grep|awk '{print $2}')
    RSSKB=$(cat /proc/$PID/status| grep VmRSS | awk '{print $2}')
    RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
    RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
    echo -e "Spring Native  : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"

    echo ""
fi
done


