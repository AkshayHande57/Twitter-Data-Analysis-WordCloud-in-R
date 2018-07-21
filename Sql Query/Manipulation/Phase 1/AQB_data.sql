-- Working on AQB Data. 
----------------------------------------------------------------------------

select * from AQB_Data order by Client_ID

-- Total number of records
select count(1) from AQB_Data -- 2073756

-- Distinct customer records 
select count(distinct(client_ID)) from AQB_DAta -- 1977860 

----------------------------------------------------------------------------
-- Distinct programme customer count 
select programme, count(distinct(client_ID)) as 'Count'
from AQB_Data 
group by programme
order by count(distinct(client_ID)) desc

----------------------------------------------------------------------------
-- Adding new column Mng_Non_Mng table AQB_data 
select * from AQB_Data

alter table AQB_Data 
add Mng_Non_Mng varchar(20) 

update AQB_Data 
set Mng_Non_Mng = 'Non_MNG'
where programme = ''
-- (719981 row(s) affected)

-- Updating records for Mng Flag. 
update AQB_Data 
set Mng_Non_Mng = 'MNG'
where Mng_Non_Mng is null 
-- (1353775 row(s) affected)

select Mng_Non_Mng,count(1) as 'Count' 
from AQB_Data
group by Mng_Non_Mng
/*
Mng_Non_Mng		Count
MNG				1353775
Non_MNG			719981
*/

select * from AQB_Data
----------------------------------------------------------------------------
-- Adding Rank column to AQB_data before counting customer on AQB_Bin

select AQB_Bin,count(1) as 'Count'
from AQB_Data
group by AQB_Bin
/*
AQB_Bin			Count
1_0				295259
2_1-25K			684983
3_25K-50K		278957
4_50K-1LAC		256630
5_1LAC-3LAC		305771
6_3LAC-5LAC		95426
7_5LAC-10LAC	83174
8_10LAC-25LAC	51495
9_>25LAC		22061
*/

-- Adding Rank Column 
select * from AQB_Data

alter table AQB_Data
add AQB_Rank int 

update AQB_Data 
set AQB_Rank = 
	case 
		when AQB_Bin = '1_0' then 1 
		when AQB_Bin = '2_1-25K' then 2 
		when AQB_Bin = '3_25K-50K' then 3 
		when AQB_Bin = '4_50K-1LAC' then 4 
		when AQB_Bin = '5_1LAC-3LAC' then 5 
		when AQB_Bin = '6_3LAC-5LAC' then 6 
		when AQB_Bin = '7_5LAC-10LAC' then 7 
		when AQB_Bin = '8_10LAC-25LAC' then 8 
		when AQB_Bin = '9_>25LAC' then 9 
	end 
-- (2073756 row(s) affected)

select * from AQB_Data order by Client_ID
----------------------------------------------------------------------------
-- Creating Max_Rank table from AQB_Data 
select Client_ID,max(AQB_Rank) as 'Max_Rank'
into ##AQB_Max_Rank_Data
from AQB_Data 
group by Client_ID 
order by Client_ID 
-- (1977860 row(s) affected)
---------------------------------------------------------------------------------------
-- Extract data from AQB_Data table with distinct cust_ID 
select * from AQB_Data
select * from ##AQB_Max_Rank_Data

select distinct a.Client_ID as 'Cust_ID',
b.AQB_Bin,Max_Rank 
into ##AQB_Distinct_Data
from ##AQB_Max_Rank_Data a inner join AQB_Data b on 
a.Client_ID = b.Client_ID and 
a.Max_Rank = b.AQB_Rank
-- (1977860 row(s) affected)

select * from ##AQB_Distinct_Data 
select count(distinct(Cust_ID)) as 'Count' from ##AQB_Distinct_Data -- 1977860
select count(1) from ##AQB_Distinct_Data
------------------------------------------------------------------------------------
-- Creating Temporary table for distinct cust_ID in DB_Bin 
select * from AQB_Data

select DB_bin,count(1) as 'Count' from AQB_DAta 
group by DB_bin
/*
DB_bin		Count
01_<=0		1234274
02_0-10K	178596
03_10-25K	70239
04_10k-50K	66392
05_50k-1L	73269
06_1L-3L	123859
07_3L-10L	125228
08_10L-25L	76214
09_25L-50L	42754
10_50L-1CR	31397
11_>1CR		51534
*/
------------------------------------------------------------------------------------
-- Adding new column DB_Bin_Rank data. 
select * from AQB_Data

alter table AQB_Data
add DB_Bin_Rank int 

update AQB_Data 
set DB_Bin_Rank = 
	case 
		when DB_Bin = '01_<=0' then 1 
		when DB_Bin = '02_0-10K' then 2 
		when DB_Bin = '03_10-25K' then 3 
		when DB_Bin = '04_10k-50K' then 4 
		when DB_Bin = '05_50k-1L' then 5 
		when DB_Bin = '06_1L-3L' then 6 
		when DB_Bin = '07_3L-10L' then 7 
		when DB_Bin = '08_10L-25L' then 8 
		when DB_Bin = '09_25L-50L' then 9 
		when DB_Bin = '10_50L-1CR' then 10 
		when DB_Bin = '11_>1CR' then 11 
	end 
-- (2073756 row(s) affected)

select * from AQB_Data
-------------------------------------------------------------------------
-- Creating DB_Max_Rank table from AQB_Data 
select Client_ID,max(DB_Bin_Rank) as 'Max_Rank'
into ##DB_Max_Rank_Data
from AQB_Data 
group by Client_ID 
order by Client_ID 
-- (1977860 row(s) affected)
---------------------------------------------------------------------------------------
-- Extract data from AQB_Data table with distinct cust_ID 
select * from AQB_Data
select * from ##DB_Max_Rank_Data

select distinct a.Client_ID as 'Cust_ID',
b.DB_Bin,Max_Rank 
into ##DB_Distinct_Data
from ##DB_Max_Rank_Data a inner join AQB_Data b on 
a.Client_ID = b.Client_ID and 
a.Max_Rank = b.DB_BIN_Rank
-- (1977860 row(s) affected)


select * from ##DB_Distinct_Data 
select count(distinct(Cust_ID)) as 'Count' from ##DB_Distinct_Data -- 1977860
select count(1) from ##DB_Distinct_Data -- 1977860
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
select * from AQB_Data

-- Remove Duplicate Client_ID from AQB_Data table.
-- Creating Customer_Max_Exposure table with distinct customers.
select a.* , ROW_NUMBER() over(partition by Client_ID order by Mng_Non_Mng) as 'RowNum'
into ##temp_Mng_Non_Mng
from AQB_Data a
order by Client_ID
-- (2073756 row(s) affected)


select * from ##temp_Mng_Non_Mng order by Client_ID

select Mng_Non_Mng,count(1) from ##temp_Mng_Non_Mng group by Mng_Non_Mng

select count(1) from ##temp_Mng_Non_Mng -- 2073756
select count(1) from ##temp_Mng_Non_Mng where RowNum = 1 -- 1977860

select Client_ID,Mng_Non_Mng into ##Mng_Non_Mng_Distinct from ##temp_Mng_Non_Mng 
where RowNum = 1
-- (1977860 row(s) affected)
----------------------------------------------------------------------------------------
-- Joining on three table to have unique customer data 
select * from ##AQB_Distinct_Data
select count(distinct(CUst_ID)) from ##AQB_Distinct_Data -- 1977860

select * from ##DB_Distinct_Data
select count(distinct(CUst_ID)) from ##AQB_Distinct_Data -- 1977860

select * from ##Mng_Non_Mng_Distinct
select count(distinct(Client_ID)) from ##Mng_Non_Mng_Distinct -- 1977860

select a.Cust_ID,a.AQB_Bin,b.DB_Bin,c.Mng_Non_Mng 
into ##AQB_DB_MGN_NON_MGN_Distinct
from ##AQB_Distinct_Data a inner join ##DB_Distinct_Data b
on a.Cust_ID = b.Cust_ID
inner join ##Mng_Non_Mng_Distinct c 
on a.Cust_ID = c.Client_ID

-- (1977860 row(s) affected)

select count(distinct(cust_ID)) from ##AQB_DB_MGN_NON_MGN_Distinct --1977860
select count(1) from ##AQB_DB_MGN_NON_MGN_Distinct
select * from ##AQB_DB_MGN_NON_MGN_Distinct order by CUst_ID

select * from ##AQB_DB_MGN_NON_MGN_Distinct

select Mng_Non_Mng,count(1) from ##AQB_DB_MGN_NON_MGN_Distinct group by Mng_Non_Mng
select AQB_BIN,count(1) from ##AQB_DB_MGN_NON_MGN_Distinct group by AQB_BIN
select DB_BIN,count(1) from ##AQB_DB_MGN_NON_MGN_Distinct group by DB_BIN