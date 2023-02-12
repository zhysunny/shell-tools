#!/bin/sh
cur_path=$(cd `dirname $0`;pwd)

PB=$[2**50]
TB=$[2**40]
GB=$[2**30]
MB=$[2**20]
KB=$[2**10]
B=$[2**0]

function Usage() {
    echo "Usage: "
    echo "sh $0 get_size (不带单位的容量) [目标单位]"
    echo "sh $0 get_byte (带单位的容量)"
    echo "sh $0 get_rate (分子) (分母)"
    exit 1
}

function get_size(){
    if [[ $# -ne 1 && $# -ne 2 ]];then Usage; fi
    if [[ $# -eq 1 ]]; then
        # 自动寻找合适的单位
        if [[ "`echo "$1 > $PB"|bc`" -eq 1 ]]; then echo "`echo "scale=2;"$1"/$PB"|bc` PB";
        elif [[ "`echo "$1 > $TB"|bc`" -eq 1 ]]; then echo "`echo "scale=2;"$1"/$TB"|bc` TB";
        elif [[ "`echo "$1 > $GB"|bc`" -eq 1 ]]; then echo "`echo "scale=2;"$1"/$GB"|bc` GB";
        elif [[ "`echo "$1 > $MB"|bc`" -eq 1 ]]; then echo "`echo "scale=2;"$1"/$MB"|bc` MB";
        elif [[ "`echo "$1 > $KB"|bc`" -eq 1 ]]; then echo "`echo "scale=2;"$1"/$KB"|bc` KB";
        else echo "`echo "scale=2;"$1"/$B"|bc` B"; fi
    fi
    if [[ $# -eq 2 ]]; then
        # 按目标单位换算
        if [[ -n `echo $2 | grep -iE "^P(B)?$"` ]]; then echo "`echo "scale=2;"$1"/$PB"|bc` PB";
        elif [[ -n `echo $2 | grep -iE "^T(B)?$"` ]]; then echo "`echo "scale=2;"$1"/$TB"|bc` TB";
        elif [[ -n `echo $2 | grep -iE "^G(B)?$"` ]]; then echo "`echo "scale=2;"$1"/$GB"|bc` GB";
        elif [[ -n `echo $2 | grep -iE "^M(B)?$"` ]]; then echo "`echo "scale=2;"$1"/$MB"|bc` MB";
        elif [[ -n `echo $2 | grep -iE "^K(B)?$"` ]]; then echo "`echo "scale=2;"$1"/$KB"|bc` KB";
        else echo "`echo "scale=2;"$1"/$B"|bc` B"; fi
    fi
}
function get_byte(){
    if [[ $# -ne 1 ]];then Usage; fi
    size=`echo "$1" | grep -oP "\-?\d*(\.\d+)?"`
    unit=`echo ${1/$size/}`
    if [[ -n `echo ${unit} | grep -iE "^P(B)?$"` ]]; then factory=${PB};
    elif [[ -n `echo ${unit} | grep -iE "^T(B)?$"` ]]; then factory=${TB};
    elif [[ -n `echo ${unit} | grep -iE "^G(B)?$"` ]]; then factory=${GB};
    elif [[ -n `echo ${unit} | grep -iE "^M(B)?$"` ]]; then factory=${MB};
    elif [[ -n `echo ${unit} | grep -iE "^K(B)?$"` ]]; then factory=${KB};
    else factory=${B}; fi
    echo "`echo "scale=2;"$size"*$factory"|bc`"
}

function get_rate(){
    if [[ $# -ne 2 ]];then Usage; fi
    if [[ "$2" -ne 0 ]]; then echo "`echo "scale=2;"$1"*100/$2"|bc` %";
    elif [[ "$1" -eq 0 ]]; then echo "0.00 %";
    else echo "100.00 %"; fi
}

COMMAND=$1
shift

case ${COMMAND} in
    get_size )
        get_size $*
        ;;
    get_byte )
        get_byte $*
        ;;
    get_rate )
        get_rate $*
        ;;
    * )
        Usage
        ;;
esac