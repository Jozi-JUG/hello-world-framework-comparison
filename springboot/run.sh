#!/usr/bin/env bash
source ~/.sdkman/bin/sdkman-init.sh
sdk use java 16.0.1-zulu
java -Xmx64M -Xms64M -jar ./target/springboot-0.0.1-SNAPSHOT.jar