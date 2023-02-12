#!/bin/sh
cur_path=$(cd `dirname $0`;pwd)

function Usage() {
    echo "Usage: "
    echo "sh $0 get"
    echo "sh $0 split (ipstring)"
    echo "sh $0 split 192.168.1.1-192.168.1.10,192.168.1.13"
    exit 1
}

function get_localhost_ip(){
    # eno16777736是自定义，一般是eth0
	echo `/sbin/ifconfig -a | grep -A 8 "eno16777736" | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' | tr -d "addr:"`
}

function split_ip_string(){
    if [[ $# -lt 1 ]]; then Usage; fi
    arrays=()
    arrayFirst=(${1//,/ })
    len=${#arrayFirst[*]}
    index=0
    for range in ${arrayFirst[*]}; do
        arraySecond=(${range//-/ })
        if [[ ${#arraySecond[*]} -eq 1 ]]; then
            arrays[$index]=$range
            ((index++))
        elif [[ ${#arraySecond[*]} -eq 2 ]]; then
            arrayOne=(${arraySecond[0]//./ })
            arrayTwo=(${arraySecond[1]//./ })
            suf1=${arrayOne[3]}
            suf2=${arrayTwo[3]}
            if [[ ${suf2} -ge ${suf1} ]]
            then
                max=${suf2}
                min=${suf1}
            else
                max=${suf1}
                min=${suf2}
            fi
            for((i=$min;i<=$max;i++))
            do
                ip="${arrayOne[0]}.${arrayOne[1]}.${arrayOne[2]}.$i";
                arrays[$index]=${ip}
                ((index++))
            done
        fi
    done

	echo ${arrays[*]}
}

COMMAND=$1
shift

case ${COMMAND} in
    get )
        get_localhost_ip $*
        ;;
    split )
        split_ip_string $*
        ;;
    * )
        Usage
        ;;
esac