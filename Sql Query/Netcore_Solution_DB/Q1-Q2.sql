select * from eq_trades

drop table eq_trades

select top 100 * into EQ_Trades from OpenQuery(PRCSN,'select * from Trades
where TRD_DT between To_date(''05-04-2017'',''dd-mm-yyyy'') and To_date(''05-04-2018'',''dd-mm-yyyy'')')

select * from EQ_Contract_note_master
drop table Contract_note_master
-- Extracting Data from contract_note_master table to Netcore_solution_DB 
select *  into EQ_Contract_note_master_Q1 from OpenQuery(PRCSN,'select * from contract_note_master 
where cnm_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''30-06-2017'',''dd-mm-yyyy'')')
-- EQ_Contact_note_master_q1 - 2324540 - Execution Time : 24 mins 

-- Q2 
select *  into EQ_Contract_note_master_Q2 from OpenQuery(PRCSN,'select * from contract_note_master 
where cnm_date between To_date(''01-07-2017'',''dd-mm-yyyy'') and To_date(''30-09-2017'',''dd-mm-yyyy'')')
-- EQ_Contact_note_master_q2 - 2648120 - Execution Time : 27.33 mins  

-- Q3 1st Oct 2017 to 31st Dec 2017
select *  into EQ_Contract_note_master_Q3 from OpenQuery(PRCSN,'select * from contract_note_master 
where cnm_date between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''31-12-2017'',''dd-mm-yyyy'')')
-- EQ_Contact_note_master_q2 --  --Execution Time :  mins  


-- Union of two tables 

/* SELECT * into FInal
From table1
UNION
SELECT * From table2
*/
use Netcore_Sol_TEMPDB
select * into EQ_contract_note_master_Q1_Q2 
FROM [dbo].[EQ_Contract_note_master_Q1] 
UNION 
select * from [dbo].[EQ_Contract_note_master_Q2]
-- (4972660 row(s) affected) 02.54 mins 

