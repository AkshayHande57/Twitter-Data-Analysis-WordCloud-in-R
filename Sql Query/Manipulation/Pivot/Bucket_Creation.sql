-- Creation of Buckets on ##Percentage_Share_BRKG_TRNOVR
select top 5 * from Percentage_Share_BRKG_TRNOVR
select count(1) from Percentage_Share_BRKG_TRNOVR

select * from ##Percentage_Share_BRKG_TRNOVR where cust_ID = '2965854' or cust_ID = '2023776'


-- Creating preferred_product table using ##Percentage_Share_BRKG_TRNOVR
drop table ##preferred_product

select CUST_ID ,
case 
	when PS_BRKG_DELIVERY >= 90 then 'DELIVERY'
	when PS_BRKG_MARGIN >= 90 then 'MARGIN'
	when PS_BRKG_FUT >= 60 then 'FUT'
	when PS_BRKG_OPT >= 60 then 'OPT'
	ELSE 'MIX'
end as 'PREFERRED_PRODUCT'
into ##preferred_product 
from Percentage_Share_BRKG_TRNOVR
-- (653207 row(s) affected)

drop table ##preferred_product

select top 5 * from ##preferred_product
select * from Percentage_Share_BRKG_TRNOVR

-- 258844
-- 414097
-- 1270010

select * from ##Percentage_Share_BRKG_TRNOVR where cust_ID = '1270010'
select * from ##preferred_product where cust_ID = '1270010'

select * from ##Percentage_Share_BRKG_TRNOVR where cust_ID = '258844'
select * from ##preferred_product where cust_ID = '258844'

select * from ##Percentage_Share_BRKG_TRNOVR where cust_ID = '414097'
select * from ##preferred_product where cust_ID = '414097'

-- count preferred_product wise.
select preferred_product,count(1) as 'count' 
from ##preferred_product 
group by preferred_product order by count(1) desc
/*
preferred_product	count
DELIVERY			591502
MARGIN				36489
MIX					11815
OPT					9097
FUT					4304


preferred_product	count
DELIVERY			574073
MARGIN				39255
MIX					26478
OPT					9097
FUT					4304
*/

-------------------------------------------------------------------------------------------

-- Creating brokeage slab for all customer based on total_brokerage earned. 
-- Creating four distinct groups.
select top 10 * from BRKG_TRNOVR_CUST_PROD
select count(1) from BRKG_TRNOVR_CUST_PROD -- 653209

-- Creating Total_Brokeage slab over total_brokeage.
-- Four category of brokerage slab:
-- 1. Less than 1000 
-- 3. 1000 to 4000
-- 4. Greater than 4000

select cust_ID, 
case 
	when BRKG_TOTAL <= 1000 then 'Less than 1000'
	when BRKG_TOTAL > 1000 and BRKG_TOTAL <= 4000 then '1000 to 4000'
	when BRKG_TOTAL > 4000 then 'Greater than 4000'
end as 'BRKG_SLAB'
into ##Brkg_slab
from BRKG_TRNOVR_CUST_PROD
-- (653207 row(s) affected)

drop table ##Brkg_slab

select count(1) from BRKG_TRNOVR_CUST_PROD
select BRKG_TOTAL from BRKG_TRNOVR_CUST_PROD where BRKG_TOTAL is null
select BRKG_TOTAL from BRKG_TRNOVR_CUST_PROD where cust_ID = '2558265'
select top 100 * from BRKG_TRNOVR_CUST_PROD

select count(1) from ##Brkg_slab -- 653207 rows 
select top 5 * from ##Brkg_slab
select top 5 * from ##preferred_product
select top 100 * from BRKG_TRNOVR_CUST_PROD

----------------------------------------------------------------------------------------------
-- Creating Active_Month for each customer using MONTH_ID. 
select top 5 * from [dbo].[MTH_TRNOVR_BRKG]
select count(1) from [MTH_TRNOVR_BRKG]

select CUST_ID, 
count(distinct(month_ID)) as 'ACTIVE_MNTS',
sum(PURE_BRK)/count(distinct(month_ID)) as 'BRKG/ACTIVE_MONTHS'
into ##ACTIVE_MON
from [MTH_TRNOVR_BRKG]
group by CUST_ID
-- (653209 row(s) affected)

drop table ##ACTIVE_MON

select top 10 * from [MTH_TRNOVR_BRKG]

select count(1) from ##ACTIVE_MON
select top 1000 * from ##ACTIVE_MON

select * from ##ACTIVE_MON where ACTIVE_MNTS is null

-- Creating Decile for active_mnths to verify distribution & come up with brackets.
select ACTIVE_MNTS, ntile(10) over (order by ACTIVE_MNTS desc) as 'Dc_ACTIVE_MNTS'
into ##Decile_Active_MNTS
from ##ACTIVE_MON

select * from ##Decile_Active_MNTS
drop table ##Decile_Active_MNTS

select Dc_ACTIVE_MNTS,min(ACTIVE_MNTS) as 'Min',
avg(ACTIVE_MNTS) as 'Avg',
max(ACTIVE_MNTS) as 'Max',
count(ACTIVE_MNTS) as 'Count'
from ##Decile_Active_MNTS
group by Dc_ACTIVE_MNTS
order by Dc_ACTIVE_MNTS

--------------------------------------------------------------------------------------------
alter table ##Customer 
add RECENCY_CAP varchar(20)

alter table ##Customer 
drop column RECENCY_CAP 

update ##Customer 
set RECENCY_CAP = 
case 
	when recency <= 60 then '0-60 days'
	when recency > 60 and recency <=180 then '60-180 days'
		when recency > 180 then '>180 days'
end 

select RECENCY_CAP ,count(1) as 'Count' from ##Customer group by RECENCY_CAP order by count(1) desc
/*
RECENCY_CAP	Count
0-60 days	356578
60-180 days	192665
>180 days	103964
*/

-------------------------------------------------------------------------- 
select top 5 * from ##preferred_product
select top 5 * from ##ACTIVE_MON
select top 5 * from ##Brkg_slab
select top 5 * from ##Customer

--------------------------------------------------------------------------
-- Creating recency table.
select * from ##LAST_TRD_DT

-- Creating ##Recency table from ##LST_TRD_DRV
select 
CUST_ID,LAST_TRD_DT,
(datediff(day,LAST_TRD_DT,cast('2018-03-31' as date))) as 'Recency'
into ##Recency_Table
from LAST_TRD_DT
-- (653209 row(s) affected)


drop table ##Recency_Table

select * from ##Recency_Table
select min(LAST_TRD_DT),max(LAST_TRD_DT) from ##Recency_Table

-- QC for Date greater than 31st March 2018
select min(LAST_TRD_DT),max(LAST_TRD_DT) from ##Recency_Table
select  * from ##Recency_Table where LAST_TRD_DT > cast('2018-04-01' as date)


select * from ##Recency_Table

select top 5 * from ##preferred_product
select top 5 * from ##ACTIVE_MON
select top 5 * from ##Brkg_slab
select top 5 * from ##Recency_Table

select count(1) from ##preferred_product --653207
select count(1) from ##ACTIVE_MON --653209
select count(1) from ##Brkg_slab --653207
select count(1) from ##Recency_Table --653209
 


-- Joining All Temp Tables to create 
select a.*,b.ACTIVE_MNTS,b.[BRKG/ACTIVE_MONTHS],c.BRKG_SLAB,D.RECENCY
into ##Customer 
from ##preferred_product a inner join ##ACTIVE_MON b on a.CUST_ID = b.CUST_ID 
inner join ##Brkg_slab c on a.CUST_ID = c.CUST_ID 
inner join ##Recency_Table d on a.CUST_ID = d.CUST_ID
-- (653207 row(s) affected)
-- Duration : 5 sec

drop table  ##Customer

select * from ##Customer -- (653207 row(s) affected)

----------------------------------------------------------------------------- 
select * from ##customer

-- Creating Decile for BRKG/Active_Month 
-- Creating Deciles for Dc_BRKG_FUT
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_MONTH'
into ##Temp_Deciles_BRKG_MONTH
from ##customer
-- (653207 row(s) affected)

drop table ##Temp_Deciles_BRKG_MONTH

-- Display min, avg, max  deciles for Dc_BRKG_OPT
select Dc_BRKG_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' 
, max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH
group by Dc_BRKG_MONTH
order by Dc_BRKG_MONTH

select * from ##customer
select [BRKG/MONTH] ,count(1) from ##customer group by [BRKG/MONTH]
select min([BRKG/MONTH]) as 'Min', max([BRKG/MONTH]) as 'Max' from ##customer

select top 100 * from ##customer

select * from ##customer

alter table ##Customer
drop column BRKG_AM

select * from ##Customer where BRKG_AM is null
------------------------------------------------------------------------------------------

-- ## Customer
select top 50 *  from ##customer

select PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,RECENCY_CAP,count(1) as 'Count'
from ##customer
group by PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,RECENCY_CAP

-----------------------------------------------------------------------------------------
select distinct(PREFERRED_PRODUCT),count(1) as 'Count'
from ##customer
group by PREFERRED_PRODUCT order by count(1) desc

select distinct(ACTIVE_MNTHS_CAP),count(1) as 'Count'
from ##customer
group by ACTIVE_MNTHS_CAP order by count(1) desc

select distinct(RECENCY_CAP),count(1) as 'Count'
from ##customer
group by RECENCY_CAP order by count(1) desc

select distinct(BRKG_AM),count(1) as 'Count'
from ##customer
group by BRKG_AM order by count(1) desc

select distinct(BRKG_SLAB),count(1) as 'Count'
from ##customer
group by BRKG_SLAB order by count(1) desc


select * from ##customer

select PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_SLAB,RECENCY_CAP,count(1) as 'Count'
from ##customer
group by PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_SLAB,RECENCY_CAP

-----------------------------------------------------------------------------------
-- All Varialbes 
select PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_AM,RECENCY_CAP,count(1) as 'Count'
from ##customer
group by PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_AM,RECENCY_CAP
order by PREFERRED_PRODUCT asc 

drop table ##customer


select * from ##customer

---------------------------------------------------------------------------------------
select * into ##All_Customer 
from ##Customer_F_O 
union 
select * from ##Customer_Margin
union 
select * from ##Customer_Delivery
-- (653207 row(s) affected)

-------------------------------------------------------------------------------------------------------------
alter table ##CustomerOneView 
add ACTIVITY_RATIO varchar(20)

alter table ##CustomerOneView
drop column ACTIVITY_RATIO

select * from ##CustomerOne

update ##CustomerOneView
set ACTIVITY_RATIO = 
case 
	when ACTIVE_MNTS <= 3 then '< 33%'
	when ACTIVE_MNTS > 3 and ACTIVE_MNTS <= 7 then '33% to 66%'
	when ACTIVE_MNTS >7  then '> 66%'
end 

select top 10 * from ##Recency_Table
select top 10 * from ##CustomerOneView

drop table ##customer

select a.*,b.LAST_TRD_DT,b.Recency into ##CustomerOne
from ##All_Customer a inner join ##Recency_Table b
on a.cust_ID = b.cust_ID
-- (653207 row(s) affected)
drop table ##CustomerOne

select top 100 * from ##CustomerOne
select * from ##Recency_Table

alter table ##CustomerOneView 
drop column RECENCY_CAP

alter table ##CustomerOneView 
add RECENCY_CAP varchar(20)

update ##CustomerOneView 
set RECENCY_CAP = 
case 
	when recency <= 60 then '0-60 days'
	when recency > 60  then ' > 60 days'
end 

select RECENCY_CAP ,count(1) as 'Count' from ##CustomerOneView group by RECENCY_CAP order by count(1) desc
select ACTIVE_MNTHS ,count(1) as 'Count' from ##CustomerOneView group by ACTIVE_MNTHS order by count(1) desc
select ACTIVITY_RATIO ,count(1) as 'Count' from ##CustomerOneView group by ACTIVITY_RATIO order by count(1) desc
-----------------------------------------------------------------------------------------------------------
select top 100 * from ##CustomerOneView

-- All Varialbes 
select PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_AM,RECENCY_CAP,count(1) as 'Count'
from ##CustomerOne
group by PREFERRED_PRODUCT,ACTIVE_MNTHS_CAP,BRKG_AM,RECENCY_CAP
order by PREFERRED_PRODUCT asc 
--------------------------------------------------------------- 
----------------------------------------------------------------------------
select top 10 * from [dbo].[Entity_Master_with_lst_DT]
select top 10 * from ##CustomerOne

--Creating ##customerOneView
select a.*
,b.ENT_TYPE
,b.ENT_CLIENT_TYPE
,b.ENT_SEG_FLAG
,b.ENT_CATEGORY
,b.ENT_STATUS
,b.ENT_ADDRESS_LINE_4
,b.ENT_ADDRESS_LINE_5
,b.ENT_BR_REG_DT
,b.ENT_ADDRESS_LINE_6
,b.ENT_ADDRESS_LINE_7
,b.ENT_DOB
,b.ENT_FIRST_TRD_DT
,b.ENT_TRD_CONFIRM
,b.ENT_DESIGNATION
,b.ENT_EDU_QUAL
,b.ENT_OCCUPATION
,b.ENT_SEX
,b.ENT_EXCH_CLIENT_ID
,b.ENT_MARITAL_STATUS
,b.ENT_NATIONALITY,
b.Age
into ##CustomerOneView
from ##CustomerOne a left join Entity_Master_with_lst_DT b
on a.cust_ID = b.ENT_ID
-- (653207 row(s) affected)

-- CustomerOneView for 1 year traded customer.
select top 100 * from ##CustomerOneView
drop table ##CustomerOneView


select PREFERRED_PRODUCT,ACTIVITY_RATIO,BRKG_AM,RECENCY_CAP,count(1) as 'Count'
from ##CustomerOneView
group by PREFERRED_PRODUCT,ACTIVITY_RATIO,BRKG_AM,RECENCY_CAP
order by PREFERRED_PRODUCT asc 

----------------------------------------------------------------------------------
-- Finding out list of NCA New Customer Acquired 
select top 100 * from ##customerOneView

select * from ##customerOneView where ENT_BR_REG_DT > cast('2018-01-01' as Date)

select * from [dbo].[ipo_appln]
select * from [dbo].[logged_users_jn]

-------------------------------------------------------------------------------------------------
select * from ##CustomerOneView
select count(1) from ##CustomerOneView

-- Creating below derived variables from above list available variables.
/*
-- AON (Age on Network) Formula : TODAY -  ENT_BR_REG_DT 
	-- AON_Days
	-- AON_Year
-- C2T (Customer to Trade) Formula : FIRST_TRADE_DT - ENT_BR_REG_DT
	-- C2T_Days
	-- C2T_Months
-- ST_Period (Stop Trade Period) Formula : Today - Last_Trade_Date
	-- ST_Period_Days
	-- ST_Period_Months
-----------------------------------------------------------------------------------------------------
-- Creating AON field in ##CustomerOneView table.
-- AON_Year 
*/
-- Today Date : 9th May 2018

alter table ##CustomerOneView
add AON_Year numeric(10)

alter table ##CustomerOneView
drop column AON_Year


update ##CustomerOneView 
set AON_Year = DATEDIFF(year,cast(ENT_BR_REG_DT as date),cast(GETDATE() as date)) 

select top 100 * from ##CustomerOneView

select AON_Year,count(1) from ##CustomerOneView group by AON_Year

------------------------------------------------------------------------------------------
-- ST_Period (Stop Trade Period) Formula : Today - Last_Trade_Date
	-- ST_Period_Days
	-- ST_Period_Months
alter table ##CustomerOneView
drop column ST_Period_Months

alter table ##CustomerOneView
add ST_Period_Months numeric(10)

update ##CustomerOneView
set ST_Period_Months = DATEDIFF(MONTH,last_trd_dt,cast('2018-03-31' as date))

select ST_Period_Months,count(1) as 'Count' from ##CustomerOneView group by ST_Period_Months

select min(last_trd_dt),max(last_trd_dt) from ##CustomerOneView

select * from ##CustomerOneView where ST_Period_MONTHS = '11' or ST_Period_MONTHS = '12'
or ST_Period_MONTHS = '13'

-- Active-Traders
-- Customer who has perform transaction in last 6 months 
ST_Period_Months <=6 

-- Stop Traders
-- Customer who has not performed transaction in last 6 month.
ST_Period_Months > 6 

-- Active Traders 
select count(1) from ##CustomerOneView where ST_Period_Months <= 6

-- Stop Traders 
select count(1) from ##CustomerOneView where ST_Period_Months > 6

----------------------------------------------------------------------------------------
-- ST_Period_Days

alter table ##CustomerOneView
add ST_Period_Days numeric(10)

update ##CustomerOneView
set ST_Period_Days = DATEDIFF(DAY,last_trd_dt,cast('2018-03-31' as date))

select * from ##CustomerOneView where ST_PERIOD_MONTHS >= 8 

select ST_PERIOD_MONTHS,min(ST_PERIOD_DAYS),avg(ST_PERIOD_DAYS),max(ST_PERIOD_DAYS) from ##CustomerOneView
group by ST_PERIOD_MONTHS having ST_PERIOD_MONTHS >=6

select * from ##CustomerOneView

alter table ##CustomerOneView
add ST_DAYS_CAPS varchar(20)

alter table ##CustomerOneView
drop column  ST_DAYS_CAPS


update ##CustomerOneView 
set ST_DAYS_CAPS = 
case
	when ST_PERIOD_DAYS < 220 then '220' 
	when ST_PERIOD_DAYS >= 220 and ST_PERIOD_DAYS <= 280 then '220 to 280'
	when ST_PERIOD_DAYS > 280 and ST_PERIOD_DAYS <= 340 then '280 to 340'
	when ST_PERIOD_DAYS > 340 then ' > 340'
end 

--(36489 row(s) affected)

select ST_DAYS_CAPS,count(1) as 'Count of Customer'  from ##CustomerOneView where ST_PERIOD_MONTHS >= 7
group by ST_DAYS_CAPS 
/*
ST_DAYS_CAPS	Count of Customer
> 340			10168
220				4537
220 to 280		37598
280 to 340		31205
*/

-- Customer One View created 
select top 1000 * from ##CustomerOneView
select count(1) from ##CustomerOneView -- 653207

--------------------------------------------------------------------------

select PREFERRED_PRODUCT,sum([BRKG/ACTIVE_MONTHS]) as 'Total Brokerage/AM across product'
from ##CustomerOneView
group by PREFERRED_PRODUCT
