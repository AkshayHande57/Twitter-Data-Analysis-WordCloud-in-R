-- These can be run as one batch.
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 
GO 
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', 
    'DynamicParameters', 1 
GO

-- Run each of the following queries individually.
EXEC sp_configure 'show advanced options',1
reconfigure
EXEC sp_configure 'Ad Hoc Distributed Queries', 1
Reconfigure