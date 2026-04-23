#!/bin/sh

NAMESPACE="backstage"

if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  kubectl create namespace "$NAMESPACE"
else
  echo "El namespace $NAMESPACE ya existe"
fi

kubectl delete secret google-secrets -n $NAMESPACE

kubectl create secret generic -n $NAMESPACE google-secrets \
  --from-literal=AUTH_GOOGLE_CLIENT_ID="$AUTH_GOOGLE_CLIENT_ID" \
  --from-literal=AUTH_GOOGLE_CLIENT_SECRET="$AUTH_GOOGLE_CLIENT_SECRET" \
  --from-literal=GCS_CLIENT_EMAIL="$GCS_CLIENT_EMAIL" \
  --from-literal=GCS_PRIVATE_KEY="$GCS_PRIVATE_KEY" \
  --from-literal=GITHUB_TOKEN="$GITHUB_TOKEN"

kubectl delete secret ghcr-secret -n $NAMESPACE

kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=$USER \
  --docker-password=$GITHUB_TOKEN_ACTIONS \
  -n $NAMESPACE