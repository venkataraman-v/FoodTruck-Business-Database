--drop database FOODTRUCK_DATABASE_TEAM_8
CREATE DATABASE FOODTRUCK_DATABASE_TEAM_8;
GO
USE FOODTRUCK_DATABASE_TEAM_8;
GO
CREATE SCHEMA mydb;
-----------------------------------------------------
-- Table mydb.Foodtruck
-----------------------------------------------------
GO
CREATE TABLE mydb.Foodtruck (
  [FoodtruckID] INT NOT NULL,
  [StartedOn] DATE NOT NULL,
  [OpeningTime] TIME(0) NOT NULL,
  [ClosingTime] TIME(0) NOT NULL,
  [FoodtruckRating] FLOAT NULL DEFAULT 0.0000,
  PRIMARY KEY ([FoodtruckID]));
GO
-----------------------------------------------------
-- Table mydb.Customer
-----------------------------------------------------
CREATE TABLE mydb.Customer (
  [CustomerID] INT NOT NULL,
  [LastName] VARCHAR(45) NOT NULL,
  [FirstName] VARCHAR(45) NOT NULL,
  [PhoneNumber] INT NOT NULL,
  [EmailId] varbinary(MAX) NOT NULL,
  [Ethinicity] VARCHAR(45) NOT NULL,
  [FavouriteCuisine] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([CustomerID]));
GO
-----------------------------------------------------
-- Table mydb.Cuisine
-----------------------------------------------------
CREATE TABLE mydb.Cuisine (
  [CuisineID] INT NOT NULL,
  [Name] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([CuisineID]),
  CONSTRAINT [Name] UNIQUE  ([Name] ASC));
GO
-----------------------------------------------------
-- Table mydb.Order
-----------------------------------------------------
CREATE TABLE mydb.[Order] (
  [OrderID] INT NOT NULL PRIMARY KEY,
  [FoodtruckID] INT NOT NULL,
  [OrderAmount] FLOAT NOT NULL DEFAULT 0,
  [PaymentType] VARCHAR(45) NOT NULL,
  [DateTime] DATETIME2(0) NOT NULL,
  [TransactionID] INT NOT NULL,
  [CustomerID] INT NOT NULL,
  CONSTRAINT paymentTypeCheck
	CHECK (PaymentType IN ('venmo','cash','card','Google Pay' )), -------------CHECK
  CONSTRAINT [fk_Order_Foodtruck1]
    FOREIGN KEY (FoodtruckID)
    REFERENCES mydb.Foodtruck(FoodtruckID),
  CONSTRAINT [fk_Order_Customer1]
    FOREIGN KEY (CustomerID)
    REFERENCES mydb.Customer(CustomerID));
GO
CREATE INDEX fk_Order_Foodtruck1_idx
ON mydb.[Order] (FoodtruckID);
CREATE INDEX fk_Order_Customer1_idx
ON mydb.[Order] (CustomerID);
GO
-----------------------------------------------------
-- Table mydb.Location
-----------------------------------------------------
CREATE TABLE mydb.Location (
  [LocationID] INT NOT NULL,
  [Pincode] INT NOT NULL,
  [Street] VARCHAR(45) NOT NULL,
  [City] VARCHAR(45) NOT NULL,
  [Neighbourhood] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([LocationID]));
GO
-----------------------------------------------------
-- Table mydb.Menu
-----------------------------------------------------
CREATE TABLE mydb.Menu (
  [MenuID] INT NOT NULL,
  [Name] VARCHAR(45) NOT NULL,
  [FoodtruckID] INT NOT NULL,
  PRIMARY KEY ([MenuID]),
  CONSTRAINT [Name_UNIQUE] UNIQUE  ([Name] ASC),
  CONSTRAINT [fk_Menu_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]));
GO
CREATE INDEX fk_Menu_Foodtruck1_idx
ON mydb.Menu (FoodtruckID);
GO
-----------------------------------------------------
-- Table mydb.FoodItem
-----------------------------------------------------
CREATE TABLE mydb.FoodItem (
  [FoodItemID] INT NOT NULL,
  [Name] VARCHAR(45) NOT NULL,
  [Price] FLOAT NOT NULL,
  [CusineID] INT NOT NULL,
  [MenuID] INT NOT NULL,
  PRIMARY KEY ([FoodItemID]),
  CONSTRAINT priceCheck
	CHECK (Price >0), -----------------------------------------CHECK
  CONSTRAINT [fk_FoodItems_Menu1]
    FOREIGN KEY ([MenuID])
    REFERENCES mydb.Menu ([MenuID]),
  CONSTRAINT [fk_FoodItems_Cuisine1]
    FOREIGN KEY ([CusineID])
    REFERENCES mydb.Cuisine ([CuisineID]));
GO
CREATE INDEX fk_FoodItems_Menu1_idx
ON mydb.FoodItem (MenuID);
CREATE INDEX fk_FoodItems_Cuisine1_idx
ON mydb.FoodItem (CusineID);
GO
-----------------------------------------------------
-- Table mydb.OrderItem
-----------------------------------------------------
CREATE TABLE mydb.OrderItem (
  [OrderItemID] INT NOT NULL,
  [FoodItemID] INT NOT NULL,
  [OrderID] INT NOT NULL,
  [RatingGiven] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [CustomerID] INT NOT NULL,
  PRIMARY KEY ([OrderItemID]),
  CONSTRAINT ratingCheck
	CHECK (RatingGiven BETWEEN 0 and 5), -----------------------CHECK
  CONSTRAINT [fk_OrderItem_Order1]
    FOREIGN KEY ([OrderID])
    REFERENCES mydb.[Order] ([OrderID]),
  CONSTRAINT qtyCheck
	CHECK (Quantity >0), ----------------------------------------CHECK
  CONSTRAINT [fk_OrderItem_FoodItems1]
    FOREIGN KEY ([FoodItemID])
    REFERENCES mydb.FoodItem ([FoodItemID]),
  CONSTRAINT [fk_OrderItem_Customer1]
    FOREIGN KEY ([CustomerID])
    REFERENCES mydb.Customer ([CustomerID]));
GO
CREATE INDEX fk_OrderItem_Order1_idx
ON mydb.OrderItem (OrderID);
CREATE INDEX fk_OrderItem_FoodItems1_idx
ON mydb.OrderItem (FoodItemID);
CREATE INDEX fk_OrderItem_Customer1_idx
ON mydb.OrderItem (CustomerID);
GO
-----------------------------------------------------
-- Table mydb.OrderIncome
-----------------------------------------------------
CREATE TABLE mydb.OrderIncome (
  [IncomeID] INT NOT NULL IDENTITY,
  [TotalIncome] FLOAT NOT NULL DEFAULT 0.00000,
  [FoodtruckID] INT NOT NULL,
  PRIMARY KEY ([IncomeID]),
  CONSTRAINT [fk_OrderIncome_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]));
GO
CREATE INDEX fk_OrderIncome_Foodtruck1_idx
ON mydb.OrderIncome (FoodtruckID);
GO
-----------------------------------------------------
-- Table mydb.Expenditure
-----------------------------------------------------
CREATE TABLE mydb.Expenditure (
  [ExpenditureID] INT NOT NULL IDENTITY,
  [TotalExpenditure] FLOAT NOT NULL DEFAULT 0.00000,
  [FoodtruckID] INT NOT NULL,
  PRIMARY KEY ([ExpenditureID]),
  CONSTRAINT [fk_Expenditure_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]));
GO
CREATE INDEX fk_Expenditure_Foodtruck1_idx
ON mydb.Expenditure (FoodtruckID);
GO
-----------------------------------------------------
-- Table mydb.Revenue
-----------------------------------------------------
CREATE TABLE mydb.Revenue (
  [RevenueID] INT NOT NULL IDENTITY,
  [TotalRevenue] FLOAT NOT NULL DEFAULT 0.00000,
  [FoodtruckID] INT NOT NULL,
  [IncomeID] INT NULL,
  [ExpenditureID] INT NULL,
  PRIMARY KEY ([RevenueID]),
  CONSTRAINT [fk_Revenue_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]),
  CONSTRAINT [fk_Revenue_OrderIncome1]
    FOREIGN KEY ([IncomeID])
    REFERENCES mydb.OrderIncome ([IncomeID]),
  CONSTRAINT [fk_Revenue_Expenditure1]
    FOREIGN KEY ([ExpenditureID])
    REFERENCES mydb.Expenditure ([ExpenditureID]));
GO
CREATE INDEX fk_Revenue_Foodtruck1_idx
ON mydb.Revenue (FoodtruckID);
CREATE INDEX fk_Revenue_OrderIncome1_idx
ON mydb.Revenue (IncomeID);
CREATE INDEX fk_Revenue_Expenditure1_idx
ON mydb.Revenue (ExpenditureID);

GO
-----------------------------------------------------
-- Table mydb.Staff
-----------------------------------------------------
CREATE TABLE mydb.Staff (
  [StaffID] INT NOT NULL,
  [FirstName] VARCHAR(45) NOT NULL,
  [LastName] VARCHAR(45) NOT NULL,
  [Phone] VARCHAR(45) NOT NULL,
  [Street] VARCHAR(45) NOT NULL,
  [Pincode] VARCHAR(45) NOT NULL,
  [City] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([StaffID]));
GO
-----------------------------------------------------
-- Table mydb.Supplies
-----------------------------------------------------
CREATE TABLE mydb.Supplies (
  [SuppliesID] INT NOT NULL,
  [SupplierName] VARCHAR(45) NOT NULL,
  [ItemName] VARCHAR(45) NOT NULL,
  [Cost] FLOAT NOT NULL,
  PRIMARY KEY ([SuppliesID]));
GO
-----------------------------------------------------
-- Table mydb.FoodtruckStaff
-----------------------------------------------------
CREATE TABLE mydb.FoodtruckStaff (
  [FoodtruckID] INT NOT NULL,
  [StaffID] INT NOT NULL,
  [EmploymentType] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([FoodtruckID], [StaffID]),
  CONSTRAINT empTypeCheck
	CHECK (EmploymentType IN ('Driver','Chef','Owner')), -----------------CHECK
  CONSTRAINT [fk_Foodtruck_has_Staff_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]),
  CONSTRAINT [fk_Foodtruck_has_Staff_Staff1]
    FOREIGN KEY ([StaffID])
    REFERENCES mydb.Staff ([StaffID]));
GO
CREATE INDEX fk_Foodtruck_has_Staff_Staff1_idx
ON mydb.FoodtruckStaff (StaffID);
CREATE INDEX fk_Foodtruck_has_Staff_Foodtruck1_idx
ON mydb.FoodtruckStaff (FoodtruckID);
GO
-----------------------------------------------------
-- Table mydb.Payslip
-----------------------------------------------------
CREATE TABLE mydb.Payslip (
  [StaffID] INT NOT NULL,
  [FoodtruckID] INT NOT NULL,
  [Salary] FLOAT NOT NULL,
  [Date] DATE NOT NULL,
  PRIMARY KEY ([StaffID], [FoodtruckID], [Date]),
  CONSTRAINT [fk_StaffWage_FoodtruckStaff1]
    FOREIGN KEY ([FoodtruckID] , [StaffID])
    REFERENCES mydb.FoodtruckStaff ([FoodtruckID] , [StaffID]));
GO
CREATE INDEX fk_StaffWage_FoodtruckStaff1_idx
ON mydb.Payslip (FoodtruckID,StaffID);
GO
-----------------------------------------------------
-- Table mydb.Date
-----------------------------------------------------
CREATE TABLE mydb.Date (
  [DateID] INT NOT NULL,
  [Date] DATE NOT NULL,
  PRIMARY KEY ([DateID]));
GO
-----------------------------------------------------
-- Table mydb.FoodtruckLocationDate
-----------------------------------------------------
CREATE TABLE mydb.FoodtruckLocationDate (
  [FoodtruckID] INT NOT NULL,
  [DateID] INT NOT NULL,
  [LocationID] INT NOT NULL,
  PRIMARY KEY ([FoodtruckID], [DateID], [LocationID]),
  CONSTRAINT [fk_Foodtruck_has_Location_date_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]),
  CONSTRAINT [fk_Foodtruck_has_Location_date_Location_date1]
    FOREIGN KEY ([DateID])
    REFERENCES mydb.Date ([DateID]),
  CONSTRAINT [fk_Foodtruck_has_Location_date_Location1]
    FOREIGN KEY ([LocationID])
    REFERENCES mydb.Location ([LocationID]));
GO
CREATE INDEX fk_Foodtruck_has_Location_date_Location_date1_idx
ON mydb.FoodtruckLocationDate (DateID);
CREATE INDEX fk_Foodtruck_has_Location_date_Foodtruck1_idx
ON mydb.FoodtruckLocationDate (FoodtruckID);
CREATE INDEX fk_Foodtruck_has_Location_date_Location1_idx
ON mydb.FoodtruckLocationDate (LocationID);
GO
-----------------------------------------------------
-- Table mydb.SuppliesCost
-----------------------------------------------------
CREATE TABLE mydb.SuppliesCost (
  [FoodtruckID] INT NOT NULL,
  [SuppliesID] INT NOT NULL,
  [TotalSuppliesCost] FLOAT NOT NULL,
  [DatePurchased] DATE NOT NULL,
  PRIMARY KEY ([FoodtruckID], [SuppliesID]),
  CONSTRAINT [fk_Foodtruck_has_Supplies_Foodtruck1]
    FOREIGN KEY ([FoodtruckID])
    REFERENCES mydb.Foodtruck ([FoodtruckID]),
  CONSTRAINT [fk_Foodtruck_has_Supplies_Supplies1]
    FOREIGN KEY ([SuppliesID])
    REFERENCES mydb.Supplies ([SuppliesID]));
GO
CREATE INDEX fk_Foodtruck_has_Supplies_Supplies1_idx
ON mydb.SuppliesCost (SuppliesID);
CREATE INDEX fk_Foodtruck_has_Supplies_Foodtruck1_idx
ON mydb.SuppliesCost (FoodtruckID);
Go

--Encryption for Customer EmailID

CREATE MASTER KEY ENCRYPTION BY  
PASSWORD = 'HuskyFoodtruck'  
GO 

CREATE CERTIFICATE SelfSignedCertificate  
WITH SUBJECT = 'Password Encryption';  
GO  
CREATE SYMMETRIC KEY SQLSymmetricKey  
WITH ALGORITHM = AES_128  
ENCRYPTION BY CERTIFICATE SelfSignedCertificate;  
GO 
