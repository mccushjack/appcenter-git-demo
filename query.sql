--name=bar
Select top 100 
x1.UserName
,x2.ObjectDatabaseName as ObjectDatabaseName
,x2.ObjectTableName as ObjectTableName
--,x2.ObjectColumnName as ObjectColumnName
,count(distinct x2.queryid) as num_query
,Count(*)
,SUM(AMPCPUTime)
,SUM(TotalIOCount)
,SUM(ReqIOKB)
,SUM(ReqPhysIO)
,SUM(ReqPhysIOKB)
from DBC.DBQLogTbl x1,
      DBC.DBQLObjTbl x2
where x1.QueryID = x2.QueryID
  and x1.ProcID = x2.ProcID
  and lower(x1.statementtype) = 'select'
 -- and cast(x1.starttime as date) >= DATE - 5
  and (x2.ObjectType ='Tab'
  or x2.ObjectType ='Col')
  group by
   x1.UserName
  ,ObjectDatabaseName
  ,ObjectTableName
  ,ObjectColumnName
  order by num_query DESC;
	-- end of query