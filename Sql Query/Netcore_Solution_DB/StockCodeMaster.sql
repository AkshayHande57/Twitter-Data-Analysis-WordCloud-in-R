-- Creating Stock Code Master.
-- Stock Code Master table contains listed companies on BSE & NSE.

-- Uploading BSE list & NSE list.
-- Adding data to SQL server from CSV File. 
select * from [dbo].[Stock Code]
-- 4340 records 

select * from [Stock Code]
select count(1) from [Stock Code]
select [ISIN NO],count(1) from [Stock Code] group by [ISIN NO] having count(1) = 1
-- 4340 


----------------------------------------------------------------------------------------------------
-- Extracting data from Security Master table from PRCSN table. 
select * into Security_Master from OpenQuery(PRCSN,'select * from security_master')
-- (48919 row(s) affected)

-- Display Records 
select * from security_master

select sem_status,count(1) as 'Count' from Security_Master group by sem_status
/*
sem_status	Count
A	48789
S	125
I	5
*/

--------------------------------------------------------------------------

select * from Security_Master
select top 100 * from EQ_contract_note_details_All_records
select * from [Stock Code]
select * from Security_Master

--------------------------------------------------------------------------
-- Adding HDFC_CODE to Stock Code table.
select * from [Stock Code]
select * from Security_Master

select a.*,b.SEM_ID as 'Hdfc_Code' into ##Stock_Code 
from [Stock Code] a left join  Security_Master b on 
a.[ISIN No] = b.SEM_ISIN_CD

select * from ##Stock_Code

select * from Security_Master

-----------------------------------------------------------------------------
-- Adding the ISIN_No to EQ_Contract_Note_Details table. 
select top 100 * from EQ_contract_note_details_All_records
select * from Security_Master

Alter table EQ_contract_note_details_All_records
add ISIN_NO varchar(15)

update  EQ_contract_note_details_All_records
set ISIN_NO = b.SEM_ISIN_CD 
from EQ_contract_note_details_All_records a 
left join Security_Master b
on a.CND_SEM_ID = b.SEM_ID
-- (66513573 row(s) affected) 
-- Duration : 1.22.36.55

-- QC 
select top 100 * from EQ_contract_note_details_All_records where CND_SEM_ID = 'L&TFHEQ'
-- INE498L01015 
-- L&TFHEQ

select top 100 * from Security_Master
where SEM_ISIN_CD = 'INE498L01015' 

-----------------------------------------------------------------------------------------
-- Tables Related to Stock Codes 
select * from [Stock Code]
select * from ##Stock_Code
select * from Security_Details
select * from Security_Master

----------------------------------------------------------------------------------------
select * from ##Stock_Code where Sector != ''

-----------------------------------------------------------------------------------------
-- Working with Market Captilization of Company. 
-- Company listed on Exchanges are classified into Market Caps ( Large , Medium, Low ).
-- Excel data with list of company as per Market Cap are uploaded into SQL Server.

-- BSE_CAP_FULL_list
-- Below table consists of list of company listed on BSE exchange & there Market Capital.\
select * from [Stock Code] -- 4340 
select * from BSE_Cap_Index_All -- 1044
select * from BSE_Cap_Index_All where [Cap Category] = 'Small' --859
select * from BSE_Cap_Index_All where [Cap Category] = 'Mid' -- 100 
select * from BSE_Cap_Index_All where [Cap Category] = 'Large' -- 85


-- NSE_CAP_FULL_LIST
select * from NSE_Cap_Index_All -- 501 
select * from NSE_Cap_Index_All where [Cap Category] = 'Small' -- 250
select * from NSE_Cap_Index_All where [Cap Category] = 'Mid' -- 150 
select * from NSE_Cap_Index_All where [Cap Category] = 'Large' -- 101
------------------------------------------------------------------------------------------------
select a.*,b.[Cap Category] as 'BSE_CAP' into ##BSE_MAR_CAP from [Stock Code] a left join 
BSE_Cap_Index_All b on a.[ISIN No] = b.[ISIN No]

select * from ##BSE_MAR_CAP
select count(1) from ##BSE_MAR_CAP -- 4340
select count(1) from ##BSE_MAR_CAP where BSE_CAP is NULL -- 3296
select count(1) from ##BSE_MAR_CAP where BSE_CAP is not NULL -- 1044
select count(1) from BSE_Cap_Index_All -- 1044 

--NSE 
select a.*,b.[Cap Category] as 'NSE_CAP' into ##NSE_MAR_CAP from [Stock Code] a left join 
NSE_Cap_Index_All b on a.[ISIN No] = b.[ISIN Code]
select * from ##NSE_MAR_CAP
select count(1) from ##NSE_MAR_CAP -- 4340
select count(1) from ##NSE_MAR_CAP where NSE_CAP is NULL -- 3839
select count(1) from ##NSE_MAR_CAP where NSE_CAP is not NULL -- 501
select count(1) from NSE_Cap_Index_All -- 501 

select * from ##BSE_MAR_CAP
select * from ##NSE_MAR_CAP

-- Combining Columns from both the temp tables. 
drop table ##BSE_NSE_MAR_CAP

select * from ##Stock_Code
select * from [Stock Code]

-- From BSE table will use BSE_CAP column & from NSE table we will use NSE_CAP column.
select a.*,b.BSE_CAP,c.NSE_CAP into ##BSE_NSE_MAR_CAP from ##Stock_Code a left join ##BSE_MAR_CAP b 
on a.[ISIN No] = b.[ISIN No] 
left join ##NSE_MAR_CAP c 
on a.[ISIN No] = c.[ISIN No]

select * from ##BSE_NSE_MAR_CAP
select count(1) from ##BSE_NSE_MAR_CAP --4340
select count(1) as 'BSE_COUNT' from ##BSE_NSE_MAR_CAP  where BSE_CAP is NULL -- 3296
select count(1) as 'NSE_COUNT' from ##BSE_NSE_MAR_CAP  where NSE_CAP is NULL -- 3839

select * from ##BSE_NSE_MAR_CAP

-- Adding New Column of Market_Cap in temp table ##BSE_NSE_MAR_CAP
alter table ##BSE_NSE_MAR_CAP
Drop column MarKet_CAP

alter table ##BSE_NSE_MAR_CAP
add Market_CAP varchar(15)

update ##BSE_NSE_MAR_CAP
set Market_CAP = 
	case 
		when BSE_CAP is null and NSE_CAP is null then NULL
		when BSE_CAP is not null and NSE_CAP is null then BSE_CAP 
		when BSE_CAP is not null and NSE_CAP is not null then NSE_CAP
		when BSE_CAP is null and NSE_CAP is not null then NSE_CAP
	end
-- (4340 row(s) affected)
select * from ##BSE_NSE_MAR_CAP

---------------------------------------------------------------------------------
select * from  ##BSE_NSE_MAR_CAP where BSE_CAP is NULL and NSE_CAP is not null  -- 12 rows 
select * from  ##BSE_NSE_MAR_CAP where BSE_CAP is Not NULL and NSE_CAP is null  -- 555 rows 

select * from ##BSE_NSE_MAR_CAP
select count(1) from ##BSE_NSE_MAR_CAP -- 4340
select count(1) from ##BSE_NSE_MAR_CAP where Market_Cap is not null -- 1056
select count(1) from ##BSE_NSE_MAR_CAP where Market_Cap is  null -- 3284

-- Droppping Column of BSE_CAP & NSE_CAP FROM Temporary table ##BSE_NSE_MAR_CAP.
-- Dropping BSE_CAP
alter table ##BSE_NSE_MAR_CAP
drop column BSE_CAP 

-- Dropping NSE_CAP
alter table ##BSE_NSE_MAR_CAP
drop column NSE_CAP 

select * from ##BSE_NSE_MAR_CAP
select Market_cap , count(1) as 'Count' from ##BSE_NSE_MAR_CAP group by [Market_Cap] order by count(1) desc

-----------------------------------------------------------------------------------------------
-- Creating Market_Cap 

select count(1) from MarketCap_HDFC_Sec --2855 
drop table MarketCap_HDFC_Sec
select * from MarketCap_HDFC_Sec
select * from ##Stock_Code

-- Creating Temporary table with Market_Cap value for listed companies from ##Stock_Code table. 
select * from ##Stock_Code
select count(1) from ##Stock_Code -- 4340 records 

-- Full Outer JOin
select a.*,b.[ Market Cap (Latest)] as 'Market_CAP_Value' from ##Stock_Code a full outer join MarketCap_HDFC_Sec b 
on a.[ISIN No] = b.[ ISIN No]

-- Equi Join
select a.*,b.[ Market Cap (Latest)] as 'Market_CAP_Value' into ##Stock_Code_MarCap 
from ##Stock_Code a inner join MarketCap_HDFC_Sec b 
on a.[ISIN No] = b.[ ISIN No]
-- 2823 rows affected 

drop table ##Stock_Code_MarCap

select * from ##Stock_Code_MarCap order by Market_CAP_Value desc
select * from ##Stock_Code_MarCap 

-- Analyzing Market Cap Size
select * from ##BSE_NSE_MAR_CAP
select count(1) from ##BSE_NSE_MAR_CAP -- 4340 
select count(1) from ##BSE_NSE_MAR_CAP where Market_CAP is null -- 3284
select count(1) from ##BSE_NSE_MAR_CAP where Market_CAP is not null --1056

select * into ##Large_cap from ##BSE_NSE_MAR_CAP where Market_CAP = 'Large' -- 104 rows 
select * into ##Mid_cap from ##BSE_NSE_MAR_CAP where Market_CAP = 'Mid' -- 154 rows 
select * into ##Small_cap from ##BSE_NSE_MAR_CAP where Market_CAP = 'Small' -- 798 rows 
-------------------------------------------------------------------------------------------

-- Analyzying Large_Cap Companies 
select * from ##Large_cap
select count(1) from ##Large_cap --104 
select * from ##stock_code_MarCap

select a.*,b.Market_CAP_Value into ##Temp_Large from ##Large_cap a left join ##Stock_Code_MarCap b 
on a.[ISIN No] = b.[ISIN No]
order by Market_cap_Value desc
-------------------------------------------------------------------------------------------

-- Analyzying Mid_Cap Companies 
select * from ##Mid_cap
select count(1) from ##Mid_cap --154 
select * from ##stock_code_MarCap

select a.*,b.Market_CAP_Value into ##Temp_Mid from ##Mid_cap a left join ##Stock_Code_MarCap b 
on a.[ISIN No] = b.[ISIN No]
order by Market_cap_Value desc
-------------------------------------------------------------------------------------------
-- Analyzying Small_Cap Companies 
select * from ##Small_cap
select count(1) from ##Small_cap -- 798 
select * from ##stock_code_MarCap

select a.*,b.Market_CAP_Value into ##Temp_Small from ##Small_cap a left join ##Stock_Code_MarCap b 
on a.[ISIN No] = b.[ISIN No]
order by Market_cap_Value desc

-- Union of All Market_Cap temp tables 
select * into ##Temp_All_Mar_Cap 
from ##Temp_Large Union Select * from ##Temp_Mid Union select * from ##Temp_Small
-- 1056 rows Affected 

select * from ##Temp_All_Mar_Cap

select Market_cap,count(1) as 'Count',
min(Market_cap_value) as 'Min',
max(Market_cap_value) as 'Max',
avg(Market_cap_value) as 'Avg' 
from ##Temp_All_Mar_Cap 
group by Market_cap
order by Market_Cap

/*
Market_cap	Count	Min		Max		Avg
Large		104		8774	670728	97828.355769
Mid			154		4023	39945	15604.318181
Small 		798		33		16301	2248.982389

*/


-----------------------------------------------------------------------------------------------------------
select top 1000 * from EQ_contract_note_details_All_records
select distinct(ISIN_NO) into ##Traded_Stocks from EQ_contract_note_details_All_records
select * from ##Traded_Stocks
select count(*) from ##Traded_Stocks -- 4357

select * from MarketCap_HDFC_SEC
select count(1) from MarketCap_HDFC_SEC --2855
select * into ##MarkCap_Traded_Stock from ##Traded_Stocks a left join MarketCap_HDFC_SEC b 
on a.ISIN_NO = b.[ ISIN No]

drop table ##MarkCap_Traded_Stock

select * from ##Traded_Stocks a full join MarketCap_HDFC_SEC b 
on a.ISIN_NO = b.[ ISIN No]

select * from ##MarkCap_Traded_Stock

select ISIN_NO,CO_NAME 
from ##MarkCap_Traded_Stock 
where CO_Name is NULL
-- 1579 

select ISIN_NO,CO_NAME
from ##MarkCap_Traded_Stock 
where CO_Name is not NULL
----------------------------------------------------------------------------------------------------
