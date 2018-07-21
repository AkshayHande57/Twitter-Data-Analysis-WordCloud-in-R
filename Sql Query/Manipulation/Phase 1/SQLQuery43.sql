-- Working on MF data. 

select * from mfss_trades

-- Number of MF Trades in mfss_Trades tables. 
select count(*) from mfss_trades -- 3095979

-- NUmber of distinct Customer who have traded in MF 
select count(distinct(ENT_ID)) from mfss_trades -- 180698 

-- Creating separate table for customer who have traded in MF 
select distinct ENT_ID into ##mf_distinct_cust from mfss_trades
-- (180698 row(s) affected) 

-- distinct cust count 
select count(distinct(ent_ID)) from ##mf_distinct_cust -- 180698
