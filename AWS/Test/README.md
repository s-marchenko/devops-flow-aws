curl -s 'http://prometheus.cluster1.regtoken.co/api/v1/query?query=up\{job="kubernetes_nodes"\}' | jq .data.result[].metric
curl -s 'http://prometheus.cluster1.regtoken.co/api/v1/query?query=targets\{job="kubernetes_nodes"\}' | jq .data.result[].metric


http://prometheus.cluster1.regtoken.co/api/v1/query?query=targets


metadata