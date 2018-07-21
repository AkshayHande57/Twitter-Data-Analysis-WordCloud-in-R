-- Creating Decile for BRKG_CNC Product
select top 100 * from BRKG_TRNOVR_CUST_PROD


-------------------------------------------------------------------------------------------------------------
-- Creating Deciles on brokerage for CNC_Product.

select count(BRKG_CNC) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_CNC) from BRKG_TRNOVR_CUST_PROD where BRKG_CNC != 0.00 -- 613164

-- Extracting customer who have traded on CNC product_Type.
select cust_Id,BRKG_CNC into #temp_BRKG_CNC_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_CNC != 0.00
select * from #temp_BRKG_CNC_Not_zero

select * from #temp_BRKG_CNC_Not_zero
drop table #temp_BRKG_CNC_Not_zero

-- Creating Deciles for CNC Product
select BRKG_CNC,ntile(10) over (order by BRKG_CNC desc) as 'Dc_BRKG_CNC'
into #Temp_Deciles_BRKG_CNC
from #temp_BRKG_CNC_Not_zero


-- Display min,avg, max for each deciles.
select Dc_BRKG_CNC,min(BRKG_CNC) as 'Min',  avg(BRKG_CNC) as 'Avg' , max(BRKG_CNC) as 'Max',sum(BRKG_CNC) as 'Sum_BRKG_CNC'
from #Temp_Deciles_BRKG_CNC
group by Dc_BRKG_CNC
order by Dc_BRKG_CNC

select Dc_BRKG_CNC,count(*) from #Temp_Deciles_BRKG_CNC group by Dc_BRKG_CNC order by Dc_BRKG_CNC
 

-------------------------------------------------------------------------


-- Creating Deciles on brokerage for BRKG_MARGIN.

select count(BRKG_MARGIN) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_MARGIN) from BRKG_TRNOVR_CUST_PROD where BRKG_MARGIN != 0.00 -- 45165

-- Extracting customer who have traded on CNC product_Type.
select cust_Id,BRKG_MARGIN into #temp_BRKG_MARGIN_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_MARGIN != 0.00
select * from #temp_BRKG_MARGIN_Not_zero -- (45165 row(s) affected)

drop table #temp_BRKG_CNC_Not_zero

-- Creating Deciles for BRKG_MARGIN
select BRKG_MARGIN,ntile(10) over (order by BRKG_MARGIN desc) as 'Dc_BRKG_MARGIN'
into #Temp_Deciles_BRKG_MARGIN
from #temp_BRKG_MARGIN_Not_zero

-- Display min,avg, max for each deciles.
select Dc_BRKG_MARGIN,min(BRKG_MARGIN) as 'Min',  avg(BRKG_MARGIN) as 'Avg' , max(BRKG_MARGIN) as 'Max',
sum(BRKG_MARGIN) as 'Sum_BRKG_MARGIN'
from #Temp_Deciles_BRKG_MARGIN
group by Dc_BRKG_MARGIN
order by Dc_BRKG_MARGIN

select Dc_BRKG_MARGIN,count(*) from #Temp_Deciles_BRKG_MARGIN group by Dc_BRKG_MARGIN order by Dc_BRKG_MARGIN

-------------------------------------------------------------------------

-- Creating Deciles on brokerage for BRKG_T2.

select count(BRKG_T2) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_T2) from BRKG_TRNOVR_CUST_PROD where BRKG_T2 != 0.00 -- 27579

-- Extracting customer who have traded on CNC product_Type.
select cust_Id,BRKG_T2 into #temp_BRKG_T2_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_T2 != 0.00
select * from #temp_BRKG_T2_Not_zero -- (27579 row(s) affected)

drop table #temp_BRKG_T2_Not_zero

-- Creating Deciles for BRKG_MARGIN
select BRKG_T2,ntile(10) over (order by BRKG_T2 desc) as 'Dc_BRKG_T2'
into #Temp_Deciles_BRKG_T2
from #temp_BRKG_T2_Not_zero

-- Display min, avg, max  deciles for Dc_BRKG_T2
select Dc_BRKG_T2,min(BRKG_T2) as 'Min',  avg(BRKG_T2) as 'Avg' , max(BRKG_T2) as 'Max',
sum(BRKG_T2) as 'sum_BRKG_T2'
from #Temp_Deciles_BRKG_T2
group by Dc_BRKG_T2
order by Dc_BRKG_T2 

select Dc_BRKG_T2,count(*) from #Temp_Deciles_BRKG_T2 group by Dc_BRKG_T2 order by Dc_BRKG_T2

---------------------------------------------------------------------------------------------------
-- Creating Deciles on brokerage for Dc_BRKG_SPOT.

select count(BRKG_SPOT) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_SPOT) from BRKG_TRNOVR_CUST_PROD where BRKG_SPOT != 0.00 -- 8558

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,BRKG_SPOT into #temp_BRKG_SPOT_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_SPOT != 0.00
select * from #temp_BRKG_SPOT_Not_zero -- (8558 row(s) affected)

drop table #temp_BRKG_T2_Not_zero

-- Creating Deciles for Dc_BRKG_SPOT
select BRKG_SPOT,ntile(10) over (order by BRKG_SPOT desc) as 'Dc_BRKG_SPOT'
into #Temp_Deciles_BRKG_SPOT
from #temp_BRKG_SPOT_Not_zero


-- Display min, avg, max  deciles for Dc_BRKG_SPOT
select Dc_BRKG_SPOT,min(BRKG_SPOT) as 'Min',  avg(BRKG_SPOT) as 'Avg' , max(BRKG_SPOT) as 'Max',

from #Temp_Deciles_BRKG_SPOT
group by Dc_BRKG_SPOT
order by Dc_BRKG_SPOT

select Dc_BRKG_SPOT,count(*) from #Temp_Deciles_BRKG_SPOT group by Dc_BRKG_SPOT order by Dc_BRKG_SPOT


---------------------------------------------------------------------------------------------------

-- Creating Deciles on brokerage for BRKG_FUT.

select count(BRKG_FUT) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_FUT) from BRKG_TRNOVR_CUST_PROD where BRKG_FUT != 0.00 -- 11190
select count(BRKG_FUT) from BRKG_TRNOVR_CUST_PROD where BRKG_FUT != 0.00 -- 11190

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,BRKG_FUT into #temp_BRKG_FUT_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_FUT != 0.00
select * from #temp_BRKG_FUT_Not_zero -- (11190 row(s) affected)

drop table #temp_BRKG_FUT_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select BRKG_FUT,ntile(10) over (order by BRKG_FUT desc) as 'Dc_BRKG_FUT'
into #Temp_Deciles_BRKG_FUT
from #temp_BRKG_FUT_Not_zero

-- Display min, avg, max  deciles for Dc_BRKG_FUT
select Dc_BRKG_FUT,min(BRKG_FUT) as 'Min',  avg(BRKG_FUT) as 'Avg' , max(BRKG_FUT) as 'Max',
sum(BRKG_FUT) as 'Sum_BRKG_FUT'
from #Temp_Deciles_BRKG_FUT
group by Dc_BRKG_FUT
order by Dc_BRKG_FUT

select Dc_BRKG_FUT,count(*) from #Temp_Deciles_BRKG_FUT group by Dc_BRKG_FUT order by Dc_BRKG_FUT

---------------------------------------------------------------------------------------------------

-- Creating Deciles on brokerage for BRKG_OPT.

select count(BRKG_OPT) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_OPT) from BRKG_TRNOVR_CUST_PROD where BRKG_OPT != 0.00 -- 20624

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,BRKG_OPT into #temp_BRKG_OPT_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_OPT != 0.00
select * from #temp_BRKG_OPT_Not_zero -- (20624 row(s) affected)

drop table #temp_BRKG_OPT_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select BRKG_OPT,ntile(10) over (order by BRKG_OPT desc) as 'Dc_BRKG_OPT'
into #Temp_Deciles_BRKG_OPT
from #temp_BRKG_OPT_Not_zero

-- Display min, avg, max  deciles for Dc_BRKG_OPT
select Dc_BRKG_OPT,min(BRKG_OPT) as 'Min',  avg(BRKG_OPT) as 'Avg' , max(BRKG_OPT) as 'Max',
sum(BRKG_OPT) as 'Sum_BRKG_OPT'
from #Temp_Deciles_BRKG_OPT
group by Dc_BRKG_OPT
order by Dc_BRKG_OPT

select Dc_BRKG_OPT,count(*) from #Temp_Deciles_BRKG_OPT group by Dc_BRKG_OPT order by Dc_BRKG_OPT

---------------------------------------------------------------------------------------------------
-- Dc_BRKG_total

select count(BRKG_total) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_total) from BRKG_TRNOVR_CUST_PROD where BRKG_total != 0.00 -- 653207

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,BRKG_total into #temp_BRKG_total_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_total != 0.00
select * from #temp_BRKG_total_Not_zero -- (653207 row(s) affected)

drop table #temp_BRKG_total_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select BRKG_total,ntile(10) over (order by BRKG_total desc) as 'Dc_BRKG_total'
into #Temp_Deciles_BRKG_total
from #temp_BRKG_total_Not_zero

select * from #Temp_Deciles_BRKG_total
select DC_BRKG_TOTAL,count(*) from #Temp_Deciles_BRKG_total group by DC_BRKG_TOTAL order by DC_BRKG_TOTAL

-- Display min, avg, max  deciles for Dc_BRKG_total
select Dc_BRKG_total,min(BRKG_TOTAL) as 'Min',  avg(BRKG_TOTAL) as 'Avg' , max(BRKG_TOTAL) as 'Max',
sum(BRKG_TOTAL) as 'Sum_BRKG_TOTAL'
from #Temp_Deciles_BRKG_total
group by Dc_BRKG_total
order by Dc_BRKG_total

select cust_ID as 'Cust_ID' ,BRKG_TOTAL 
from BRKG_TRNOVR_CUST_PROD
where BRKG_TOTAL = 0.00

---------------------------------------------------------------------------------------------------
-- QC for count of records in each products. 
select top 100 *  from [dbo].[MTH_TRNOVR_BRKG]
select top 100 *  from [dbo].[BRKG_TRNOVR_CUST_PROD]

select min(brkg_total) as 'Min', max(brkg_total) as 'Max' from [BRKG_TRNOVR_CUST_PROD] 
select product_type,count(distinct(cust_ID)) as 'Count' from [dbo].[MTH_TRNOVR_BRKG] group by PRODUCT_TYPE

select * from #PS_BRK_TRNOVR


select top 100 * from [dbo].[EQ_Contract_note_details_All_records] 
where CND_PRODUCT_TYPE = 'SPOT'
/*
2018022707025900
2018013105272000
2018013105273100
2017071802844200
2017042402345900
2017121500424500
2017071903052400
2017113003521900
2018030100302700
2017090104728500
*/

--------------------------------------------------------------------------------------

-- Combining BRKG_CNC & BRK_SPOT 
select top 10000 * from [BRKG_TRNOVR_CUST_PROD] 

alter table [BRKG_TRNOVR_CUST_PROD]
add BRKG_CNC_SPOT numeric(38,2)

update [BRKG_TRNOVR_CUST_PROD]
set BRKG_CNC_SPOT = BRKG_CNC + BRKG_SPOT
-- 2738646

select count(BRKG_CNC_SPOT) from BRKG_TRNOVR_CUST_PROD -- 653209
select count(BRKG_CNC_SPOT) from BRKG_TRNOVR_CUST_PROD where BRKG_CNC_SPOT != 0.00 -- 614749

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,BRKG_CNC_SPOT into #temp_BRKG_CNC_SPOT_Not_zero from BRKG_TRNOVR_CUST_PROD where BRKG_CNC_SPOT != 0.00
select * from #temp_BRKG_CNC_SPOT_Not_zero -- (614749 row(s) affected)

drop table #temp_BRKG_total_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select BRKG_CNC_SPOT,ntile(10) over (order by BRKG_CNC_SPOT desc) as 'Dc_BRKG_CNC_SPOT'
into #Temp_Deciles_BRKG_CNC_SPOT
from #temp_BRKG_CNC_SPOT_Not_zero

select * from #Temp_Deciles_BRKG_CNC_SPOT
select DC_BRKG_TOTAL,count(*) from #Temp_Deciles_BRKG_total group by DC_BRKG_TOTAL order by DC_BRKG_TOTAL

-- Display min, avg, max  deciles for Dc_BRKG_total
select Dc_BRKG_CNC_SPOT,min(BRKG_CNC_SPOT) as 'Min',  avg(BRKG_CNC_SPOT) as 'Avg' , max(BRKG_CNC_SPOT) as 'Max',
sum(BRKG_CNC_SPOT) as 'Sum_BRKG_CNC_SPOT'
from #Temp_Deciles_BRKG_CNC_SPOT
group by Dc_BRKG_CNC_SPOT
order by Dc_BRKG_CNC_SPOT

select cust_ID as 'Cust_ID' ,BRKG_TOTAL 
from BRKG_TRNOVR_CUST_PROD
where BRKG_TOTAL = 0.00

