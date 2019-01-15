#!/bin/bash
#the conf name,please make it not wrong!
cd `dirname $0`
APP_HOME=`pwd`
APP_MAINCLASS=com.kong.jenkinsjar.StartApplication
JAVA_OPTS="-Xms128m -Xmx128m -XX:MaxPermSize=128m -XX:+UseConcMarkSweepGC -XX:MaxTenuringThreshold=5 -XX:+ExplicitGCInvokesConcurrent -XX:SurvivorRatio=4 -XX:GCTimeRatio=19"

COMMAND=$1
###################################
#JDK....
#check JAVA_HOME
if [ X$JAVA_HOME = X ]
    then
      echo "$CONF_FILE  file  is not set JAVA_HOME variable,please set it!"
	  exit 1
    else
      echo  "JAVA_HOME is $JAVA_HOME!"
fi

#check APP_MAINCLASS
if [ X$APP_MAINCLASS = X ]
    then
      echo "$CONF_FILE  file  is not set APP_MAINCLASS variable,please set it!"
	  echo ""
	  exit 1
    else
      echo "APP_MAINCLASS is $APP_MAINCLASS!"
fi


INPUT_PARAMS=""

while  [ -n "$2" ]
do
        INPUT_PARAMS=$INPUT_PARAMS" "$2
        shift
done
#check input java_opts
if [  "$INPUT_PARAMS" ]
    then
        JAVA_OPTS=$INPUT_PARAMS
fi

#check JAVA_OPTS
if [ X"$JAVA_OPTS" = X ]
    then
      echo "$CONF_FILE  file  is not set JAVA_OPTS variable,please set it!"
	  exit 1
    else
      echo  "JAVA_OPTS is $JAVA_OPTS!"
fi




#.....classpath.......lib......jar
CLASSPATH=$APP_HOME
for i in "$APP_HOME"/lib/*.*; do
CLASSPATH="$CLASSPATH":"$i"
done
CLASSPATH=$CLASSPATH:"$APP_HOME"/config:"$APP_HOME"/config/logback.xml

#java.......


#echo "JAVA_OPTS is $JAVA_OPTS"

###################################
#(..).........
#
#...
#..JDK...JPS...grep.........pid
#jps . l .......java......
#..awk....pid ($1..)..Java....($2..)
###################################
#...psid......
psid=0


checkpid() {
javaps=`$JAVA_HOME/bin/jps -l | grep $APP_MAINCLASS`

if [ -n "$javaps" ]; then
psid=`echo $javaps | awk '{print $1}'`
else
psid=0
fi
}

###################################
#(..)....
#
#...
#1. ....checkpid.....$psid....
#2. .........$psid...0..........
#3. ..................
#4. ............checkpid..
#5. ....4..........pid,...[OK].....[Failed]
#...echo -n ...........
#..: "nohup ... >/dev/null 2>&1 &" ...
###################################
start() {
checkpid

if [ $psid -ne 0 ]; then
echo "================================"
echo "warn: $APP_MAINCLASS already started! (pid=$psid)"
echo "================================"
else
echo -n "Starting $APP_MAINCLASS ..."
echo "nohup $JAVA_HOME/bin/java $JAVA_OPTS -classpath $CLASSPATH $APP_MAINCLASS >>/dev/null 2>&1  &";
nohup $JAVA_HOME/bin/java $JAVA_OPTS -classpath $CLASSPATH $APP_MAINCLASS >>/dev/null 2>&1  &
checkpid
if [ $psid -ne 0 ]; then
echo "(pid=$psid) [OK]"
else
echo "[Failed]"
fi
fi
}

###################################
#(..)....
#
#...
#1. ....checkpid.....$psid....
#2. .........$psid...0....................
#3. ..kill -9 pid..........
#4. ..kill.....................: $?
#5. ....4...$?..0,...[OK].....[Failed]
#6. ....java...............................stop..
#...echo -n ...........
#..: .shell...."$?" .................
###################################
stop() {
checkpid

if [ $psid -ne 0 ]; then
echo -n "Stopping $APP_MAINCLASS ...(pid=$psid) "
kill -9 $psid
if [ $? -eq 0 ]; then
echo "[OK]"
else
echo "[Failed]"
fi

checkpid
if [ $psid -ne 0 ]; then
stop
fi
else
echo "================================"
echo "warn: $APP_MAINCLASS is not running"
echo "================================"
fi
}

###################################
#(..)........
#
#...
#1. ....checkpid.....$psid....
#2. .........$psid...0.............pid
#3. ..........
###################################
status() {
checkpid

if [ $psid -ne 0 ]; then
echo "$APP_MAINCLASS is running! (pid=$psid)"
else
echo "$APP_MAINCLASS is not running"
fi
}

###################################
#(..)........
###################################
info() {
echo "System Information:"
echo "****************************"
echo `head -n 1 /etc/issue`
echo `uname -a`
echo
echo "JAVA_HOME=$JAVA_HOME"
echo `$JAVA_HOME/bin/java -version`
echo
echo "APP_HOME=$APP_HOME"
echo "APP_MAINCLASS=$APP_MAINCLASS"
echo "****************************"
}

###################################
#..........($1).....
#.......{start|stop|restart|status|info}
#...................
###################################
case "$COMMAND" in
'start')
start
;;
'stop')
stop
;;
'restart')
stop
start
;;
'status')
status
;;
'info')
info
;;
*)
echo "Usage: $0 {start|stop|restart|status|info}"
exit 1
esac
exit 0

