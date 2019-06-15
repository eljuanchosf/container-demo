#! /usr/bin/env bash

fly --target tutorial set-pipeline --pipeline test-deploy --config test-deploy-pipeline.yml \
    --var "kubernetes-user-token=$(cat $HOME/work/user.token)" \
    --var "kubernetes-user-cert=$(cat $HOME/work/ca.crt)" \
    --var "kubernetes-api-server=$(cat $HOME/work/kubeurl)" \
    --var "dockerhub-id=$DOCKER_REPO" \
		--var "dockerhub-username=$DOCKER_USERNAME" \
		--var "dockerhub-password=$DOCKER_PASSWORD"