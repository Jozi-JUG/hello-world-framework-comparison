#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 21.2.0.r11-grl
mvn -e package -Pnative