-- MF Releated queries 

-- Extracting data from mf_trades table 
-- Extracting Data from  mfss_contract_note table in Netcore DB 
select *  into mfss_contract_note from OpenQuery(PRCSN,'select * from mfss_contract_note 
where transaction_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- NUmber of Rows : 2879463 -- Execution Time : 13.50
select * from mfss_contract_note

-- QC test for mfss_contract_note table 
select min(transaction_date),max(transaction_date) from mfss_contract_note

-- Creating Allotment statement table in Netcore DB 
select * into allotment_statement from OpenQuery(PRCSN,'select * from allotment_statement 
where order_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- (2692860 row(s) affected) Execution Time : 11.39 mins
select * from allotment_statement

select min(order_date),max(order_date) from allotment_statement

-- creating redemption_statement table in netcore DB 
select * into redemption_statement from OpenQuery(PRCSN,'select * from redemption_statement 
where order_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
select * from redemption_statement

-- (151075 row(s) affected) -- Execution Time : 0.40 sec

select min(order_date),max(order_date) from redemption_statement

-- 
--------------------------------------------------------------------------------------
select top 100 * from mfss_contract_note
select top 100 * from allotment_statement
select top 100 * from redemption_statement


select distinct(SECURITY_TXN_TAX) , count(*) 
from mfss_contract_note
group by SECURITY_TXN_TAX

select distinct([STATUS]) , count(*) 
from mfss_contract_note
group by [STATUS]
/*
STATUS	(No column name)
C	3870
I	2875593
*/

select distinct(stc_type), count(*)
from mfss_contract_note
group by stc_type

select distinct(SCHEME_ID) , count(*)
from mfss_contract_note
group by SCHEME_ID
-- All Values are marked as "1" dropping this value.

-----------------------------------------------------------------------------------------

-- Extracting mfss_trades data for 1 years
select * into mfss_trades
from 
OpenQuery(PRCSN,'select * from mfss_trades
where ORDER_DATE between To_date(''01-04-2017'',''dd-mm-yyyy'') 
and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Number of rows :  3095979
-- Duratio : 25.19 mins

-- MF trades data extracted for past 1 years



