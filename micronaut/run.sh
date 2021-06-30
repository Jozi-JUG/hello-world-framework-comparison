#!/usr/bin/env bash
source ~/.sdkman/bin/sdkman-init.sh
sdk use java 16.0.1-zulu
java -Xmx30M -Xms30M -jar ./target/micronaut-0.1.jar