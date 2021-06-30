#!/usr/bin/env bash
pushd helidon
call ./build.sh
popd
pushd micronaut
call ./build.sh
popd
pushd quarkusnative
call ./build.sh
popd
pushd quarkusvm
call ./build.sh
popd
pushd springboot
call ./build.sh
popd
pushd springaot
call ./build.sh
popd
pushd springnative
call ./build.sh
popd