#!/bin/bash
#只能支持手机号account和贷款id
echo "--------------------打印命中短信关键字[开始]--------------------"
para=$1
if [ ${#para} -lt "1" ] ; 
then 
  echo Invalid Input!; 
  exit 1; 
fi 

if [ ${#para} -eq "11" ] ; then 
  query={\"account\":\"$para\"}; 
else
  query={\"id\":\"$para\"}
fi

echo The query statement is: $query

$mongoHome/mongo business -u test -p 123456 --eval 'db.RulesCache.find('$query').forEach(
function (obj) { 
    for ( x in obj.hit_rules) { 
        if(obj.hit_rules[x].name !="Rule2013") { continue;}    
       // print (obj.hit_rules[x].desc,":",obj.hit_rules[x].result.matchedKeywordSmsList); 
        smsobj=obj.hit_rules[x].result.matchedKeywordSmsList; 
        for(p in smsobj){ 
      	  print(p,":", smsobj[p]); 
       for(arr in smsobj.p) {
             print (smsobj.p[arr]);
          }
       } 
    } 
} 
);'| awk 'NR>2'
echo "--------------------打印命中短信关键字[结束]--------------------"
