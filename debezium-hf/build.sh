#!/usr/bin/env bash

set -e

DEBEZIUM_VERSION=1.7.2

cd "$(pwd)"/..

rm -rf debezium-ddl-parser/target

mvn clean package -DskipITs -DskipTests -Passembly,oracle -pl :debezium-server-dist -am

docker build -f debezium-hf/Dockerfile . -t "cdps-debezium:$DEBEZIUM_VERSION"

aws ecr get-login-password --region eu-west-1 --profile sso-hf-it-developer | docker login --username AWS --password-stdin https://489198589229.dkr.ecr.eu-west-1.amazonaws.com

docker tag "cdps-debezium:$DEBEZIUM_VERSION" 489198589229.dkr.ecr.eu-west-1.amazonaws.com/customer-delivery-planning-service:cdps-debezium-$DEBEZIUM_VERSION

docker push 489198589229.dkr.ecr.eu-west-1.amazonaws.com/customer-delivery-planning-service:cdps-debezium-$DEBEZIUM_VERSION