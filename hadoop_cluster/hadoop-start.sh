#!/bin/bash

base01_docker_id=$(pidof dockerd)
#on centos launchctl will be systemctl
if [ -z "$base01_docker_id" ]; then
sudo launchctl start docker 5 
fi
echo "********docker started***********" 

hosts_info="--add-host nn01:172.168.8.11 --add-host dn01:172.168.8.12 --add-host dn02:172.168.8.13"

IMG=hadoop_cluster
VOLUME_DIR=
HDFS_DIR=/usr/local/hadoop-3.2.2/hdfs

echo "********create  docker********"

mkdir -p $VOLUME_DIR/nn01/{data,name,tmp}
docker run --name nn01 --network bridge_for_hadoop --ip 172.168.8.11 -h nn01 -v $VOLUME_DIR/nn01:$HDFS_DIR $hosts_info -p 50070:50070 -p 9870:9870 -p 8088:8088 -p 10000:10000  -d $IMG
mkdir -p $VOLUME_DIR/dn01/{data,name,tmp}
docker run --name dn01 --network bridge_for_hadoop --ip 172.168.8.12 -h dn01 -v $VOLUME_DIR/dn01:$HDFS_DIR $hosts_info -d $IMG
mkdir -p $VOLUME_DIR/dn02/{data,name,tmp}
docker run --name dn02 --network bridge_for_hadoop --ip 172.168.8.13 -h dn02 -v $VOLUME_DIR/dn02:$HDFS_DIR $hosts_info -d $IMG

nn01_local_ip=root@172.168.8.11
#hadoop 3以后，slaves改为workers
ssh $nn01_local_ip "echo 'nn01' > /usr/local/hadoop-3.2.2/etc/hadoop/workers"
ssh $nn01_local_ip "echo 'dn01' >> /usr/local/hadoop-3.2.2/etc/hadoop/workers"
ssh $nn01_local_ip "echo 'dn02' >> /usr/local/hadoop-3.2.2/etc/hadoop/workers"

sleep 2
ssh $nn01_local_ip "cd /usr/local/hadoop-3.2.2;./bin/hdfs namenode -format" 
echo "******** namenode format ok! ********"
ssh $nn01_local_ip "cd /usr/local/hadoop-3.2.2;./sbin/start-all.sh" 
echo "******** start hadoop cluster ok! ********"
ssh $nn01_local_ip "source /etc/profile;cd /usr/local/hadoop/sbin;nohup hiveserver2 >/dev/null 2>/dev/null &" 
echo "******** start hiveserver2 ok! ********"
echo "******** all ok! ********"
