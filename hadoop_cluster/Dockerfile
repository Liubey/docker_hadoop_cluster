FROM centos7_with_nopass_ssh_basic

ADD jdk-8u311-linux-aarch64.tar.gz /usr/local
ADD hadoop-3.2.2.tar.gz /usr/local
ADD apache-hive-3.1.2-bin.tar.gz /usr/local

WORKDIR /usr/local

RUN ln -s ./hadoop-3.2.2 hadoop

#ENV JAVA_HOME /usr/local/jdk1.8.0_311
#ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#ENV PATH $PATH:$JAVA_HOME/bin

#ENV HADOOP_HOME /usr/local/hadoop
#ENV PATH $HADOOP_HOME/bin:$PATH

RUN echo 'JAVA_HOME=/usr/local/jdk1.8.0_311' >> /etc/profile
RUN echo 'CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' >>/etc/profile
RUN echo 'PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile

RUN echo 'HADOOP_HOME=/usr/local/hadoop-3.2.2' >> /etc/profile
RUN echo 'PATH=$PATH:$HADOOP_HOME/bin' >> /etc/profile
RUN echo 'export PATH' >> /etc/profile

RUN echo 'HIVE_HOME=/usr/local/apache-hive-3.1.2-bin' >> /etc/profile
RUN echo 'PATH=$PATH:$HIVE_HOME/bin' >> /etc/profile

RUN source /etc/profile