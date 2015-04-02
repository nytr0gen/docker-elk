# Elasticsearch Logstash Kibana

Elasticsearch, Logstash and Kibana stack. Lightweight.


You can check it out by running the following commands
'''
docker run -ti -p 80:5601 -p 28777:28777 vulpe03/elk
echo 'message2' | nc -w 1 localhost 28777
'''

But I would recommend using a nginx or haproxy and securing it with an auth. Also change the logger ports 
