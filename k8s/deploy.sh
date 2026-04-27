#!/bin/bash

set -e

NAMESPACE=backstage
APP_NAME=backstage
export IMAGE=$1

echo "🚀 Deploying $APP_NAME with image $IMAGE"

# 1. Aplicar recursos estáticos (solo si cambian)
echo "📦 Applying base resources (service, ingress...)"
kubectl apply -f k8s/manifests

# 2. Actualizar solo la imagen del deployment
echo "🔄 Updating deployment image"
envsubst < k8s/deployment/deployment.yaml | kubectl apply -n $NAMESPACE -f -

# 3. Esperar rollout
echo "⏳ Waiting for rollout"
kubectl rollout status deployment/$APP_NAME -n $NAMESPACE

echo "✅ Deployment successful"