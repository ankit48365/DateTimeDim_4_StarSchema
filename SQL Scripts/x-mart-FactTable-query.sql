
/* Step 8  (after executing - x-mart-dimtable-query script)

Create Fact table to hold all your transactional entries of previous day sales with appropriate foreign key columns which refer to primary key column of your dimensions; 
you have to take care while populating your fact table to refer to primary key values of appropriate dimensions.
e.g.
Customer Henry Ford has purchase purchased 2 items (sunflower oil 1 kg, and 2 Nirma soap) in a single invoice on date 1-jan-2013 from D-mart at Sivranjani and sales person was Jacob , 
billing time recorded is 13:00, so let us define how will we refer to the primary key values from each dimension.

Before filling fact table, you have to identify and do look up for primary key column values in dimensions as per given example 
and fill in foreign key columns of fact table with appropriate key values.
*/

Use Sales_DW
Go

--drop table FactProductSales

Create Table FactProductSales
(
TransactionId bigint primary key identity,
SalesInvoiceNumber int not null,
SalesDateKey int,
SalesTimeKey int,
SalesTimeAltKey int,
StoreID int not null,
CustomerID int not null,
ProductID int not null,
SalesPersonID int not null,
Quantity float,
SalesTotalCost money,
ProductActualCost money,
Deviation float
)
Go

--Add Relation between Fact table and dimension tables:

-- Add relation between fact table foreign keys to Primary keys of Dimensions
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_StoreID FOREIGN KEY (StoreID)REFERENCES DimStores(StoreID);
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_CustomerID FOREIGN KEY (CustomerID)REFERENCES Dimcustomer(CustomerID);
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_ProductKey FOREIGN KEY (ProductID)REFERENCES Dimproduct(ProductKey);
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_SalesPersonID FOREIGN KEY (SalesPersonID)REFERENCES Dimsalesperson(SalesPersonID);
Go
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_SalesDateKey FOREIGN KEY (SalesDateKey)REFERENCES DimDate(DateKey);
Go
AlTER TABLE FactProductSales ADD CONSTRAINT
FK_SalesTimeKey FOREIGN KEY (SalesTimeKey)REFERENCES DimTime(TimeKey);
Go

--Populate your Fact table with historical transaction values of sales for previous day, with proper values of dimension key values.

Insert into FactProductSales(SalesInvoiceNumber,SalesDateKey,
SalesTimeKey,SalesTimeAltKey,StoreID,CustomerID,ProductID ,
SalesPersonID,Quantity,ProductActualCost,SalesTotalCost,Deviation)values
--1-jan-2019
--SalesInvoiceNumber,SalesDateKey,SalesTimeKey,SalesTimeAltKey,StoreID,CustomerID,ProductID ,SalesPersonID,Quantity,_ProductActualCost,SalesTotalCost,Deviation)

(1,20190101,44347,121907,1,1,1,1,2,11,13,2),
(1,20190101,44347,121907,1,1,2,1,1,22.50,24,1.5),
(1,20190101,44347,121907,1,1,3,1,1,42,43.5,1.5),

(2,20190101,44519,122159,1,2,3,1,1,42,43.5,1.5),
(2,20190101,44519,122159,1,2,4,1,3,54,60,6),

(3,20190101,52415,143335,1,3,2,2,2,11,13,2),
(3,20190101,52415,143335,1,3,3,2,1,42,43.5,1.5),
(3,20190101,52415,143335,1,3,4,2,3,54,60,6),
(3,20190101,52415,143335,1,3,5,2,1,135,139,4),

--2-jan-2019

(4,20190102,44347,121907,1,1,1,1,2,11,13,2),
(4,20190102,44347,121907,1,1,2,1,1,22.50,24,1.5),

(5,20190102,44519,122159,1,2,3,1,1,42,43.5,1.5),
(5,20190102,44519,122159,1,2,4,1,3,54,60,6),

(6,20190102,52415,143335,1,3,2,2,2,11,13,2),
(6,20190102,52415,143335,1,3,5,2,1,135,139,4),

(7,20190102,44347,121907,2,1,4,3,3,54,60,6),
(7,20190102,44347,121907,2,1,5,3,1,135,139,4),

--3-jan-2019

(8,20190103,59326,162846,1,1,3,1,2,84,87,3),
(8,20190103,59326,162846,1,1,4,1,3,54,60,3),


(9,20190103,59349,162909,1,2,1,1,1,5.5,6.5,1),
(9,20190103,59349,162909,1,2,2,1,1,22.50,24,1.5),

(10,20190103,67390,184310,1,3,1,2,2,11,13,2),
(10,20190103,67390,184310,1,3,4,2,3,54,60,6),

(11,20190103,74877,204757,2,1,2,3,1,5.5,6.5,1),
(11,20190103,74877,204757,2,1,3,3,1,42,43.5,1.5)
Go