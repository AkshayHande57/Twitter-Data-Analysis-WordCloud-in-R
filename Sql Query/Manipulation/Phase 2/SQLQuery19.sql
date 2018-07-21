-----------------------------------------------------------------------------------
select CUST_ID,sum(TRD_VAL_B) as 'Total_B_Val_Union' , sum(TRD_VAL_S) as 'Total_S_Val_Union'
into ##Cust_Unio
from Union_Four_Combo
group by CUST_ID 

select count(1) from ##Cust_Unio -- 614749

alter table ##Cust_Union
drop column Total_B_S_SUM

select * from ##Cust_Unio where Cust_ID = '2302862'
/*
CUST_ID		Total_B_Val_Union	Total_S_Val_Union
2302862		25195.000			12515.500
*/


select * from EQ_contract_note_details_All_Delivery_records

select CND_ENT_ID,cnd_BUY_SELL_FLG,sum(TRADED_VALUE) as 'Total_Value'
into ##CUST_Source
from EQ_contract_note_details_All_Delivery_records
group by CND_ENT_ID,cnd_BUY_SELL_FLG
-- (977421 row(s) affected)

select * from ##CUST_Source

-- Creating Temporary table Pivot table for Total_AVG_PRICE
select	Cnd_ENT_ID,
		[B] as 'Total_B_Source',
		[S] as 'Total_S_Source'
into ##CUST_SRC
from  
( 
select  Cnd_ENT_ID,CND_BUY_SELL_FLG,Total_Value
from ##CUST_Source 
) as source
pivot
(
	sum(Total_Value)
	for CND_BUY_SELL_FLG in ([B],[S])
) as Pivot_TABLES
-- (614749 row(s) affected)
-- Duration : 1 sec


select * into ##Combine 
from ##CUST_SRC a full outer join ##Cust_Unio b on a.CND_ENT_ID = b.CUST_ID

select count(1) from ##Combine
select * from ##Combine

-------------------------------------------------------------------------------------------------------
-- Union_B = Source_b ( Matching ) 
select count(1) from ##Combine where round(Total_B_Source,0) = round(Total_B_Val_Union,0) -- 490686

-- Union_S = Source_S
select count(1) from ##Combine where round(Total_S_Source) = round(Total_S_Val_Union -- 432730

-- Union_B != Source_B ( Not Matching ) 
select count(1) from ##Combine where round(Total_B_Source,0) != round(Total_B_Val_Union,0) -- 14971

-- Union_S != Source_S
select count(1) from ##Combine where Total_B_Source != Total_B_Val_Union -- 32269

--(Either NUll)
select count(1) from ##Combine where (Total_B_Val_Union is null and Total_B_Source is not null) 
or (Total_B_Val_Union is not null and Total_B_Source is null ) -- 1593

-- ( Both Null ) 
select count(1) from ##Combine where (Total_B_Val_Union is null and Total_B_Source is null) -- 107499
-------------------------------------------------------------------------------------------------------
