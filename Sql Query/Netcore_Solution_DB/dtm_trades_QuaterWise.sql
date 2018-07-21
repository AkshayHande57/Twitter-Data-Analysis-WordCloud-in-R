-- Extracting Data from dtm_trades table to Netcore_solution_DB 


-- Q1 
select * into dtm_trades_Q1 from OpenQuery(PRCSN,'select * from dtm_trades
where DTR_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''30-06-2017'',''dd-mm-yyyy'')')
-- dtm_trades_Q1 -- 1289400 -- Execution Time : 10.47 mins

-- Q2 1st June to 30th Sept 2017
select * into dtm_trades_Q2 from OpenQuery(PRCSN,'select * from dtm_trades
where DTR_DT between To_date(''01-07-2017'',''dd-mm-yyyy'') and To_date(''30-09-2017'',''dd-mm-yyyy'')')
-- dtm_trades_Q2 - 1484220  - Execution Time : 13.18 mins  

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


-- Q3 1st Oct 2017 to 31st Dec 2017
select * into dtm_trades_Q3 from OpenQuery(PRCSN,'select * from dtm_trades
where DTR_DT between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''31-12-2017'',''dd-mm-yyyy'')')
-- dtm_trades_Q3 --1555223  --Execution Time : 12.45 mins  

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



-- Q4 1st Jan 2018 to 31st March 2018
select * into dtm_trades_Q4 from OpenQuery(PRCSN,'select * from dtm_trades
where DTR_DT between To_date(''01-01-2018'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- dtm_trades_Q4 --1707026   --Execution Time : 13.44 mins  

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

-- Total Number of all records for dtm_trades table. 
-- Q1 + Q2 + Q3 + Q4 = 


-- Combing all records for dtm_trades table.
select * into dtm_trades_All_records
from dtm_trades_Q1
UNION 
select * from dtm_trades_Q2
UNION
select * from dtm_trades_Q3
UNION 
select * from dtm_trades_Q4
-- (6035869 row(s) affected)  old 
-- 

-- Drop Tables 
drop table [dbo].[dtm_trades_All_records]



-- QC Check on dtm_trades tables
select min(DTR_DT), max(DTR_DT) from dtm_trades_all_records

select  * from [dbo].[dtm_trades_All_records] 
where [DTR_CP_CD] is not null 

