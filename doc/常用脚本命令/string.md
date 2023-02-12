# linux bash shell之字符串操作
```
字符串判空 
if [[ -z "$str" ]]; str为空时返回true
if [[ -n "$str" ]]; str不为空时返回true

echo "$str"; 去掉两边的空格
echo ${str#"as"}; 去掉首字符串
echo ${str%"as"}; 去掉尾字符串
echo ${str:-"test"}; 默认值为test
expr length "$str"; 字符串长度

字符串比较
在bash中"="与"=="是同样的
if [[ "$str1" = "$str2" ]]; 不推荐
if [[ "$str1" == "$str2" ]];
if [[ "$str1" != "$str2" ]];
if [[ "$str1" =~ "$str2" ]];  包含子字符串str2
if [[ "$str1" == "*$str2" ]];  endswith
if [[ "$str1" == "$str2"* ]];  startswith

大小写转换
echo "$str" | tr [a-z] [A-Z]

字符串替换
echo ${str/$source/$target}; 替换一个source
echo ${str//$source/$target}; 替换所有source

indexOf
expr index "$str" "$s"; 索引从1开始
substr
expr substr "$str" $start $len; 

```