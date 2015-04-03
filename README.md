# Elasticsearch Logstash Kibana

Elasticsearch, Logstash and Kibana stack. Lightweight.

> Elasticsearch 1.4.4
> Kibana 4.0.1
> Logstash 1.4.2

You can check it out by running the following commands
```
docker run -ti -p 127.0.0.1:5601:5601 -p 28777:28777 vulpe03/elk
echo 'message2' | nc -w 1 localhost 28777
```

But I would recommend using a nginx or haproxy and securing it with an auth. Also change the logger port forwarding from 28777 to something as big.
