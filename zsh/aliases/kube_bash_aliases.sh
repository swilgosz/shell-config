# List environment vars (stored in secret), e.g. env app
env(){
  kubectl get secret $1-secret -o json | jq '.data | map_values(@base64d)'
}

# Set environment var, e.g. envset app VAR_NAME value
envset(){
  kubectl get secret $1-secret -o json | jq --arg foo "$(echo -n $3 | base64)" '.data["'"$2"'"]=$foo' | kubectl apply -f -
}

# Remove environment var, e.g. envrem app VAR_NAME
envrem(){
  kubectl get secret $1-secret -o json | jq 'del(.data."'$2'")' | kubectl apply -f -
}

# restart component in given deployment, e.g. res app server
res(){
  kubectl patch deployment $1-deployment -p '{"spec":{"template":{"spec":{"containers":[{"name":"$2","env":[{"name":"LAST_MANUAL_RESTART","value":"'$(date +%s)'"}]}]}}}}'
}


alias kubectl="$HOME/bin/kubectl"
