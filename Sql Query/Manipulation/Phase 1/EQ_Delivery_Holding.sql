-- Working on Holding Data. 

select * from EQ_contract_note_details_All_Delivery_records

-- Creating EQ_Delivery_Holding Table. 
select CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,CND_DT,sum(CND_QTY) as 'TOTAL_SUM_QTY'
into EQ_Delivery_Holding
from EQ_contract_note_details_All_records 
where CND_PRODUCT_TYPE = 'CNC' or CND_PRODUCT_TYPE = 'SPOT'
group by CND_ENT_ID,CND_SEM_ID,CND_BUY_SELL_FLG,CND_DT
-- (18302453 row(s) affected)

select * from EQ_Delivery_Holding order by CND_ENT_ID