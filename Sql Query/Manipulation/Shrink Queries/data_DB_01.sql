USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB_1' , 31000)
GO
/*
DbId	FileId	CurrentSize	MinimumSize	UsedPages	EstimatedPages
8		3		3968000		384			3911112		3911112
*/