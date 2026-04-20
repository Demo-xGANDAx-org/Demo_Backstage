kubectl delete secret google-secrets -n backstage

kubectl create secret generic -n backstage google-secrets \
  --from-literal=AUTH_GOOGLE_CLIENT_ID='$AUTH_GOOGLE_CLIENT_ID' \
  --from-literal=AUTH_GOOGLE_CLIENT_SECRET='$AUTH_GOOGLE_CLIENT_SECRET' \
  --from-literal=GCS_CLIENT_EMAIL='$GCS_CLIENT_EMAIL' \
  --from-literal=GCS_PRIVATE_KEY='$GCS_PRIVATE_KEY'

