#!/bin/bash
Node_IP=""
SEEDS=""
CLUSTER_NAME=""
Num_Token=256
REPLICATION_FACTOR="1"
USER_NAME="cassandra"
PASSWORD="cassandra"
ALLOCATE_FLAG=1
JVM=0
CUSER="cassandra"
CPASSWORD="cassandra"
while getopts :i:e:s:n:r:u:p:a:j:x:z:m option
do
    case "$option" in
        i)
            Node_IP=$OPTARG
            echo "option:i, value $OPTARG"
            ;;
        e)
            SEEDS=$OPTARG
            echo "option:e, value $OPTARG"
            ;;
        s)
            CLUSTER_NAME=$OPTARG
            echo "option:s, value $OPTARG"
            ;;
        n)
            Num_Token=$OPTARG
            echo "option:n, value $OPTARG"
            ;;
        r)
            REPLICATION_FACTOR=$OPTARG
            echo "option:r, value $OPTARG"
            ;;
        u)
            USER_NAME=$OPTARG
            echo "option:u, value $OPTARG"
            ;;
        p)
            PASSWORD=$OPTARG
            echo "option:p, value $OPTARG"
            ;;
        a)
            ALLOCATE_FLAG=$OPTARG
            echo "option:a, value $OPTARG"
            ;;
        j)
            JVM=$OPTARG
            echo "option:j, value $OPTARG"
            ;;
        x)
            CUSER=$OPTARG
            echo "option:cu, value $OPTARG"
            ;;
        z)
            CPASSWORD=$OPTARG
            echo "option:cp, value $OPTARG"
            ;;
        \?)
            echo "Usage: args [-i]"
            echo "-i nodeip"
            echo "Usage: args [-e]"
            echo "-e means seeds"
            echo "Usage: args [-s]"
            echo "-e means cluster name"
            echo "Usage: args [-n]"
            echo "-n means num_tokens in cassandra.yaml"
            echo "Usage: args [-r]"
            echo "-n means replication factor,it will use to genetate allocate token keyspace  in cassandra.yaml"
            exit 1;;
    esac
done
if [ -z "$Node_IP" ]
 then
  printf "Option -i specified\n"
fi
if [ -z "$SEEDS" ] 
then
  printf 'Option -e specified\n' "$bval"
fi
if [ -z "$CLUSTER_NAME" ] 
then
  printf 'Option -s  specified\n' "$tval"
fi

apt install -y python-pip 
apt install -y openjdk-8-jdk 
echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list 
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add - 
apt-get update 
apt-get install -y cassandra

type=ext4
mount_dir=/data
mkfs.$type /dev/vdb 
mkdir -p $mount_dir
echo "/dev/vdb $mount_dir $type defaults 0 0" >> /etc/fstab
mount -a

mkdir /data
mkdir /data/cassandra
mkdir /data/cassandra/data
mkdir /data/cassandra/commitlog
mkdir /data/cassandra/saved_caches
mkdir /data/cassandra/hints

chmod 777 /data
chmod 777 /data/cassandra/
chmod 777 /data/cassandra/*

./generate_node_config.sh -i $Node_IP -e $SEEDS -s $CLUSTER_NAME -n $Num_Token -r $REPLICATION_FACTOR -a $ALLOCATE_FLAG

cp -f $Node_IP/* /etc/cassandra/

sed -i "$a\$USER_NAME readwrite" /etc/java-8-openjdk/management/jmxremote.access
printf "monitorRole QED\ncontrolRole R&D\n$USER_NAME $PASSWORD">/etc/cassandra/jmxremote.password
chown cassandra:cassandra /etc/cassandra/jmxremote.password
chmod 400 /etc/cassandra/jmxremote.password
cp -f tp/jmx_prometheus_javaagent-0.3.0.jar /usr/lib/
mkdir /etc/cassandra/prometheus/
cp -f tp/cassandra.yml /etc/cassandra/prometheus/

service cassandra restart
if [ $JVM -eq 1 ]
  then
  cp optional/* /etc/cassandra
fi
if [ $ALLOCATE_FLAG -eq 0 ]
  then
    KEYSPACE_NAME="keyspace_with_replication_factor_$REPLICATION_FACTOR"
    arr=(${SEEDS//,/ })
    cqlsh ${arr[0]} -u cassandra -p cassandra -f "cql/$KEYSPACE_NAME.cql"
    sed -i -e "s/#allocate_tokens_for_keyspace/allocate_tokens_for_keyspace/g"  /etc/cassandra/cassandra.yaml
    service cassandra restart
fi

sed -i -e "s/AllowAllAuthenticator/PasswordAuthenticator/g"  /etc/cassandra/cassandra.yaml
service cassandra restart
echo $CUSER
echo $CPASSWORD
sed -e "s/superusername/$CUSER/g" -e "s/superuserpassword/$CPASSWORD/g" cql/create_user.cql>cql/create_user_$Node_IP.cql
cqlsh $Node_IP -u cassandra -p cassandra -f cql/create_user_$Node_IP.cql
cqlsh $Node_IP -u $CUSER -p $CPASSWORD -f cql/disable_user.cql
cp -f tp/node_exporter  /usr/local/bin/
cp -f tp/node_exporter.service /etc/systemd/system/
chmod +x /etc/systemd/system/node_exporter.service
useradd prometheus
chown prometheus:prometheus /etc/systemd/system/node_exporter.service
chown prometheus:prometheus /usr/local/bin/node_exporter
chmod +x /usr/local/bin/node_exporter
systemctl daemon-reload
systemctl start node_exporter
systemctl status node_exporter
systemctl enable node_exporter


swapoff -a
sed -i 's/^\(.*swap\)/#\1/' /etc/fstab
echo "vm.swappiness = 1" > /etc/sysctl.d/swappiness.conf
sysctl -p /etc/sysctl.d/swappiness.conf

