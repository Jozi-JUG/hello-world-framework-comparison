#!/usr/bin/env bash
pushd helidon
bash ./build.sh
popd
pushd micronaut
bash ./build.sh
popd
pushd quarkusnative
bash ./build.sh
popd
pushd quarkusvm
bash ./build.sh
popd
pushd springboot
bash ./build.sh
popd
pushd springaot
bash ./build.sh
popd
pushd springnative
bash ./build.sh
popd
pushd ktor
bash ./build.sh
popd