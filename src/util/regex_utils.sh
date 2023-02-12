#!/bin/sh
cur_path=$(cd `dirname $0`;pwd)

DOUBLE_REGEX="\-?\d*(\.\d+)?"
EMAIL_REGEX="[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+"
URL_REGEX="[a-zA-z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*"
PHONENUM_REGEX="((\+?[0-9]{2,4}\-[0-9]{3,4}\-)|([0-9]{3,4}\-))?([0-9]{7,8})(\-[0-9]+)?"
MOBILEPHONENUM_REGEX="((\d{2,3})|(\d{3}\-))?(13|15|18)\d{9}"
QQ_REGEX="[1-9]*[1-9][0-9]*"
IP_REGEX="\d{1,3}(.\d{1,3}){3}"
DOUBLE_BYTE_REGEX="[^\x00-\xff]+"

function Usage() {
    echo "Usage: "
    echo "sh $0 get_double (str)"
    echo "sh $0 get_email (str)"
    echo "sh $0 get_url (str)"
    echo "sh $0 get_phoneNum (str)"
    echo "sh $0 get_mobilePhoneNum (str)"
    echo "sh $0 get_QQ (str)"
    echo "sh $0 get_ip (str)"
    echo "sh $0 get_double_byte (str)"
    exit 1
}

function get(){
    regex=$1
    shift
	if [[ $# -gt 0 ]]; then echo "$*" | grep -oP ${regex}; else Usage; fi
}

function get_double(){
	get ${DOUBLE_REGEX} "$*"
}
function get_email(){
	get ${EMAIL_REGEX} "$*"
}
function get_url(){
	get ${URL_REGEX} "$*"
}
function get_phoneNum(){
	get ${PHONENUM_REGEX} "$*"
}
function get_mobilePhoneNum(){
	get ${MOBILEPHONENUM_REGEX} "$*"
}
function get_QQ(){
	get ${QQ_REGEX} "$*"
}
function get_ip(){
	get ${IP_REGEX} "$*"
}
function get_double_byte(){
	get ${DOUBLE_BYTE_REGEX} "$*"
}

COMMAND=$1
shift

case ${COMMAND} in
    get_double )
        get_double $*
        ;;
    get_email )
        get_email $*
        ;;
    get_url )
        get_url $*
        ;;
    get_phoneNum )
        get_phoneNum $*
        ;;
    get_mobilePhoneNum )
        get_mobilePhoneNum $*
        ;;
    get_QQ )
        get_QQ $*
        ;;
    get_ip )
        get_ip $*
        ;;
    get_double_byte )
        get_double_byte $*
        ;;
    * )
        Usage
        ;;
esac