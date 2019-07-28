# Common Shell Usage

### Content

- Command
- File
- Directory
- Text Line
- Input 
- Output
- Condition Branch
- Loop
- Variable
- Function
- Package Management
- Process
- Network



### Main



### Command 

If command is not exists, install it. 

```shell
if ! [ -x "$(command -v wget)" ]; then
    echo ""
    echo "Install wget<<<<<<<<<<<<<<<<<<<<"
    echo ""
    sudo apt-get install wget -y
    echo ""
    echo "Install wget is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi
```

Get Command Output

```shell
archive_filename=$(ls | grep jdk*.tar.gz | head -n 1)
jdk_name=$(tar tf $archive_filename | head -n 1)
```



### File

Is file path exists

```shell
if [ -f $file_name ]; then
fi
```

Find file is exists in a directory

```shell
# know file name
if [[ -n $(find /tools -name redis-server) ]]; then
		echo ""
		echo "redis is exist!"
		echo ""
else
fi
```

```shell
# don't know file name. Is file not exist
if ! [[ -n $(ls | grep jdk*.tar.gz) ]]; then
		echo ""
		echo "JDK package is not exist!"
		echo ""
else
fi
```

Remove files by wildcard

```shell
sudo rm -rf /tools/jdk*
```

Unarchive file to specific path

```shell
sudo tar xzvf $archive_filename -C $install_path
```



### Directory

Create multiple level directories

```shell
mkdir -p /tools/java
```

Is directory path exists

```shell
if [ -d $JAVA_HOME/bin ]; then
fi
```



### Text Line

find String from a file

```shell
$ grep 'word' filename
$ grep 'word' file1 file2 file3
$ grep 'string1 string2'  filename
$ cat otherfile | grep 'something'
```

Rewrite text of a file

```shell
echo "
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
"| sudo tee /etc/apt/sources.list  # add -a for append (>>) ;
```

Append text lines into a file

`cat`, `>>`

```shell
cat <<EOT >> greetings.txt
line 1
line 2
EOT # EOT is just a random string.
```

`tee`

```shell
tee -a filepath << END
Host localhost
  ForwardAgent yes
END
```

`echo `, `>>`

```shell
echo "
export JAVA_HOME=$JAVA_HOME
export PATH=\$PATH:\$JAVA_HOME/bin
">>~/.profile ;
```

`echo`, `tee`

```shell
echo "
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
"| sudo tee -a /etc/apt/sources.list  # add -a for append (>>) ;
```

Replace String of text lines from a file

```shell
sed -i 's/old-text/new-text/g' input.txt
```

Remove text lines contain a string from a file

```shell
sed -i "/\b\(JAVA_HOME\)\b/d" ~/.profile
```



### Input

Read from terminal

```shell
read -p "
Selecting your want to install package:
0. install All 1. install JDK 2. install MySQL 3.intsall Tomcat 4.intsall Redis 5. nginx 
" install_code
```



### Output

Output to terminal

```shell
echo "Hello World!"
```

Output newline

```shell
echo -e "Hello\nWorld\n\n"
```



### Condition Branch

If x equals y

```shell
if [ $operation_code -eq 1 ]; then 
fi
```

If not null

```shell
if [[ -n $(find /tools -name redis-server) ]]; then 
fi
```

Switch Case 

```shell
case ${uninstall_code:i:1} in
	0) uninstall_jdk
		uninstall_mysql 
		uninstall_tomcat 
		uninstall_redis
		uninstall_nginx
		;;
	1) uninstall_jdk 
		;;
	2) uninstall_mysql 
		;;
	3) uninstall_tomcat 
		;;
	4) uninstall_redis 
		;;
	5) uninstall_nginx
		;;
esac
```



### Loop

Loop i from 0 to n

```shell
for (( i=0; i<${#uninstall_code}; i++)); do

done
```



### Variable

Declare a variable

```shell
install_path=/tools
```

Using variable

```shell
$install_path
```



### Function

Function Declare

```shell
function install_redis
{
}
```

```shell
install_redis () {
}
```

Call a function

```shell
function_name
```

Get a function output

```shell
function myfunc()
{
    local  myresult='some value'
    echo "$myresult"
}
result=$(myfunc)   # or result=`myfunc`
echo $result
```

Function shell variables

```shell
All function parameters or arguments can be accessed via $1, $2, $3,..., $N.
$0 always point to the shell script name.
$* or $@ holds all parameters or arguments passed to the function.
$# holds the number of positional parameters passed to the function.
```



### Package Management

Check package manager

```shell
if [ -x "$(command -v yum)" ]; then
	package_manager=yum
else
	package_manager=apt-get
fi
```



Is package installed by apt-get install

```shell
$ dpkg -l mysql-server &> /dev/null && echo "mysql-server is installed"
```

```shell
function package_exists() {
    return dpkg -l "$1" &> /dev/null
}
if ! package_exists mysql-server ; then
    echo ”Please install mysql-server!"
fi
```

```shell
if [[ -n "$(which redis-server)" ]]; then
	echo "redis is installed"
fi
```



### Process

get process PID by name

```shell
pgrep -f <process_name>
pid=$(pgrep -f <process_name> | head -n 1)
```

Get process listening port number by PID

```shell
port=$(sudo lsof -i -P | grep -i LISTEN | grep <pid>)
```

Kill process by PID

```shell
sudo kill -9 PID
```



### Network

Checking ping is reach

```shell
ping -c 1 -w 5 google.com
if [ $? -eq 0 ]; then 
	echo "ok"
else
	echo "fail"
fi
```

Get server host IP address

```shell
server_ip=$(curl http://ifconfig.me/ip)
```

