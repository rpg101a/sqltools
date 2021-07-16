SELECT windows_release, windows_service_pack_level, windows_sku, os_language_version  
FROM sys.dm_os_windows_info;  

select serverproperty('productlevel'),
serverproperty('productversion'),
serverproperty('edition')

SELECT windows_release, windows_service_pack_level, 
       windows_sku, os_language_version
FROM sys.dm_os_windows_info WITH (NOLOCK) OPTION (RECOMPILE);