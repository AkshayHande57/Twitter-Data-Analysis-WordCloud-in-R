-- Exploring redemeption table 
select * from redemption_statement 

-- Count for each reportdate 
select distinct(report_date),count(*)
from redemption_statement
group by REPORT_DATE

-- Display disinct scheme_Code 
select distinct(scheme_code),count(*) 
from redemption_statement
group by SCHEME_CODE
order by count(*) desc 
