-- Creating Hash Table with percentage share across products
-- Calculating Percentage share across prodcuts for all customer 
-- 2872657

-- This table will created as Temp table in db.
select cust_ID,
case
	when brkg_total = 0.00 then 0
	when brkg_total != 0.00 then (cast((BRKG_CNC/ brkg_total) * 100 as int))
end  as 'PS_BRKG_CNC',
case 
	when brkg_total = 0.00 then 0
	when brkg_total != 0.00 then (cast((BRKG_MARGIN/ brkg_total) * 100 as int))
end as 'PS_BRKG_MARGIN',
case 
	when brkg_total = 0.00 then 0
	when brkg_total != 0.00 then (cast((BRKG_T2/ brkg_total) * 100 as int ))
end as 'PS_BRKG_T2',
case
	when brkg_total = 0.00 then 0
	when brkg_total != 0.00 then (cast((BRKG_SPOT/ brkg_total) * 100 as int))
end as 'PS_BRKG_SPOT',
case
	when brkg_total = 0.00 then 0 
	when brkg_total != 0.00 then (cast((BRKG_FUT/ brkg_total) * 100 as int))
end as 'PS_BRKG_FUT',
case
	when brkg_total = 0.00 then 0 
	when brkg_total != 0.00 then (cast((BRKG_OPT/ brkg_total) * 100 as int ))
end as 'PS_BRKG_OPT',
case 
	when brkg_total = 0.00 then 0 
	when brkg_total != 0.00 then (cast((BRKG_TOTAL/ brkg_total) * 100 as int))
end as 'PS_BRKG_TOTAT',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then (cast((TRNOVR_CNC/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_CNC',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then (cast((TRNOVR_MARGIN/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_MARGIN',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then(cast((TRNOVR_T2/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_T2',
case
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then(cast((TRNOVR_SPOT/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_SPOT',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then(cast((TRNOVR_FUT/ TRNOVR_TOTAL) * 100 as int ))
end as 'PS_TRNOVR_FUT',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then(cast((TRNOVR_OPT/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_OPT',
case 
	when TRNOVR_TOTAL = 0.00 then 0 
	when TRNOVR_TOTAL != 0.00 then(cast((TRNOVR_TOTAL/ TRNOVR_TOTAL) * 100 as int))
end as 'PS_TRNOVR_TOTAL'
into ##PS_BRK_TRNOVR
from BRKG_TRNOVR_CUST_PROD


drop table ##Percentage_Share_BRKG_TRNOVR
drop table ##PS_BRK_TRNOVR


-- Cust_ID : 879567
select  * from ##PS_BRK_TRNOVR where cust_ID = '879567'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '879567'




-- Cust_ID : 1151976
select  * from #PS_BRK_TRNOVR where cust_ID = '1151976'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '1151976'

-- Cust_ID : 2968966
select  * from #PS_BRK_TRNOVR where cust_ID = '2968966'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '2968966'

-- Cust_ID : 2368956
select * from #PS_BRK_TRNOVR where cust_ID = '2368956'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '2368956'

-- Cust_ID : 609162
select * from #PS_BRK_TRNOVR where cust_ID = '609162'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '609162'

-- Cust_ID : 607172
select * from #PS_BRK_TRNOVR where cust_ID = '607172'
select * from  BRKG_TRNOVR_CUST_PROD where cust_ID = '607172'

-- Cust_ID : 659279
select * from #PS_BRK_TRNOVR where cust_ID = '659279'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '659279'

-- Cust_ID : 1945232
select * from #PS_BRK_TRNOVR where cust_ID = '1945232'
select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '1945232'

-----------------------------------------------------------------------------------
select cust_ID, (PS_BRKG_CNC + PS_BRKG_SPOT) as 'PS_BRKG_DELIVERY',
(PS_BRKG_MARGIN + PS_BRKG_T2) as 'PS_BRKG_MARGIN' ,
PS_BRKG_FUT,
PS_BRKG_OPT,
(PS_BRKG_CNC + PS_BRKG_SPOT + PS_BRKG_T2+PS_BRKG_MARGIN+PS_BRKG_FUT+PS_BRKG_OPT) as 'PS_BRKG_TOTAL',
(PS_TRNOVR_CNC + PS_TRNOVR_SPOT) as 'PS_TRNOVR_DELIVERY',
PS_TRNOVR_MARGIN + PS_TRNOVR_T2 as 'PS_TRNOVR_MARGIN' ,
PS_TRNOVR_FUT,
PS_TRNOVR_OPT,
(PS_TRNOVR_CNC + PS_TRNOVR_SPOT + PS_TRNOVR_T2+PS_TRNOVR_MARGIN+PS_TRNOVR_FUT+PS_TRNOVR_OPT) as 'PS_TRNOVR_TOTAL'
into Percentage_Share_BRKG_TRNOVR
from ##PS_BRK_TRNOVR
-- (653207 row(s) affected)

select * from Percentage_Share_BRKG_TRNOVR
-- 653207
-- 22 Sec

drop table ##PS_BRK_TRNOVR
drop table ##Percentage_Share_BRKG_TRNOVR

select * from ##PS_BRK_TRNOVR where cust_ID = '2965854' or cust_ID = '2023776'
BRKG_TRNOVR_CUST_PROD

select * from BRKG_TRNOVR_CUST_PROD where cust_ID = '2965854' or cust_ID = '2023776'
delete from BRKG_TRNOVR_CUST_PROD
where cust_ID = '2965854' or cust_ID = '2023776'

select 
max(PS_BRKG_DELIVERY) as 'Max_PS_BRKG_DELIVERY',
min(PS_BRKG_DELIVERY) as ' Min_PS_BRKG_DELIVERY',
max(PS_BRKG_MARGIN) as 'Max_PS_BRKG_MARGIN',
min(PS_BRKG_MARGIN) as ' Min_PS_BRKG_MARGIN',
max(PS_BRKG_FUT) as 'Max_PS_BRKG_FUT',
min(PS_BRKG_FUT) as ' Min_PS_BRKG_FUT',
max(PS_BRKG_OPT) as 'Max_PS_BRKG_OPT',
min(PS_BRKG_OPT) as ' Min_PS_BRKG_OPT',
max(PS_BRKG_TOTAL) as 'Max_PS_BRKG_TOTAL',
min(PS_BRKG_TOTAL) as ' Min_PS_BRKG_TOTAL'
from ##Percentage_Share_BRKG_TRNOVR


----------------------------------------------------------------------------------------------

-- Creating Decile for Percentage Share across various Products.
select count(PS_BRKG_DELIVERY) from ##Percentage_Share_BRKG_TRNOVR -- 653209
select count(PS_BRKG_DELIVERY) from ##Percentage_Share_BRKG_TRNOVR where PS_BRKG_DELIVERY != 0.00 -- 611120

select cust_Id,PS_BRKG_DELIVERY into ##temp_PS_BRKG_DELIVERY_Not_zero from ##Percentage_Share_BRKG_TRNOVR 
where PS_BRKG_DELIVERY != 0.00

drop table #temp_PS_BRKG_DELIVERY_Not_zero
select top 1000 * from #temp_PS_BRKG_DELIVERY_Not_zero

select PS_BRKG_DELIVERY , count(1) 
from ##temp_PS_BRKG_DELIVERY_Not_zero
group by PS_BRKG_DELIVERY
order by PS_BRKG_DELIVERY desc 

drop table #Temp_Deciles_PS_BRKG_DELIVERY

-- Creating Deciles for CNC Product
select PS_BRKG_DELIVERY,ntile(10) over (order by PS_BRKG_DELIVERY desc) as 'Dc_PS_BRKG_DELIVERY'
into ##Temp_Deciles_PS_BRKG_DELIVERY
from ##temp_PS_BRKG_DELIVERY_Not_zero

select * from ##Temp_Deciles_PS_BRKG_DELIVERY

select ntile(10) over (order by PS_BRKG_MARGIN desc) as 'Dc_PS_BRKG_DELIVERY' 
into temp
from ##PS_BRK_TRNOVR  where PS_BRKG_MARGIN > 0
group by Dc_PS_BRKG_DELIVERY

-- Display min,avg, max for each deciles.
select 
Dc_PS_BRKG_DELIVERY,min(PS_BRKG_DELIVERY) as 'Min',  
avg(PS_BRKG_DELIVERY) as 'Avg' ,
max(PS_BRKG_DELIVERY) as 'Max',
count(PS_BRKG_DELIVERY) as 'Count'
from ##Temp_Deciles_PS_BRKG_DELIVERY
group by Dc_PS_BRKG_DELIVERY
order by Dc_PS_BRKG_DELIVERY

select top 1000 * from ##Percentage_Share_BRKG_TRNOVR

---------------------------------------------------------------------------------------------------------

-- Creating Decile for Percentage Share across various Products.
select count(PS_BRKG_MARGIN) from ##Percentage_Share_BRKG_TRNOVR -- 653209
select count(PS_BRKG_MARGIN) from ##Percentage_Share_BRKG_TRNOVR where PS_BRKG_MARGIN != 0.00 -- 44637

select cust_Id,PS_BRKG_MARGIN into ##temp_PS_BRKG_MARGIN_Not_zero from ##Percentage_Share_BRKG_TRNOVR 
where PS_BRKG_MARGIN != 0.00

select top 1000 * from #temp_PS_BRKG_MARGIN_Not_zero

select PS_BRKG_MARGIN , count(1) 
from ##temp_PS_BRKG_MARGIN_Not_zero
group by PS_BRKG_MARGIN
order by PS_BRKG_MARGIN desc 


-- Creating Deciles for CNC Product
select PS_BRKG_MARGIN,ntile(10) over (order by PS_BRKG_MARGIN desc) as 'Dc_PS_BRKG_MARGIN'
into ##Temp_Deciles_PS_BRKG_MARGIN
from ##temp_PS_BRKG_MARGIN_Not_zero

select * from #Temp_Deciles_PS_BRKG_MARGIN


-- Display min,avg, max for each deciles.
select 
Dc_PS_BRKG_MARGIN,min(PS_BRKG_MARGIN) as 'Min',  
avg(PS_BRKG_MARGIN) as 'Avg' ,
max(PS_BRKG_MARGIN) as 'Max',
count(PS_BRKG_MARGIN) as 'Count'
from ##Temp_Deciles_PS_BRKG_MARGIN
group by Dc_PS_BRKG_MARGIN
order by Dc_PS_BRKG_MARGIN

select top 100 * from #Percentage_Share_BRKG_TRNOVR
----------------------------------------------------------------------------------------
select count(PS_BRKG_FUT) from ##Percentage_Share_BRKG_TRNOVR -- 653209
select count(PS_BRKG_FUT) from ##Percentage_Share_BRKG_TRNOVR where PS_BRKG_FUT > 0.00 -- 10819

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,PS_BRKG_FUT into ##temp_PS_BRKG_FUT_Not_zero from ##Percentage_Share_BRKG_TRNOVR where PS_BRKG_FUT != 0.00
select * from ##temp_PS_BRKG_FUT_Not_zero -- (10819 row(s) affected)

drop table #temp_PS_BRKG_FUT_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select PS_BRKG_FUT,ntile(10) over (order by PS_BRKG_FUT desc) as 'Dc_PS_BRKG_FUT'
into ##Temp_Deciles_PS_BRKG_FUT
from ##temp_PS_BRKG_FUT_Not_zero

-- Display min, avg, max  deciles for Dc_BRKG_FUT
select Dc_PS_BRKG_FUT,min(PS_BRKG_FUT) as 'Min',  avg(PS_BRKG_FUT) as 'Avg' , max(PS_BRKG_FUT) as 'Max',
count(PS_BRKG_FUT) as 'Count'
from ##Temp_Deciles_PS_BRKG_FUT
group by Dc_PS_BRKG_FUT
order by Dc_PS_BRKG_FUT


---------------------------------------------------------------------------------------

-- Creating Deciles on brokerage for BRKG_OPT.
select PS_BRKG_DELIVERY,PS_BRKG_MARGIN,PS_BRKG_FUT,PS_BRKG_OPT,count(distinct(cust_ID)) 
from ##Percentage_Share_BRKG_TRNOVR
group by PS_BRKG_DELIVERY,PS_BRKG_MARGIN,PS_BRKG_FUT,PS_BRKG_OPT 


select count(PS_BRKG_OPT) from ##Percentage_Share_BRKG_TRNOVR -- 653209
select count(PS_BRKG_OPT) from ##Percentage_Share_BRKG_TRNOVR where PS_BRKG_OPT != 0.00  --19698

-- Extracting customer who have traded on BRKG_SPOT product_Type.
select cust_Id,PS_BRKG_OPT into ##temp_PS_BRKG_OPT_Not_zero from ##Percentage_Share_BRKG_TRNOVR 
where PS_BRKG_OPT != 0.00

select * from ##temp_PS_BRKG_OPT_Not_zero -- (19698 row(s) affected)

drop table #temp_PS_BRKG_OPT_Not_zero

-- Creating Deciles for Dc_BRKG_FUT
select PS_BRKG_OPT,ntile(10) over (order by PS_BRKG_OPT desc) as 'Dc_PS_BRKG_OPT'
into #Temp_Deciles_PS_BRKG_OPT
from ##temp_PS_BRKG_OPT_Not_zero

-- Display min, avg, max  deciles for Dc_BRKG_OPT
select Dc_PS_BRKG_OPT,min(PS_BRKG_OPT) as 'Min',  avg(PS_BRKG_OPT) as 'Avg' , max(PS_BRKG_OPT) as 'Max',
count(PS_BRKG_OPT) as 'Sum_BRKG_OPT'
from #Temp_Deciles_PS_BRKG_OPT
group by Dc_PS_BRKG_OPT
order by Dc_PS_BRKG_OPT

select top 10 * from [dbo].[MTH_TRNOVR_BRKG] where cust_ID = '3073818'

select cust_ID,count(distinct(MONTH_ID)) from [dbo].[MTH_TRNOVR_BRKG]  group by cust_ID

