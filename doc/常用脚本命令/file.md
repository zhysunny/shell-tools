# linux bash shell之文件操作
```
if [[ -e "$file" ]]; 是否存在
if [[ -f "$file" ]]; 是否为文件
if [[ -d "$file" ]]; 是否为目录
if [[ -x "$file" ]]; 是否可执行
if [[ -r "$file" ]]; 是否可读
if [[ -w "$file" ]]; 是否可写
touch $file; 创建文件
mkdir $file; 创建目录，父目录不存在会报错
mkdir -p $file; 递归创建目录，不会报错
basename $file; 文件名
dirname $file; 文件所在目录
echo ${file##*.}; 文件后缀

stat命令获取文件信息
stat -c "%s" $file; 文件大小
stat -c "%z" $file; 文件最后修改时间: 2023-02-12 09:28:11.271689626 +0800
stat -c "%Y" $file; 文件最后修改时间: 1676165291
```