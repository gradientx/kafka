#!/bin/bash
GROUP_ID=$1
ARTIFACT_ID=$2
VERSION=$3
PACKAGING=$4
IS_RELEASE=$5

PROJECT=$ARTIFACT_ID-$VERSION

mvn install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID \
  -Dversion=$VERSION \
  -Dpackaging=$PACKAGING \
  -DgeneratePom=true \
  -Dfile=core/build/libs/$PROJECT.jar

mvn install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID-distribution \
  -Dversion=$VERSION \
  -Dpackaging=$PACKAGING \
  -Dfile=target/$PROJECT-distribution.$PACKAGING

if [ $IS_RELEASE == "true" ]; then
    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING \
      -DgeneratePom=true \
      -Dfile=core/build/libs/$PROJECT.jar \
      -DrepositoryId=gradientx-release-repo \
      -Durl=http://artifactory.gradientx.com:8081/artifactory/libs-release-local

    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID-distribution \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING \
      -Dfile=target/$PROJECT-distribution.$PACKAGING \
      -DrepositoryId=gradientx-release-repo \
      -Durl=http://artifactory.gradientx.com:8081/artifactory/libs-release-local
else
    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING \
      -DgeneratePom=true \
      -Dfile=core/build/libs/$PROJECT.jar \
      -DrepositoryId=gradientx-snapshot-repo \
      -Durl=http://stage-artifactory001.ae1i.gradientx.com:8081/artifactory/libs-snapshot-local

    mvn deploy:deploy-file \
      -DgroupId=$GROUP_ID \
      -DartifactId=$ARTIFACT_ID-distribution \
      -Dversion=$VERSION \
      -Dpackaging=$PACKAGING \
      -Dfile=target/$PROJECT-distribution.$PACKAGING \
      -DrepositoryId=gradientx-snapshot-repo \
      -Durl=http://stage-artifactory001.ae1i.gradientx.com:8081/artifactory/libs-snapshot-local
fi