-- Display top 100 rows 
select top 100 * from Entity_Master

-- Creating of Customer One Datamart.

-- Looking at the last trade_date for both eq_trades & dtm_trades.
select top 100 * from eq_charges_validity
select top 100 * from dtm_charges_validity

-- Required columns from Entity_Master for creation of Customer_OneView table.
/*
-- ENT_ID (CUSTOMER_ID)
-- ENT_TYPE (CUSTOMER_TYPE)
-- ENT_CLIENT_TYPE
-- ENT_CATEGORY
-- ENT_STATUS
-- ENT_ADDRESS_LINE_4 (CITY)
-- ENT_ADDRESS_LINE_5 (STATE)
-- ENT_BR_REG_DT (CUSTOMER_ACQUIRE_DT)
-- ENT_ADDRESS_LINE_6 (COUNTRY)
-- ENT_ADDRESS_LINE_7 (PINCODE) 
-- ENT_FIRST_TRD_DT (FIRST_TRADE_DT)
-- ENT_DESIGNATION 
-- ENT_EDU_QUAL
-- ENT_OCCUPATION
-- ENT_SEX (GENDER)
-- ENT_MARITAL_STATUS
-- ENT_NATIONALITY
-- AGE
*/

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
-- CITY (Tier Classification of Indian City)

*/

---------------------------------------------------------------------------------------------

-- Creating derived variable AON (Age_on_Network) column for Entity_Master table.

-- Creating AON_Month Column
alter table Entity_Master
add AON_Month numeric(10)

select top 100 cast(ENT_BR_REG_DT as date) as 'Acquire_DT',cast(GETDATE() as date)as 'Today', DATEDIFF(month,ENT_BR_REG_DT,SYSDATETIME()) as 'AON'
from Entity_Master 

update Entity_Master 
set AON_Month = DATEDIFF(month,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) 

-- QC 
select top 1000 AON_month from Entity_Master

-- Creating AON_Days Column
alter table Entity_Master
add AON_Days numeric(10)

update Entity_Master 
set AON_Days = DATEDIFF(DAY,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) 

-- Creating AON_Days Year
alter table Entity_Master
add AON_Year numeric(10)

update Entity_Master 
set AON_Year = DATEDIFF(YEAR,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) 

select top 100 AON_Days,AON_month,AON_Year
from Entity_Master
--------------------------------------------------------------------------------------------

-- Create new column C2T (Customer_To_Trade) 
-- Formula : C2T = Acqur_DT - First_Trade_DT

select top 100 ENT_BR_REG_DT, ENT_FIRST_TRD_DT, datediff(month,ENT_BR_REG_DT,ENT_FIRST_TRD_DT) as 'C2T_Month',
datediff(year,ENT_BR_REG_DT,ENT_FIRST_TRD_DT) as 'C2T_Year',
datediff(day,ENT_BR_REG_DT,ENT_FIRST_TRD_DT) as 'C2T_Day'
from Entity_Master

-- Create C2T_Day 
alter table Entity_Master
add C2T_Day numeric(10)

update Entity_Master 
set C2T_Day = DATEDIFF(Day,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) 

-- Create C2T_Month 
alter table Entity_Master
add C2T_Month numeric(10)

update Entity_Master 
set C2T_Month = DATEDIFF(Month,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) 

-- Create C2T_Year 
alter table Entity_Master
add C2T_Year numeric(10)

update Entity_Master 
set C2T_Year = DATEDIFF(Year,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) 

select top 100 C2T_Day,C2T_Month,C2T_Year 
from Entity_Master
--------------------------------------------------------------------------------------------

-- Working on Last_Trade column 
-- Last_Trade_DT is not available in Entity_Master table therefore extracting Last_Trade table 
-- from other tables.
select * from Entity_Master where ent_ID = '1000002'
select top 100 * from eq_charges_validity where ecv_ent_ID = '1082543'

-- Creating New column 'Last_Trade_DT_EQ' 
select a.*,case 
			when a.ENT_FIRST_TRD_DT is null then NULL 
			when b.ECV_LAST_TRD_DT_BSE > b.ECV_LAST_TRD_DT_NSE then b.ECV_LAST_TRD_DT_BSE 
			when b.ECV_LAST_TRD_DT_BSE < b.ECV_LAST_TRD_DT_NSE then b.ECV_LAST_TRD_DT_NSE
			when b.ECV_LAST_TRD_DT_BSE is null then b.ECV_LAST_TRD_DT_NSE
			when b.ECV_LAST_TRD_DT_NSE is null then b.ECV_LAST_TRD_DT_BSE 
		end as 'Last_Trade_DT_EQ',b.ECV_LAST_TRD_DT_BSE,b.ECV_LAST_TRD_DT_NSE
into Entity_Master_Trade_DT
from Entity_Master a left join eq_charges_validity b 
on a.ENT_ID = b.ECV_ENT_ID
-- Number of records : (3009075 row(s) affected)
-- Duration : 4.37 mins

select top 100 * from Entity_Master_Trade_DT

-- Checking last_Trade_dt for custoemr for derivaties trades. 
select top 100 * from dtm_charges_validity
select top 100 * from Entity_Master_Trade_DT

-- Left join on Entity_Master_Trade_DT with dtm_charges_validity to extract last trade for
-- customer performing derivaties transactions.
select a.*,case 
			when a.ENT_FIRST_TRD_DT is null then NULL 
			when b.DTM_LAST_TRD_DT_BSE > b.DTM_LAST_TRD_DT_NSE then b.DTM_LAST_TRD_DT_BSE
			when b.DTM_LAST_TRD_DT_BSE < b.DTM_LAST_TRD_DT_NSE then b.DTM_LAST_TRD_DT_NSE
			when b.DTM_LAST_TRD_DT_BSE is null then b.DTM_LAST_TRD_DT_NSE
			when b.DTM_LAST_TRD_DT_NSE is null then b.DTM_LAST_TRD_DT_BSE 
		end as 'Last_Trade_DT_DTM',b.DTM_LAST_TRD_DT_BSE,b.DTM_LAST_TRD_DT_NSE
into Entity_Master_with_lst_DT
from Entity_Master_Trade_DT a left join dtm_charges_validity b 
on a.ENT_ID = b.DTM_ENT_ID

select  * from Entity_Master_with_lst_DT where Last_Trade_DT_DTM is not null

-- We now have two different Last_Trade_DT_EQ & Last_Trade_DT_DTM with us.
-- Will create new column on Entity_Master_with_lst_DT table which will have date which is 
-- lastest in both.

-- Adding New column from LST_TRD_DT
alter table Entity_Master_with_lst_DT
add LST_TRD_DT datetime2

select top 10000 Last_Trade_DT,Last_Trade_DT_DTM,
		case  
			when Last_Trade_DT is null then Last_Trade_DT_DTM
			when Last_Trade_DT_DTM is null then Last_Trade_DT
			when Last_Trade_DT > Last_Trade_DT_DTM then Last_Trade_DT
			when Last_Trade_DT_DTM > Last_Trade_DT then Last_Trade_DT_DTM
		end as LST_TRD_DT
from Entity_Master_with_lst_DT 

select top 1 * from Entity_Master_with_lst_DT

update Entity_Master_with_lst_DT
set LST_TRD_DT = case  
					when Last_Trade_DT is null then Last_Trade_DT_DTM
					when Last_Trade_DT_DTM is null then Last_Trade_DT
					when Last_Trade_DT > Last_Trade_DT_DTM then Last_Trade_DT
					when Last_Trade_DT_DTM > Last_Trade_DT then Last_Trade_DT_DTM
				 end

-- Droping intermediate tables 
drop table [dbo].[Entity_Master_Trade_DT]
drop table [dbo].[Entity_Master_lst_date]

-- QC 
select top 10 * from Entity_Master_with_lst_DT

---------------------------------------------------------------------------------------

-- Creating Derived columns ST_Days & ST_Mths
select top 1000 lst_trd_dt, 
DATEDIFF(day,lst_trd_dt,getdate()) as 'ST_Days',
DATEDIFF(MONTH,lst_trd_dt,getdate()) as 'ST_Month'
from Entity_Master_with_lst_DT

-- Adding two column on Entity_Master_with_lst_DT
alter table Entity_Master_with_lst_DT
add ST_Days numeric(10)

alter table Entity_Master_with_lst_DT
add ST_Mths numeric(10)

-- Update ST_Days and ST_Mths 
update Entity_Master_with_lst_DT
set ST_Days = DATEDIFF(day,lst_trd_dt,getdate())

update Entity_Master_with_lst_DT
set ST_Mths = DATEDIFF(MONTH,lst_trd_dt,getdate())

select top 10 * from Entity_Master_with_lst_DT


-------------------------------------------------------------------------------------------

-- Query to create Customer One View Table.

/*
Step 1 : Creation of Last_Trade_DT columns
 
Last_Trade_Date is not avialable in source table therefore we need to create with 
with joining two tables and performing manipulation on it.

For a customer , ther two separate Last_Trade_DT captured one for Equity & Derivaties.
These dates are strored in two separate table ecv_charges_validity and dtm_charges_validity.


			

*/
-----------------------------------------------------------------------------
--STEP 1--
-----------------------------------------------------------------------------
-- Creating New column 'Last_Trade_DT_EQ' 
select a.*,case 
			when a.ENT_FIRST_TRD_DT is null then NULL 
			when b.ECV_LAST_TRD_DT_BSE > b.ECV_LAST_TRD_DT_NSE then b.ECV_LAST_TRD_DT_BSE 
			when b.ECV_LAST_TRD_DT_BSE < b.ECV_LAST_TRD_DT_NSE then b.ECV_LAST_TRD_DT_NSE
			when b.ECV_LAST_TRD_DT_BSE is null then b.ECV_LAST_TRD_DT_NSE
			when b.ECV_LAST_TRD_DT_NSE is null then b.ECV_LAST_TRD_DT_BSE 
			when ECV_LAST_TRD_DT_NSE = ECV_LAST_TRD_DT_BSE then ECV_LAST_TRD_DT_NSE
		end as 'Last_Trade_DT_EQ',b.ECV_LAST_TRD_DT_BSE,b.ECV_LAST_TRD_DT_NSE
into Entity_Master_Trade_DT
from Entity_Master a left join eq_charges_validity b 
on a.ENT_ID = b.ECV_ENT_ID

drop table Entity_Master_Trade_DT

select top 100 * from Entity_Master_Trade_DT  where ENT_ID = '1570991'

-- Left join on Entity_Master_Trade_DT with dtm_charges_validity to extract last trade for
-- customer performing derivaties transactions.
select a.*,case 
			when a.ENT_FIRST_TRD_DT is null then NULL 
			when b.DTM_LAST_TRD_DT_BSE > b.DTM_LAST_TRD_DT_NSE then b.DTM_LAST_TRD_DT_BSE
			when b.DTM_LAST_TRD_DT_BSE < b.DTM_LAST_TRD_DT_NSE then b.DTM_LAST_TRD_DT_NSE
			when b.DTM_LAST_TRD_DT_BSE is null then b.DTM_LAST_TRD_DT_NSE
			when b.DTM_LAST_TRD_DT_NSE is null then b.DTM_LAST_TRD_DT_BSE 
			when b.DTM_LAST_TRD_DT_NSE = b.DTM_LAST_TRD_DT_BSE then b.DTM_LAST_TRD_DT_BSE
		end as 'Last_Trade_DT_DTM',b.DTM_LAST_TRD_DT_BSE,b.DTM_LAST_TRD_DT_NSE
into Entity_Master_with_EQ_DRV
from Entity_Master_Trade_DT a left join dtm_charges_validity b 
on a.ENT_ID = b.DTM_ENT_ID

select * from Entity_Master_with_EQ_DRV where ENT_ID = '674410'
select max(LST_TRD_DT) from Entity_Master_with_EQ_DRV
select * from Entity_Master_with_EQ_DRV where LST_TRD_DT is null 

drop table Entity_Master_with_EQ_DRV

-- We now have two different Last_Trade_DT_EQ & Last_Trade_DT_DTM with us.
-- Will create new column on Entity_Master_with_lst_DT table which will have date which is 
-- lastest in both.


-- Adding New column from LST_TRD_DT
alter table Entity_Master_with_EQ_DRV
add LST_TRD_DT datetime2

update Entity_Master_with_EQ_DRV
set LST_TRD_DT = case  
					when Last_Trade_DT_EQ is null then Last_Trade_DT_DTM
					when Last_Trade_DT_DTM is null then Last_Trade_DT_EQ
					when Last_Trade_DT_EQ > Last_Trade_DT_DTM then Last_Trade_DT_EQ
					when Last_Trade_DT_DTM > Last_Trade_DT_EQ then Last_Trade_DT_DTM
					when Last_Trade_DT_EQ = Last_Trade_DT_DTM then Last_Trade_DT_EQ
				 end
-- (3009075 row(s) affected)

-- Droping intermediate tables 
drop table [dbo].[Entity_Master_Trade_DT]
drop table [dbo].[Entity_Master_lst_date]

-- Delete below intermediate columns from Entity_Master_with_lst_DT
-- 1. Last_Trade_DT_EQ
-- 2. Last_Trade_DT_DTM


/*
Final Query to create Customer_One View.
Prequiste : Step 1 : Last_TRD_DT step should be executed before this step.
*/
select  
ENT_ID,
ENT_TYPE,
ENT_CLIENT_TYPE,
ENT_SEG_FLAG,
ENT_CATEGORY,
ENT_STATUS,
ENT_ADDRESS_LINE_4 as 'City',
ENT_ADDRESS_LINE_5 as 'State',
ENT_ADDRESS_LINE_6 as 'Country',
ENT_ADDRESS_LINE_7 as 'Pincode',
ENT_DESIGNATION,
ENT_EDU_QUAL,
ENT_OCCUPATION,
ENT_SEX,
ENT_MARITAL_STATUS,
ENT_DOB,
DATEDIFF(YEAR,cast(ENT_DOB as date),cast(getdate() as date)) as 'Age',
ENT_BR_REG_DT as 'Acq_DT',
ENT_FIRST_TRD_DT, 
DATEDIFF(month,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) as 'AON_Month',
DATEDIFF(day,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) as 'AON_Days',
DATEDIFF(Year,cast(ENT_BR_REG_DT as date),cast(getdate() as date)) as 'AON_Year',
DATEDIFF(Day,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) as 'C2T_Day',
DATEDIFF(MONTH,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) as 'C2T_MONTH',
DATEDIFF(year,cast(ENT_BR_REG_DT as date),cast(ENT_FIRST_TRD_DT as date)) as 'C2T_year',
LST_TRD_DT,
DATEDIFF(day,cast(lst_trd_dt as date),cast(getdate() as date)) as 'ST_days',
DATEDIFF(MONTH,cast(lst_trd_dt as date),cast(getdate() as date)) as 'ST_Mths'
from Entity_Master_with_lst_DT

