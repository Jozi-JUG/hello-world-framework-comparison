#!/usr/bin/env bash
source ~/.sdkman/bin/sdkman-init.sh
sdk use java 21.1.0.r11-grl
mvn -e package -Pnative