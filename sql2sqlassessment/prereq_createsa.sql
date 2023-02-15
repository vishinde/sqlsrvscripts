USE [master]
GO
CREATE LOGIN [test] WITH PASSWORD=N'P@ssword1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
EXEC master..sp_addsrvrolemember @loginame = N'test', @rolename = N'sysadmin'