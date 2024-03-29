FROM intra/centos7_base
LABEL maintainer="Rainer Hörbe <r2h2@hoerbe.at>"

RUN yum update -y \
 && yum -y install curl git ip lsof net-tools openssl tar unzip wget which \
 && yum -y install gcc openssl-devel bzip2-devel libffi-devel \
 && yum clean all && rm -rf /var/cache/yum

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src
RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
 && tar -xzf Python-3.7.4.tgz \
 && rm Python-3.7.4.tgz

WORKDIR /usr/local/src/Python-3.7.4
RUN ./configure --enable-optimizations \
 && make altinstall \
 && ln -sf /usr/local/bin/python3.7 /usr/bin/python3

ARG TIMEZONE='Europe/Vienna'
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
