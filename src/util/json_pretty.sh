#!/usr/bin/bash

# Author      : zhysunny
# Date        : 2020/8/7 21:46
# Description : json字符串操作

function green_message()
{
    echo -ne "\033[32m$@\033[0m"
    echo
}

# show message in red
function red_message()
{
    echo -ne "\033[31m$@\033[0m"
    echo
}

function judge_char()
{
    case "$1" in
        "{")
        [[ "$double_quotes" == "true" ]] && echo -n "$1" && return
        let indent_num++
        combining_indent +
        echo "{"
        echo -ne "$indent_str"
        ;;

        "}")
        [[ "$double_quotes" == "true" ]] && echo -n "$1" && return
        let indent_num--
        combining_indent -
        echo
        echo -ne "$indent_str}"
        ;;

        "[")
        [[ "$double_quotes" == "true" ]] && echo -n "$1" && return
        let indent_num++
        combining_indent +
        echo "["
        echo -ne "$indent_str"
        ;;

        "]")
        [[ "$double_quotes" == "true" ]] && echo -n "$1" && return
        let indent_num--
        combining_indent -
        echo
        echo -ne "$indent_str]"
        ;;

        ",")
        [[ "$double_quotes" == "true" ]] && echo -n "$1" && return
        echo ","
        echo -ne "$indent_str"
        ;;

        '"')
        [[ "$double_quotes" == "true" ]] && double_quotes=false || double_quotes=true
        echo -n '"'
        ;;

        ":")
        [[ "$double_quotes" == "false" ]] && echo -n " : " || echo -n ":"
        ;;

        "\\")
        # if get \ ,will skip the next char, mostly it is \n
        [[ "$double_quotes" == "false" ]] && let offset++ || echo -n "\\"
        ;;

        *)
        echo -n "$1"
        ;;

    esac
}

function combining_indent()
{
    if [[ ${indent_num} -lt 0 ]];then
        red_message "Wrong Json format!"
        exit 255
    fi
    case $1 in
        +)
        indent_str+=$indent
        ;;
        -)
        indent_str=${indent_str%"$indent"}
        ;;

    esac
}

function Usage() {
    echo "Usage: "
    echo "sh $0 (json_str)"
    echo "sh $0 -f (json_file)"
    exit 1
}

function json_pretty(){
    indent_num=0
    indent_str=""
    indent="    "
    double_quotes=false
    if [[ "$1" == "-f" ]] || [[ "$1" == "--file"  ]];then
        file_name=$2
        [[ ! -f "${file_name}" ]] && red_message "Can't find the file :${file_name}" && Usage
        strings="$(cat ${file_name})"
    else
        strings="$@"
    fi

    offset=0
    while ((1)); do
        ch="${strings:$offset:1}"
        judge_char "$ch"
        [[ -z "$ch" ]] && break
        let offset++
    done
    echo
}

json_pretty $*
# 样例 json_str='{"message":"json pretty"}'
# 样例 json_str='{"message":"success感谢又拍云(upyun.com)提供CDN赞助","status":200,"date":"20200422","time":"2020-04-22 22:22:23","cityInfo":{"city":"天津市","citykey":"101030100","parent":"天津","updateTime":"17:33"},"data":{"shidu":"8%","pm25":11.0,"pm10":31.0,"quality":"优","wendu":"15","ganmao":"各类人群可自由活动","forecast":[{"date":"22","high":"高温 16℃","low":"低温 6℃","ymd":"2020-04-22","week":"星期三","sunrise":"05:26","sunset":"18:55","aqi":37,"fx":"西北风","fl":"4-5级","type":"晴","notice":"愿你拥有比阳光明媚的心情"}],"yesterday":{"date":"21","high":"高温 15℃","low":"低温 6℃","ymd":"2020-04-21","week":"星期二","sunrise":"05:28","sunset":"18:54","aqi":60,"fx":"西北风","fl":"5-6级","type":"晴","notice":"愿你拥有比阳光明媚的心情"}}}'
