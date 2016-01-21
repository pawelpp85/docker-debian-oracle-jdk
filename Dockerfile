FROM debian:squeeze
MAINTAINER pawelpp@gmail.com

ARG jdk
ENV JDK_VERSION $jdk

RUN echo "Bulding JDK $jdk"
# add webupd8 repository
RUN  echo "adding webupd8 repository..." \
 && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
 && apt-get update \
 \
 && echo "install Java $JDK_VERSION" \
 && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes oracle-java$JDK_VERSION-installer oracle-java$JDK_VERSION-set-default \    
    \
 && echo "cleaning up" \
 && rm -rf /var/cache/oracle-jdk$JDK_VERSION-installer \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
