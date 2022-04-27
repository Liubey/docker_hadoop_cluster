FROM centos:7
#install ssh
RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN yum  install -y openssh-clients

#config root 
RUN echo "root:loong" | chpasswd
RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers
#ssh key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key
#make no-passoword login
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

#copy your id_dsa.pub to dockerfile path，then add to authorized_keys
ADD id_rsa.pub /root/
RUN cat /root/id_rsa.pub >> ~/.ssh/authorized_keys

#take out first login yes confirm(Are you sure you want to continue connecting (yes/no))
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config

#config sshd
RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
