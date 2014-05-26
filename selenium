#!/bin/sh

NAME="[TEST DAEMON]"
PID="./selenium.pid"
CMD="ruby selenium_daemon.rb"

if [ ! -x "`which ruby`" ]; then
    echo "Not found ruby"
    exit 1
fi

start()
{
    if [ -e $PID ]; then
        echo "$NAME already started"
        exit 1
    fi
    echo "$NAME START!"
    $CMD
}

stop()
{
    if [ ! -e $PID ]; then
        echo "$NAME not started"
        exit 1
    fi
    echo "$NAME STOP!"
    kill -INT `cat ${PID}`
    rm $PID
}

restart()
{
    stop
    sleep 2
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "Syntax Error: release [start|stop|restart]"
        ;;
esac

