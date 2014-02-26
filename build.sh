#!/bin/bash
VERSION=$1

GRADLE_PROPERTIES="gradle.properties"

sed -i "" "s/^version=.*/version=$VERSION/g" $GRADLE_PROPERTIES

./gradlew clean
./gradlew test
./gradlew jar

echo "====Start Maven Package===="
mvn assembly:single
echo "====End Maven Package===="