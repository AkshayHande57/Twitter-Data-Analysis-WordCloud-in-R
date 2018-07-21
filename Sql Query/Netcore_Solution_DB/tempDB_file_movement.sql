-- Moving TempDB file from C:\ drive to D:\ drive 
USE TempDB
GO
EXEC sp_helpfile
GO


ALTER DATABASE TempDB MODIFY FILE
(NAME = tempdev, FILENAME = 'D:\MSSQLDATA\tempdb.mdf')

ALTER DATABASE TempDB MODIFY FILE
(NAME = templog, FILENAME = 'D:\MSSQLDATA\templog.ldf')