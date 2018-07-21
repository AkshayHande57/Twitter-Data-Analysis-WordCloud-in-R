select CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,CND_QTY,CND_PRICE,(CND_QTY * CND_PRICE) as 'TRADED_VALUE',
((CND_QTY * CND_PRICE)/CND_QTY) as 'AVG_PRICE'
into EQ_TEMP_Contract_details
from EQ_Contract_note_details

select * from EQ_Contract_note_details
drop table EQ_TEMP_Contract_details

select * from EQ_TEMP_Contract_details where cnd_ENT_ID = '1000040' order by CND_BUY_SELL_FLG

select CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,sum(CND_QTY) as 'Total QTY' ,sum(TRADED_VALUE) as 'Total Traded Value',
(sum(AVG_PRICE)/count(cnd_QTY)) as 'Avg_Price'
into temp_1
from EQ_TEMP_Contract_details
where cnd_ENT_ID = '1000040'
group by CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG

select * from temp_1
drop table temp_1
----------------------------------------------------------------------------------------

select	cnd_ENT_ID as 'Cust_ID',
		cnd_SEM_ID as 'Compnay_Name',
		[B] as 'QTY_B',
		[S] as 'QTY_S'
from  
( 
select  cnd_ENT_ID,cnd_SEM_ID,cnd_BUY_SELL_FLG,[Total QTY]
from temp_1 
) as source
pivot
(
	max([Total QTY])
	for cnd_BUY_SELL_FLG in ([B],[S])
) as Pivot_TABLES


-------------------------------------------------------------------------------------------
select	cnd_ENT_ID,
		cnd_SEM_ID,
		[B] as 'QTY_B',
		[S] as 'QTY_S'
		--[PT.B] as 'TRD_VAL_B',
		--[PT.S] as 'TRD_VAL_S',
		--[PT2.B] as 'AVG_VAL_B',
		--[PT2.S] as 'AVG_VAL_S'
from  
( 
select  cnd_ENT_ID,cnd_SEM_ID,cnd_BUY_SELL_FLG,[Total QTY]
from temp_1 
) as source
pivot
(
	max([Total Traded Value])
	for cnd_BUY_SELL_FLG in ([PT.B],[PT.S])
) as PT
pivot
(
	max([Avg_Price])
	for cnd_BUY_SELL_FLG in ([PT2.B],[PT2.S])
) as PT2


select * from Temp01_Pivot
drop table Temp01_Pivot
-- (653209 row(s) affected)

select * from Temp_1

select CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,
(
select CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,ROW_NUMBER() over (Partition by cnd_SEM_ID 
order by CND_BUY_SELL_FLG ) as ColSEq
from Temp_1
)temp