checkpoint

use tempdb
dbcc shrinkfile (tempdev, 10)
dbcc shrinkfile (templog, 10)

-- Data available Clean up 

checkpoint

USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB' , 0, TRUNCATEONLY)
GO

checkpoint

USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB_1' , 0, TRUNCATEONLY)
GO

checkpoint

USE [Netcore_solution_DB]
GO

checkpoint

-- Clean log file 
USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB_log' , 0, TRUNCATEONLY)
GO

checkpoint 

USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB_log2' , 0, TRUNCATEONLY)
GO

checkpoint

DBCC SHRINKFILE (N'Netcore_solution_DB_log_1' , 0, TRUNCATEONLY)
GO

checkpoint