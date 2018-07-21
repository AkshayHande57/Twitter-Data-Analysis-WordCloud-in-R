-- Working on MIX Customer VS Non-Mix Customer 

select top 1000 * from Final_Cust_One_View 
select count(*) from Final_Cust_One_View -- 653207 
select count(distinct(cust_ID)) from Final_Cust_One_View -- 653207

-- Entity Master Table
select top 1000 * from Entity_Master_with_lst_DT
select count(*) from Entity_Master_with_lst_DT -- 3009075 
select count(distinct(ENT_ID)) from Entity_Master_with_lst_DT -- 3009075

-- Creating Demogrpahic details table
-- Using two table to create Demo_details table.
-- 1. Final_Cust_One_View 2. Entity_Master_with_lst_DT

select a.*,
b.ENT_TYPE,
b.ENT_CLIENT_TYPE,
b.ENT_SEG_FLAG,
b.ENT_CATEGORY,
b.ENT_STATUS,
b.ENT_ADDRESS_LINE_4 as 'City',
b.ENT_ADDRESS_LINE_5 as 'State',
b.ENT_BR_REG_DT as 'Acquire_Date',
b.ENT_ADDRESS_LINE_6 as 'Country',
b.ENT_ADDRESS_LINE_7 as 'Pin_Code',
b.ENT_DOB,
b.ENT_FIRST_TRD_DT,
b.ENT_TRD_CONFIRM,
b.ENT_DESIGNATION,
b.ENT_EDU_QUAL,
b.ENT_OCCUPATION,
b.ENT_SEX as 'Gender',
b.ENT_EXCH_CLIENT_ID,
b.ENT_MARITAL_STATUS,
b.ENT_NATIONALITY,
b.Age,
b.AON_Month,
b.AON_Days,
b.AON_Year,
b.C2T_Day,
b.C2T_Month,
b.C2T_Year,
b.LST_TRD_DT,
b.ST_Days,
b.ST_Mths
into ##Cust_Demo_Details
from Final_Cust_One_View a left join Entity_Master_with_lst_DT b on 
a.Cust_ID = b.ENT_ID
-- (653207 row(s) affected) 



-- ##Cust_Demo_Details table. 
select * from ##Cust_Demo_Details where cust_ID = '621697'
select count(*) from ##Cust_Demo_Details -- 653207
select count(distinct(cust_ID)) as 'Count' from ##Cust_Demo_Details --653207

-- Mix Vs. Non_Mix customer 
select * from ##Cust_Demo_Details

select PREFERRED_PRODUCT,count(distinct(cust_ID)) as 'Unique_Cust_Count'
from ##Cust_Demo_Details 
group by Preferred_PRODUCT 
order by count(distinct(cust_ID)) desc
/*
PREFERRED_PRODUCT	Unique_Cust_Count
DELIVERY			574073
MARGIN				39255
MIX					26478
OPT					9097
FUT					4304
*/

-- Adding Flag to ##Cust_Demo_Details which will classify if the product is Mix or not.
alter table ##Cust_Demo_Details
add MIX_FLG varchar(10) 

update ##Cust_Demo_Details
set MIX_FLG = 
	case 
		when PREFERRED_PRODUCT = 'MIX' then 'Mix'
		else 'Non_Mix'
	end
-- (653207 row(s) affected)
----------------------------------------------------------------------------
 -- ##Cust_Demo_Details 
 select * from ##Cust_Demo_Details

 -- Count of Mix Vs Non_Mix 
 select MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by MIX_FLG
/*
MIX_FLG	Unique_Cust_Count
Mix			26478
Non_Mix		626729
*/
----------------------------------------------------------------------------
-- Distinct Customer Count across Country Variable. 
 select Country,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Country 
 order by count(distinct(cust_ID)) desc
---------------------------------------------------------------------------
-- Distinct Customer Count across City Variable.
select * from ##Cust_Demo_Details

 select City,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by City 
 order by count(distinct(cust_ID)) desc

 -- City Vs MIX_FLG
 select City,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by City,MIX_FLG 
 order by count(distinct(cust_ID)) desc
 
 ---------------------------------------------------------------------------
 -- Distinct Customer Count across State Variable.
select * from ##Cust_Demo_Details

 select [State],count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by [State] 
 order by count(distinct(cust_ID)) desc
 ---------------------------------------------------------------------------
  -- Distinct Customer Count across Gender Variable.
 select * from ##Cust_Demo_Details

 select Gender,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Gender 
 order by count(distinct(cust_ID)) desc

 -- Gender VS MIX_FLG
 select Gender,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Gender,MIX_FLG 
 order by count(distinct(cust_ID)) desc


 ---------------------------------------------------------------------------
  -- Distinct Customer Count across Activity_Ratio Variable.
 select * from ##Cust_Demo_Details

 select Activity_Ratio,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Activity_Ratio 
 order by count(distinct(cust_ID)) desc

 -- ACtivity-Ratio Vs MIX_FLG
 select Activity_Ratio,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Activity_Ratio,MIX_FLG 
 order by count(distinct(cust_ID)) desc

 ---------------------------------------------------------------------------
   -- Distinct Customer Count across Recency_Cap Variable.
 select * from ##Cust_Demo_Details

 select Recency_Cap,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Recency_Cap 
 order by count(distinct(cust_ID)) desc

 -- Recency_CAP Vs Mix_FLG
 select Recency_Cap,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Recency_Cap,MIX_FLG 
 order by count(distinct(cust_ID)) desc
 ---------------------------------------------------------------------------
    -- Distinct Customer Count across BRKG_AM Variable.
 select * from ##Cust_Demo_Details

 select BRKG_AM,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by BRKG_AM 
 order by count(distinct(cust_ID)) desc

 -- Recency_CAP Vs Mix_FLG
 select BRKG_AM,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by BRKG_AM,MIX_FLG 
 order by count(distinct(cust_ID)) desc
 ---------------------------------------------------------------------------
 -- Creating Age Buckets for Column Age 
  select * from ##Cust_Demo_Details

-- Adding new column Age_Buckets 
alter table ##Cust_Demo_Details
add Age_Bucket varchar(20)

update ##Cust_Demo_Details
set Age_Bucket = 
	case 
		when Age <= 20 then '< 20'
		when Age > 20 and Age <= 25 then '20 - 25'
		when Age > 25 and Age <= 30 then '25 - 30'
		when Age > 30 and Age <= 35 then '30 - 35' 
		when Age > 35 and Age <= 40 then '35 - 40'
		when Age > 40 and Age <= 60 then '40 - 60'
		when Age > 60 then '> 60'
	end
-- (653207 row(s) affected)

select * from ##Cust_Demo_Details

 -- Distinct Customer Count across Age_Bucket Variable.
 select * from ##Cust_Demo_Details

 select Age_Bucket,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Age_Bucket 
 order by count(distinct(cust_ID)) desc

 -- Recency_CAP Vs Mix_FLG
 select Age_Bucket,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Age_Bucket,MIX_FLG 
 order by count(distinct(cust_ID)) desc
-----------------------------------------------------------------------------
 -- Distinct Customer Count across Preferred_Channel Variable.
 select * from ##Cust_Demo_Details

 select Preferred_Channel,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Preferred_Channel 
 order by count(distinct(cust_ID)) desc

 -- Recency_CAP Vs Mix_FLG
 select Preferred_Channel,MIX_FLG,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Cust_Demo_Details 
 group by Preferred_Channel,MIX_FLG 
 order by count(distinct(cust_ID)) desc
 -----------------------------------------------------------------------------
 -- Country based analysis. 
 -- Selecting country as INDIA 
 select * from ##Cust_Demo_Details where PREFERRED_PRODUCT = 'FUT'
 select count(1) from ##Cust_Demo_Details -- 653207

 select * into ##Cust_India from ##Cust_Demo_Details where Country = 'INDIA'
 -- (642691 row(s) affected)
 
 select * from ##Cust_India

 -- Distinct Customer count across various states in INDIA. 
 select [state],count(distinct(Cust_ID)) as 'Count'
 from ##Cust_India 
 group by [state]
 order by [state],count(distinct(cust_ID)) desc

 -- State VS Mix_Flg 
 select [state],MIX_FLG,count(distinct(Cust_ID)) as 'Count'
 from ##Cust_India 
 group by [state],MIX_FLG
 order by count(distinct(cust_ID)) desc

 select * from ##Cust_India
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
