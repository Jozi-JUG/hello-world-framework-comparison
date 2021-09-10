#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 21.1.0.r16-grl
./mvnw package -Pnative -Dquarkus.native.container-build=true