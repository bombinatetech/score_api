#!/bin/bash

case "$1" in
    start)
        echo "Starting Ok_Api Application"
        elixir --sname score_api --cookie "scoreapi" --detached --no-halt -S mix run
        ;;
    console)
        iex --sname score_api --cookie "scoreapi" -S mix run
        ;;
    stop)
        echo "need to implement"
#        sudo erl -noshell -sname temp_control -setcookie "oktalk" \
#        -eval "rpc:call('ok_api@ip-172-31-31-28-18', init, stop, [])" \
#        -s init stop
        ;;
    attach)
        iex --sname console --cookie "scoreapi" --remsh score_api@$HOSTNAME
        # connect to ok_api shell
        # ^G
        # r 'ok_api@<<$hostname>>'
        # c
       
        # disconnect from ok_api shell
        # ^G
        # q
        ;;
    *)
    echo "Usage: $0 {start|stop|attach|console}"
esac

exit 0 