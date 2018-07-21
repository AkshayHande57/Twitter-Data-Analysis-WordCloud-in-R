-- Creating EQ Data Mart from EQ_Contract_note_details_All_records

select top 10 * from EQ_Contract_note_details_All_records
select top 10 * from EQ_Contract_note_details_April

select
cnd_ent_id as 'Cust_ID',
SUBSTRING(convert(varchar,cnd_dt),1,7) as 'Month_ID',
CND_PRODUCT_TYPE as 'Product_Type',
count(distinct(CND_SEM_ID)) as 'No_scrip',
count(distinct(CND_TRADE_NO)) as 'No_Trans',
sum((isnull(CND_QTY,0) * isnull(CND_PRICE,0))) as 'TRNOVR',
sum(CND_PURE_BRK) as 'Pure_Brk'
into MTH_TROVR_BRKG_EQ
from EQ_Contract_note_details_All_records
group by CND_ENT_ID,SUBSTRING(convert(varchar,cnd_dt),1,7),CND_PRODUCT_TYPE
-- (3079422 row(s) affected)
-- duration

-- Command to drop 
drop table MTH_TROVR_BRKG_EQ
drop table EQ_Contract_note_details_All_records


select top 10 * from EQ_Contract_note_details_All_records

select cust_ID,month_id,product_type,count(1)
from MTH_TROVR_BRKG_EQ
group by cust_ID,month_id,pRODUCT_TYPE
-- 3079422 records retrived . 

select cnd_ENT_ID,cnd_DT,cnd_product_type,count(1)
from EQ_Contract_note_details_All_records
group by cnd_ENT_ID,cnd_DT,cnd_product_type



select cust_ID,month_id,PRODUCT_TYPE,count(1)
from MTH_TROVR_BRKG_EQ
group by cust_ID,month_id,PRODUCT_TYPE
having count(1) > 1
-- NUll Records Retrived. 

--------------------------------------------------------------------------------

-- Extracting Cust_ID who has done multiple number of EQ_Transactions. 
select top 1000 * from MTH_TROVR_BRKG_EQ


select top 10 * from EQ_Contract_note_details_All_records

select count(distinct(CND_PRODUCT_TYPE)),count(distinct(CND_TRADE_NO)),count(Distinct(cnd_sem_ID))
from EQ_Contract_note_details_All_records
group by CND_PRODUCT_TYPE,CND_TRADE_NO,cnd_sem_ID


select cust_ID,
count(distinct(CND_PRODUCT_TYPE)) as 'Distinct_Prod',
count(distinct(No_Scrip)) as 'Distinct_Company',
count(Distinct(No_Trans)) as 'Distinct_Transc'
from MTH_TROVR_BRKG_EQ
group by cust_ID
having count(distinct(CND_PRODUCT_TYPE)) > 1
order by count(Distinct(No_Trans))  desc

---------------------------------- PErforming QC --------------------------------

-- Verify TRNOVR Totals & Total_BRK totals for sample customer IDs

-------------------------------- CUST_ID : 937438 --------------------------------

select cnd_ent_ID, sum(a.CND_QTY * a.CND_PRICE) as 'Total_TRNOVR_source_tbl',sum(a.CND_PURE_BRK) as 'Total_BRK_source_tbl'
from EQ_Contract_note_details_All_records a
where CND_ENT_ID = '937438'
group by CND_ENT_ID
/*
cnd_ent_ID	Total_TRNOVR	Total_BRK
937438		69828469.650	190822.0100
*/

select cust_Id,sum(TRNOVR) as 'Total TRNOVR_summary_Rprt'
,sum(PURE_BRK) as 'Total_BRK_summary_Rprt' 
from MTH_TROVR_BRKG_EQ 
where cust_ID = '937438' 
group by cust_Id

/*
cust_Id	Total TRNOVR	Total_BRK
937438	69828469.650	190822.0100
*/


-------------------------------- CUST_ID : 982974 --------------------------------

select cnd_ent_ID, sum(a.CND_QTY * a.CND_PRICE) as 'Total_TRNOVR',sum(a.CND_PURE_BRK) as 'Total_BRK'
from EQ_Contract_note_details_All_records a
where CND_ENT_ID = '982974'
group by CND_ENT_ID
/*
cnd_ent_ID	Total_TRNOVR	Total_BRK
982974		619040146.700	1349728.0200
*/


select cust_Id,sum(TRNOVR) as 'Total TRNOVR'
,sum(Brokerage) as 'Total_BRK' 
from MTH_TROVR_BRKG_EQ 
where cust_ID = '982974' 
group by cust_Id

/*
cust_Id	Total TRNOVR	Total_BRK
982974	619040146.700	1349728.0200
*/

-------------------------------- CUST_ID : 2565646 --------------------------------

select cnd_ent_ID, sum(a.CND_QTY * a.CND_PRICE) as 'Total_TRNOVR',sum(a.CND_PURE_BRK) as 'Total_BRK'
from EQ_Contract_note_details_All_records a
where CND_ENT_ID = '2565646'
group by CND_ENT_ID
/*
cnd_ent_ID	Total_TRNOVR	Total_BRK
2565646		557898538.900	710788.8600
*/

select cust_Id,sum(TRNOVR) as 'Total TRNOVR'
,sum(Brokerage) as 'Total_BRK' 
from MTH_TROVR_BRKG_EQ 
where cust_ID = '2565646' 
group by cust_Id
/*
cust_Id	Total TRNOVR	Total_BRK
2565646	557898538.900	710788.8600
*/

----------------------------------- MIN & MAX Dates FOR both tables -----------------------------------
-- Cust_ID : 982974
select min(cnd_dt) as 'Min_DT_source',max(cnd_dt) as 'Max_DT_source'
from EQ_Contract_note_details_All_records where CND_ENT_ID = '982974'

select min(month_ID) as 'Min_DT_report',max(month_ID) as 'Max_DT_report' 
from [dbo].[MTH_TROVR_BRKG_EQ] where cust_ID = '982974'



-- Cust_ID : 937438
select min(cnd_dt),max(cnd_dt) from EQ_Contract_note_details_All_records where CND_ENT_ID = '937438'
select min(month_ID),max(month_ID) from [dbo].[MTH_TROVR_BRKG_EQ] where cust_ID = '937438'
-------------------------------------------------------------------------------------------------------

--------------------------------- Distinct Count for Company  ---------------------------------
select top 10 * from EQ_Contract_note_details_All_records
select top 10 * from [MTH_TROVR_BRKG_EQ]

select CND_ENT_ID,year(cnd_DT),month(cnd_DT),CND_PRODUCT_TYPE,count(distinct(cnd_SEM_ID))
from EQ_Contract_note_details_All_records where CND_ENT_ID = '982974' 
group by  CND_ENT_ID,year(cnd_DT),month(CND_DT),CND_PRODUCT_TYPE
-- cust_ID	(Sum_SCRIP)
-- 982974	987

select cust_ID,month_ID,cnd_product_type, sum(No_scrip) as 'Sum_SCRIP' from MTH_TROVR_BRKG_EQ where cust_ID = '982974' 
group by cust_ID,month_ID,cnd_product_type
-- cust_ID	(Sum_SCRIP)
-- 982974	987

--------------------------------- Distinct Cust_ID count  ---------------------------------

select count(distinct(Cust_ID)) as 'Distinct_CUST_ID' from MTH_TROVR_BRKG_EQ
/*
Distinct_CUST_ID
650398
*/

select count(Distinct(cnd_ENT_ID)) as 'Count'
from EQ_Contract_note_details_All_records
/*
Count
650398
*/

-------------------------------------------------------------------------------------
--------------------------- Over all Brokerage & Trunover ---------------------------

-- soruce table : EQ_Contract_note_details_All_records
-- Report table : [MTH_TROVR_BRKG_EQ]


-- Total TRNOVR in soure table 
select sum(CND_QTY * CND_PRICE) as 'Total TRNOVR_Source', sum(CND_PURE_BRK) as 'Total Brokerage_Source'
 from EQ_Contract_note_details_All_records
/*
Total TRNOVR		Total Brokerage
1853780248971.070	4560634273.7900
*/

-- TOTAL TRNOVR IN Summary table.
select sum(trnovr) as 'Total TRNOVR_Summary',sum(PURE_BRK) as 'Total Brokerage_Summary' from [MTH_TROVR_BRKG_EQ]
/*
Total TRNOVR		Total Brokerage
1853780248971.070	4560634273.7900
*/


------------------------------------------------------------------------------------------

select * from EQ_Contract_note_details_All_records where CND_ENT_ID = '1210589' and CND_DT between '2017-07-01' and '2017-07-31'
select top(1) * from EQ_Contract_note_details_All_records

select * from [MTH_TROVR_BRKG_EQ] where cust_ID = '1210589'

select  CND_PRODUCT_TYPE,SUM(No_Trans), sum(TRNOVR), SUM(Brokerage), SUM(Notional_TRNOVR)
from [MTH_TROVR_BRKG_EQ] 
GROUP BY CND_PRODUCT_TYPE

select  PRODUCT_TYPE,SUM(No_Trans), sum(Turnover), SUM(Pure_Brk), SUM(Notional_TRNOVR)
from [MTH_TROVR_BRKG_DERV] 
GROUP BY PRODUCT_TYPE

SELECT TOP(1) * FROM [MTH_TROVR_BRKG_DERV]


select  CND_PRODUCT_TYPE,count(distinct(CND_TRADE_NO)), sum(CND_QTY*CND_PRICE), SUM(CND_Pure_Brk)
from EQ_Contract_note_details_All_records 
GROUP BY CND_PRODUCT_TYPE

select top(10) * from EQ_Contract_note_details_All_records

select  CND_PRODUCT_TYPE,SUM(No_Trans), sum(Turnover), SUM(Pure_Brk), SUM(Notional_TRNOVR)
from EQ_Contract_note_details_All_records 
GROUP BY CND_PRODUCT_TYPE

select top(1) * from EQ_Contract_note_details_All_records


select CND_ENT_ID, cnd_TRade_no, count(1) as 'instance' into #TRD_NO_Rep
from EQ_Contract_note_details_All_records 
group by CND_ENT_ID,cnd_TRade_no 
having count(1) > 1 

select * from #TRD_NO_Rep order by instance desc

select * from EQ_Contract_note_details_All_records where CND_ENT_ID = '1210589' and CND_DT between '2017-07-01' and '2017-07-31'
select top(1) * from EQ_Contract_note_details_All_records

select * from EQ_Contract_note_details_All_records where cnd_trade_no = '2018010500480700'