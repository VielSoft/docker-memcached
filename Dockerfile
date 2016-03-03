#Base Image
 FROM phusion/baseimage
#locale settings for Ubuntu
 RUN locale-gen en_US.UTF-8
 ENV LANG       en_US.UTF-8
 ENV LC_ALL     en_US.UTF-8
#Install Necessary Software
 RUN apt-get update -y
 RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y memcached
#Use baseimage-docker's init system.
 CMD ["/sbin/my_init"]
#Copy the memcache.conf file.
 COPY ./memcached.conf /etc/memcached.conf
#runit service files
 RUN mkdir /etc/service/memcached
 COPY ./memcached.sh /etc/service/memcached/run
 RUN chmod +x /etc/service/memcached/run
 CMD service memcached start && tail -F /var/log/memcached.log
EXPOSE 11211
#apt-cleanup
 RUN apt-get clean
 RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
