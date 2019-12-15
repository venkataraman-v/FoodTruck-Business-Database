USE FOODTRUCK_DATABASE_TEAM_8;
Go

-- Trigger on OrderItem for calculating total order amount and food truck rating for each order

CREATE TRIGGER mydb.OrderAmountAndRating ON mydb.orderitem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN	
	DECLARE @orderItemCostNew FLOAT;
	DECLARE @orderItemCostOld FLOAT;
	DECLARE @foodtruckID FLOAT;
	DECLARE @newRating FLOAT;
	DECLARE @oldRating FLOAT;
	DECLARE @orderValueBefore FLOAT;
	DECLARE @orderID INT;
	SET @orderItemCostNew = 0;
	SET @orderItemCostOld = 0;
	SET @newRating = 0;
	SET @oldRating = 0;

	IF EXISTS(SELECT * FROM Inserted)
	BEGIN
		SET @orderItemCostNew= (Select i.Quantity*fi.price from Inserted i INNER JOIN
		mydb.fooditem fi ON fi.FoodItemID=i.FoodItemID)
		SET @newRating= (Select RatingGiven from Inserted )
		SET @orderID=(select OrderID from Inserted)
	END
	iF EXISTS(SELECT * FROM Deleted)
	BEGIN
		SET @orderItemCostOld = (Select d.Quantity*fi.price from Deleted d INNER JOIN
		mydb.fooditem fi ON fi.FoodItemID=d.FoodItemID)
		SET @oldRating= (Select RatingGiven from Deleted )
		SET @orderID=(select OrderID from Deleted)
	END
	SET @orderValueBefore= (Select OrderAmount from [order] where OrderID = @orderID)
	UPDATE mydb.[order] SET OrderAmount = @orderValueBefore+@orderItemCostNew-@orderItemCostOld where OrderID = @orderID
	IF @oldRating <> @newRating
		BEGIN
			SET @foodtruckID = (Select DISTINCT FoodtruckID from [order] where OrderID = @orderID)
			iF EXISTS(SELECT * FROM mydb.orderitem where OrderID in (Select OrderID from mydb.[order] where FoodtruckID = @foodtruckID))
			BEGIN
				UPDATE foodtruck SET FoodtruckRating = (SELECT AVG(CAST(RatingGiven AS FLOAT)) FROM mydb.orderitem where OrderID in (Select OrderID from mydb.[order] where FoodtruckID = @foodtruckID)) where FoodtruckID = @foodtruckID
			END
			ELSE
			BEGIN
				UPDATE foodtruck SET FoodtruckRating = 0 where FoodtruckID = @foodtruckID
			END
		END
END;
Go

--Trigger for calculating the total Income from orders.

CREATE TRIGGER mydb.OrderIncomeCalculation
ON mydb.[order]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @orderCostNew FLOAT;
	DECLARE @orderCostOld FLOAT;
	DECLARE @orderValueBefore FLOAT;
	DECLARE @FoodtruckID FLOAT;
	SET @orderCostNew = 0;
	SET @orderCostOld = 0;	

	IF EXISTS(SELECT * FROM Inserted)
	BEGIN
		SET @orderCostNew= (Select OrderAmount from Inserted)
		SET @FoodtruckID= (Select FoodtruckID from Inserted)
	END
	iF EXISTS(SELECT * FROM Deleted)
	BEGIN
		SET @orderCostOld= (Select OrderAmount from Deleted)
		SET @FoodtruckID= (Select FoodtruckID from Deleted)
	END
	SET @orderValueBefore= (Select TotalIncome from orderincome where FoodtruckID=@FoodtruckID)
	UPDATE mydb.orderincome SET TotalIncome = @orderValueBefore+@orderCostNew-@orderCostOld WHERE FoodtruckID = @FoodtruckID
END;
Go

--Trigger on foodtruck upon creation to insert the records in OrderIncome, Expenditure and revenue tables 

CREATE TRIGGER mydb.InsertTables ON mydb.foodtruck
AFTER INSERT
AS
BEGIN 
	IF EXISTS(SELECT * FROM Inserted)
	BEGIN
		INSERT INTO mydb.revenue(FoodtruckID) Values((Select FoodtruckID from Inserted))
		INSERT INTO mydb.orderincome(FoodtruckID) Values((Select FoodtruckID from Inserted))
		INSERT INTO mydb.expenditure(FoodtruckID) Values((Select FoodtruckID from Inserted))
	END	
END;
Go


--Trigger on supplies cost to update supplies cost from total supplies cost column in Supplies entity 

CREATE TRIGGER mydb.TotalSuppliesCost ON mydb.suppliescost
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @TotalSuppliesCost FLOAT;
  DECLARE @foodtruckID INT;
  DECLARE @SuppliesID INT;
  DECLARE @DatePurchased DATE;
  SET @TotalSuppliesCost = (SELECT Cost FROM mydb.supplies WHERE SuppliesID=(Select SuppliesID FROM Inserted))
  SET @foodtruckID=(SELECT FoodTruckID FROM Inserted)
  SET @SuppliesID=(SELECT SuppliesID FROM Inserted)
  SET @DatePurchased =(SELECT DatePurchased FROM Inserted)
  INSERT INTO mydb.suppliescost VALUES (@foodtruckID,@SuppliesID,@TotalSuppliesCost,@DatePurchased)
END;
Go

-- Trigger for updating expenditure from supplies in Expenditure table.

CREATE TRIGGER mydb.supppliesExpenditure ON mydb.suppliescost
AFTER INSERT, UPDATE, DELETE
AS
BEGIN 
	DECLARE @totalExpenditureBefore FLOAT;
	DECLARE @suppliesCostNew FLOAT;
	DECLARE @suppliesCostOld FLOAT;
	DECLARE @FoodtruckID INT;
	SET @suppliesCostNew = 0;
	SET @suppliesCostOld = 0;
	IF EXISTS(SELECT * FROM Deleted)
	BEGIN
		SET @suppliesCostOld= (Select TotalSuppliesCost from Deleted)
		SET @totalExpenditureBefore= (Select TotalExpenditure from mydb.expenditure where FoodtruckID in (select FoodtruckID from Deleted))
		SET @FoodtruckID= (Select FoodtruckID from Deleted)
	END
	IF EXISTS(SELECT * FROM Inserted)
	BEGIN
		SET @suppliesCostNew= (Select TotalSuppliesCost from Inserted)
		SET @totalExpenditureBefore= (Select TotalExpenditure from mydb.expenditure where FoodtruckID in (select FoodtruckID from Inserted))
		SET @FoodtruckID= (Select FoodtruckID from Inserted)
	END		
	UPDATE mydb.expenditure SET TotalExpenditure = @totalExpenditureBefore+@suppliesCostNew-@suppliesCostOld WHERE FoodtruckID = @FoodtruckID
END;
Go

--Trigger upon deletion of Foodtruck to delete it's records in OrderIncome, Expenditure and revenue tables.

CREATE TRIGGER mydb.DeleteTables
ON mydb.foodtruck
INSTEAD OF DELETE
AS
BEGIN
IF EXISTS(SELECT * FROM Deleted)
	BEGIN
		Delete from mydb.revenue WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.orderincome WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.expenditure WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.[order] WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.menu WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.foodtruckstaff WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.suppliescost WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.foodtrucklocationdate WHERE FoodtruckID=(Select FoodtruckID from Deleted)
		Delete from mydb.foodtruck WHERE FoodtruckID=(Select FoodtruckID from Deleted)
	END
END;
Go

--Trigger for updating incomeID in Revenue table

CREATE TRIGGER AddIncomeIDInRevenue on mydb.OrderIncome
After INSERT
AS
	BEGIN
		UPDATE mydb.revenue SET IncomeID = (select IncomeID from inserted)
		where FoodtruckID = (select FoodtruckID from inserted)
	END;
Go

--Trigger for updating ExpenditureID in Revenue table

CREATE TRIGGER AddExpenditureIDInRevenue on mydb.Expenditure
After INSERT
AS
	BEGIN
		UPDATE mydb.revenue SET ExpenditureID = (select ExpenditureID from inserted)
		where FoodtruckID = (select FoodtruckID from inserted)
	END;
Go

--Trigger for adding payslip amounts to Expenditure entity

CREATE TRIGGER AddSalaryToExpenditure ON mydb.Payslip
AFTER INSERT, UPDATE 
AS  
	BEGIN
		UPDATE mydb.expenditure SET TotalExpenditure = TotalExpenditure + (select Salary from inserted)
		where FoodtruckID = (select FoodtruckID from inserted)
	END;
Go

--Trigger for deleting payslip amounts to Expenditure entity on deletion of payslip

CREATE TRIGGER DeleteSalaryFromExpenditure ON mydb.Payslip
FOR DELETE, UPDATE
AS
	BEGIN
		UPDATE mydb.expenditure SET TotalExpenditure = TotalExpenditure - (select Salary from deleted)
		where FoodtruckID = (select FoodtruckID from deleted)
	END;
Go

--Trigger for updating order income in Revenue table

CREATE TRIGGER UpdateIncomeInRevenue on mydb.OrderIncome
After UPDATE
AS
	BEGIN
		UPDATE mydb.revenue SET TotalRevenue = (select TotalIncome from inserted) - 
		(
		select TotalExpenditure 
		from mydb.expenditure 
		where FoodtruckID = (select FoodtruckID from inserted)
		)
		where FoodtruckID = (select FoodtruckID from inserted)
	END;
Go

--Trigger for updating expenditure in Revenue table

CREATE TRIGGER UpdateExpenditureInRevenue on mydb.Expenditure
After UPDATE
AS
	BEGIN
		UPDATE mydb.revenue SET TotalRevenue = (
		select TotalIncome 
		from mydb.orderincome 
		where FoodtruckID = (select FoodtruckID from inserted)
		) - (select TotalExpenditure from inserted)
		where FoodtruckID = (select FoodtruckID from inserted)
	END;