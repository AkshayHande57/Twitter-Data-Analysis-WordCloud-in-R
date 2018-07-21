-- Identifying important columns from EQ_Contract_note_details table.

select top 10 * from EQ_Contract_note_details_April


/*

Below important columns will be required for the intermediate table of EQ_contract_note_Details

CND_ENT_ID (Customer _ID)
CND_DT (Date)
CND_PRODUCT_TYPE
CND_TRADE_NO
CND_SEM_ID (Company_Name)
CND_QTY
CND_PRICE
CND_PURE_BRK

*/

-- Union query with list of only required columns. 
-- Union done on all Table at once.
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK
into EQ_Contract_note_details_All_records
from EQ_Contract_note_details_April 
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from EQ_Contract_note_details_May
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_June]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_July]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_August]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_sept]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Oct]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Nov]
union
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Dec]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Jan]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Feb]
union 
select CND_ENT_ID,
CND_DT,
CND_PRODUCT_TYPE,
CND_TRADE_NO,
CND_SEM_ID,
CND_QTY,
CND_PRICE,
CND_PURE_BRK from [dbo].[EQ_Contract_note_details_Mar]

-- 65995070 rows affected.
-- Duration : 19.29 mins

-- QC for [EQ_Contract_note_details_All_records] 
-- Display top 1000 records from EQ_Contract_note_Details_All_records
select top 100 * from [dbo].[EQ_Contract_note_details_All_records]

-- Min - Max Date 
select min(CND_DT) as 'Min_DT' , max(CND_DT) as 'Max_DT'
from EQ_Contract_note_details_All_records
/*
Min_DT						Max_DT
2017-04-03 00:00:00.0000000	2018-03-28 00:00:00.0000000
*/

-- Distinct ENT_ID 
select distinct(CND_ENT_ID)
from EQ_Contract_note_details_All_records
-- 650398 records retrieved

select distinct(CND_ENT_ID),count(1)
from EQ_Contract_note_details_All_records 
group by CND_ENT_ID
order by count(1) desc

select distinct(CND_TRADE_NO),count(*)
from EQ_Contract_note_details_All_records
group by CND_TRADE_NO