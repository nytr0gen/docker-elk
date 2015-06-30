FROM 0x4139/java8
MAINTAINER nytr0gen.george@gmail.com

# Utilities
RUN apt-get update; apt-get install -y wget curl python
WORKDIR /opt

# ElasticSearch
RUN \
  mkdir -p elasticsearch; \
  wget -nv -O - https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz | \
  tar xzf - --strip=1 -C elasticsearch; \
  sed -i -E "s/\#network\.host.+/network.host: localhost/" elasticsearch/config/elasticsearch.yml

# Kibana
RUN \
  mkdir -p kibana; \
  wget -nv -O - https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz | \
  tar xzf - --strip=1 -C kibana

# Logstash
RUN \
  mkdir -p logstash; \
  wget -nv -O - https://download.elasticsearch.org/logstash/logstash/logstash-1.5.1.tar.gz | \
  tar xzf - --strip=1 -C logstash

# Elastic Curator
RUN \
  bash -c "python <(curl https://bootstrap.pypa.io/get-pip.py)"; \
  pip install elasticsearch-curator

# Supervisord
RUN \
  apt-get install -y supervisor; \
	mkdir -p /var/log/supervisor

# Configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY logstash.conf /etc/logstash.conf
COPY curator_cron.sh /opt/curator_cron.sh

CMD /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
EXPOSE 5601 9200 28777 49021
# 5601=kibana, 9200=elasticsearch, 49021=logstash, 28777=logger

# Clean everything up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*