#!/bin/bash

read -p " 请输入贷款申请ID： > >  " loanId
    echo "输入的贷款申请ID为:"${loanId}
account=""
if [ "$loanId" == "" ] ; then
    read -p " 请输入手机号： > >  " account
    echo "输入的手机号为:"${account}
fi
name=""
if [ "$loanId" == "" -a "$account" == "" ] ; then
    read -p " 请输入姓名： > >  " name
    echo "输入的姓名为：${name}"
fi

if [ "$loanId" != "" ] ; then
    lId=$(/data2/welab/mongodb/bin/mongo business -quiet --eval "db.LoanApplication.findOne({'id' : '$loanId'},{"_id":0,"id":1});")

    if [ "$lId" == "null" ];then
	echo "没有找到贷款ID为【${loanId}】的贷款申请"
	exit
    fi
fi

if [ "$loanId" == "" -a "$account" != "" ] ; then
    lId=$(/data2/welab/mongodb/bin/mongo business -quiet --eval "db.LoanApplication.findOne({'account' : $account},{"_id":0,"id":1});")
    if [ "$lId" == "null" ];then
	echo "没有找到手机号为【${account}】的贷款申请"
	exit
    else
	aid=${lId:10}
	loanId=${aidd%\"*}
    fi
fi
if [ "$loanId" == "" -a "$account" == "" -a "$name" != "" ] ; then
    lId=$(/data2/welab/mongodb/bin/mongo business -quiet --eval "db.LoanApplication.findOne({'detail.profile.name' : $name},{"_id":0,"id":1});")
    if [ "$lId" == "null" ];then
	echo "没有找到姓名为【${name}】的贷款申请"
	exit
    else
	aid=${lId:10}
	loanId=${aidd%\"*}
    fi
fi

./argFile.sh $loanId $account $name >inputArg.js

./thirdData.sh $loanId >/dev/null 2>&1

/data2/welab/mongodb/bin/mongo outputReport.js -quiet
