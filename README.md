# Elasticsearch Logstash Kibana

Elasticsearch, Logstash and Kibana stack. Lightweight.

> Elasticsearch 1.6.0
> Kibana 4.1.0
> Logstash 1.5.1
> Elastic Curator

You can check it out by running the following commands
```bash
docker run -p 127.0.0.1:5601:5601 -p 25432:28777 vulpe03/elk
echo 'message2' | nc -w 1 localhost 28777
```

But I would recommend using a nginx or haproxy and securing it with an auth. Also change the logger port forwarding from 28777 to something as big.

For persistent elasticsearch data use
```bash
docker run -v /opt/elasticsearch/data:/opt/elasticsearch/data -p 127.0.0.1:5601:5601 -p 25432:28777 vulpe03/elk
```

I also added a script for curating logstash every 1 day
```bash
docker run -e CURATOR_CRON=true vulpe03/elk
```

You can replace my curator_clean.sh with your own doing something like this with your Dockerfile
```dockerfile
FROM vulpe03/elk
COPY your_curator_cron.sh /opt/curator_cron.sh
```
