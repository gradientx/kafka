#!/bin/bash
./sbt package make-pom
mvn deploy:deploy-file -DpomFile=core/target/scala-2.8.0/kafka_2.8.0-0.8.1-SNAPSHOT.pom \
-Dfile=core/target/scala-2.8.0/kafka_2.8.0-0.8.1-SNAPSHOT.jar \
-DrepositoryId=gradientx-snapshot-repo \
-Durl=s3://prod.codex.gradientx.com/maven/snapshot
