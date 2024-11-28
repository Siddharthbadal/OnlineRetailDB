-- Create Database 
CREATE DATABASE RetailDBOnline;

-- Use Database
USE RetailDBOnline;

-- Create Tables
-- Customers table 
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Email NVARCHAR(100),
	Contact NVARCHAR(15),
	AddressID INT,
	CreatedAt DATETIME DEFAULT GETDATE(),
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID(),
	
);

-- Address table
CREATE TABLE Address(
	CustomerID INT,
	AddressID INT PRIMARY KEY IDENTITY(1,1),
	Addressline1 NVARCHAR(150),
	Addressline2 NVARCHAR(150),
	Area NVARCHAR(150),
	City NVARCHAR(50),
	State NVARCHAR(50),
	Zipcode NVARCHAR(15),
	Country NVARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE(),
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID(),
	
);


-- Category table
CREATE TABLE ProductCategory(
	CategoryID Int PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(50),	
	Description NVARCHAR(150),
	CreatedAt DATETIME DEFAULT GETDATE(),
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID()
	
);

-- Products table
CREATE TABLE Products(
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(50),
	CategoryID INT,
	StandardCost Decimal(10,2),
	ListPrice DECIMAL(10,2),	
	Inhouse NVARCHAR(5) DEFAULT 'yes',
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE(),
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID(),
	FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID) ON UPDATE CASCADE,
);


-- Orders Table
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount Decimal(10, 2),
	OrderFrom NVARCHAR(5) DEFAULT 'yes',
	PaymentMode NVARCHAR(5) DEFAULT 'card',
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID(),
);

-- OrderItems table
CREATE TABLE OrderItems(
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price Decimal(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON UPDATE CASCADE,
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON UPDATE CASCADE,
	rowguid UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWSEQUENTIALID(),
);

-- Add Forgein Keys in tabled
ALTER TABLE dbo.Customers
ADD FOREIGN KEY (AddressID) REFERENCES Address(AddressID) ON UPDATE CASCADE;

ALTER TABLE dbo.Address
ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON UPDATE No Action;


-- Rename columns 
-- EXEC sp_rename 'table.old-col-name', 'new-col-name', 'column';

