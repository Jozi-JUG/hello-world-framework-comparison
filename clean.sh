#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 16.0.1-zulu
pushd helidon
mvn clean
popd
pushd micronaut
mvn clean
popd
pushd quarkusnative
mvn clean
popd
pushd quarkusvm
mvn clean
popd
pushd springboot
mvn clean
popd
pushd springaot
mvn clean
popd
pushd springnative
mvn clean
popd
pushd ktor
gradlew clean
popd