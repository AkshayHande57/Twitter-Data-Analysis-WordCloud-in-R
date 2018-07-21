-- Temp Join table
drop table temp_join

select a.[DTR_TRD_NO], b.[DCD_TRADE_NO] into temp_join
from [dbo].[dtm_trades_All_records] a full outer join [dbo].[dtm_contract_note_details_All_records] b 
on a.[DTR_TRD_NO]=  b.[DCD_TRADE_NO]
-- 6134177 

select top 100 * from temp_join
-- 6134177

select distinct(dcd_trade_no),count(*)
from temp_join
group by dcd_trade_no


select 
count(dtr_trd_no) as 'Not_Null in dtr_trd_no', 
count(*) - count(dtr_trd_no) as 'Null in dtr_trd_no', 
count(dcd_trade_no) as 'Not_Null  in dcd_trade_no', 
count(*) - count(dcd_trade_no) as 'Null in dcd_trade_no'
from temp_join 
/*
Not_Null in dtr_trd_no	Null in dtr_trd_no	Not_Null  in dcd_trade_no	Null in dcd_trade_no
6120953					13224				5932299						201878
*/
----------------------------------------------------------------------------------------

select * from temp_join where dcd_trade_no is null 
-- 201878 

select * from temp_join where	dtr_trd_no is null 
-- 13224

select * from temp_join where dcd_trade_no is not null 
-- 5932299

select * from temp_join where	dtr_trd_no is not null 
-- 6120953

select top 1000 * From temp_join

select * from [dbo].[dtm_trades_All_records] where [DTR_TRD_NO] = '2017041237534280'

select * from [dbo].[dtm_trades_All_records] where [DTR_TRD_NO] = '2017051275122996'

select * from [dbo].[dtm_contract_note_details_All_records] where dcd_Trade_no = '1'


-- Missing Pure Brokerage Amount.
SELECT [DTR_TRD_NO]
      ,[DCD_TRADE_NO]
      ,[DCD_PURE_BRK]
  FROM [Netcore_solution_DB].[dbo].[all_trd_brk_table]
  where dcd_pure_brk is  null 

-- 215102 records are number of records for which we dont have pure_Brk amount after joining table.



