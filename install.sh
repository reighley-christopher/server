#!/bin/bash

DIR=$PWD
PATH=/usr/local/bin:$PATH

#yum install pygpgme yum-utils nginx
#cp etc/yum.repos.d/* /etc/yum.repos.d
#yum -q makecache -y
#yum install ncurses-devel

#yum install riak --nogpgcheck

#yum install gcc
#yum install socat
#yum install openssl-devel

#mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
#cp etc/nginx/nginx.conf /etc/nginx/nginx.conf
#wget http://erlang.org/download/otp_src_19.3.tar.gz
#gzip --decompress otp_src_19.3.tar.gz
#tar -xf otp_src_19.3.tar
#cd otp_src_19.3
#./configure
#make install
#cd $DIR

#wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-generic-unix-3.6.9.tar.xz
#xz --decompress rabbitmq-server-generic-unix-3.6.9.tar.xz
#tar -xf rabbitmq-server-generic-unix-3.6.9.tar
#cp -r rabbitmq_server-3.6.9/etc /usr/local
#cp -r rabbitmq_server-3.6.9/sbin /usr/local
#cp -r rabbitmq_server-3.6.9/share /usr/local

#mkdir /usr/local/lib/rabbitmq
#mkdir /usr/local/lib/rabbitmq/lib
#cp -r rabbitmq_server-3.6.9 /usr/local/lib/rabbitmq/lib

#cp -r www /www
#cd /www/static
#wget https://github.com/mrdoob/three.js/archive/master.zip
#unzip master.zip
#mv three.js-master threejs
#wget https://code.jquery.com/jquery.js
#wget http://underscorejs.org/underscore.js
#wget http://backbonejs.org/backbone.js
#wget https://raw.githubusercontent.com/PaulUithol/Backbone-relational/a7634e7d9deac64e3da455a3fde13b96ae253612/backbone-relational.js
#wget http://fontawesome.io/assets/font-awesome-4.7.0.zip
#unzip font-awesome-4.7.0.zip
#mv font-awesome-4.7.0 font-awesome

#cd $DIR
#cp etc/rc.d/init.d/* /etc/rc.d/init.d
#wget https://nodejs.org/dist/v6.10.2/node-v6.10.2-linux-x64.tar.xz
#xz --decompress node-v6.10.2-linux-x64.tar.xz
#tar -xf node-v6.10.2-linux-x64.tar
#cp -r node-v6.10.2-linux-x64/bin /usr/local
#cp -r node-v6.10.2-linux-x64/lib /usr/local
#cp -r node-v6.10.2-linux-x64/include /usr/local
#cp -r node-v6.10.2-linux-x64/share /usr/local

#cd /srv/run_master/bin
#npm install express
#npm install promise

#mkdir /srv/run_master
#cp -r services/run_master/bin /srv/run_master/bin
#cp -r services/run_master/node_modules /srv/run_master/node_modules
#cp -r services/run_master/components /srv/run_master/components
#cp -r services/run_master/glyphs /srv/run_master/glyphs
#cd services/run_master/src/pipefitter
#make install
#cd $DIR

#mkdir /srv/amqp_to_socketio
#cp -r services/amqp_to_socketio/bin /srv/amqp_to_socketio/bin
#cp -r services/amqp_to_socketio/node_modules /srv/amqp_to_socketio/node_modules

#cd /srv/amqp_to_socketio
#npm install amqp
#npm install socket.io
#npm install express
#npm install promise
#cd $DIR
