USE [MoM_dev]
select * from hr.v_Employee where Login = 'eroseberry'
update hr.tblEmployee set login = 'groseberry' where EmployeeID = 81
update dbo.aspnet_Users set UserName = 'ONCOLOGY\groseberry', LoweredUserName = 'oncology\groseberry' where ApplicationId = '2E1102E7-4688-4F4D-A3BD-C0B808659E3E' and username like '%roseberry%'

update hr.tblEmployee set login = 'eroseberry' where EmployeeID = 81
update dbo.aspnet_Users set UserName = 'CLSNET\eroseberry', LoweredUserName = 'clsnet\eroseberry' where ApplicationId = '2E1102E7-4688-4F4D-A3BD-C0B808659E3E' and username like '%roseberry%'

select * from hr.v_Employee where login like '%roseberry%'
select * from dbo.aspnet_Users where username like '%roseberry%'

--===================================================================
select * from hr.v_Employee where Login = 'rgama'
update hr.tblEmployee set login = 'rgama' where EmployeeID = 188

select * from dbo.aspnet_Users where username like '%roseberry%' or username like '%rgama%'
update dbo.aspnet_Users set UserName = 'CLSNET\rgama', LoweredUserName = 'clsnet\rgama' where ApplicationId = '2E1102E7-4688-4F4D-A3BD-C0B808659E3E' and username like '%rgama%'
