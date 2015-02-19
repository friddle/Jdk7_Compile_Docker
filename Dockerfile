# VERSION 1.0
FROM friddle/ali_mirrors_ubuntu
MAINTAINER friddle "friddle@friddle.me"
RUN mkdir -p /root/jdkcompile
#拷贝JDK源文件
ADD ./jdk7u40 /root/jdkcompile
#装需要的软件
RUN apt-get install -y aptitude
#修改Mercurial的配置
RUN apt-get install -y mercurial
RUN hg clone http://bitbucket.org/pmezard/hgforest-crew /root/hgforest
RUN touch /root/.hgrc
RUN echo "[extension]" >> .hgrc
RUN echo "forest=/root/hgforest/forest.py \n fetch=" >> .hgrc

#装依赖
RUN aptitude build-dep -y openjdk-7-jdk
RUN apt-get install -y ant
RUN apt-get install -y build-essential
RUN apt-get install -y libxrender-dev
RUN apt-get install -y xorg-dev
RUN apt-get install -y libasound2-dev
RUN apt-get install -y libcups2-dev
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y systemtap-sdt-dev
RUN apt-get install -y gawk zip libxtst-dev libxi-dev libxt-dev

#设置系统环境
RUN export LANG=C
RUN export ALT_BOOTDIR=/root/java
RUN export ALLOW_DOWNLOADS=true
RUN unset JAVA_HOME
RUN unset CLASSPATH

#开始运行
RUN sh /root/jdkcompile/get_source.sh
RUN export ALT_BOOTDIR=/usr/lib/jvm/java-7-openjdk-amd64 
RUN cd /root/jdkcompile && make  

