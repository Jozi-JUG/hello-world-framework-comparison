#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 8.0.292-zulu
java -Xmx50M -Xms30M -jar ./build/libs/ktorvm-0.0.1-all.jar