# exporter
https://github.com/zegelin/cassandra-exporter
https://github.com/criteo/cassandra_exporter
https://docs.datastax.com/en/dse/6.7/dse-dev/datastax_enterprise/tools/metricsCollector/mcExportMetricsManually.html
https://docs.datastax.com/en/dse/6.7/dse-dev/datastax_enterprise/tools/metricsCollector/mcExportMetricsDocker.html
https://github.com/oleg-glushak/cassandra-prometheus-jmx
https://github.com/instaclustr/cassandra-exporter

# dashboard
https://github.com/outbrain/Cassibility
https://github.com/soccerties/cassandra-monitoring
https://github.com/datastax/dse-metric-reporter-dashboards

# metric
https://cassandra.apache.org/doc/latest/operating/metrics.html
https://github.com/apache/cassandra/tree/trunk/src/java/org/apache/cassandra/metrics

# prometheus
https://github.com/prometheus/prometheus
https://github.com/prometheus/alertmanager
https://github.com/prometheus/jmx_exporter
https://github.com/prometheus/node_exporter

https://www.instaclustr.com/support/documentation/announcements/instaclustr-open-source-project-status/#section-monitoring-information
https://github.com/instaclustr
https://github.com/instaclustr/cassandra-lucene-index
https://github.com/instaclustr/cassandra-sstable-tools
https://github.com/instaclustr/cassandra-docker




```
docker run --name alertmanager -d -p 127.0.0.1:9093:9093 prom/alertmanager
```

```
docker run -d --name=grafana -p 3000:3000 grafana/grafana 
```

```
docker run --name prometheus -d -p 127.0.0.1:9090:9090 prom/prometheus
```