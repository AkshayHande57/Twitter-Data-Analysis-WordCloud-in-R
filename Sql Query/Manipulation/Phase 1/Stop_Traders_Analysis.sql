-- Working on Stop Traders analysis for customer base where preferrred product is delivery. 

select * into Customer_Profile_MF_Data from ##Customer_Profile_MF_Data
-- (653207 row(s) affected)

select * from Customer_Profile_MF_Data
--------------------------------------------------------------------------------------
-- Adding new column Age_Buckets 
alter table Customer_Profile_MF_Data
add Age_Bucket varchar(20)

update Customer_Profile_MF_Data
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

select * from Customer_Profile_MF_Data

 -- Distinct Customer Count across Age_Bucket Variable.
 select * from Customer_Profile_MF_Data

 select Age_Bucket,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from Customer_Profile_MF_Data 
 group by Age_Bucket 
 order by count(distinct(cust_ID)) desc
/*
Age_Bucket	Unique_Cust_Count
40 - 60		220992
30 - 35		117202
35 - 40		103800
25 - 30		92459
> 60		80395
20 - 25		30515
< 20		7844
*/
-------------------------------------------------------------------------------------
-- Adding Logged_Details to Customer_One_View 
select a.*,b.[Nos.Of.Time] as 'Login_Count',
b.last_login,
b.BK_login_Count 
into FINAL_Customer_One_View
from Customer_Profile_MF_Data a left join ##logged_summary_wo_null b
on a.cust_ID = b.ilu_entity_ID
--  (653207 row(s) affected)

--------------------------------------------------------------------------------------
-- Extracting Customer base for Delivery base customer.
select * into ##ST_Delivery 
from FINAL_Customer_One_View where Preferred_Product = 'DELIVERY'
-- (574073 row(s) affected)


select count(*) from ##ST_Delivery -- 574073
select count(distinct(CUST_ID)) from ##ST_Delivery -- 574073
select * from ##ST_Delivery

-----------------------------------------------------------------------------
-- Adding Flag for Recency_90 days 
-- If Recency > 90 days then > 90 days else < 90 days. 
alter table ##ST_Delivery 
add Cap_90_days varchar(20) 

update ##ST_Delivery
set Cap_90_days = 
	case 
		when Recency > 90 then '> 90 days'
		when Recency <= 90 then '< 90 days'
	end
-- (574073 row(s) affected)

-----------------------------------------------------------------------------
-- Count across Cap_90_Days flag. 
select Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by Cap_90_days
order by count(distinct(cust_ID)) desc
/*
Cap_90_days		Count
< 90 days		373723
> 90 days		200350
*/
------------------------------------------------------------------------------
-- Creating Profile for ST_Delivey base customer.

-- 1. Age_Bucket across Cap_90_days 
select Age_Bucket,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by Age_Bucket,Cap_90_days
order by count(distinct(cust_ID)) desc

------------------------------------------------------------------------------
-- 2. Traded-Product
select * from ##ST_Delivery

select Traded_Product,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by Traded_Product
order by count(distinct(cust_ID)) desc
/*
Traded_Product	Count
Only_Delivery	566435
Del_Mar			6288
Del_OPT			919
Del_FUT			233
Del_FUT_OPT		85
Del_Mar_OPT		84
Mix				15
Del_Mar_FUT		14
*/

-- Traded_Product Vs cap_90_Days 
select Traded_Product,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by Traded_Product,Cap_90_days
order by count(distinct(cust_ID)) desc

------------------------------------------------------------------------------
-- 3. Activity_Ratio 
select top 10 * from ##ST_Delivery

select Activity_Ratio,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by Activity_Ratio
order by count(distinct(cust_ID)) desc
/*
Activity_Ratio	Count
< 33%			312370
33% to 66%		136647
> 66%			125056
*/

-- Activity Ratio Vs. Cap_90_days
select Activity_Ratio,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by Activity_Ratio,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 4. BK_Total_Rlz_BV 
select top 10 * from ##ST_Delivery

select BK_Total_Rlz_BV,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Total_Rlz_BV
order by count(distinct(cust_ID)) desc
/*
BK_Total_Rlz_BV	Count
NULL			304049
1lk to 10lk		84205
10k to 50k		63342
<= 10k			56331
50k to 1lk		31070
10lk to 50lk	25423
>1Cr			4844
50lk to 1Cr		4809
*/

-- BK_Total_Rlz_BV Vs. Cap_90_days
select BK_Total_Rlz_BV,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by BK_Total_Rlz_BV,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 5. BK_Perc_Rlz
select top 10 * from ##ST_Delivery

select BK_Perc_Rlz,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Perc_Rlz
order by count(distinct(cust_ID)) desc
/*
BK_Perc_Rlz		Count
NULL			304049
0 % to 10 %		131201
0 % to -10 %	62443
10 % to 20 %	39946
20 % to 50 %	19705
-10 % to -20 %	8646
> 50 %.			3945
-20 % to -50 %	3774
< -50 %.		364
*/

-- BK_Perc_Rlz Vs. Cap_90_days
select BK_Perc_Rlz,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by BK_Perc_Rlz,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 6. BK_Total_Unrlz_BV
select top 10 * from ##ST_Delivery

select BK_Total_Unrlz_BV,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Total_Unrlz_BV
order by count(distinct(cust_ID)) desc
/*
BK_Total_Unrlz_BV	Count
NULL				164616
1lk to 10lk			127054
<= 10k				105155
10k to 50k			99656
50k to 1lk			49904
10lk to 50lk		24108
50lk to 1Cr			2330
>1Cr				1250
*/

-- BK_Total_Unrlz_BV  Vs. Cap_90_days
select BK_Total_Unrlz_BV,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by BK_Total_Unrlz_BV,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 7. BK_Perc_Unreal
select top 10 * from ##ST_Delivery

select BK_Perc_Unreal,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Perc_Unreal
order by count(distinct(cust_ID)) desc
/*
BK_Perc_Unreal	Count
NULL			166224
-20 % to -50 %	103881
0 % to -10 %	99146
-10 % to -20 %	83273
0 % to 10 %		60710
10 % to 20 %	22885
< -50 %.		17933
20 % to 50 %	16413
> 50 %.			3608
*/

--BK_Perc_Unreal Vs. Cap_90_days
select BK_Perc_Unreal,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by BK_Perc_Unreal,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 8. Preferred_Channel
select top 10 * from ##ST_Delivery

select Preferred_Channel,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by Preferred_Channel
order by count(distinct(cust_ID)) desc
/*
Preferred_Channel	Count
I					192221
C					117330
T					100119
O					92810
R					47916
Mix					23677
*/

-- Preferred_Channel Vs. Cap_90_days
select Preferred_Channel,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by Preferred_Channel,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 9. Preferred_Sector 
select top 10 * from ##ST_Delivery

select Preferred_Sector,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by Preferred_Sector
order by count(distinct(cust_ID)) desc
/*

*/

-- Preferred_Sector Vs. Cap_90_days
select Preferred_Sector,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by Preferred_Sector,Cap_90_days
order by count(distinct(cust_ID)) desc
------------------------------------------------------------------------------
-- 10. City 
select top 10 * from ##ST_Delivery

select City,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery
group by City
order by count(distinct(cust_ID)) desc
/*

*/

-- City Vs. Cap_90_days
select City,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
where city = 'MUMBAI' or
city = 'PUNE' or
city = 'CHENNAI' or
city = 'BENGALURU' or
city = 'KOLKATA' or
city = 'THANE' or
city = 'NEW DELHI' or
city = 'DELHI' or
city = 'AHMEDABAD' or
city = 'HYDERABAD' or
city = 'NAVI MUMBAI' or
city = 'GURGAON' or
city = 'VADODARA' or
city = 'BANGALORE' or
city = 'JAIPUR' or
city = 'SURAT' or
city = 'GHAZIABAD' or
city = 'RAJKOT' or
city = 'NASHIK' or
city = 'INDORE' or
city = 'DUBAI' or
city = 'FARIDABAD' or
city = 'LUCKNOW' or
city = 'NOIDA' or
city = 'COIMBATORE' or
city = 'NAGPUR' or
city = 'PATNA' or
city = 'HOWRAH' or
city = 'BHARUCH' or
city = 'ERNAKULAM' or
city = 'BHOPAL' or
city = 'CHANDIGARH' or
city = 'JAMNAGAR' or
city = 'THRISSUR' or
city = 'VISAKHAPATNAM' or
city = 'KANPUR' or
city = 'LUDHIANA' or
city = 'HOOGHLY' or
city = 'JAMSHEDPUR' or
city = 'GUNTUR' or
city = 'SECUNDERABAD' or
city = 'BHAVNAGAR' or
city = 'RANCHI' or
city = 'GUWAHATI' or
city = 'AGRA' or
city = 'AMRITSAR' or
city = 'GANDHINAGAR' or
city = 'SALEM' or
city = 'AURANGABAD' or
city = 'KOLHAPUR' or
city = 'BHUBANESWAR' or
city = 'RANGAREDDY' or
city = 'JALGAON' or
city = 'ALLAHABAD' or
city = 'GWALIOR' or
city = 'SATARA' or
city = 'SANGLI' or
city = 'PANCHKULA' or
city = 'JAMMU' or
city = 'JALANDHAR' or
city = 'MADURAI' or
city = 'PALAKKAD' or
city = 'ABU DHABI' or
city = 'UDAIPUR' or
city = 'JABALPUR' or
city = 'MYSORE' or
city = 'AHMEDNAGAR' or
city = 'ERODE' or
city = 'DEHRADUN' or
city = 'RAIPUR' or
city = 'MEERUT' or
city = 'KARIMNAGAR' or
city = 'TRIVANDRUM' or
city = 'HISAR' or
city = 'RAIGARH' or
city = 'JODHPUR' or
city = 'KANCHEEPURAM' or
city = 'VARANASI' or
city = 'CUTTACK' or
city = 'BOKARO' or
city = 'BURDWAN' or
city = 'VELLORE' or
city = 'KRISHNA' or
city = 'AKOLA' or
city = 'MOHALI' or
city = 'GORAKHPUR' or
city = 'BARODA' or
city = 'WARANGAL' or
city = 'SOLAPUR' or
city = 'KOTA' or
city = 'AMRAVATI' or
city = 'SINGAPORE' or
city = 'NELLORE' or
city = 'AJMER' or
city = 'BELGAUM' or
city = 'KANNUR' or
city = 'ANKLESHWAR' or
city = 'SRINAGAR' or
city = 'ALWAR' or
city = 'JUNAGADH' or
city = 'KOZHIKODE' or
city = 'NORTH PARGANAS' or
city = 'KOTTAYAM' or
city = 'MANGALORE' or
city = 'KURNOOL' or
city = 'DHANBAD' or
city = 'VAPI' or
city = 'SILIGURI' or
city = 'TRICHY' or
city = 'PANIPAT' or
city = 'REWARI' or
city = 'PATIALA' or
city = 'BAREILLY' or
city = 'CHITTOOR' or
city = 'BILASPUR' or
city = 'VIJAYAWADA' or
city = 'MEDAK' or
city = 'NAVSARI' or
city = 'ALIGARH' or
city = 'KARNAL' or
city = 'ANAND' or
city = 'ANANTAPUR' or
city = 'DURGAPUR' or
city = 'MUZAFFARPUR' or
city = 'KOCHI' or
city = 'VALSAD' or
city = 'THIRUVANANTHAPURAM' or
city = 'UDUPI' or
city = 'THANE WEST' or
city = 'KHAMMAM' or
city = 'TIRUVALLUR' or
city = 'UJJAIN' or
city = 'NAMAKKAL' or
city = 'TIRUNELVELI' or
city = 'BHILWARA' or
city = 'RATNAGIRI' or
city = 'SOUTH DELHI' or
city = 'PRAKASAM' or
city = 'BATHINDA' or
city = 'GAYA' or
city = 'KALYAN' or
city = 'LATUR' or
city = 'SHARJAH' or
city = 'BHIWANI' or
city = 'JALNA' or
city = 'ROHTAK' or
city = 'MEHSANA' or
city = 'SONIPAT' or
city = 'EAST GODAVARI' or
city = 'KANPUR NAGAR' or
city = 'NORTH TWENTY FOUR PARGANAS' or
city = 'KARAD' or
city = 'WEST GODAVARI' or
city = 'K V RANGAREDDY' or
city = 'MATHURA' or
city = 'NALGONDA' or
city = 'SILVASSA' or
city = 'TIRUCHIRAPPALLI' or
city = 'GULBARGA' or
city = 'PORBANDAR' or
city = 'GAUTAM BUDDHA NAGAR' or
city = 'SURENDRANAGAR' or
city = 'DURG' or
city = 'BHAGALPUR' or
city = 'THANJAVUR' or
city = 'CHANDIGARH U T' or
city = 'RANGAREDDI' or
city = 'MORADABAD' or
city = 'KOLLAM' or
city = 'MALAPPURAM' or
city = 'RAIGAD' or
city = 'GANDHIDHAM' or
city = 'SAHARANPUR' or
city = 'NADIAD' or
city = 'SHIMLA' or
city = 'CUDDAPAH' or
city = 'SATNA' or
city = 'AHMADNAGAR' or
city = 'ROURKELA' or
city = 'DHULE' or
city = 'PALGHAR' or
city = 'MAHESANA' or
city = 'AMBALA' or
city = 'NASIK' or
city = 'MUZAFFARNAGAR' or
city = 'KURUKSHETRA' or
city = 'CUDDALORE' or
city = 'PALANPUR' or
city = 'SIRSA' or
city = 'VIZIANAGARAM' or
city = 'DIST THANE' or
city = 'SRIKAKULAM' or
city = 'JORHAT' or
city = 'HOSHIARPUR' or
city = 'DEOGHAR' or
city = 'TIRUPPUR' or
city = 'HYDERABAD TELANGANA' or
city = 'KANGRA' or
city = 'DINDIGUL' or
city = 'ANGUL' or
city = 'AHMADABAD' or
city = 'NIZAMABAD' or
city = 'BIKANER' or
city = 'PONDA' or
city = 'BHILAI' or
city = 'NANDED' or
city = 'DOHA' or
city = 'HAMIRPUR' or
city = 'EAST DELHI' or
city = 'SHILLONG' or
city = 'VIRUDHUNAGAR' or
city = 'DARBHANGA' or
city = 'ALAPPUZHA' or
city = 'JHANSI' or
city = 'PONDICHERRY' or
city = 'PATHANAMTHITTA' or
city = 'AMRELI' or
city = 'KANCHIPURAM' or
city = 'RAMGARH' or
city = 'KAKINADA' or
city = 'KHOPOLI' or
city = 'KUWAIT' or
city = 'SANGAMNER' or
city = 'CHANDRAPUR' or
city = 'MUSCAT' or
city = 'KAITHAL' or
city = 'MORBI' or
city = 'BULANDSHAHR' or
city = 'MANDI' or
city = 'KARUR' or
city = 'TRICHUR' or
city = 'RANGA REDDY' or
city = 'TIRUPATI' or
city = 'NORTH PARGANAS' or
city = 'MARGAO' or
city = 'YAVATMAL' or
city = 'BHUJ' or
city = 'ADILABAD' or
city = 'SAGAR' or
city = 'BELLARY' or
city = 'NAINITAL' or
city = 'BEGUSARAI' or
city = 'KUSHINAGAR' or
city = 'SIKAR' or
city = 'PANVEL' or
city = 'WARDHA' or
city = 'WEST DELHI' or
city = 'HARIDWAR' or
city = 'RATLAM' or
city = 'VILLUPURAM' or
city = 'GURDASPUR' or
city = 'SOUTH WEST DELHI' or
city = 'CHITTORGARH' or
city = 'SOLAN' or
city = 'DEORIA' or
city = 'VERAVAL' or
city = 'KAPURTHALA' or
city = 'TINSUKIA' or
city = 'PRATAPGARH' or
city = 'KORBA' or
city = 'HUBLI' or
city = 'REWA' or
city = 'ICHALKARANJI' or
city = 'DIBRUGARH' or
city = 'NADIA' or
city = 'UNNAO' or
city = 'TIRUPUR' or
city = 'ULHASNAGAR' or
city = 'MOGA' or
city = 'ASANSOL' or
city = 'YAMUNANAGAR' or
city = 'BANKURA' or
city = 'GANJAM' or
city = 'JAUNPUR' or
city = 'DAMAN' or
city = 'PALI' or
city = 'PARBHANI' or
city = 'SOUTH PARGANAS' or
city = 'DHARMAPURI' or
city = 'KALOL' or
city = 'JIND' or
city = 'SHIMOGA' or
city = 'DHARWAD' or
city = 'YAMUNA NAGAR' or
city = 'RIYADH' or
city = 'BALLIA' or
city = 'KADAPA' or
city = 'BEED' or
city = 'MITHAPUR' or
city = 'GIRIDIH' or
city = 'AZAMGARH' or
city = 'FATEHPUR' or
city = 'PATHANKOT' or
city = 'BIJNOR' or
city = 'PANAJI' or
city = 'COCHIN' or
city = 'MANDSAUR' or
city = 'RAJAHMUNDRY' or
city = 'BHIWADI' 
group by City,Cap_90_days
order by count(distinct(cust_ID)) desc

------------------------------------------------------------------------
-- 11. Login Data 
select * from ##ST_Delivery

select BK_login_count,count(distinct(CUST_ID)) as 'Logged_In_Count'
from ##ST_Delivery
group by BK_login_count
order by count(distinct(CUST_ID)) desc

-- BK_login_count Vs. Cap_90_days
select BK_login_count,Cap_90_days,count(distinct(cust_ID)) as 'Count'
from ##ST_Delivery 
group by BK_login_count,Cap_90_days
order by count(distinct(cust_ID)) desc

------------------------------------------------------------------------
-- 12. Market Cap data 
select * from ##ST_Delivery

select Preferred_Market_cap,Cap_90_days,count(distinct(Cust_ID)) as 'Count'
from ##ST_Delivery
group by Preferred_Market_cap,Cap_90_days
order by count(distinct(Cust_ID)) desc

--------------------------------------------------------------------------
-- Adding Vintage Bucket to Stop Traders tables. 
select * from ##ST_Delivery

alter table ##ST_Delivery
add BK_Vintage_mth varchar(20) 

update ##ST_Delivery
set BK_Vintage_mth = 
	case 
		when AON_MONTH < 6 then '< 6' 
		when AON_MONTH >= 6 and AON_MONTH < 12 then '6 to 12' 
		when AON_MONTH >= 12 and AON_MONTH < 24 then '12 to 24'
		when AON_MONTH >= 24 and AON_MONTH < 36 then '24 to 36'
		when AON_MONTH >= 36 and AON_MONTH < 60 then '36 to 60'
		when AON_MONTH >= 60 then '> 60'
	end
-- (574073 row(s) affected)

select * from ##ST_Delivery

-- Vintage Months
select BK_Vintage_mth,count(distinct(Cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Vintage_mth
order by count(distinct(Cust_ID))

-- Vintage VS Cap_90_days
select BK_Vintage_mth,Cap_90_days,count(distinct(Cust_ID)) as 'Count'
from ##ST_Delivery
group by BK_Vintage_mth,Cap_90_days
order by count(distinct(Cust_ID)) desc

------------------------------------------------------------------------------------------------
-- Working on Realized BV & Unrealized BV 
select top 100 * from ##ST_Delivery

-- Creating Temp ##Real_BV table where Total_Real_BV is null and cap_90_days > 90 days 
select CUST_ID as 'Cust_ID_RBV',Preferred_PRODUCT, BK_Total_rlz_BV,Cap_90_days
into ##Real_BV
from ##ST_Delivery
where BK_Total_rlz_BV is null and Cap_90_days = '> 90 days'
-- (139079 row(s) affected)

select top 100 * from ##Real_BV
select count(distinct(Cust_ID_RBV)) from ##Real_BV --139079

------------------------------------------------------------------------------------------------
-- Creating Temp ##Unreal_BV table where Total_unReal_BV is null and cap_90_days > 90 days 
select CUST_ID as 'Cust_ID_UnBV',Preferred_PRODUCT, BK_Total_unrlz_BV,Cap_90_days
into ##UnReal_BV
from ##ST_Delivery
where BK_Total_unrlz_BV is null and Cap_90_days = '> 90 days'
-- (103598 row(s) affected)

select * from ##UnReal_BV
select count(distinct(Cust_ID_UnBV)) from ##UnReal_BV --103598

------------------------------------------------------------------------------------------------
-- Full outer join on  ##Real_BV & ##UnReal_BV table.
select distinct a.Cust_ID_RBV,b.Cust_ID_UnBV 
into ##Union_RBV_UnrBV
from ##Real_BV a full outer join ##unreal_BV b 
on a.Cust_ID_RBV = b.Cust_ID_UnBV
-- (173557 row(s) affected)

select * from ##Union_RBV_UnrBV 
------------------------------------------------------------------------------------------------
-- Adding Tag Column to ##Union_RV_UnrBV table.
Alter table ##Union_RBV_UnrBV
add Tag varchar(10) 

update ##Union_RBV_UnrBV
set Tag = 
	case 
		when Cust_ID_RBV is not null and Cust_ID_UnBV is not null then 'BNA'
		when Cust_ID_RBV is not null and Cust_ID_UnBV is null then 'RNA'
		when Cust_ID_RBV is null and Cust_ID_UnBV is not null then 'UNA'
	end
-- (173557 row(s) affected)
------------------------------------------------------------------------------------------------
-- Count of Tag
select * from ##Union_RBV_UnrBV where Tag = 'BNA'

select Tag,count(1) as 'Count' 
from ##Union_RBV_UnrBV 
group by Tag
order by count(1) desc
/*
Tag	Count
RNA	69959
BNA	69120
UNA	34478
*/

-- QC 2377369,636715,2628303,299297
select * from ##ST_Delivery where cust_ID ='2377369'
select * from ##ST_Delivery where cust_ID ='2628303'
select * from ##ST_Delivery where cust_ID ='636715'
select * from ##ST_Delivery where cust_ID ='299297'

----------------------------------------------------------------------------------------
-- Adding new Column as Final_ID to ##Union_RBV_UnrBV
alter table ##Union_RBV_UnrBV
add Final_Cust_ID varchar(20) 

update ##Union_RBV_UnrBV
set Final_Cust_ID = 
	case 
		when Cust_ID_RBV is not null and Cust_ID_UnBV is not null then Cust_ID_RBV
		when Cust_ID_RBV is null and Cust_ID_UnBV is not null then Cust_ID_UnBV
		when Cust_ID_RBV is not null and Cust_ID_UnBV is null then Cust_ID_RBV
	end
-- (173557 row(s) affected)

select * from ##Union_RBV_UnrBV
select count(distinct(Final_Cust_ID)) from ##Union_RBV_UnrBV -- 173557
----------------------------------------------------------------------------------------
-- Creating summary records from EQ_contract_note_details_All_Delivery_records
select CND_ENT_ID,CND_ORDER_NO,CND_PRODUCT_TYPE,CND_BUY_SELL_FLG,TRADED_VALUE
into ##Temp_rlz_Unrlz_all_delivery_records
from EQ_contract_note_details_All_Delivery_records 
-- (48525227 row(s) affected)

select * from ##Temp_rlz_Unrlz_all_delivery_records

select CND_ENT_ID,CND_BUY_SELL_FLG,sum(TRADED_VALUE) as 'Total_Traded_Value',
count(distinct(CND_ORDER_NO)) as 'Total_Count'
into ##Summary_rlz_unrlz_delivery_records
from ##Temp_rlz_Unrlz_all_delivery_records
group by CND_ENT_ID,CND_BUY_SELL_FLG
order by CND_ENT_ID 
-- (977421 row(s) affected)

select * from ##Summary_rlz_unrlz_delivery_records
select count(distinct(CND_ENT_ID)) from ##Summary_rlz_unrlz_delivery_records -- 614749

----------------------------------------------------------------------------------------
-- We need to Tranpose ##Summary_rlz_Unrlz_delivery_records table. 
-- Following code create Pivot table for Total_Traded_value & Total_count by BUY_SELL_FLG.

-- Creating Pivot table for Pivot table Traded_Value 
select	Cnd_ENT_ID,
		[B] as 'TRD_VAL_B',
		[S] as 'TRD_VAL_S'
into ##Pivot_TRD_VAL_Rlz_Unrlz
from  
( 
select  Cnd_ENT_ID,CND_BUY_SELL_FLG,[Total_Traded_Value]
from ##Summary_rlz_unrlz_delivery_records 
) as source
pivot
(
	max([Total_Traded_Value])
	for CND_BUY_SELL_FLG in ([B],[S])
) as Pivot_TABLES
-- (614749 row(s) affected)
-- Duration : 1 sec

select * from ##Pivot_TRD_VAL_Rlz_Unrlz

-- Creating Pivot table to Tranpose Total-Count column based on Buy_Sell Flg.
-- Creating Pivot table for Pivot table Total-Count
select	Cnd_ENT_ID,
		[B] as 'Total_Buy_Order',
		[S] as 'Total_Sell_Order'
into ##Pivot_Total_Count_Rlz_Unrlz
from  
( 
select  Cnd_ENT_ID,CND_BUY_SELL_FLG,[Total_Count]
from ##Summary_rlz_unrlz_delivery_records 
) as source
pivot
(
	max([Total_Count])
	for CND_BUY_SELL_FLG in ([B],[S])
) as Pivot_TABLES
-- (614749 row(s) affected)

select * from ##Pivot_Total_Count_Rlz_Unrlz
----------------------------------------------------------------------------------------
-- Joining Two Pivot table 
select a.*,b.Total_Buy_Order,b.Total_Sell_Order
into ##Pivot_TRD_VAL_Both_Order
from ##Pivot_TRD_VAL_Rlz_Unrlz a inner join ##Pivot_Total_Count_Rlz_Unrlz b
on a.CND_ENT_ID = b.CND_ENT_ID
-- (614749 row(s) affected) 

select top 1000 * from ##Pivot_TRD_VAL_Both_Order
select count(distinct(cnd_ENT_ID)) from ##Pivot_TRD_VAL_Both_Order -- 614749

-- Adding new column to ##Pivot_TRD_VAL_Both_Order table. 
alter table ##Pivot_TRD_VAL_Both_Order
add Total_TRD_Value numeric(13,3) 

update ##Pivot_TRD_VAL_Both_Order
set Total_TRD_Value = 
	case 
		when TRD_VAL_B is not null and TRD_VAL_S is not null then TRD_VAL_B + TRD_VAL_S 
		when TRD_VAL_B is not null and TRD_VAL_S is null then TRD_VAL_B 
		when TRD_VAL_B is null and TRD_VAL_S is not null then TRD_VAL_S
	end 
 -- (614749 row(s) affected)

select top 100 * from ##Pivot_TRD_VAL_Both_Order
select * from ##Pivot_TRD_VAL_Both_Order where Total_TRD_Value is null
-- No records retrived.

-- Adding new column Perc_Sell to ##Pivot_TRD_VAL_Both_Order table. 
alter table ##Pivot_TRD_VAL_Both_Order
add Perc_Sell numeric(13,2)

update ##Pivot_TRD_VAL_Both_Order
set Perc_Sell = (ISNULL(TRD_VAL_S,0)/Total_TRD_value)*100
-- (614749 row(s) affected)

select top 100 * from ##Pivot_TRD_VAL_Both_Order

---------------------------------------------------------------
-- Creating Framework for Stop_Traderds for Rlz & Unrlz Flag.
select top 100 * from ##Union_RBV_UnrBV
select count(distinct(Final_Cust_ID)) from ##Union_RBV_UnrBV -- 173557 
select top 100 * from ##Pivot_TRD_VAL_Both_Order
select count(distinct(cnd_ENT_ID)) from ##Pivot_TRD_VAL_Both_Order -- 614749 

-- Left Join on ##Union_RBV_UnrBV & ##Pivot_TRD_VAL_Both_Order 
select a.Final_Cust_ID as 'Cust_ID',
a.Tag,
b.TRD_VAL_B,
b.TRD_VAL_S,
b.Total_TRD_Value,
b.Perc_Sell,
b.Total_Buy_Order,
b.Total_Sell_Order
into ##ST_Rlz_Unrlz_Delivery
from ##Union_RBV_UnrBV a left join ##Pivot_TRD_VAL_Both_Order b
on a.Final_Cust_ID = b.cnd_ENT_ID 
-- (173557 row(s) affected)

select * from ##ST_Rlz_Unrlz_Delivery
select count(distinct(Cust_ID)) from ##ST_Rlz_Unrlz_Delivery --173557

-----------------------------------------------------------------------------
-- QC 
select * from ##ST_Rlz_Unrlz_Delivery where cust_ID ='3056451'

------------------------------------------------------------------------------ 
-- Looking at Perc_Sell Distrubution across all Tag. 
select * from ##ST_Rlz_Unrlz_Delivery 

-- Creating Deciles based on Tag = UNA
select Perc_sell,ntile(10) over (order by Perc_sell desc) as 'Dc_Perc_sell'
into #Temp_Deciles_Perc_sell_UNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'UNA'
-- (34478 row(s) affected)

select Dc_Perc_sell,min(Perc_sell) as 'Min', 
max(Perc_sell) as 'Max',avg(Perc_sell) as 'Avg',
count(Perc_sell) as 'count'
from #Temp_Deciles_Perc_sell_UNA
group by Dc_Perc_sell
order by Dc_Perc_sell
------------------------------------------------------------------------------
-- Creating Deciles based on Tag = RNA
select Perc_sell,ntile(10) over (order by Perc_sell desc) as 'Dc_Perc_sell'
into #Temp_Deciles_Perc_sell_RNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'RNA'
-- (69959 row(s) affected)

select Dc_Perc_sell,min(Perc_sell) as 'Min', 
max(Perc_sell) as 'Max',avg(Perc_sell) as 'Avg',
count(Perc_sell) as 'count'
from #Temp_Deciles_Perc_sell_RNA
group by Dc_Perc_sell
order by Dc_Perc_sell
------------------------------------------------------------------------------
-- Creating Deciles based on Tag = BNA
select Perc_sell,ntile(10) over (order by Perc_sell desc) as 'Dc_Perc_sell'
into #Temp_Deciles_Perc_sell_BNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'BNA'
-- (69120 row(s) affected)

select Dc_Perc_sell,min(Perc_sell) as 'Min', 
max(Perc_sell) as 'Max',avg(Perc_sell) as 'Avg',
count(Perc_sell) as 'count'
from #Temp_Deciles_Perc_sell_BNA
group by Dc_Perc_sell
order by Dc_Perc_sell
------------------------------------------------------------------------------
-- Creatin Deciles for Buy Order based on TAG. 

select * from ##ST_Rlz_Unrlz_Delivery
-- Creating Deciles for Total_Buy_Order based on Tag = BNA
select Total_Buy_Order,ntile(10) over (order by Total_Buy_Order desc) as 'Dc_Total_Buy_Order'
into #Temp_Deciles_Total_Buy_Order_BNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'BNA'
-- (69120 row(s) affected)

select Dc_Total_Buy_Order,min(Total_Buy_Order) as 'Min', 
max(Total_Buy_Order) as 'Max',avg(Total_Buy_Order) as 'Avg',
count(Total_Buy_Order) as 'count'
from #Temp_Deciles_Total_Buy_Order_BNA
group by Dc_Total_Buy_Order
order by Dc_Total_Buy_Order

-- UNA 
select * from ##ST_Rlz_Unrlz_Delivery
-- Creating Deciles for Total_Buy_Order based on Tag = UNA
select Total_Buy_Order,ntile(10) over (order by Total_Buy_Order desc) as 'Dc_Total_Buy_Order'
into #Temp_Deciles_Total_Buy_Order_UNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'UNA'
-- (34478 row(s) affected)

select Dc_Total_Buy_Order,min(Total_Buy_Order) as 'Min', 
max(Total_Buy_Order) as 'Max',avg(Total_Buy_Order) as 'Avg',
count(Total_Buy_Order) as 'count'
from #Temp_Deciles_Total_Buy_Order_UNA
group by Dc_Total_Buy_Order
order by Dc_Total_Buy_Order

-- RNA 
select * from ##ST_Rlz_Unrlz_Delivery
-- Creating Deciles for Total_Buy_Order based on Tag = RNA
select Total_Buy_Order,ntile(10) over (order by Total_Buy_Order desc) as 'Dc_Total_Buy_Order'
into #Temp_Deciles_Total_Buy_Order_RNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'RNA'
-- (34478 row(s) affected)

select Dc_Total_Buy_Order,min(Total_Buy_Order) as 'Min', 
max(Total_Buy_Order) as 'Max',avg(Total_Buy_Order) as 'Avg',
count(Total_Buy_Order) as 'count'
from #Temp_Deciles_Total_Buy_Order_RNA
group by Dc_Total_Buy_Order
order by Dc_Total_Buy_Order

---------------------------------------------------------------------------------------------
-- Deciles for Total_Sell_orders 
select * from ##ST_Rlz_Unrlz_Delivery

-- Creating Deciles for Total_Buy_Order based on Tag = BNA
select Total_Sell_Order,ntile(10) over (order by Total_Sell_Order desc) as 'Dc_Total_Sell_Order'
into #Temp_Deciles_Total_Sell_Order_BNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'BNA'
-- (69120 row(s) affected)

select Dc_Total_Sell_Order,min(Total_Sell_Order) as 'Min', 
max(Total_Sell_Order) as 'Max',avg(Total_Sell_Order) as 'Avg',
count(Total_Sell_Order) as 'count'
from #Temp_Deciles_Total_Sell_Order_BNA
group by Dc_Total_Sell_Order
order by Dc_Total_Sell_Order

-- Creating Deciles for Total_Buy_Order based on Tag = UNA
select Total_Sell_Order,ntile(10) over (order by Total_Sell_Order desc) as 'Dc_Total_Sell_Order'
into #Temp_Deciles_Total_Sell_Order_UNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'UNA'
-- (34478 row(s) affected)

select Dc_Total_Sell_Order,min(Total_Sell_Order) as 'Min', 
max(Total_Sell_Order) as 'Max',avg(Total_Sell_Order) as 'Avg',
count(Total_Sell_Order) as 'count'
from #Temp_Deciles_Total_Sell_Order_UNA
group by Dc_Total_Sell_Order
order by Dc_Total_Sell_Order

-- Creating Deciles for Total_Buy_Order based on Tag = RNA
select Total_Sell_Order,ntile(10) over (order by Total_Sell_Order desc) as 'Dc_Total_Sell_Order'
into #Temp_Deciles_Total_Sell_Order_RNA
from ##ST_Rlz_Unrlz_Delivery
where Tag = 'RNA'
-- (69959 row(s) affected)

select Dc_Total_Sell_Order,min(Total_Sell_Order) as 'Min', 
max(Total_Sell_Order) as 'Max',avg(Total_Sell_Order) as 'Avg',
count(Total_Sell_Order) as 'count'
from #Temp_Deciles_Total_Sell_Order_RNA
group by Dc_Total_Sell_Order
order by Dc_Total_Sell_Order
---------------------------------------------------------------------------------------------