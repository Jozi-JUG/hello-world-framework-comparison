#!/usr/bin/env bash
ulimit -n 10000
DURATION=20
CONC=100
TESTS=100

function measure_jvm() {
  name=$1
  process=$2
  url=$3
  
  wrk -d$DURATION -t5 -c$CONC "$url" > /tmp/wrk
  result=$?
  if [ $result -eq 0 ]
  then
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.1f" "$RPS")
    PID=$(jps | grep "$process" | awk '{print $1}')
    if [ $PID -ne 0 ]
    then
      RSSKB=$(cat /proc/$PID/status | grep VmRSS | awk '{print $2}')
      RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
      RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
      echo -e "$name : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"
    fi
  fi
}

function measure_ntv() {
  name=$1
  process=$2
  url=$3
  
  wrk -d$DURATION -t5 -c$CONC "$url" > /tmp/wrk
  result=$?
  if [ $result -eq 0 ]
  then
    RPS=$(grep "Requests/sec:" /tmp/wrk | awk '{print $2}')
    RPS=$(printf "%0.1f" "$RPS")
    PID=$(ps -ef|grep "$process" | grep -v grep| awk '{print $2}')
    if [ $PID -ne 0 ]
    then
      RSSKB=$(cat /proc/$PID/status | grep VmRSS | awk '{print $2}')
      RSSMB=$(echo "scale=1 ; $RSSKB / 1024" | bc)
      RPS_PER_MB=$(echo "scale=0 ; $RPS / $RSSMB" | bc)
      echo -e "$name : $(printf "%8.8s\n" "$RPS") requests per second consuming $(printf "%6.6s\n" "$RSSMB") MB RSS, equating to $(printf "%5.5s\n" "$RPS_PER_MB") RPS/MB"
    fi
  fi
}

run=1
trap shutdown SIGHUP SIGINT SIGTERM SIGABRT SIGUSR1 SIGUSR2 SIGQUIT
function shutdown {
run=0
}

for i in {1..$TESTS}
do
if [ $run = 1 ]; then

    measure_jvm "Quarkus HS     " "quarkusvm"     "http://localhost:9001/"
    measure_jvm "SpringBoot HS  " "springboot"    "http://localhost:9002/"
    measure_jvm "Micronaut HS   " "micronaut"     "http://localhost:9004/"
    measure_jvm "Helidon HS     " "helidon"       "http://localhost:9006/"
    measure_jvm "Spring AOT     " "springaot"     "http://localhost:9007/"
    measure_jvm "Ktor           " "ktorvm"        "http://localhost:9009/"
    measure_ntv "Quarkus Native " "quarkusnative" "http://localhost:9005/"
    measure_ntv "Spring Native  " "springnative"  "http://localhost:9008/"
    measure_ntv "Ktor Native    " "ktornative"    "http://localhost:9010/"

    echo ""
fi
done


