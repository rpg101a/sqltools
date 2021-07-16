uSE master;

DECLARE @kill varchar(8000); SET @kill = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'  
FROM master..sysprocesses  
WHERE dbid = db_id('mom_dev')

EXEC(@kill); 
