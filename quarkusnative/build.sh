#!/usr/bin/env bash
source ~/.sdkman/bin/sdkman-init.sh
sdk use java 16.0.1-zulu
./mvnw package -Pnative -Dquarkus.native.container-build=true