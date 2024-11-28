-- USE RetailDBOnline;
/*
Maintaing Logs
Creating few queries to update, delete and maintain trigger for RetailDBOnline.	
Triggers are automatic procedures that executes in case of any event happenns in the table
such as insert, update or delete.

Goal is to create a trigger to log any insert , update or delete operations
in the database.
Table used:
Products -- Insert, Update, Delete
Customers -- Insert, Update
*/

-- create a log table 
CREATE TABLE Logs(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	TableName NVARCHAR(50),
	Operation NVARCHAR(25),
	RecordID INT,
	ChangeDate DATETIME DEFAULT GETDATE(),
	ChangedBY NVARCHAR(50)
)
GO
-- Insert triggers for products table
CREATE OR ALTER TRIGGER trg_Insert_Product
ON Products
AFTER INSERT
AS 
BEGIN
	-- insert a record in products table 
	INSERT INTO Logs(TableName, Operation, RecordID, ChangedBY)
	SELECT 'Products', 'INSERT', inserted.ProductID, SYSTEM_USER 
	FROM inserted;

	-- display message for successful trigger execution
	PRINT 'Insert operation logged for Products table.'
END

-- Update triggers for products table
CREATE OR ALTER TRIGGER trg_Update_Product
ON Products
AFTER UPDATE
AS 
BEGIN
	-- update a record in products table 
	INSERT INTO Logs(TableName, Operation, RecordID, ChangedBY)
	SELECT 'Products', 'UPDATE', inserted.ProductID, SYSTEM_USER 
	FROM inserted;

	-- display message for successful trigger execution
	PRINT 'Update operation logged for Products table.'
END

-- Deletion triggers for products table
CREATE OR ALTER TRIGGER trg_Delete_Product
ON Products
AFTER DELETE
AS 
BEGIN
	-- delete a record from products table 
	INSERT INTO Logs(TableName, Operation, RecordID, ChangedBY)
	SELECT 'Products', 'DELETE', deleted.ProductID, SYSTEM_USER 
	FROM deleted;

	-- display message for successful trigger execution
	PRINT 'Delete operation logged for Products table.'
END



-- Triggers for Customers Table
-- Insert triggers for products table
CREATE OR ALTER TRIGGER trg_Insert_Customers
ON Customers
AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	-- insert a record in customer table 
	INSERT INTO Logs(TableName, Operation, RecordID, ChangedBY)
	SELECT 'Customers', 'INSERT', inserted.CustomerID, SYSTEM_USER 
	FROM inserted;

	-- display message for successful trigger execution
	PRINT 'Insert operation logged for Customers table.'
END


-- Update triggers for products table
CREATE OR ALTER TRIGGER trg_Update_Customers
ON Customers
AFTER UPDATE
AS 
BEGIN
	-- update a record in products table 
	INSERT INTO Logs(TableName, Operation, RecordID, ChangedBY)
	SELECT 'Customers', 'UPDATE', inserted.CustomerID, SYSTEM_USER 
	FROM inserted;

	-- display message for successful trigger execution
	PRINT 'Update operation logged for Customers table.'
END












