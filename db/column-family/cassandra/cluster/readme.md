
```shell
sudo su
chmod 777 cluster/*
cd cluster
//first node in new cluster
./install.sh -i 10.178.86.195 -e 10.178.86.195 -s 'qaenvironment' -n 4 -r 1 -u cassandra1 -p cassandra2 -a 0 -j 1
//second node in new cluster
./install.sh -i 10.178.86.198 -e 10.178.86.195 -s 'qaenvironment' -n 4 -r 1 -u cassandra1 -p cassandra2 -a 1 -j 1
```

```shell
./install.sh -i {nodeip} -e {seeds} -s '{cluster name}' -n {num_tokens} -r {replication_factors} -u {jmx_username} -p {jmx_password} -a {first_node_or_not} -j {jvm_default_or_not}
```
-i node ip  
-s cluster name  
-e seeds {ip1},{ip2},{ip3}  
-n num_tokens  
-r replication_factors,the default replication strategy is NetworkTopologyStrategy  
-u jmx username  
-p jmx password  
-a it is  the first node of the cluster,which should be 1,which will create keyspace for allocate_tokens_for_keyspace in cassandra.yaml  
-j we have 8G jvm config file,if the parameter is 1,will copy the jvm_options file to /etc/cassandra,default value is 0.  
-x superuser name   
-z superuser password

check cassanra
```shell
service cassandra restart
nodetool -u cassandra -pw cassandra status
```
check monitor
```shell
curl 127.0.0.1:9100/metrics nodexporter
curl 127.0.0.1:7070/metrics prometheus
```
 
If you encounter some errors,you could access /var/log/cassandra/system.log,/var/log/cassandra/debug.log
```shell
cd /var/log/cassandra/system.log
cd /var/log/cassandra/debug.log
```

