use FOODTRUCK_DATABASE_TEAM_8;
Go
 
--View for analysis of Foodtruck Performance 

CREATE VIEW Foodtruck_Performance AS
Select F.FoodtruckID, F.StartedOn,ROUND(F.FoodtruckRating,2) AS FoodtruckRating, Count(O.OrderID) as [Total Order Count],
Round(sum(O.OrderAmount),2) as [Income on Orders],
Round(sum(ISNULL(CAST(P.Salary as float), 0)),2) as [Expenditure on Payslips], 
Round(sum(ISNULL(CAST(S.TotalSuppliesCost as float), 0)),2) as [Expenditure on Supplies],
Round(sum(O.OrderAmount) - sum(ISNULL(CAST(P.Salary as float), 0)) - sum(ISNULL(CAST(S.TotalSuppliesCost as float), 0)),2) as [Total Revenue] 
from mydb.foodtruck F
left join mydb.[order] O on
O.FoodtruckID = F.FoodtruckID
left join mydb.payslip P
on P.FoodtruckID = F.FoodtruckID
left join mydb.suppliescost S
on S.FoodtruckID = F.FoodtruckID
group by F.FoodtruckID, F.StartedOn,F.FoodtruckRating;
Go
Select * from Foodtruck_Performance;

-- View for identifing popular cusines by location
Go
CREATE VIEW Popular_Cusine_by_Location
AS
	WITH Temp
	AS
	(
	select A.LocationID, A.CuisineID,l.Neighbourhood,c.Name from 
	(select P.LocationID, P.CuisineID,
	DENSE_RANK() over (Partition by P.LocationID order by P.LocationID) as [RANK] from 
	(select OrderItemID, F.FoodItemID, OI.OrderID, O.FoodtruckID, 
	O.DateTime, D.DateID, CuisineID, LocationID from mydb.OrderItem OI
	left join mydb.fooditem F
	on OI.FoodItemID = F.FoodItemID
	left join mydb.cuisine C
	on C.CuisineID = F.CusineID
	left join mydb.[Order] O
	on O.OrderID = OI.OrderID
	left join mydb.[date] D
	on D.Date = convert(date, O.DateTime)
	left join mydb.foodtrucklocationdate FL
	on FL.FoodtruckID = O.FoodtruckID and FL.DateID = D.DateID) P
	where P.LocationID is not NULL
	group by P.LocationID, P.CuisineID) A
	INNER JOIN mydb.location l ON A.LocationID=l.LocationID
	INNER JOIN mydb.cuisine c ON c.CuisineID=A.CuisineID
	where [Rank] = 1
)

select DISTINCT a.Neighbourhood AS Location,
  STUFF((SELECT DISTINCT ', ' + b.name
         from Temp b
         where a.Neighbourhood = b.Neighbourhood
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,2,'') PopularCusine
from Temp a;
Go
Select * from Popular_Cusine_by_Location;

--Functions to get the Foodtruck performance in a given time period

Go
CREATE FUNCTION GetPayslipExpenditureBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS float 
AS 
BEGIN
	DECLARE @TotalSalariesGiven float
	SELECT @TotalSalariesGiven = ISNULL((select Round(Sum(ISNULL(CAST(P.Salary as float), 0)),2) from mydb.payslip as P
	where FoodtruckID = @foodtruckID and P.[Date] >= @DateFrom and P.[Date] <= @DateTo), 0)
	
	Return @TotalSalariesGiven
END;
Go

CREATE FUNCTION GetSuppliesExpenditureBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS float 
AS 
BEGIN
	DECLARE @TotalSuppliesCost float
	SELECT @TotalSuppliesCost = ISNULL((select Round(Sum(ISNULL(CAST(SC.TotalSuppliesCost as float), 0)),2) 
	from mydb.suppliescost AS SC
	where FoodtruckID = @foodtruckID and SC.DatePurchased <= @DateTo and SC.DatePurchased >= @DateFrom), 0)

	Return @TotalSuppliesCost
END;
Go

CREATE FUNCTION GetExpenditureBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS float 
AS 
BEGIN
	Return dbo.GetPayslipExpenditureBetween(@foodtruckID, @DateFrom, @DateTo) + 
	dbo.GetSuppliesExpenditureBetween(@foodtruckID, @DateFrom, @DateTo)
END;
Go

CREATE FUNCTION GetOrderIncomeBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS float 
AS 
BEGIN
	Return ISNULL((select Round(Sum(ISNULL(CAST(O.OrderAmount as float), 0)),2) from mydb.[order] as O
	where FoodtruckID = @foodtruckID and O.[DateTime] >= @DateFrom and O.[DateTime] <= @DateTo), 0)
END;
Go

CREATE FUNCTION GetTotalRevenueBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS float 
AS 
BEGIN
	Return dbo.GetOrderIncomeBetween(@foodtruckID, @DateFrom, @DateTo) - dbo.GetExpenditureBetween(@foodtruckID, @DateFrom, @DateTo)
END;
Go

CREATE FUNCTION GetOrderCountBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS int
as 
BEGIN
	Return ISNULL((select Count(OrderID) from mydb.[order] as O
	where FoodtruckID = @foodtruckID and O.[DateTime] >= @DateFrom and O.[DateTime] <= @DateTo), 0)
END;
Go

CREATE FUNCTION GetFoodTruckPerformanceBetween(@foodtruckID int, @DateFrom varchar(10), @DateTo varchar(10))
RETURNS TABLE
AS
RETURN (Select @foodtruckID as [FoodtruckID], @DateFrom as [From Date], @DateTo AS [To Date],
dbo.GetOrderCountBetween(@foodtruckID, @DateFrom, @DateTo) as [Total Order Count],
dbo.GetOrderIncomeBetween(@foodtruckID, @DateFrom, @DateTo) as [Income on Orders], 
dbo.GetPayslipExpenditureBetween(@foodtruckID, @DateFrom, @DateTo) as [Expenditure on Payslips],
dbo.GetSuppliesExpenditureBetween(@foodtruckID, @DateFrom, @DateTo) as [Expenditure on Supplies],
dbo.GetTotalRevenueBetween(@foodtruckID, @DateFrom, @DateTo) as [Total Revenue]);
Go

-- Select query to get the Foodtruck performance in a given time period

Select * from dbo.GetFoodTruckPerformanceBetween(2, '2019-01-01', '2019-12-01');

Go
