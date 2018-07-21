-- Phase 1 Tables 

-- EQ_Contract_note_details Table.
select count(1) from EQ_contract_note_details_All_records
-- 66513573 

select top 100 * from EQ_contract_note_details_All_records
---------------------------------------------------------------------

-- MTH_TROVR_BRKG_EQ
select top 100 * from MTH_TROVR_BRKG_EQ

select count(1) from MTH_TROVR_BRKG_EQ -- 3079422

-- Sum of total_Pure_Brk acrosss multiple products 
select Product_Type,sum(Pure_Brk) as 'Sum_Pure_Brk' 
from MTH_TROVR_BRKG_EQ
group by Product_Type 
/*
Product_Type	Sum_Pure_Brk
CNC				3165823337.5700
MARGIN			943553947.6800
SPOT			10885582.0000
T+2				440371406.5400
*/

-----------------------------------------------------------------------------------------
-- Derivaties contract note details all records
select top 100 * from dtm_contract_note_details_All_records
select count(1) from dtm_contract_note_details_All_records
-- 5909619

-- Derv
select top 100 * from drv_Contract_note_details_All_records
-----------------------------------------------------------------------------------------
-- MTH_TROVR_BRKG_DERV 
select * from MTH_TROVR_BRKG_DERV 
select count(*) from MTH_TROVR_BRKG_DERV
-- 150230
-----------------------------------------------------------------------------------------
-- MTH_TRNOVR_BRKG 
select * from MTH_TRNOVR_BRKG 
select count(1) from MTH_TRNOVR_BRKG -- 3229652

select Product_Type,sum(Pure_brk) as 'Total_Pure_brk' from MTH_TRNOVR_BRKG
group by Product_type
/*
Product_Type	Total_Pure_brk
CNC				3165823337.57
FUT				590668315.08
MARGIN			943553947.68
OPT				614625650.72
SPOT			10885582.00
T+2				440371406.54
*/

select count(1) from MTH_TRNOVR_BRKG -- 3229652 


------------------------------------------------------------------------
-- BRKG_TRNOVR_CUST_PROD
select top 10 * from MTH_TRNOVR_BRKG
select top 10 * from BRKG_TRNOVR_CUST_PROD 
select count(1) from BRKG_TRNOVR_CUST_PROD -- 653207
------------------------------------------------------------------------
-- Percentage_Share_BRKG_TRNOVR
select * from Percentage_Share_BRKG_TRNOVR

------------------------------------------------------------------------
-- Creating Product_Preference table.
select CUST_ID ,
case 
	when PS_BRKG_DELIVERY >= 90 then 'DELIVERY'
	when PS_BRKG_MARGIN >= 90 then 'MARGIN'
	when PS_BRKG_FUT >= 60 then 'FUT'
	when PS_BRKG_OPT >= 60 then 'OPT'
	ELSE 'MIX'
end as 'PREFERRED_PRODUCT'
into ##product_Pref
from Percentage_Share_BRKG_TRNOVR
-- (653207 row(s) affected)

select * from ##product_Pref
select count(distinct(cust_ID)) as 'Count' from ##product_Pref -- 653207

-- Preference Product Count 
select PREFERRED_PRODUCT,count(distinct(CUST_ID)) as 'Count' 
from ##product_Pref 
group by PREFERRED_PRODUCT
order by count(distinct(CUST_ID)) desc
/*
PREFERRED_PRODUCT	Count
DELIVERY			574073
MARGIN				39255
MIX					26478
OPT					9097
FUT					4304
*/
