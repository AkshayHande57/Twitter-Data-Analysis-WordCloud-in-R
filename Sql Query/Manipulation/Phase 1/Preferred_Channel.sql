-- Extracting data from Oracle Server from trades tables.
-- Required Columns from Trades Tables.
-- 1. TRD_ENT_ID,
-- 2. TRD_NO
-- 3. TRD_SEM_ID,
-- 4. TRD_CHANNEL_TYPE

select * into ##EQ_Trades_product from OpenQuery(PRCSN,'select TRD_ENT_ID,
TRD_NO,
TRD_SEM_ID,
TRD_CHANNEL_TYPE
from Trades
where TRD_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- (65839740 row(s) affected) 
-- Duration : 36.30 Mins 

select * from ##EQ_Trades_product 

----------------------------------------------------------------------------
-- Distinct Customer present in TRD_CHANNEL_TYPE 
select count(distinct(TRD_ENT_ID)) as 'Distinct_Count of TRD_ENT_ID' 
from ##EQ_Trades_product
-- 650398
-- Duration : 6 Sec

select count(distinct(TRD_NO)) as 'Distinct_Count of TRD_NO' 
from ##EQ_Trades_product
-- 63445313
-- Duration : 2.28 mins

-----------------------------------------------------------------------------
-- Group by on Customer Level with TRD_CHANNEL_TYPE
select TRD_ENT_ID,TRD_CHANNEL_TYPE,count(distinct(TRD_NO)) as 'Count'
into ##Preferred_Product
from ##EQ_Trades_product 
group by TRD_ENT_ID,TRD_CHANNEL_TYPE
order by TRD_ENT_ID
-- (1035807 row(s) affected)
-- Duration  : 2.26 mins

select * from ##Preferred_Product order by TRD_ENT_ID

-----------------------------------------------------------------------------
-- Adding new column Total_Trans_count to temporary table ##Preferred_Product
select * from ##Preferred_Product order by TRD_ENT_ID

alter table ##Preferred_Product 
add Total_Trans_count numeric

update A
set Total_Trans_count = B.[Sum]
from ##Preferred_Product A inner join 
( Select TRD_ENT_ID,sum([Count]) as 'Sum' from  ##Preferred_Product group by TRD_ENT_ID) B
on B.TRD_ENT_ID = A.TRD_ENT_ID
-- (1035807 row(s) affected) 

select * from ##Preferred_Product order by TRD_ENT_ID

-----------------------------------------------------------------------------
-- Adding new column 'Max_Count' to temporary table ##Preferred_Product
alter table ##Preferred_Product
add Max_Count numeric

update A
set Max_Count = B.[Max]
from ##Preferred_Product A inner join 
( Select TRD_ENT_ID,max([Count]) as 'Max' from  ##Preferred_Product group by TRD_ENT_ID) B
on B.TRD_ENT_ID = A.TRD_ENT_ID
-- (1035807 row(s) affected) 

select * from ##Preferred_Product order by TRD_ENT_ID
-----------------------------------------------------------------------------
-- Adding Max_Perc column to temporary table ##to temporary table ##Preferred_Product 
alter table ##Preferred_Product
add Max_Perc numeric(13,2)

update ##Preferred_Product 
set Max_Perc = ((Max_Count / Total_Trans_count ) * 100)
-- (1035807 row(s) affected) 
-- Duration :

select * from ##Preferred_Product order by TRD_ENT_ID

select * from ##Preferred_Product where TRD_CHANNEL_TYPE
-----------------------------------------------------------------------------
-- Count across TRD_Channel_Type 
select count(1) from ##Preferred_Product

select TRD_Channel_Type,count(1) as 'Count' from ##Preferred_Product
group by TRD_Channel_Type
order by count(1) desc
/*
TRD_Channel_Type	Count
I					287084
C					214494
T					197880
O					160147
R					133088
NULL				43112
*/


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Looking at the deciles across channels. 

-- Creating Deciles for TWS Channel medium. 
select Max_Perc,ntile(10) over (order by Max_Perc desc) as 'Dc_Max_Perc'
into #Temp_Deciles_Max_Perc_TWS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'T'
-- (197880 row(s) affected)

select Dc_Max_Perc,min(Max_Perc) as 'Min', 
max(Max_Perc) as 'Max',avg(Max_Perc) as 'Avg',
count(Max_Perc) as 'count'
from #Temp_Deciles_Max_Perc_TWS
group by Dc_Max_Perc
order by Dc_Max_Perc
-----------------------------------------------------------------------------
-- Creating Deciles for ITS Channel medium. 
select Max_Perc,ntile(10) over (order by Max_Perc desc) as 'Dc_Max_Perc'
into #Temp_Deciles_Max_Perc_ITS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'I'
-- (287084 row(s) affected)

select Dc_Max_Perc,min(Max_Perc) as 'Min', 
max(Max_Perc) as 'Max',avg(Max_Perc) as 'Avg',
count(Max_Perc) as 'count'
from #Temp_Deciles_Max_Perc_ITS
group by Dc_Max_Perc
order by Dc_Max_Perc
-----------------------------------------------------------------------------
-- Creating Deciles for C Channel medium. 
select Max_Perc,ntile(10) over (order by Max_Perc desc) as 'Dc_Max_Perc'
into #Temp_Deciles_Max_Perc_C
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'C'
-- (214494 row(s) affected)

select Dc_Max_Perc,min(Max_Perc) as 'Min', 
max(Max_Perc) as 'Max',avg(Max_Perc) as 'Avg',
count(Max_Perc) as 'count'
from #Temp_Deciles_Max_Perc_C
group by Dc_Max_Perc
order by Dc_Max_Perc
-----------------------------------------------------------------------------
-- Creating Deciles for OWS Channel medium. 
select Max_Perc,ntile(10) over (order by Max_Perc desc) as 'Dc_Max_Perc'
into #Temp_Deciles_Max_Perc_OWS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'O'
-- (160147 row(s) affected)

select Dc_Max_Perc,min(Max_Perc) as 'Min', 
max(Max_Perc) as 'Max',avg(Max_Perc) as 'Avg',
count(Max_Perc) as 'count'
from #Temp_Deciles_Max_Perc_OWS
group by Dc_Max_Perc
order by Dc_Max_Perc
-----------------------------------------------------------------------------
-- Creating Deciles for RMS Channel medium. 
select Max_Perc,ntile(10) over (order by Max_Perc desc) as 'Dc_Max_Perc'
into #Temp_Deciles_Max_Perc_RMS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'R'
-- (133088 row(s) affected)

select Dc_Max_Perc,min(Max_Perc) as 'Min', 
max(Max_Perc) as 'Max',avg(Max_Perc) as 'Avg',
count(Max_Perc) as 'count'
from #Temp_Deciles_Max_Perc_RMS
group by Dc_Max_Perc
order by Dc_Max_Perc
-----------------------------------------------------------------------------
-- ##Preferred_Product
select * from ##Preferred_Product order by TRD_ENT_ID

-- Adding new Column Percent_Channel
alter table ##preferred_Product 
add Perc_Channel numeric(13,2) 

update ##Preferred_Product 
set Perc_Channel = ([count]/Total_trans_count) * 100 
-----------------------------------------------------------------------------
-- Creating new Channel column.
alter table ##preferred_Product
add Channel_Used varchar(5)

update ##Preferred_Product 
set Channel_Used = 
	case 
		when Perc_Channel >= 50.00 and Max_Perc = Perc_Channel then TRD_Channel_Type
		when Perc_Channel < 50.00 and Max_Perc = Perc_Channel then 'MIX'
	end
-- (1035807 row(s) affected)

select * from ##Preferred_Product order by TRD_ENT_ID

select * into ##temp_Channel from ##Preferred_Product where Max_Perc = Perc_Channel
-- (665758 row(s) affected)

select * from ##temp_Channel

select count(distinct(TRD_ENT_ID)) from ##temp_Channel -- 650398

select Channel_used,count(distinct(TRD_ENT_ID)) as 'Count'
from ##temp_Channel
group by Channel_used
/*
Channel_used	Count
NULL			2398
C				133347
I				208617
MIX				8586
O				108136
R				54799
T				147296
*/

select * from ##temp_Channel where Channel_used = 'MIX'
-----------------------------------------------------------------------------

-- Creating new temporary table for extracting preferred channel of customer. 
select TRD_ENT_ID as 'Cust_ID',
Channel_Used as 'Preferred_Channel',
Max_Perc as 'Preferred_Channel_Perc'
into ##Preferred_Channel from ##temp_Channel where [Count] = [Max_Count]
-- (665758 row(s) affected)

select * from ##Preferred_Channel
-----------------------------------------------------------------------------
-- Removing Duplicate Customer from ##Preferred_Channel table 

select count(1) from ##Preferred_Channel -- 665758
select count(distinct(cust_ID)) from ##Preferred_Channel -- 650398

-- Remove Duplicate Cust_ID from ##Cust_MAX_STK table.
-- Creating Customer_Max_Exposure table with distinct customers.
select a.* , ROW_NUMBER() over(partition by Cust_ID order by Preferred_Channel) as 'RowNum'
into ##temp_Preferred_Channel
from ##Preferred_Channel a
order by Cust_ID
-- (665758 row(s) affected)


select * from ##temp_Preferred_Channel order by cust_ID
select count(1) from ##temp_Preferred_Channel --665758
select count(1) from ##temp_Preferred_Channel where RowNum = 1 -- 650398

select CUST_ID,Preferred_Channel,Preferred_Channel_Perc into CUST_Prf_Chnl 
from ##temp_Preferred_Channel where RowNum = 1
-- (650398 row(s) affected)


-----------------------------------------------------------------------------
-- Preferred Channel Wise count distribution 
select Preferred_Channel,count(1) as 'Count' 
from CUST_Prf_Chnl 
group by Preferred_Channel
order by count(1) desc 
/*
Preferred_Channel	Count
I					204559
T					143615
C					133292
O					106626
R					51322
MIX					8586
NULL				2398
*/


-- Joining Preferred Channel column to Final_Customer_One_View table. 
select * from Final_Customer_One_View
select count(distinct(CUST_ID)) from Final_Customer_One_View -- 653207
select count(1) from ##temp_Channel -- 665758
select count(distinct(TRD_ENT_ID)) from ##temp_Channel -- 650398

-- Temp ##Final_Customer_One_View
select a.*,b.Preferred_Channel,b.Preferred_Channel_Perc 
into Final_Cust_One_View from ##Final_Cust_One_View a left join CUST_Prf_Chnl b
on a.CUST_ID = b.Cust_ID
-- (653207 row(s) affected)

select top 1000 * from Final_Cust_One_View

select Preferred_Channel,count(1) as 'Count' from Final_Cust_One_View
group by Preferred_Channel
order by count(1) desc
/*
Preferred_Channel	Count
I					204559
T					143615
C					133292
O					106626
R					51322
MIX					8586
NULL				5207
*/