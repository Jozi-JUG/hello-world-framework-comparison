#!/usr/bin/env bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install maven 3.8.1
sdk install java 16.0.1-zulu
sdk install java 21.1.0.r11-grl
sdk use java 21.1.0.r11-grl
gu install native-image
