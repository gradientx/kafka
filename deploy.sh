#!/bin/bash
GROUP_ID=$1
ARTIFACT_ID=$2
VERSION=$3
IS_RELEASE=$4

PACKAGING_JAR=jar
PACKAGING_TAG_GZ=tar.gz
PROJECT=$ARTIFACT_ID-$VERSION

mvn install:install-file \
  -DpomFile = core/build/pom.xml \
  -Dfile=core/build/libs/$PROJECT.$PACKAGING_JAR

mvn install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID-distribution \
  -Dversion=$VERSION \
  -Dpackaging=$PACKAGING_TAG_GZ \
  -Dfile=target/$PROJECT-distribution.$PACKAGING_TAG_GZ

if [ $IS_RELEASE == "true" ]; then
    mvn deploy:deploy-file \
      -DpomFile = core/build/pom.xml \
      -Dfile=core/build/libs/$PROJECT.$PACKAGING_JAR \
      -DrepositoryId=gradientx-release-repo \
      -Durl=http://artifactory.gradientx.com:8081/artifactory/libs-release-local

    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID-distribution \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING_TAG_GZ \
      -Dfile=target/$PROJECT-distribution.$PACKAGING_TAG_GZ \
      -DrepositoryId=gradientx-release-repo \
      -Durl=http://artifactory.gradientx.com:8081/artifactory/libs-release-local
else
    mvn deploy:deploy-file \
      -DpomFile = core/build/pom.xml \
      -Dfile=core/build/libs/$PROJECT.$PACKAGING_JAR \
      -DrepositoryId=gradientx-snapshot-repo \
      -Durl=http://stage-artifactory001.ae1i.gradientx.com:8081/artifactory/libs-snapshot-local

    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID-distribution \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING_TAG_GZ \
      -Dfile=target/$PROJECT-distribution.$PACKAGING_TAG_GZ \
      -DrepositoryId=gradientx-snapshot-repo \
      -Durl=http://stage-artifactory001.ae1i.gradientx.com:8081/artifactory/libs-snapshot-local
fi