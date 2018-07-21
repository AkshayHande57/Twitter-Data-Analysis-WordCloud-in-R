[dbo].[logged_users_jn]


select distinct(ILU_terminal_type),count(*)
from logged_users_jn
group by ILU_TERMINAL_TYPE
/*
ILU_terminal_type	(No column name)
NULL	10254313
ITS	9454957
ITSLITE	50132
*/

select distinct(ilu_interface_type),count(*)
from logged_users_jn
group by ilu_interface_type
/*
ilu_interface_type	(No column name)
E_A01	11196128
E_A02	163206
E_A03	217463
E_A04	1346
ITS	8181259
*/