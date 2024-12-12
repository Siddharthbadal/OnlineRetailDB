-- Implementing Security and Roale based access control

-- Create logins with sql server authentication 
CREATE LOGIN RetaildbUser WITH PASSWORD ='1234';
CREATE LOGIN SalesdbUser WITH PASSWORD ='1234';

-- create user
USE RetailDBOnline;
GO
CREATE USER RetaildbUser FOR LOGIN RetaildbUser;
CREATE USER SalesUser FOR LOGIN SalesdbUser;

-- create role 
-- used to group users with similar permissions
CREATE ROLE SalesRole;
CREATE ROLE MarketingRole;

-- assign users to role
EXEC sp_addrolemember 'SalesRole', 'SalesUser';

-- grant permissions 
GRANT SELECT ON Customers TO SalesRole;
GRANT SELECT ON Address TO SalesRole;
GRANT INSERT on Customers TO SalesRole;
GRANT INSERT on Orders TO SalesRole;
GRANT INSERT on OrderItems TO SalesRole;
GRANT UPDATE on Customers TO SalesRole;
GRANT UPDATE on Address TO SalesRole;

-- REVOKE INSERT ON Orders from SalesRole;


-- View permissions
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');

-- Access Roles
-- read only role 
CREATE ROLE ReadOnlyRole;
GRANT SELECT ON SCHEMA::dbo TO ReadOnlyRole;

-- Customer Supoort role 
CREATE ROLE CustomerSupport;
GRANT SELECT on Customers TO CustomerSupport;
GRANT SELECT on Address TO CustomerSupport;
GRANT SELECT on Orders TO CustomerSupport;
GRANT SELECT on OrderItems TO CustomerSupport;

-- Manager
CREATE ROLE ManagerRole;
GRANT SELECT, INSERT, UPDATE on SCHEMA::dbo TO ManagerRole;

-- BackUP
-- CREATE ROLE BackupRole;
-- GRANT BACKUP DATABASE TO BackupRole;






