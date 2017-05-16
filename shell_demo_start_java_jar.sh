ulimit -c unlimited
JAVA_OPTS="-server -Xms4000m -Xmx4000m -Xmn1500m -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+HeapDumpOnOutOfMemoryError"
A1_OPTS="-Da1=true -Da1StartHour=7 -Da1EndHour=23 -Da1StartDay=1 -Da1EndDay=7"
A2_OPTS="-Da2=false -Da2StartHour=9 -Da2EndHour=23 -Da2StartDay=2 -Da2EndDay=2"
A3_OPTS="-Da3=true -Da3Debug=false -Da3StartHour=7"
D1_OPTS="-Dd361=true"
AUTOREJECT_OPTS="-DnoAutoReject=false -DnoAutoRejectStartDay=2 -DnoAutoRejectEndDay=6"
SemiAuto_OPTS="-DsemiAuto=true -DsemiAutoStartHour=7 -DsemiAutoEndHour=23 -DsemiAutoStartDay=1 -DsemiAutoEndDay=7"

cd /data/server/bin
ps -ef |grep myserver|grep "port=9010"|awk '{print $2}'|xargs kill -9
java $JAVA_OPTS $D1_OPTS $A1_OPTS $A2_OPTS $A3_OPTS $AUTOREJECT_OPTS $SemiAuto_OPTS -DloanThreadNum=5 -DserverId=riskProduct -Dport=9010 -DthreadNum=20 -DmgoHosts=121.201.63.17:27014,121.201.63.17:37014 -DmgoHostsApp=121.201.63.17:27015,121.201.63.17:37015 -DmgoHosts3rd=121.201.63.17:27016,121.201.63.17:37016 -DmgoUser=applogs -DmgoPwd=welab201412 -DtoolHost=121.201.24.13 -DtoolPort=9031 -DblacklistHost=121.201.15.220 -DmysqlHost=121.201.13.154 -DmysqlPort=16033 -DmysqlUser=wedefendapp -DmysqlPwd="JrnneE8#VN*&!CVp" -DmysqlDB=wolaidai_olap -DmqUri=amqps://welend:wewe@sgateway.wolaidai.com:25671/production -DruleEngineUrl=121.201.15.220:9080 -DruleEngineUrl2=127.0.0.1:9088 -jar myserver.jar > /dev/null 2>&1 &
