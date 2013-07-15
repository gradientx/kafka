#!/bin/bash
mvn deploy:deploy-file -DpomFile=core/target/scala-2.8.0/kafka_2.8.0-0.8.0-SNAPSHOT.pom \
-Dfile=core/target/scala-2.8.0/kafka_2.8.0-0.8.0-SNAPSHOT.jar \
-DrepositoryId=gradientx-snapshot-repo \
-Durl=s3://codex.corp.gradientx.com/maven/snapshot
