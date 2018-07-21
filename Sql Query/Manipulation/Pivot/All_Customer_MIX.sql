-----------------------------------------------------------------------------
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

drop table preferred_product

select top 5 * from ##preferred_product
select top 5 * from Percentage_Share_BRKG_TRNOVR

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
------------------------------------------------------------------------------------------
-- Creating Delivery Product Customer
select CUST_ID,PREFERRED_PRODUCT,
ACTIVE_MNTS,
[BRKG/ACTIVE_MONTHS]
into ##Customer_Delivery from ##customer where Preferred_product = 'DELIVERY'
-- (574073 row(s) affected)

select * from ##customer
select * from ##Customer_Delivery
select count(1) from ##Customer_Delivery
drop table ##Customer_Delivery

-- Qc check of customer 
select cust_id,[BRKG/ACTIVE_MONTHS] from ##Customer_Delivery where [BRKG/ACTIVE_MONTHS] < 1 -- 82306 customer 
-- This are customer who gives brkg/AM less than 1 rupees.

select cust_id,[BRKG/ACTIVE_MONTHS] from ##Customer_Delivery where [BRKG/ACTIVE_MONTHS] = 0 
-- No customer with brkg/AM is 0

------------------------------------------------------------------------------------------
-- Creating Deciles for DC_BRKG_AM for delivery customer
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_MONTH'
into ##Temp_Deciles_BRKG_MONTH_Delivery
from ##Customer_Delivery
-- (574073 row(s) affected)

drop table ##Temp_Deciles_BRKG_MONTH_Delivery

-- Display min, avg, max  deciles for Dc_BRKG_OPT
select Dc_BRKG_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' 
, max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH_Delivery
group by Dc_BRKG_MONTH
order by Dc_BRKG_MONTH

-- Creating Customer Delivery BRKG/AM month slab 
alter table ##Customer_Delivery
add BRKG_AM varchar(20)

update ##Customer_Delivery 
set BRKG_AM = 
case 
	when [BRKG/ACTIVE_MONTHS] <= 150  then '0 to 150'
	when [BRKG/ACTIVE_MONTHS] > 150 and [BRKG/ACTIVE_MONTHS] <= 500 then '150 - 500'
	when [BRKG/ACTIVE_MONTHS] > 500 and [BRKG/ACTIVE_MONTHS] <= 1000 then '500 - 1000'
	when [BRKG/ACTIVE_MONTHS] > 1000 then '> 1000'
end 
--(574073 row(s) affected)

select * from ##Customer_Delivery

alter table ##Customer_Delivery
drop column BRKG_AM

select * from ##Customer_Delivery where BRKG_AM is null

select BRKG_AM,count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total_BRKG'
from ##Customer_Delivery group by BRKG_AM order by count(1) desc
/*
BRKG_AM			Count	Total_BRKG
0 to 150		310823	13650732.491688
150 - 500		124734	35660245.334630
> 1000			82778	371184467.129422
500 - 1000		55738	39500057.308824
*/

------------------------------------------------------------------------------------------
-- Creating Margin Product Customer
select CUST_ID,PREFERRED_PRODUCT,
ACTIVE_MNTS,
[BRKG/ACTIVE_MONTHS]
into ##Customer_Margin from ##customer where Preferred_product = 'MARGIN'
-- (39255 row(s) affected)

select * from ##Customer_Margin
drop table ##Customer_Margin

-- Creating Decile for BRKG/ACTIVE_MONTHS for MARGIN PRODUCT

-- Creating Deciles for BRKG/ACTIVE_MONTHS
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_ACTIVE_MONTH'
into ##Temp_Deciles_BRKG_MONTH_AM_MARGIN
from ##Customer_Margin
-- (39255 row(s) affected)

select * from ##Temp_Deciles_BRKG_MONTH_AM_MARGIN
drop table ##Temp_Deciles_BRKG_MONTH_AM_MARGIN

-- Display min, avg, max  deciles for Dc_BRKG_OPT
select Dc_BRKG_ACTIVE_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' , max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH_AM_MARGIN
group by Dc_BRKG_ACTIVE_MONTH
order by Dc_BRKG_ACTIVE_MONTH

-- Creating Buckets for BRKG_AM_MARGIN
alter table ##Customer_Margin
add BRKG_AM varchar(20)

alter table ##Customer_Margin
drop  column BRKG_AM

update ##Customer_Margin 
set BRKG_AM = 
case 
	when [BRKG/ACTIVE_MONTHS] <= 500  then '0 to 500'
	when [BRKG/ACTIVE_MONTHS] > 500 and [BRKG/ACTIVE_MONTHS] <= 1000 then '500 - 1000'
	when [BRKG/ACTIVE_MONTHS] > 1000 and [BRKG/ACTIVE_MONTHS] <= 3000 then '1000 - 3000'
	when [BRKG/ACTIVE_MONTHS] > 3000 then '> 3000'
end 
--(39255 row(s) affected)
 
Select * from ##Customer_Margin

select distinct(BRKG_AM),count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total_BRKG_AM'
from ##Customer_Margin
group by BRKG_AM 

/*
BRKG_AM			Count		Total_BRKG_AM
1000 - 3000		6675		11692771.866344
> 3000			6432		87747726.644587
500 - 1000		5329		3820869.139312
0 to 500		20819		3350578.089602
*/

------------------------------------------------------------------------------------------------------
-- Creating FUT Product Customer
select CUST_ID,PREFERRED_PRODUCT,
ACTIVE_MNTS,
[BRKG/ACTIVE_MONTHS]
into ##Customer_FUT from ##customer where Preferred_product = 'FUT'
-- (4304 row(s) affected)

select count(1) from ##Customer_FUT -- (4304 row(s) affected)
drop table ##Customer_FUT

-- Creating Deciles for BRKG/ACTIVE_MONTHS for PRODUCT TYPE FUT
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_ACTIVE_MONTH'
into ##Temp_Deciles_BRKG_MONTH_AM_FUT
from ##Customer_FUT
-- (4304 row(s) affected)

select Dc_BRKG_ACTIVE_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' , max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH_AM_FUT
group by Dc_BRKG_ACTIVE_MONTH
order by Dc_BRKG_ACTIVE_MONTH


alter table ##Customer_FUT
add BRKG_AM varchar(20)

alter table ##Customer_FUT
drop column BRKG_AM 


update ##Customer_FUT 
set BRKG_AM = 
case 
	when [BRKG/ACTIVE_MONTHS] <= 3600  then '< 3600'
	when [BRKG/ACTIVE_MONTHS] > 3600 and [BRKG/ACTIVE_MONTHS] <= 9200 then '3600 - 9200'
	when [BRKG/ACTIVE_MONTHS] > 9200 and [BRKG/ACTIVE_MONTHS] <= 24000 then '9200 - 24000'
	when [BRKG/ACTIVE_MONTHS] > 24000 then '> 24000'
end 
-- (4304 row(s) affected)

select distinct(BRKG_AM),count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total_BRKG_AM'
from ##Customer_FUT
group by BRKG_AM order by count(1) desc

/*
BRKG_AM			Count	Total_BRKG_AM
< 3600			1717	2917462.790630
3600 - 9200		1288	7684273.746907
9200 - 24000	871		12637046.579854
> 24000			428		25857644.270133
*/
----------------------------------------------------------------------------------------
-- Creataing deciles for customer who have traded in OPTIONS 
select CUST_ID,PREFERRED_PRODUCT,
ACTIVE_MNTS,
[BRKG/ACTIVE_MONTHS]
into ##Customer_OPT from ##customer where Preferred_product = 'OPT'
-- (9097 row(s) affected)

drop table ##Customer_OPT

-- Creating Deciles for OPTIONS customer 
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_ACTIVE_MONTH'
into ##Temp_Deciles_BRKG_MONTH_AM_OPT
from ##Customer_OPT
-- (9097 row(s) affected)


-- AVG , MIN, MAX , SUM of deciles 
select Dc_BRKG_ACTIVE_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' , max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH_AM_OPT
group by Dc_BRKG_ACTIVE_MONTH
order by Dc_BRKG_ACTIVE_MONTH

alter table ##Customer_OPT
add BRKG_AM varchar(20)

update ##Customer_OPT
set BRKG_AM = 
case 
	when [BRKG/ACTIVE_MONTHS] <= 1420  then '< 1420'
	when [BRKG/ACTIVE_MONTHS] > 1420 and [BRKG/ACTIVE_MONTHS] <= 4600 then '1420 - 4600'
	when [BRKG/ACTIVE_MONTHS] > 4600 and [BRKG/ACTIVE_MONTHS] <= 14275 then '4600 - 14275'
	when [BRKG/ACTIVE_MONTHS] > 14275 then '> 14275'
end 
-- (9097 row(s) affected)

select distinct(BRKG_AM),count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total_BRKG_AM'
from ##Customer_OPT
group by BRKG_AM order by count(1) desc
/*
BRKG_AM			Count	Total_BRKG_AM
< 1420			3639	2200268.456935
1420 - 4600		2724	7352776.530583
4600 - 14275	1824	14594326.060948
> 14275			910		37045887.542093
*/
----------------------------------------------------------------------------------------
-- Creating BRKG_SLAB for customer with MIX prefernce.
-- Creating MIX customer list

select CUST_ID,PREFERRED_PRODUCT,
ACTIVE_MNTS,
[BRKG/ACTIVE_MONTHS]
into ##Customer_MIX from ##customer where Preferred_product = 'MIX'
-- (26478 row(s) affected)

select * from ##Customer_MIX
drop table ##Customer_MIX

-- Creating Deciles for MIX customer 
select [BRKG/ACTIVE_MONTHS],ntile(10) over (order by [BRKG/ACTIVE_MONTHS] desc) as 'Dc_BRKG_ACTIVE_MONTH'
into ##Temp_Deciles_BRKG_MONTH_AM_MIX
from ##Customer_MIX
-- (11815 row(s) affected)

drop table ##Temp_Deciles_BRKG_MONTH_AM_MIX

-- AVG , MIN, MAX , SUM of deciles 
select Dc_BRKG_ACTIVE_MONTH,min([BRKG/ACTIVE_MONTHS]) as 'Min',  avg([BRKG/ACTIVE_MONTHS]) as 'Avg' , max([BRKG/ACTIVE_MONTHS]) as 'Max',
count([BRKG/ACTIVE_MONTHS]) as 'Count_[BRKG/MONTH]',
sum([BRKG/ACTIVE_MONTHS]) as 'SUM'
from ##Temp_Deciles_BRKG_MONTH_AM_MIX
group by Dc_BRKG_ACTIVE_MONTH
order by Dc_BRKG_ACTIVE_MONTH


alter table ##Customer_MIX
add BRKG_AM varchar(20)

update ##Customer_MIX
set BRKG_AM = 
case 
	when [BRKG/ACTIVE_MONTHS] <= 850  then '< 850'
	when [BRKG/ACTIVE_MONTHS] > 850 and [BRKG/ACTIVE_MONTHS] <= 3525 then '850 - 3525'
	when [BRKG/ACTIVE_MONTHS] > 3525 and [BRKG/ACTIVE_MONTHS] <= 12400 then '3525 - 12400'
	when [BRKG/ACTIVE_MONTHS] > 12400 then '> 12400'
end 
-- (11815 row(s) affected)


select distinct(BRKG_AM),count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total_BRKG_AM'
from ##Customer_MIX
group by BRKG_AM order by count(1) desc
/*
BRKG_AM			Count	Total_BRKG_AM
< 850			10634	3722796.578465
850 - 3525		8600	15959241.637579
3525 - 12400	5121	33204267.285683
> 12400			2123	71429414.771939
*/

------------------------------------------------------------------------------------------------
-- Creating New customer table with new product type 

select * into ##All_Customer_MIX 
from ##Customer_FUT
union 
select * from ##Customer_Margin
union 
select * from ##Customer_Delivery
union 
select * from ##Customer_OPT
union 
select * from ##Customer_MIX

-- (653207 row(s) affected)

drop table ##All_Customer_MIX

select * from ##All_Customer_MIX
select count(1)  from ##All_Customer_MIX -- 653207

----------------------------------------------------------------------------------
-- Adding Activity_Ratio to All_customer_MIX Table.
alter table ##All_Customer_MIX 
add ACTIVITY_RATIO varchar(20)

update ##All_Customer_MIX
set ACTIVITY_RATIO = 
case 
	when ACTIVE_MNTS <= 3 then '< 33%'
	when ACTIVE_MNTS > 3 and ACTIVE_MNTS <= 7 then '33% to 66%'
	when ACTIVE_MNTS >7  then '> 66%'
end 
-- (653207 row(s) affected)

-- Count of Activty_Ratio 
select activity_ratio,count(1) as 'Count' from ##All_Customer_MIX group by activity_ratio order by count(1) desc
/*
Activity_ratio	Count
< 33%			334460
> 66%			160340
33% to 66%		158407

*/

-- Display records of All_customer_mix table 
select top 100 * from ##All_Customer_MIX
select top 100 * from ##Recency_Table

------------------------------------------------------------------------------------------------------------------

-- Adding new Recency & last_trd_Dt to All_customer_mix table
select a.*,b.RECENCY,b.last_trd_dt
into ##Customer_Mix 
from ##All_Customer_MIX a inner join ##Recency_Table b on a.CUST_ID = b.CUST_ID 
-- (653207 row(s) affected)

drop table ##Customer_Mix

select top 100 * from ##Customer_Mix where Activity_ratio = '> 66%'

------------------------------------------------------------------------------------------------------------------

-- Adding new column Recency_Cap to ##Customer_OneView_Mix
-- Recency Cap is calculated based on Product_Type & Activity Ratio of customer.
alter table ##Customer_Mix
add Recency_Cap varchar(20) 

update ##Customer_Mix 
set RECENCY_CAP = 
case 
	when Activity_ratio = '> 66%' and recency <= 30 then '0-30 days'
	when Activity_ratio = '> 66%' and recency > 30 then  '> 30 days'
	when Activity_ratio = '33% to 66%' and recency <= 60 then '0-60 days'
	when Activity_ratio = '33% to 66%' and recency > 60 then  '> 60 days'
	when Activity_ratio = '< 33%' and recency <= 90 then '0-90 days'
	when Activity_ratio = '< 33%' and recency > 90 then  '> 90 days'
end 
-- (653207 row(s) affected)
-- DUration : 13 Sec 

select top 100 * from ##Customer_Mix where activity_ratio = '< 33%'
select top 100 * from ##Customer_Mix where activity_ratio = '> 66%'
select top 100 * from ##Customer_Mix where activity_ratio = '33% to 66%'

--------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
-- Total Brokerage_AM across Product
select PREFERRED_PRODUCT,count(1) as 'Count',sum([BRKG/ACTIVE_MONTHS]) as 'Total Brokerage/AM across product'
from ##Customer_Mix
group by PREFERRED_PRODUCT
order by count(1) desc

/*
PREFERRED_PRODUCT		Count	Total Brokerage/AM across product
DELIVERY				574073	459995502.264564
MARGIN					39255	106611945.739845
MIX						26478	124315720.273666
OPT						9097	61193258.590559
FUT						4304	49096427.387524
*/

-----------------------------------------------------------------------------------------------------------------
-- Creating Vintage column in ##Customer_OneView_Mix table for all customer
select top 100 * from ##Customer_Mix

-- Adding Registration date to table.
-- To Calculate Vintage of customer below formula is used.
-- In Months Vintage = Registration Date - Today

select a.*,
b.ENT_BR_REG_DT as 'REG_DT',b.ENT_FIRST_TRD_DT as 'FIRST_TRD_DT'
into ##Customer_Mix_V01
from ##Customer_Mix a left join Entity_Master_with_lst_DT b 
on a.cust_ID = b.ent_ID 
-- (653207 row(s) affected)
-- Duration : 12 sec

select * from ##Customer_Mix_V01

-- Vintage in terms of month will be calculate on 17th May 2018.
alter table ##Customer_Mix_V01
add Vintage_Mnths int

alter table ##Customer_OneView_MIX_v01
drop column vintage_Mnths

-- Calculating vintage_Mnths for each customer 
-- Formula used to calculate Vintage
-- Vintage = REG_DT - TODAY
update ##Customer_Mix_V01
set Vintage_Mnths = DATEDIFF(month,REG_DT,getdate())
-- (653207 row(s) affected)

select * from ##Customer_Mix_V01
select min(Vintage_Mnths) as 'Min Months' ,max(Vintage_Mnths) as 'Max Months' from ##Customer_Mix_V01
select * from ##Customer_OneView_MIX_v01 where Vintage_Mnths = '220'

-- Creating Ntile for Vintage_Mnths to understand distribution 
select Vintage_Mnths,ntile(10) over (order by Vintage_Mnths desc) as 'Dc_Vintage_Mnths'
into ##Temp_Deciles_Vintage_Mnths
from ##Customer_OneView_MIX_v01

drop table ##Temp_Deciles_Vintage_Mnths

select * from ##Temp_Deciles_Vintage_Mnths


-- Display min,avg, max for each deciles.
select 
Dc_Vintage_Mnths,min(Vintage_Mnths) as 'Min',  
avg(Vintage_Mnths) as 'Avg' ,
max(Vintage_Mnths) as 'Max',
count(Vintage_Mnths) as 'Count'
from ##Temp_Deciles_Vintage_Mnths
group by Dc_Vintage_Mnths
order by Dc_Vintage_Mnths

----------------------------------------------------------------------------------------
-- New Customer Acqusition
-- ##Customer_OneView_MIX_v01
select * from ##Customer_Mix_V01

-- Creating Segment of customer who have recenctly joined
-- This customer can be idnetified by REG_DT for whom it is greater than 1st Jan 2018.
select * from ##Customer_Mix_V01 where REG_DT > cast('2018-01-01' as date)
-- 30802 customer
-- Duration : 1 sec 

-- Extract customer who have into temporary table ##NCA table
select * into ##NCA 
from ##Customer_Mix_V01 where REG_DT > cast('2018-01-01' as date)
-- (30802 row(s) affected)

-- Count 
select count(1) from ##NCA --30802 

-- Preferred Product for new customer 
select * from ##NCA
select activity_ratio,count(1) from ##NCA where preferred_product = 'MARGIN' group by activity_ratio
select Preferred_product,count(1) as 'Count' from ##NCA group by preferred_product order by count(1) desc
/*

Preferred_product	Count
DELIVERY			29772
MIX					463
MARGIN				267
OPT					226
FUT					74

*/

---------------------------------------------------------------------------------------------------
-- Creating Perment Custome_MIX table 
-- This table contains data which are used to create segments for Phase 1 .
select * into Customer_Mix
from ##Customer_Mix_V01
-- (653207 row(s) affected)
-- Duration : 1 Sec

select * from Customer_Mix
-- 653207 Rows
-- Duration : 25 Sec 

-- All variables segments used for creating Segments for Phase I
select PREFERRED_PRODUCT,BRKG_AM,ACTIVITY_RATIO,RECENCY_CAP,count(1) as 'Count'
from Customer_Mix
group by PREFERRED_PRODUCT,BRKG_AM,ACTIVITY_RATIO,RECENCY_CAP
order by PREFERRED_PRODUCT asc
-- 120 rows retrived (Distinct Segemtns)
-- Duration: 1 sec 