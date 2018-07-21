-- Working on  Customer Porfiling. 
-----------------------------------------------------------------------------

-- Using Customer One View ' ##Cust_Demo_Details '.
select * from ##Cust_Demo_Details
select * from ##Distinct_Cust_Traded_Product

-- Joining  with ##Distinct_Cust_Traded_Product table to get Total_Pure_Brokerage.
select a.*,b.Total_Pure_brokerage into ##CUST_Profile
from ##Cust_Demo_details a  left join ##Distinct_Cust_Traded_Product b
on a.cust_ID = b.cust_ID
-- (653207 row(s) affected) 


-- Cust_Profile table. 
select * from ##CUST_Profile 

-- Adding new column Profile_Flg to ##Cust_Profile table.
alter table ##Cust_Profile 
add Profile_Flg varchar(50) 

update ##Cust_Profile
set Profile_Flg = 
	case 
		when Traded_Product = 'Only_Delivery' then 'Only_Delivery'
		when Traded_Product = 'Only_Margin' then 'Only_Margin'
		when Traded_Product = 'Only_FUT' then 'Only_FUT'
		when Traded_Product = 'Only_OPT' then 'Only_OPT'
		when Traded_Product = 'Del_Mar' then 'Del_Mar'
		else 'Others'
	end
-- (653207 row(s) affected)

select Profile_Flg,count(distinct(cust_ID)) as 'Count',sum(Total_pure_brokerage) as 'Total_Brkg' 
from ##CUST_Profile 
group by Profile_flg
order by count(distinct(cust_ID)) desc
/*
Profile_Flg		Count	Total_Brkg
Only_Delivery	566435	2578054672.48
Only_Margin		31418	457581545.78
Del_Mar			30916	953225470.75
Others			22198	1702902374.64
Only_OPT		1823	54272776.64
Only_FUT		417		19891399.30
*/

-----------------------------------------------------------------------------
-- Activity_ratio across Profile_Flg 
select * from ##CUST_Profile

select activity_ratio,Profile_Flg, count(distinct(cust_ID)) as 'Count_Customer',
sum(Total_pure_brokerage) as 'Total_Brkg' 
from ##CUST_Profile 
group by activity_ratio, Profile_Flg
order by count(distinct(cust_ID)) desc


-----------------------------------------------------------------------------
-- Recency Cap across Profile_Flg 
select * from ##CUST_Profile

select Recency_CAP,Profile_Flg, count(distinct(cust_ID)) as 'Count_Customer',
sum(Total_pure_brokerage) as 'Total_Brkg' 
from ##CUST_Profile 
group by Recency_CAP, Profile_Flg
order by count(distinct(cust_ID)) desc

-----------------------------------------------------------------------------
-- Preferred_Channel across Profile_Flg 

select Preferred_Channel,Profile_Flg, count(distinct(cust_ID)) as 'Count_Customer',
sum(Total_pure_brokerage) as 'Total_Brkg' 
from ##CUST_Profile 
group by Preferred_Channel, Profile_Flg
order by count(distinct(cust_ID)) desc

-----------------------------------------------------------------------------
/*
-- Percentile of total Pure Brokerage across all customer base.
select * from ##CUST_Profile

-- Creating Deciles for OWS Channel medium. 
select Total_Pure_Brokerage,ntile(100) over (order by Total_Pure_Brokerage desc) as 'Dc_Total_Pure_Brokerage'
into #Temp_Deciles_Total_Pure_Brokerage
from ##CUST_Profile
-- (653207 row(s) affected)

select Dc_Total_Pure_Brokerage,min(Total_Pure_Brokerage) as 'Min', 
max(Total_Pure_Brokerage) as 'Max',avg(Total_Pure_Brokerage) as 'Avg',
count(Total_Pure_Brokerage) as 'count'
from #Temp_Deciles_Total_Pure_Brokerage
group by Dc_Total_Pure_Brokerage
order by Dc_Total_Pure_Brokerage
*/

---------------------------------------------------------------------------------
-- Adding Columns of AQB_DB related records to ##CUST_Profile table. 
select * from ##CUST_Profile
select count(Distinct(cust_ID)) from ##CUST_Profile -- 653207

select * from ##AQB_DB_MGN_NON_MGN_Distinct
select count(Distinct(cust_ID)) from ##AQB_DB_MGN_NON_MGN_Distinct -- 1977860

select a.*,b.AQB_Bin,b.DB_Bin,Mng_Non_Mng 
into Customer_Profile
from ##CUST_Profile a left join ##AQB_DB_MGN_NON_MGN_Distinct b 
on a.cust_ID = b.cust_ID
-- (653207 row(s) affected)

select * from Customer_Profile
---------------------------------------------------------------------------------
-- Manage-Non_Manage Vs. Profile of customer 

-- Manage Vs Non_Manage 
select Mng_Non_Mng,count(distinct(cust_ID)) as 'Count' from Customer_Profile group by Mng_Non_Mng
/*
Mng_Non_Mng	Count
NULL		13129
MNG			489235
Non_MNG		150843
*/

select Mng_Non_Mng,Profile_Flg,count(distinct(cust_ID)) as 'Unique_Cust_Count'
from Customer_Profile
group by Mng_Non_Mng,Profile_Flg
order by count(distinct(cust_ID)) desc

---------------------------------------------------------------------------------
-- AQB_BIN Count details 
select AQB_BIN,count(1) as 'Count' from Customer_Profile group by AQB_BIN
/*
AQB_BIN			Count
NULL			13129
1_0				22685
2_1-25K			182891
3_25K-50K		105553
4_50K-1LAC		102742
5_1LAC-3LAC		126133
6_3LAC-5LAC		39179
7_5LAC-10LAC	32780
8_10LAC-25LAC	19963
9_>25LAC		8152
*/

select AQB_BIN,Profile_Flg,count(distinct(cust_ID)) as 'Unique_Cust_Count'
from Customer_Profile
group by AQB_BIN,Profile_Flg
order by count(distinct(cust_ID)) desc

----------------------------------------------------------------------------------------
-- DB_BIN Customer Count
select DB_BIN,count(1) as 'Count' from Customer_Profile group by DB_BIN order by count(1) desc

-- DB_Bin Vs PROFIE 
select DB_BIN,Profile_Flg,count(distinct(cust_ID)) as 'Unique_Cust_Count'
from Customer_Profile
group by DB_BIN,Profile_Flg
order by count(distinct(cust_ID)) desc
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- Creating Deciles for Total_Pure_Brokerage across the Customer_Profile.
select * from ##Customer_Profile_MF_Data

-- 1. Decile for Total_Pure_Brokerage where Traded_Product is Only Delivery. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Only_Del
from ##Customer_Profile_MF_Data
where Traded_Product = 'Only_Delivery'
-- (566435 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Only_Del
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage

----------------------------------------------------------------------------------------

-- 2. Decile for Total_Pure_Brokerage where Traded_Product is Only margin. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Only_Mar
from ##Customer_Profile_MF_Data
where Traded_Product = 'Only_Margin'
-- (31418 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Only_Mar
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage

----------------------------------------------------------------------------------------

-- 3. Decile for Total_Pure_Brokerage where Traded_Product is Only FUT. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Only_FUT
from ##Customer_Profile_MF_Data
where Traded_Product = 'Only_FUT'
-- (417 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Only_FUT
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage

----------------------------------------------------------------------------------------

-- 3. Decile for Total_Pure_Brokerage where Traded_Product is Only OPT. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Only_OPT
from ##Customer_Profile_MF_Data
where Traded_Product = 'Only_OPT'
-- (1823 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Only_OPT
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage

----------------------------------------------------------------------------------------

-- 4. Decile for Total_Pure_Brokerage where Traded_Product is Delivery & Margin. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Only_DEL_MAR
from ##Customer_Profile_MF_Data
where Traded_Product = 'Del_Mar'
-- (30916 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Only_DEL_MAR
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage

----------------------------------------------------------------------------------------
-- 4. Decile for Total_Pure_Brokerage where Traded_Product is Others. 
-- Deciles overall for unrealized_Pnl on customer level 
select Total_pure_brokerage,ntile(10) over (order by Total_pure_brokerage desc) as 'Dc_Total_pure_brokerage'
into #Temp_Deciles_Total_pure_brokerage_Others
from ##Customer_Profile_MF_Data
where Traded_Product != 'Only_Delivery' and 
Traded_Product != 'Only_Margin' and
Traded_Product != 'Only_FUT' and
Traded_Product != 'Only_OPT' and 
Traded_Product != 'Del_Mar'
-- (22198 row(s) affected)

select Dc_Total_pure_brokerage,min(Total_pure_brokerage) as 'Min', 
max(Total_pure_brokerage) as 'Max',avg(Total_pure_brokerage) as 'Avg',
count(Total_pure_brokerage) as 'count'
from #Temp_Deciles_Total_pure_brokerage_Others
group by Dc_Total_pure_brokerage
order by Dc_Total_pure_brokerage


----------------------------------------------------------------------------------
-- Adding Online & Offline Flag to ##Customer_Profile_MF_Data table 
select * from ##Customer_Profile_MF_Data

select Preferred_Channel,count(distinct(cust_ID)) as 'Count'
from ##Customer_Profile_MF_Data
group by Preferred_Channel
order by count(distinct(cust_ID)) desc
/*
Preferred_Channel	Count
I					200777
T					143234
C					126111
O					104065
R					50036
Mix					28984
*/

-- Adding New Column to ##Customer_Profile_MF_Data table. 
alter table ##Customer_Profile_MF_Data
add Online_offline varchar(10)

update ##Customer_Profile_MF_Data
set Online_Offline = 
	case 
		when Preferred_Channel = 'I' then 'OnL'
		when Preferred_Channel = 'T' then 'Ofl'
		when Preferred_Channel = 'C' then 'Onl'
		when Preferred_Channel = 'O' then 'Ofl'
		when Preferred_Channel = 'R' then 'Ofl'
		when Preferred_Channel = 'Mix' then 'Both'
	end
-- (653207 row(s) affected)

select Online_Offline,count(distinct(cust_ID)) as 'Count'
from ##Customer_Profile_MF_Data
group by Online_Offline
order by count(distinct(cust_ID)) desc

-- Online & Offline Flag VS Customer Profile.
select * from ##Customer_Profile_MF_Data

select Profile_Flg,Online_Offline,count(distinct(cust_ID)) as 'Count'
from ##Customer_Profile_MF_Data
group by Profile_Flg,Online_Offline
order by count(distinct(cust_ID)) desc

----------------------------------------------------------------------------------

-- QC realated to Preferred Channel for Customer who trading in Only_FUT & Only_OPT.
select * from CUST_Prf_Chnl
select * from ##EQ_Trades_product

-- Only FUT 
select * into ##temp_Only_FUT 
from ##Customer_Profile_MF_Data 
where Traded_Product = 'Only_FUT'
-- (417 row(s) affected)

select * from ##temp_Only_FUT 
/*
1389129
2948435
3020058
801500
1334639
1082298
*/

select * from ##EQ_Trades_product where TRD_ENT_ID = '1389129'