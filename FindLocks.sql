SELECT  A.Session_id,
        A.blocking_session_id,
        DB_NAME(B.database_id) [Database],
        C.text, *
FROM    sys.dm_exec_requests A
        LEFT JOIN sys.dm_exec_requests B ON A.blocking_session_id = B.session_id
        OUTER APPLY sys.dm_exec_sql_text(B.sql_handle) C
WHERE   A.blocking_session_id <> 0
GO

SELECT  A.Session_id,
        A.blocking_session_id,
        DB_NAME(A.database_id) [Database],
        B.text
FROM    sys.dm_exec_requests A        
        CROSS APPLY sys.dm_exec_sql_text(A.sql_handle) B
WHERE   A.blocking_session_id <> 0
GO
exec sp_whoisactive