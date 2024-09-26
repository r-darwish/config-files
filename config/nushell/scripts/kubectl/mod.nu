export def get-pods [] {
    kubectl get pods | from ssv
}

export def restart-broken-pods [] {
    get-pods | where STATUS =~ "(Error|Crash)" | get name | kubectl delete pod ...$in
}
