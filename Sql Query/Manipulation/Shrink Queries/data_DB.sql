USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB' , 13000)
GO
/*
DbId	FileId	CurrentSize	MinimumSize	UsedPages	EstimatedPages
8		1		2135600		384			1623496		1623496

*/

USE [Netcore_solution_DB]
GO
DBCC SHRINKFILE (N'Netcore_solution_DB' , 0, TRUNCATEONLY)
GO
