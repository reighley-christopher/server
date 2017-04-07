#!/bin/sh
#
# amqp_to_socketio
#
# chkconfig:   - 85 15
# description: bridge between a the rabbitmq message queue and the socketio.js websocket implementation
# processname: amqp_to_socketio
# pidfile:     /var/run/amqp_to_socketio.pid

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0

exec="/nfs/export/UTIL/bin/amqp_to_socketio"

start() {
    echo -n $"Starting $exec: "
    # start it up here, usually something like "daemon $exec"
    daemon "nohup $exec > /dev/null &"
    retval=$?
    echo
    return $retval
}

stop() {
    echo -n $"Stopping $exec: "
    # stop it here, often "killproc $prog"
    killproc $exec
    retval=$?
    echo
    return $retval
}

status() {
    echo "server is peachy"
}

case "$1" in
    start|stop|status)
        $1
        ;;
    *)
        echo $"Usage: $0 {start|stop|status}"
        exit 2
esac
