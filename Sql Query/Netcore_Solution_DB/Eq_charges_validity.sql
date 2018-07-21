-- Detailed analysis of Eq_charges_validitiy 
select top 1000 * from eq_charges_validity
-- Number of Records : 2837261
-- Number of Columns : 44 

select Distinct(ecv_rental_bill_generated_YN),count(*)
from eq_charges_validity
group by ecv_rental_bill_generated_YN
/*
ecv_rental_bill_generated_YN	(No column name)
N	2799399
Y	37862
*/ 


select distinct(ecv_deposit_used) , count(*) 
from eq_charges_validity
group by ecv_deposit_used

select distinct(ecv_turnover_for_month_normal) , count(*) 
from eq_charges_validity
group by ecv_turnover_for_month_normal

select distinct(ecv_turnover_for_month_its) , count(*) 
from eq_charges_validity
group by ecv_turnover_for_month_its

select distinct(ecv_deposit_amount) , count(*) 
from eq_charges_validity
group by ecv_deposit_amount

select distinct(ecv_prg_id) , count(*) 
from eq_charges_validity
group by ecv_prg_id
/*
ecv_prg_id	(No column name)
Charges_Validity_Mig	1
CSSBCBGC	1
CSSBTRSET	2833381
CSSCCNG	41
CSSFMMT26	3837
*/

select distinct(ECV_CREAT_BY) , count(*) 
from eq_charges_validity
group by ECV_CREAT_BY

select distinct(ECV_RENTAL_AMOUNT) , count(*) 
from eq_charges_validity
group by ECV_RENTAL_AMOUNT

ecv_last_trd_dt_bse
select distinct(ecv_last_trd_dt_bse),count(*)
from eq_charges_validity
group by ECV_LAST_TRD_DT_BSE

