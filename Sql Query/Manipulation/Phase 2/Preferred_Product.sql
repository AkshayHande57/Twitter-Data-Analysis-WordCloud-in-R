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
-- ##Preferred_Product
select * from ##Preferred_Product order by TRD_ENT_ID

-- Adding new Column Percent_Channel
alter table ##preferred_Product 
add Perc_Channel numeric(13,2) 

update ##Preferred_Product 
set Perc_Channel = ([count]/Total_trans_count) * 100 
-- (1035807 row(s) affected)

select * from ##Preferred_Product order by TRD_ENT_ID

-----------------------------------------------------------------------------
-- Looking at the deciles across channels. 

-- Creating Deciles for TWS Channel medium. 
select Perc_Channel,ntile(10) over (order by Perc_Channel desc) as 'Dc_Perc_Channel'
into #Temp_Deciles_Perc_Channel_TWS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'T'
-- (197880 row(s) affected)

select Dc_Perc_Channel,min(Perc_Channel) as 'Min', 
max(Perc_Channel) as 'Max',avg(Perc_Channel) as 'Avg',
count(Perc_Channel) as 'count'
from #Temp_Deciles_Perc_Channel_TWS
group by Dc_Perc_Channel
order by Dc_Perc_Channel
-----------------------------------------------------------------------------
-- Creating Deciles for ITS Channel medium. 
select Perc_Channel,ntile(10) over (order by Perc_Channel desc) as 'Dc_Perc_Channel'
into #Temp_Deciles_Perc_Channel_ITS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'I'
-- (287084 row(s) affected)

select Dc_Perc_Channel,min(Perc_Channel) as 'Min', 
max(Perc_Channel) as 'Max',avg(Perc_Channel) as 'Avg',
count(Perc_Channel) as 'count'
from #Temp_Deciles_Perc_Channel_ITS
group by Dc_Perc_Channel
order by Dc_Perc_Channel
-----------------------------------------------------------------------------
-- Creating Deciles for C Channel medium. 
select Perc_Channel,ntile(10) over (order by Perc_Channel desc) as 'Dc_Perc_Channel'
into #Temp_Deciles_Perc_Channel_C
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'C'
-- (214494 row(s) affected)

select Dc_Perc_Channel,min(Perc_Channel) as 'Min', 
max(Perc_Channel) as 'Max',avg(Perc_Channel) as 'Avg',
count(Perc_Channel) as 'count'
from #Temp_Deciles_Perc_Channel_C
group by Dc_Perc_Channel
order by Dc_Perc_Channel
-----------------------------------------------------------------------------
-- Creating Deciles for OWS Channel medium. 
select Perc_Channel,ntile(10) over (order by Perc_Channel desc) as 'Dc_Perc_Channel'
into #Temp_Deciles_Perc_Channel_OWS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'O'
-- (160147 row(s) affected)

select Dc_Perc_Channel,min(Perc_Channel) as 'Min', 
max(Perc_Channel) as 'Max',avg(Perc_Channel) as 'Avg',
count(Perc_Channel) as 'count'
from #Temp_Deciles_Perc_Channel_OWS
group by Dc_Perc_Channel
order by Dc_Perc_Channel
-----------------------------------------------------------------------------
-- Creating Deciles for RMS Channel medium. 
select Perc_Channel,ntile(10) over (order by Perc_Channel desc) as 'Dc_Perc_Channel'
into #Temp_Deciles_Perc_Channel_RMS
from ##Preferred_Product
where TRD_CHANNEL_TYPE = 'R'
-- (133088 row(s) affected)

select Dc_Perc_Channel,min(Perc_Channel) as 'Min', 
max(Perc_Channel) as 'Max',avg(Perc_Channel) as 'Avg',
count(Perc_Channel) as 'count'
from #Temp_Deciles_Perc_Channel_RMS
group by Dc_Perc_Channel
order by Dc_Perc_Channel
-----------------------------------------------------------------------------
-- Adding New Column Channel_Used to ##Preferred_Product table 
select * from ##Preferred_Product order by TRD_ENT_ID

-- Creating new Channel column.
alter table ##preferred_Product
add Channel_Used varchar(5)

update ##Preferred_Product 
set Channel_Used = 
	case 
		when Perc_Channel > 50.00 then TRD_Channel_Type
		when Perc_Channel <= 50.00 then 'MIX'
	end
-- (1035807 row(s) affected)

select * from ##Preferred_Product order by TRD_ENT_ID
select count(distinct(TRD_ENT_ID)) from ##Preferred_Product -- 650398
-----------------------------------------------------------------------------
-- Non Mix Customer base 
select TRD_ENT_ID as 'Cust_ID',
Channel_Used as 'Preferred_Channel',
Perc_Channel as 'Preferred_Channel_Perc' 
into ##Preferred_Channel from ##Preferred_Product where Channel_Used != 'Mix'
-- (624223 row(s) affected)


select * from ##Preferred_Channel
select count(distinct(Cust_ID)) from ##Preferred_Channel -- 624223

select Preferred_Channel,count(distinct(Cust_ID)) as 'Count'
from ##Preferred_Channel
group by Preferred_Channel
/*
Channel_used	Count
C				126111
I				200777
O				104065
R				50036
T				143234
*/
-----------------------------------------------------------------------------
-- Joining Preferred Channel column to Final_Customer_One_View table. 
select * from ##Final_Cust_One_View
select count(distinct(CUST_ID)) from ##Final_Cust_One_View -- 653207
select count(distinct(CUST_ID)) from ##Preferred_Channel -- 624223


-- Temp ##Final_Customer_One_View
select a.*,b.Preferred_Channel,b.Preferred_Channel_Perc 
into Final_Cust_One_View from ##Final_Cust_One_View a left join ##Preferred_Channel b
on a.CUST_ID = b.Cust_ID
-- (653207 row(s) affected)

select top 1000 * from Final_Cust_One_View
drop table Final_Cust_One_View

select Preferred_Channel,count(1) as 'Count' from Final_Cust_One_View
group by Preferred_Channel
order by count(1) desc
/*
Preferred_Channel	Count
I					200777
T					143234
C					126111
O					104065
R					50036
NULL				28984
*/
-----------------------------------------------------------------------------
-- In Table Final_Cust_One_View table,Updating records for column Preferred_Channel 
-- where the values are Null.
update Final_Cust_One_View
set Preferred_Channel = 
	case 
		when Preferred_Channel is not null then Preferred_Channel
		when Preferred_Channel is null then 'Mix'
	end
-- (653207 row(s) affected)

update Final_Cust_One_View
set Preferred_Channel_Perc = 
	case
		when Preferred_Channel !=  'Mix' then Preferred_Channel_Perc
		when Preferred_Channel =  'Mix' then 50.00
	end
-- (653207 row(s) affected)

select * from Final_Cust_One_View where Preferred_Channel != 'Mix'
-----------------------------------------------------------------------------
-- Preferred_Channel count across unique customer 
select Preferred_Channel,count(distinct(cust_ID)) as 'Unique_Count' 
from Final_Cust_One_View
group by Preferred_Channel
order by count(distinct(cust_ID)) desc
/*
Preferred_Channel	Unique_Count
I					200777
T					143234
C					126111
O					104065
R					50036
Mix					28984
*/