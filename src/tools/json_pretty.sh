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

function usage()
{
    cat << USAGE
$0 -f \$json_file
$0 \$json_str
USAGE
    exit 255
}

function json_pretty(){
    indent_num=0
    indent_str=""
    indent="    "
    double_quotes=false
    if [[ "$1" == "-f" ]] || [[ "$1" == "--file"  ]];then
        file_name=$2
        [[ ! -f "${file_name}" ]] && red_message "Can't find the file :${file_name}" && usage
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

