-- Step 1 : Create the user with the login details
CREATE USER user_load FOR LOGIN user_load;


-- Step 2 : Give necssary privileges to the newly created user
GRANT ADMINISTER DATABASE BULK OPERATIONS TO user_load;
GRANT CREATE TABLE TO user_load;
GRANT ALTER ON SCHEMA::dbo TO user_load;
GRANT INSERT TO user_load;
GRANT SELECT TO user_load;


-- Step 3 : Create and Define a  Workload group with required resources
CREATE WORKLOAD GROUP DataLoads
WITH 
( 
    MIN_PERCENTAGE_RESOURCE = 100,
    CAP_PERCENTAGE_RESOURCE = 100,
    REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
);


-- Step 4 : Add the newly created user to the above workload group
CREATE WORKLOAD CLASSIFIER [ELTLogin]
WITH 
(
    WORKLOAD_GROUP = 'DataLoads',
    MEMBERNAME = 'user_load'
);


-- Drop the external table if it exists
DROP EXTERNAL TABLE logdata;