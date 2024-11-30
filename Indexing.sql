/*
Optimizing Database Performance - Implementing Indexes 
Clustered Index - Usually Applied with primary key or unique data.
Only one clustered Index is allowed for a table.
*/
use RetailDBOnline;
GO

-- Create cluster on oders - column orderID
	-- drop forgein key refernece on orderitem table
	-- in keys find the name of forgein key applied on
ALTER TABLE OrderItems DROP CONSTRAINT FK__OrderItem__Produ__5DCAEF64;


CREATE  CLUSTERED INDEX	IDX_Products_ProductID
ON Products(productID)
-- non clustered index on categoryID in products table
CREATE NONCLUSTERED INDEX IDX_Products_CategoryID
ON Products(CategoryID)

-- non clustered index on price column in products table
CREATE NONCLUSTERED INDEX IDX_Products_ListPrice
ON Products(ListPrice)

-- non clustered index on price column in products table
CREATE NONCLUSTERED INDEX IDX_Products_StandardCost
ON Products(StandardCost)

-- Add productid as forgein key wherever reference required
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItemm_Products
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)



-- Cluster Index on ProductCategory table. Column name - categoryID
CREATE CLUSTERED INDEX IDX_ProductCategory_CategoryID
ON dbo.ProductCategory(categoryID)
-- Adding forgein key on products table categoryID column 
ALTER TABLE Products ADD CONSTRAINT FK_ProductCategory_CategoryID
FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID)

/*
if OBJECT_ID('productscategory..#index') is not null
DROP index dbo.productscategory.PK__ProductC__19093A2B7B721B3F;

need to remove primary key or any refernce relationship with other table. 
*/