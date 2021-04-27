#!/bin/bash
Node_IP=""
SEEDS=""
CLUSTER_NAME=""
Num_Token=256
REPLICATION_FACTOR="1"
ALLOCATE_FLAG=1
while getopts :i:e:s:n:r:u:p:a:m option
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
        a)
            ALLOCATE_FLAG=$OPTARG
            echo "option:r, value $OPTARG"
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

mkdir $Node_IP
# cp config/* $Node_IP
KEYSPACE_NAME="keyspace_with_replication_factor_$REPLICATION_FACTOR"
sed -i "$a\$USER_NAME readwrite" /etc/cassandra/cassandra.access
sed -e "s/numbertoken/$Num_Token/g" -e "s/seedsiplist/$SEEDS/g" -e "s/clusternamevalue/'$CLUSTER_NAME'/g" -e "s/allocatetokensforkeyspace/$KEYSPACE_NAME/g" config/cassandra.yaml >$Node_IP/cassandra.yaml
sed -e "s/jmxhost/$Node_IP/g" config/cassandra-env.sh >$Node_IP/cassandra-env.sh
if [ $ALLOCATE_FLAG -eq 0 ]
then
sed -i -e "s/allocate_tokens_for_keyspace/#allocate_tokens_for_keyspace/g" $Node_IP/cassandra.yaml
fi
