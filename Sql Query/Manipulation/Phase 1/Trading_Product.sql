-- Working on Trading Product of customer. 
 
select top 1000 * from MTH_TRNOVR_BRKG
select count(1) from MTH_TRNOVR_BRKG -- 3229652
select count(distinct(Cust_ID)) from MTH_TRNOVR_BRKG -- 653209
select * from MTH_TRNOVR_BRKG order by CUST_ID
-----------------------------------------------------------------------------
select * from MTH_TRNOVR_BRKG
	
select Product_Type,sum(Pure_brk) as 'Total_Pure_brk',
count(distinct(cust_ID)) as 'Count'
from MTH_TRNOVR_BRKG
group by Product_type
order by sum(Pure_Brk) desc
/*
Product_Type	Total_Pure_brk	Count
CNC				3165823337.57	613164
MARGIN			943553947.68	45165
OPT				614625650.72	20627
FUT				590668315.08	11201
T+2				440371406.54	27579
SPOT			10885582.00		8558
*/

select * from MTH_TRNOVR_BRKG

select TRD_PROD,sum(Pure_brk) as 'Total_Pure_brk',
count(distinct(cust_ID)) as 'Count'
from MTH_TRNOVR_BRKG
group by TRD_PROD
order by sum(Pure_Brk) desc
/*
TRD_PROD	Total_Pure_brk	Count
DELIVERY	3176708919.57	614749
MARGIN		1383925354.22	72043
OPT			614625650.72	20627
FUT			590668315.08	11201
*/

-----------------------------------------------------------------------------
-- Count distinct customer across product
select Product_Type,count(distinct(CUST_ID)) as 'Distinct_Customer' from MTH_TRNOVR_BRKG
group by Product_type
order by count(distinct(cust_ID)) desc

-----------------------------------------------------------------------------
select count(distinct(cust_ID)) from MTH_TRNOVR_BRKG -- 653209
-----------------------------------------------------------------------------
-- Creating New flag for Trading Product type in MTH_TRNOVR_BRKG table 
select top 100 * from MTH_TRNOVR_BRKG order by cust_ID

-- Adding new flag column to the table.
alter table MTH_TRNOVR_BRKG
add TRD_PROD varchar(15) 

update MTH_TRNOVR_BRKG
set TRD_PROD = 
	case 
		when PRODUCT_TYPE = 'CNC' then 'DELIVERY' 
		when PRODUCT_TYPE = 'SPOT' then 'DELIVERY' 
		when PRODUCT_TYPE = 'MARGIN' then 'MARGIN' 
		when PRODUCT_TYPE = 'T+2' then 'MARGIN' 
		when PRODUCT_TYPE = 'FUT' then 'FUT'
		when PRODUCT_TYPE = 'OPT' then 'OPT'
	end 
-- (3229652 row(s) affected)
------------------------------------------------------------------------------------
-- Count across TRD_PROD
select TRD_PROD,count(distinct(cust_ID)) as 'Count'
from MTH_TRNOVR_BRKG 
group by TRD_PROD
order by count(1) desc
/*
TRD_PROD	Count
DELIVERY	2738492
MARGIN		340930
OPT			91476
FUT			58754
*/

select PRODUCT_TYPE,count(1) as 'Count'
from MTH_TRNOVR_BRKG 
group by PRODUCT_TYPE
order by count(1) desc
/*
PRODUCT_TYPE	Count
CNC				2725636
MARGIN			261204
OPT				91476
T+2				79726
FUT				58754
SPOT			12856
*/
--------------------------------------------------------------------------------------
select * from MTH_TRNOVR_BRKG order by CUST_ID


-- Count across TRD_PROD
select TRD_PROD,sum(Pure_Brk) as 'Total_Brokerage'
from MTH_TRNOVR_BRKG 
group by TRD_PROD
order by sum(Pure_Brk) desc
/*
TRD_PROD	Total_Brokerage
DELIVERY	3176708919.57
MARGIN		1383925354.22
OPT			614625650.72
FUT			590668315.08
*/

select PRODUCT_TYPE,sum(Pure_Brk) as 'Total_Brokerage'
from MTH_TRNOVR_BRKG 
group by PRODUCT_TYPE
order by sum(Pure_Brk) desc
/*
PRODUCT_TYPE	Count
CNC				2725636
MARGIN			261204
OPT				91476
T+2				79726
FUT				58754
SPOT			12856
*/


--------------------------------------------------------------------------------------
-- Creating Pivot table for customer who have traded in multiple product. 
-- Pivoting table to capture for each customer & product type in which it has traded.

select  CUST_ID,
	[DELIVERY] as 'DELIVERY',
	[MARGIN] as 'MARGIN',
	[FUT] as 'FUT',
	[OPT] as 'OPT'
into Cust_TRD_PRODUCT
from  
( 
select  CUST_ID,TRD_PROD
from MTH_TRNOVR_BRKG 
) as source
pivot
(
	max(TRD_PROD)
	for TRD_PROD in ([DELIVERY],[MARGIN],[FUT],[OPT])
) as Pivot_TABLES 

select * from Cust_TRD_PRODUCT order by cust_ID

---------------------------------------------------------------------------------------
-- QC on CUST_TRD_PRODUCT table. 
-- 1000009 -> M 
-- 1000033 -> M + F + O 
-- 1000028 -> D
-- 1000055 -> D + M 
-- 1000119 -> D + F + O 
-- 1000287 -> D + O 
-- 1000429 -> D + F 
-- 1000530 -> M + F 


select * from MTH_TRNOVR_BRKG where cust_ID = '1000009'
select * from MTH_TRNOVR_BRKG where cust_ID = '1000033'
select * from Cust_TRD_PRODUCT where cust_ID = '1000033'
---------------------------------------------------------------------------------------
-- Cust_TRD_PROD Table. 

select * from Cust_TRD_PRODUCT order by cust_ID
select count(distinct(cust_ID)) from Cust_TRD_PRODUCT -- 653209

---------------------------------------------------------------------------------------
-- Adding new column to CUST_TRD_PRODUCT table
select * from Cust_TRD_PRODUCT order by cust_ID

-- Adding new column 'TRD_PRODUCT' 
alter table CUST_TRD_PRODUCT 
add TRD_PRODUCT varchar(50) 

update CUST_TRD_PRODUCT
set TRD_PRODUCT = 
	case 
		when Delivery is not null and Margin is null and Fut is null and OPT is null then 'Only_Delivery'
		when Margin is not null and DELIVERY is null and Fut is null and OPT is null then 'Only_Margin'
		when FUT is not null and DELIVERY is null and Margin is null and OPT is null then 'Only_FUT'
		when OPT is not null and DELIVERY is null and Margin is null and FUT is null then 'Only_OPT'

		when Delivery is not null and Margin is not null and Fut is null and OPT is null then 'Del_Mar'
		when Delivery is not null and Fut is not null and Margin is null and OPT is null then 'Del_FUT'
		when Delivery is not null and OPT is not null and Margin is null and FUT is null then 'Del_OPT'

		when Delivery is null and Margin is not null and Fut is not null and OPT is null then 'Mar_FUT'
		when Delivery is null and Margin is not null and Fut is null and OPT is not null then 'Mar_OPT'

		when Delivery is null and Margin is null and Fut is not null and OPT is not null then 'FUT_OPT'
	
		when Delivery is not null and Margin is not null and Fut is not null and OPT is not null then 'Mix'

		when Delivery is not null and Margin is not null and Fut is null and OPT is not null then 'Del_Mar_OPT'
		when Delivery is not null and Margin is not null and Fut is not null and OPT is null then 'Del_Mar_FUT'

		when Delivery is not null and Margin is null and Fut is not null and OPT is not null then 'Del_FUT_OPT'
		when Delivery is null and Margin is not null and Fut is not null and OPT is not null then 'Mar_FUT_OPT'
	end
-- (653207 row(s) affected) 

select * from Cust_TRD_PRODUCT order by cust_ID 

-- Count across Traded Product type.
select TRD_PRODUCT,count(distinct(cust_ID)) as 'Count' 
from Cust_TRD_PRODUCT 
group by TRD_PRODUCT
order by count(distinct(cust_ID)) desc

----------------------------------------------------------------------------------------------
-- Pure Brokerage across products for only delivery, margin , fut & Option based customer. 
select top 100 * from MTH_TRNOVR_BRKG 
select count(*) from MTH_TRNOVR_BRKG -- 3229652
select count(distinct(cust_ID)) from MTH_TRNOVR_BRKG -- 653209

select top 100 * from Cust_TRD_PRODUCT
select count(*) from Cust_TRD_PRODUCT -- 653209
select count(distinct(cust_ID)) from Cust_TRD_PRODUCT -- 653209

select a.*,b.TRD_PRODUCT as 'Trading_Product' 
into CUST_TRD_PROD_BRKG
from MTH_TRNOVR_BRKG a left join Cust_TRD_PRODUCT b on 
a.CUST_ID = b.CUST_ID
order by CUST_ID
-- (3229652 row(s) affected)

select * from CUST_TRD_PROD_BRKG

-- Total brkg across trading product.
select Trading_Product,sum(Pure_Brk) as 'Total_Pure_Brk'
from CUST_TRD_PROD_BRKG 
group by Trading_Product 
order by sum(Pure_Brk) desc

select Trading_Product,count(distinct(cust_ID)) as 'Unique_Cust_Count',
sum(Pure_Brk) as 'Total_Pure_Brk'
from CUST_TRD_PROD_BRKG 
group by Trading_Product 
order by count(distinct(cust_ID)) desc

----------------------------------------------------------------------------------------------
-- Joining Final_Customer_One_View & CUST_TRD_PROD_BRKG table 
select * from Final_Customer_One_View
select count(*) from Final_Customer_One_View -- 653207
select count(distinct(cust_ID)) from Final_Customer_One_View -- 653207 

select * from CUST_TRD_PROD_BRKG order by CUST_ID

-- Creating Temporary Traded_Product table with distinct Cust_ID
select cust_ID,Trading_Product as 'Traded_Product',sum(Pure_Brk) as 'Total_Pure_Brokerage'
into ##Distinct_Cust_Traded_Product
from CUST_TRD_PROD_BRKG 
group by cust_ID,Trading_Product
order by cust_ID
-- (653207 row(s) affected) 


select * from ##Distinct_Cust_Traded_Product order by CUST_ID
select count(distinct(cust_ID)) as 'Count' from ##Distinct_Cust_Traded_Product -- 653209
----------------------------------------------------------------------------------------------
-- Creating temporary table Final_customer_One_view table
select a.*,b.Traded_Product  into ##Final_Cust_One_View
from Final_Customer_One_View a left join ##Distinct_Cust_Traded_Product b 
on a.CUST_ID = b.CUST_ID

select count(*) from ##Final_Cust_One_View -- 653207
select * from ##Final_Cust_One_View

select Traded_Product,count(distinct(cust_ID)) as 'Count'
from ##Final_Cust_One_View
group by Traded_Product
----------------------------------------------------------------------------------------------
select * from ##Final_Cust_One_View

-- Updating records of customer for FUT & OPT preferred porduct,MOdifying recency cap. For Fut & OPt recency Cap is 60 - 30 - 15 
update ##Final_Cust_One_View 
set RECENCY_CAP = 
case 
	when Activity_ratio = '> 66%' and recency <= 30 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then '0-30 days'
	when Activity_ratio = '> 66%' and recency > 30 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then  '> 30 days'

	when Activity_ratio = '> 66%' and recency <= 15 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then '0-15 days'
	when Activity_ratio = '> 66%' and recency > 15 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then  '> 15 days'
	-------------------------------------------------------------------------------------------
	when Activity_ratio = '33% to 66%' and recency <= 60 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then '0-60 days'
	when Activity_ratio = '33% to 66%' and recency > 60 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then  '> 60 days'
	
	when Activity_ratio = '33% to 66%' and recency <= 30 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then '0-30 days'
	when Activity_ratio = '33% to 66%' and recency > 30 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then  '> 30 days'
	-------------------------------------------------------------------------------------------
	when Activity_ratio = '< 33%' and recency <= 60 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then '0-90 days'
	when Activity_ratio = '< 33%' and recency > 60 and (PREFERRED_PRODUCT = 'DELIVERY'
	or PREFERRED_PRODUCT = 'MARGIN' or PREFERRED_PRODUCT = 'MIX') then  '> 90 days'

	when Activity_ratio = '< 33%' and recency <= 60 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then '0-60 days'
	when Activity_ratio = '< 33%' and recency > 60 and (PREFERRED_PRODUCT = 'FUT'
	or PREFERRED_PRODUCT = 'OPT') then  '> 60 days'
end 
-- (653207 row(s) affected)

select * from ##Final_Cust_One_View 
where PREFERRED_PRODUCT = 'FUT' or PREFERRED_PRODUCT = 'OPT'

select PREFERRED_PRODUCT,count(1) from ##Final_Cust_One_View group by PREFERRED_PRODUCT

----------------------------------------------------------------------------------------------

-- Customer One View Updated for FUT & OPT with Recency Cap of 60 - 30 - 15 days.
select Preferred_Product,Brkg_Am,Activity_Ratio,Recency_Cap,count(1) as 'Count'
from ##Final_Cust_One_View 
where PREFERRED_PRODUCT = 'FUT' or PREFERRED_PRODUCT = 'OPT'
group by Preferred_Product,Brkg_Am,Activity_Ratio,Recency_Cap
order by PREFERRED_PRODUCT