# docker_hadoop_cluster
A docker way to quick build a hadoop and hive cluster with hadoop3.2&amp;hive3.1.2

# Step 0
clone this repository to your computer

# Step 1
first you need to make a basic image that login without password,so in this repository it called **centos7_with_nopass_ssh_basic**.
## 1.1 confirm you Dockerfile id_rsa.pub
copy your id_rsa.pub to centos7_with_nopass_ssh_basic/

## 1.2 build centos7_with_nopass_ssh_basic images
in this directory, you get two files:id_rsa.pub and Dockerfile,then run this command:

```
docker build -t centos7_with_nopass_ssh_basic .

```

# Step 2 create network for docker

```
docker network create --subnet=172.168.8.0/24 bridge_for_hadoop

```

# Step 3 build hadoop and hive image
change your directory to hadoop_cluster and run:
add apache-hive-3.1.2-bin.tar.gz and hadoop-3.2.2.tar.gz to this directory
add jdk-8u311-linux-aarch64.tar.gz or jdk-8u311-linux-x64.tar.gz to this directory

```
docker build -t hadoop_cluster .

```
# Step 4 create a volume for hadoop data

```
mkdir -p your_path_to_docker_volumn(you need to change this command for you)
```
# Step 5 change and run hadoop-start.sh
change hosts_info to you create network 
change VOLUME_DIR to you create
then,run 

```
./hadoop-start.sh
```
# Step 6
you can get the log:

```
******** start hadoop cluster ok! ********
******** start hiveserver2 ok! ********
******** all ok! ********
```

enjoy you journey！