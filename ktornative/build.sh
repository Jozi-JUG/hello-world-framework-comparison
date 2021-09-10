#!/usr/bin/env bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 21.2.0.r8-grl
./gradlew assemble
native-image --no-fallback --enable-all-security-services \
  --report-unsupported-elements-at-runtime \
  --install-exit-handlers --allow-incomplete-classpath  \
  --initialize-at-build-time=io.ktor,kotlinx,kotlin,org.slf4j,ch.qos.logback \
  -H:+ReportUnsupportedElementsAtRuntime \
  -H:+ReportExceptionStackTraces \
  -H:ReflectionConfigurationFiles=./reflection.json \
  -cp ./build/libs/ktornative-0.0.1-all.jar -H:Class=com.example.ApplicationKt -H:Name=build/ktornative