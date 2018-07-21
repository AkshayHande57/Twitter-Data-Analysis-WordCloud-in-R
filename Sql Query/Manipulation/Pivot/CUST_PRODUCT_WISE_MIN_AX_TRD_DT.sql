
select top 100 * from [EQ_Contract_note_details_All_records]

select CND_ENT_ID, CND_PRODUCT_TYPE,min(CND_DT) as 'MIN_TRD_DT',max(CND_DT) as 'MAX_TRD_DT'
into ##CUST_PRODUCT_WISE_MIN_MAX_TRD_DT
from [EQ_Contract_note_details_All_records]
group by CND_ENT_ID,CND_PRODUCT_TYPE

select  * from ##CUST_PRODUCT_WISE_MIN_MAX_TRD_DT where CND_ENT_ID = '2638961'

select  * from [EQ_Contract_note_details_All_records] where CND_ENT_ID = '2638961'

