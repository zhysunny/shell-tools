#!/bin/sh
# chkconfig: 2345 60 40
# Author      : 章云
# Date        : 2019/8/21 8:57
# Description : 开机自启动脚本，适用于单机版，集群版由于启动时间不一致会导致组件启动失败

Usage()
{
    echo "Usage：(start | stop | restart) as first argument"
    exit 1
}

ENVIRONMENT=/etc/profile
source ${ENVIRONMENT}

start(){
    # zookeeper.sh
    cd ${ZOOKEEPER_HOME}/bin
    sh zkServer.sh start
}

stop(){
    # zookeeper.sh
    cd ${ZOOKEEPER_HOME}/bin
    sh zkServer.sh stop
}

restart(){
    stop $*
    start $*
}


COMMAND=$1

#参数位置左移1
shift

case ${COMMAND} in
    start )
        start $*
        ;;
	stop )
        stop $*
        ;;
	restart )
        restart $*
        ;;
    * )
		Usage
        exit 1
        ;;
esac
