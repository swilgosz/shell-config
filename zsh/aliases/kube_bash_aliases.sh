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

# Logs in you to sidekiq pod for given namespace.
# Usage:
#   1. Generate Kubernetes Token for remote cluster.
#   2. Get namespace you want to login into: `kubectl get namespaces` (example: e2e-reporting)
#   3. klogin e2e-reporting
klogin() {
  a="$1";
  kubectl get pods -n "$a" | awk -v ns="$a" '$1 ~ "^" ns "-sidekiq" {print $1}' | \
  xargs -oI {} kubectl exec -c main -n "$1" -it {} -- sh
}

alias kubectl="$HOME/bin/kubectl"
