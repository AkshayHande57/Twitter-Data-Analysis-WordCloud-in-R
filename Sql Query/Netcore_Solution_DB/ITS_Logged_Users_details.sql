-- Extracting Login Details for all users.
select * into logged_users_jn
from 
OpenQuery(ORSPRO,'select * from ITS_LOGGED_USERS_JN')

select * from logged_users_jn

-- 19759402 NUmbers of rows extracted from ITS_logged user_Jn table 
-- Duration : 27.25

select top 10 * from logged_users_jn
