USE MASTER;
GO

ALTER DATABASE Netcore_solution_DB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

EXEC MASTER.dbo.sp_detach_db @dbname = N'Netcore_solution_DB'
GO

CREATE DATABASE [Netcore_solution_DB] ON
( FILENAME = N'D:\MSSQLDATA\Netcore_solution_DB.mdf' ),
( FILENAME = N'D:\MSSQLDATA\Netcore_solution_DB_log.ldf' )
FOR ATTACH
GO