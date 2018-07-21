-- Union of MTH_TRNOVR_BRK_EQ  & MTH_TRNOVR_BRK_DERV tables.

-- Display all cloumns for EQ & DERV.
select top 10 * from MTH_TROVR_BRKG_EQ
select top 10 * from MTH_TROVR_BRKG_DERV

-- Count of records in each table.
select count(*) as 'Total Nos of records in EQ' from MTH_TROVR_BRKG_EQ -- 3079422
select count(*) as 'Total Nos of records in EQ' from MTH_TROVR_BRKG_DERV -- 150230

-- Notional_TRONVR column is missing from MTH_TROVR_BRKG_EQ 
-- Creating new column in Notional_TRNOVR in MTH_TROVR_BRKG_EQ
alter table MTH_TROVR_BRKG_EQ
add N_TRNOVR numeric 

update MTH_TROVR_BRKG_EQ set N_TRNOVR = 0
-- 3079422

-- Union of EQ & DERV tables. 
select CUST_ID,MONTH_ID,PRODUCT_TYPE,Pure_Brk,TRNOVR,N_TRNOVR,NO_SCRIP,NO_TRANS
into MTH_TRNOVR_BRKG
from MTH_TROVR_BRKG_EQ 
union 
select CUST_ID,MONTH_ID,PRODUCT_TYPE,PURE_BRK,TRNOVR,N_TRNOVR,NO_SCRIP,NO_TRANS 
from MTH_TROVR_BRKG_DERV
-- (3229652 row(s) affected)

-- Display all records and columns.
select top 100 * from MTH_TRNOVR_BRKG
-- 3229652 rows 
-- duration : 48 secs

-- Command to drop table.
drop table MTH_TRNOVR_BRKG

-- REName column names.
exec sp_rename 'MTH_TRNOVR_BRKG.CND_PRODUCT_TYPE','PRODUCT_TYPE','COLUMN'

------------------------- Analysis of MTH_TRNOVR_BRKG ------------------------------------------

-- PRODUCT TYPE wise count :
select distinct(PRODUCT_TYPE),count(*) as 'Count'
from MTH_TRNOVR_BRKG
group by PRODUCT_TYPE
/*
PRODUCT_TYPE	Count
CNC				2725636
FUT				58754
MARGIN			261204
OPT				91476
SPOT			12856
T+2				79726
*/

-- MONTH_ID WISE COUNT 
select distinct(MONTH_ID),count(*) as 'Count'
from MTH_TRNOVR_BRKG
group by MONTH_ID
/*
MONTH_ID	Count
2017-04		228314
2017-05		245965
2017-06		225065
2017-07		257129
2017-08		257817
2017-09		264361
2017-10		283851
2017-11		310227
2017-12		291783
2018-01		320652
2018-02		282708
2018-03		261780
*/


-----------------------  QC check on MTH_TRNOVR_BRKG ----------------------- 
----------------------- Check on TRNOVR, BROKERRAGE, NOTIONAL_TRNOVR ----------------

----------------------- MTH_TRNOVR_BRKG for FUT & OPT -----------------------
select 
sum(TRNOVR) as 'Total_TRNOVR_FUT_OPT',
sum(N_TRNOVR) as 'TOTAL_NTRNOVR_FUT_OPT',
sum(Pure_BRK) as 'Total_BRK_FUT_OPT'
from MTH_TRNOVR_BRKG
where PRODUCT_TYPE = 'FUT' or PRODUCT_TYPE = 'OPT'
/*
Total_TRNOVR_FUT_OPT	TOTAL_NTRNOVR_FUT_OPT	Total_BRK_FUT_OPT
8093147385515.900		12285277333147.750		1205293965.80
*/

----------------------- MTH_TROVR_BRKG_DERV -----------------------
select  sum(b.TRNOVR) as 'Total_TRNOVR', sum(b.N_TRNOVR) as 'Total_N_TRNOVR' ,
sum(b.Pure_BRK) as 'TOTAL_PURE_BRK'
from MTH_TROVR_BRKG_DERV b
/*
Total_TRNOVR		Total_N_TRNOVR		TOTAL_PURE_BRK
1950732143783.150	12285277333147.750	1205293965.80
*/

-------------------------------------------------------------------------

----------------------- MTH_TRNOVR_BRKG for CNC	, MARGIN , SPOT , T+2  -----------------------
select 
sum(TRNOVR) as 'Total_TRNOVR_EQ',
sum(N_TRNOVR) as 'TOTAL_NTRNOVR_EQ',
sum(Pure_BRK) as 'Total_BRK_EQ'
from MTH_TRNOVR_BRKG
where PRODUCT_TYPE  = 'CNC' or PRODUCT_TYPE = 'MARGIN' or PRODUCT_TYPE = 'SPOT' or PRODUCT_TYPE = 'T+2'
/*
Total_TRNOVR_EQ		TOTAL_NTRNOVR_EQ	Total_BRK_EQ
1853780248971.070	0.000				4560634273.79
*/

select sum(trnovr) as 'Total TRNOVR_Summary',
sum(N_TRNOVR) as 'N_TRNOVR_SUMMARY',
sum(Pure_BRK) as 'Total Brokerage_Summary' 
from [MTH_TROVR_BRKG_EQ] 
/*
Total TRNOVR_Summary	N_TRNOVR_SUMMARY	Total Brokerage_Summary
1853780248971.070		0					4560634273.7900
*/

-------------------------------------------------------------------------

-- Display top 10 rows 
select top 10000 * from MTH_TRNOVR_BRKG where PRODUCT_TYPE = 'CNC'
select distinct(PRODUCT_TYPE) from MTH_TRNOVR_BRKG

-- Adding new column EQ_FO_FLG in MTH_TRNOVR_BRKG table.
alter table MTH_TRNOVR_BRKG
add EQ_FO_FLG varchar(5)

update MTH_TRNOVR_BRKG
set EQ_FO_FLG = case 
					when PRODUCT_TYPE in ('CNC','MARGIN','SPOT','T+2') then 'EQ'
					when PRODUCT_TYPE in ('FUT','OPT') then 'FO'
				end 
-- (3229652 row(s) affected)


---------------------------------------------------------------------------------------------------
-- Total Sum of TRNOVR, N_TRNOVR,PURE_BRK across different Product_Type.
select PRODUCT_TYPE,
sum(TRNOVR) as 'Total_TRNOVR',
sum(N_TRNOVR) as 'Total_N_TRNOVR',
sum(Pure_BRK) as 'Total_Pure_BRK'
from MTH_TRNOVR_BRKG
group by PRODUCT_TYPE
/*
PRODUCT_TYPE	Total_TRNOVR		Total_N_TRNOVR		Total_Pure_BRK
CNC				1189529098750.430	0.000				3165823337.57
FUT				1950732143783.150	NULL				590668315.08
MARGIN			487782357603.240	0.000				943553947.68
OPT				6142415241732.750	12285277333147.750	614625650.72
SPOT			1920162794.460		0.000				10885582.00
T+2				174548629822.940	0.000				440371406.54

*/


--
select top 100 * from MTH_TRNOVR_BRKG
select count(1) from MTH_TRNOVR_BRKG

select top 100 * from MTH_TRNOVR_BRKG
select top 100 * from [dbo].[dtm_contract_note_details_All_records]
select top 100 * from [dbo].[EQ_Contract_note_details_All_records]

select month_Id,count(distinct(cust_ID)) as 'Count_Cust' from MTH_TRNOVR_BRKG 
group by month_Id,product_type
order by month_ID

/*
month_Id	Count_Cust
2017-04	5570
2017-04	6416
2017-04	831
2017-04	20593
2017-04	190609
2017-04	4295
*/

--228314

select distinct month_id,product_type, sum(pure_brk) as 'Total_Pure_Brk',
sum(trnovr) as 'Total_Trnovr',
sum(n_trnovr) as 'Total_N_Trnovr',
count(distinct(cust_ID)) as 'Count_Cust'
from MTH_TRNOVR_BRKG group by month_id,product_type
order by month_id
/*
Result saved in Excel sheet
*/
select top 100 *  from MTH_TRNOVR_BRKG
select top 100 *  from BRKG_TRNOVR_CUST_PROD

select * from BRKG_TRNOVR_CUST_PROD
where cust_ID = '879567'

select cust_Id,month_ID,product_type,sum(pure_brk)as 'Total_pure_brk',
sum(trnovr) as 'Total_Trnovr' ,
sum(n_trnovr)as 'Total_n_trnovr' from MTH_TRNOVR_BRKG
where cust_ID = '879567'
group by cust_ID,month_Id,product_type
order by month_ID

