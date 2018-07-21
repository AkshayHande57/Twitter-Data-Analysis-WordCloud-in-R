-- Extracting Entity_Master table to Netcore_solution_DB 

select * into Entity_Master from OpenQuery(PRCSN,'select * from entity_master') 
-- (3009075 row(s) affected) Duration : 1hours .51 mins

select * from Entity_Master
-- 3009075 - Execution Time : 9min 20sec



