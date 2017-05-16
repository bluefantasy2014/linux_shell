#!/bin/bash
#入口主方法调用，可以传入贷款id，身份证号，手机号中的任意一个参数
mongoHome=/data/welabx/mongodb/mongo/bin

para=$1
if [ ${#para} -lt "1" ] ; 
then 
  echo Invalid Input!; 
  exit 1; 
fi 

if [ ${#para} -eq "11" ] ; then 
  query={\"account\":\"$para\"}; 
elif [ ${#para} -eq "18" -o ${#para} -eq "15" ]; then 
  query={\"detail.profile.cnid\":\"$para\"}
else 
  query={\"id\":\"$para\"}
fi

echo The query statement is: $query

#cd $mongoHome
myvar=`$mongoHome/mongo business -u test -p 123456 --eval 'db.LoanApplication.find('$query').limit(1).forEach(function (obj) {
 print (obj.id,":",obj.account,":",obj.detail.profile.cnid); 
 } );' | awk 'NR>2'`
echo $myvar
loanid=`echo $myvar | awk -F: '{print $1}'`
account=`echo $myvar | awk -F: '{print $2}'`
cnid=`echo $myvar | awk -F: '{print $3}'`
echo "loanid:"$loanid" account:"$account" cnid:"$cnid
echo "开始打印相关信息........"

. ./printHitRules.sh $loanid
. ./printHitSmsMatchKeywords.sh $loanid


