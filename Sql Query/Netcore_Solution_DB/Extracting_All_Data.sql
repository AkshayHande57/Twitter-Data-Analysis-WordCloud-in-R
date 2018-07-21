-- Creating New Database with all required tables 
-- Extracting ALL DATA for below tables. 
---------------------------------------------------------------------------------------

-- Creating New Table eq_charges_validity with all data present 
select * into eq_charges_validity 
from 
OpenQuery(PRCSN,'select * from eq_charges_validity')
-- 2837261 number of rows in eq_Charges_validity Table 

select *  from eq_charges_validity
-- 2837261 number of rows in eq_Charges_validity Table 

---------------------------------------------------------------------------------------
-- Creating New Table dtm_charges_validity with all data present 
select * into dtm_charges_validity 
from 
OpenQuery(PRCSN,'select * from dtm_charges_validity ')
-- 810560 number of rows in dtm_charges_validity Table 

select top 1000 * from dtm_charges_validity
---------------------------------------------------------------------------------------

-- Creating New Table cur_charges_validity 
select * into cur_charges_validity 
from 
OpenQuery(PRCSN,'select * from cur_charges_validity')

-- 23908 number of rows in dtm_charges_validity Table 
select * from cur_charges_validity

---------------------------------------------------------------------------------------
