#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 16.0.1-zulu
java -Xmx50M -Xms50M -jar ./target/springboot-0.0.1-SNAPSHOT.jar
