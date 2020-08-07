#!/usr/bin/bash

# Author      : zhysunny
# Date        : 2020/8/7 21:53
# Description : test json.sh

# 当前文件所在目录，这里是相对路径
LOCAL_PATH=`dirname $0`
# 当前文件所在目录转为绝对路径
BASE_PATH=`cd ${LOCAL_PATH}/../;pwd`

json_str='{"message":"success感谢又拍云(upyun.com)提供CDN赞助","status":200,"date":"20200422","time":"2020-04-22 22:22:23","cityInfo":{"city":"天津市","citykey":"101030100","parent":"天津","updateTime":"17:33"},"data":{"shidu":"8%","pm25":11.0,"pm10":31.0,"quality":"优","wendu":"15","ganmao":"各类人群可自由活动","forecast":[{"date":"22","high":"高温 16℃","low":"低温 6℃","ymd":"2020-04-22","week":"星期三","sunrise":"05:26","sunset":"18:55","aqi":37,"fx":"西北风","fl":"4-5级","type":"晴","notice":"愿你拥有比阳光明媚的心情"}],"yesterday":{"date":"21","high":"高温 15℃","low":"低温 6℃","ymd":"2020-04-21","week":"星期二","sunrise":"05:28","sunset":"18:54","aqi":60,"fx":"西北风","fl":"5-6级","type":"晴","notice":"愿你拥有比阳光明媚的心情"}}}'

echo ${json_str} > test_json.txt

sh ${BASE_PATH}/tools/json.sh -f test_json.txt

rm -rf test_json.txt

echo ""

json_str='{"message":"json pretty"}'

sh ${BASE_PATH}/tools/json.sh ${json_str}