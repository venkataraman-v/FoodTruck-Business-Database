-- Insert Tables
USE FOODTRUCK_DATABASE_TEAM_8;
--Cuisine Table
INSERT INTO mydb.cuisine VALUES(1, 'Andhra');
INSERT INTO mydb.cuisine VALUES(2, 'Argentine');
INSERT INTO mydb.cuisine VALUES(3, 'Chinese');
INSERT INTO mydb.cuisine VALUES(4, 'Indian');
INSERT INTO mydb.cuisine VALUES(5, 'Korean');
INSERT INTO mydb.cuisine VALUES(6, 'Nigerian');
INSERT INTO mydb.cuisine VALUES(7, 'English');
INSERT INTO mydb.cuisine VALUES(8, 'German');
INSERT INTO mydb.cuisine VALUES(9, 'Italian');
INSERT INTO mydb.cuisine VALUES(10, 'Mexican');
INSERT INTO mydb.cuisine VALUES(11, 'French');
INSERT INTO mydb.cuisine VALUES(12, 'Rajasthani');
INSERT INTO mydb.cuisine VALUES(13, 'Tamil');
INSERT INTO mydb.cuisine VALUES(14, 'Udupi');
INSERT INTO mydb.cuisine VALUES(15, 'Greek');
SELECT * FROM mydb.cuisine;

-- Customer Table
OPEN SYMMETRIC KEY SQLSymmetricKey  
DECRYPTION BY CERTIFICATE SelfSignedCertificate;  
INSERT INTO mydb.customer VALUES(1,'Venkataraman','Vijayakumar',486579740,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'venkataraman.v@husky.neu.edu'),'Indian','Mexican');
INSERT INTO mydb.customer VALUES(2,'Narra','Rohith Reddy',987792324,EncryptByKey(Key_GUID('SQLSymmetricKey'),'narra.r@husky.neu.edu'),'Indian','Andhra');
INSERT INTO mydb.customer VALUES(3,'Venkat','Mithun',912354321,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'mithun.v@husky.neu.edu'),'Indian','Andhra');
INSERT INTO mydb.customer VALUES(4,'Hamilton','Lewis',948679740,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'vic.v@husky.neu.edu'),'White','English');
INSERT INTO mydb.customer VALUES(5,'Vettel','Seb',948657098,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'vettel.v@husky.neu.edu'),'White','German');
INSERT INTO mydb.customer VALUES(6,'Sainz','Carlos',948657097,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'aman.v@husky.neu.edu'),'White','Mexican');
INSERT INTO mydb.customer VALUES(7,'Raghuram','Arun',945437970,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'raghu.v@husky.neu.edu'),'Indian','Udupi');
INSERT INTO mydb.customer VALUES(8,'Kairnair','Ashvin',989989909,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'kairnw.v@husky.neu.edu'),'Indian','Rajasthani');
INSERT INTO mydb.customer VALUES(9,'Itekela','Satya',900998761,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'kata.v@husky.neu.edu'),'Indian','Andhra');
INSERT INTO mydb.customer VALUES(10,'Verstappen','Max',948657970,EncryptByKey(Key_GUID('SQLSymmetricKey'), 'raman.v@husky.neu.edu'),'White','Greek');
SELECT * FROM mydb.customer;
CLOSE SYMMETRIC KEY SQLSymmetricKey;  
GO 

-- Staff table

Insert into mydb.staff values(100, 'Weng', 'Simon', 206941505, 'Northeastern', 98100, 'Seattle');
Insert into mydb.staff values(101, 'Arsene', 'Wenger', 206343231, 'West Rochester', 98110, 'Seattle');
Insert into mydb.staff values(102, 'Nicolas', 'Lodeiro', 206879634, 'Bank Colony', 98125, 'Seattle');
Insert into mydb.staff values(103, 'Phoebe', 'Buffet', 206854477, 'Issaquah', 98167, 'Seattle');
Insert into mydb.staff values(104, 'Joey', 'Tribbiani', 206325357, 'Sammasish', 98104, 'Seattle');
Insert into mydb.staff values(105, 'Harvey', 'Spectre', 206678567, 'Boren', 98196, 'Seattle');
Insert into mydb.staff values(106, 'Mike', 'Ross', 206924575, 'Clive', 98245, 'Seattle');
Insert into mydb.staff values(107, 'Charlie', 'Sheen', 206785676, 'Lloyd', 98934, 'Seattle');
Insert into mydb.staff values(108, 'Jesse', 'Pinkman', 206989955, 'Lake City', 98342, 'Seattle');
Insert into mydb.staff values(109, 'Walter', 'White', 257678543, 'Northgate', 98576, 'Seattle');
Insert into mydb.staff values(110, 'Michael', 'Scofield', 256757434, 'Westminster', 98234, 'Seattle');
Insert into mydb.staff values(111, 'Hong', 'Cho', 267876854, 'Buckingham', 98232, 'Seattle');
Insert into mydb.staff values(112, 'Leslie', 'Smith', 206784524, 'South Union', 98674, 'Seattle');
Select * from mydb.staff;

-- Supplies Table


Insert into mydb.supplies values(530, 'Greg Farms' , 'Onion', 20);
Insert into mydb.supplies values(531, 'Jonny Sims' , 'Cheese', 39);
Insert into mydb.supplies values(532, 'Pollos Hermanos' , 'Chciken', 64);
Insert into mydb.supplies values(533, 'QFC' , 'Rice', 70);
Insert into mydb.supplies values(534, 'RMDX' , 'Bell Pepper', 33);
Insert into mydb.supplies values(535, 'TRPL' , 'Tomatoes', 24);
Insert into mydb.supplies values(536, 'FMCG' , 'Fish', 50);
Insert into mydb.supplies values(537, 'Jose Depot' , 'Taco Shells', 10);
Insert into mydb.supplies values(538, 'Green Haven' , 'Fetucchini', 15);
Insert into mydb.supplies values(539, 'Gregory Farms' , 'Pizza Dough', 40);
select * from mydb.supplies;

-- Foodtruck Table

INSERT INTO mydb.foodtruck VALUES (1,CAST('2019-12-01' AS DATE),'08:30:00','12:30:00',0);
INSERT INTO mydb.foodtruck VALUES (2,CAST('2019-08-23' AS DATE),'07:30:00','11:30:00',0);
INSERT INTO mydb.foodtruck VALUES (3,CAST('2019-11-29' AS DATE),'13:30:00','19:30:00',0);
INSERT INTO mydb.foodtruck VALUES (4,CAST('2019-10-12' AS DATE),'15:00:00','20:30:00',0);
INSERT INTO mydb.foodtruck VALUES (5,CAST('2019-11-06' AS DATE),'17:00:00','23:30:00',0);
INSERT INTO mydb.foodtruck VALUES (6,CAST('2019-09-22' AS DATE),'09:00:00','15:30:00',0);
INSERT INTO mydb.foodtruck VALUES (7,CAST('2019-05-25' AS DATE),'09:00:00','20:00:00',0);
INSERT INTO mydb.foodtruck VALUES (8,CAST('2019-07-13' AS DATE),'00:30:00','10:30:00',0);
INSERT INTO mydb.foodtruck VALUES (9,CAST('2019-03-26' AS DATE),'00:30:00','07:30:00',0);
INSERT INTO mydb.foodtruck VALUES (10,CAST('2019-02-04' AS DATE),'07:30:00','10:30:00',0);
SELECT * FROM mydb.foodtruck;

--  Menu Table

INSERT INTO mydb.menu VALUES(1,'Burger, She Wrote',1);
INSERT INTO mydb.menu VALUES(2,'Cluck It Up',2);
INSERT INTO mydb.menu VALUES(3,'Pimp My Rice',3);
INSERT INTO mydb.menu VALUES(4,'Curry Up Now',4);
INSERT INTO mydb.menu VALUES(5,'Easy Slider',5);
INSERT INTO mydb.menu VALUES(6,'Grillenium Falcon',6);
INSERT INTO mydb.menu VALUES(7,'Hamborghini',7);
INSERT INTO mydb.menu VALUES(8,'Guac N Roll',8);
INSERT INTO mydb.menu VALUES(9,'I Dream of Weenie',9);
INSERT INTO mydb.menu VALUES(10,'Ms. Cheezious',10);
SELECT * FROM mydb.menu;

-- FoodItem Table

INSERT INTO mydb.fooditem VALUES(1,'Pav Bhaji',10,4,4);
INSERT INTO mydb.fooditem VALUES(2,'Bhel Puri',7.5,4,4);
INSERT INTO mydb.fooditem VALUES(3,'Mac & Cheese',8.7,7,10);
INSERT INTO mydb.fooditem VALUES(4,'Cheese Burger',15,7,10);
INSERT INTO mydb.fooditem VALUES(5,'Burrito',8,10,8);
INSERT INTO mydb.fooditem VALUES(6,'3-Tacos',5,10,8);
INSERT INTO mydb.fooditem VALUES(7,'Egg Noodles',10,3,3);
INSERT INTO mydb.fooditem VALUES(8,'Dumplings',5,3,3);
INSERT INTO mydb.fooditem VALUES(9,'Spring Rolls',10,3,3);
INSERT INTO mydb.fooditem VALUES(10,'Fried Rice',18,3,3);
INSERT INTO mydb.fooditem VALUES(12,'Tofu Burger',9.99,15,1);
INSERT INTO mydb.fooditem VALUES(11,'Hamburger',3,7,7);
INSERT INTO mydb.fooditem VALUES(13,'Gongura Biryani',30,1,4);
INSERT INTO mydb.fooditem VALUES(14,'Curry',10,1,4);
INSERT INTO mydb.fooditem VALUES(15,'Punugulu',1.99,1,4);
INSERT INTO mydb.fooditem VALUES(16,'Juice',19.9,9,2);
INSERT INTO mydb.fooditem VALUES(17,'Tofu Slider',10.9,5,5);
INSERT INTO mydb.fooditem VALUES(18,'Grilled Sandwich ',7.9,6,6);
INSERT INTO mydb.fooditem VALUES(19,'Hot Dog',17.9,11,9);
SELECT * FROM mydb.fooditem;

-- Location Table

Insert into mydb.location values(630, 98100, 'Northeastern', 'Seattle', 'South Union')
Insert into mydb.location values(631, 98110, 'West Rochester', 'Seattle', 'Rochester')
Insert into mydb.location values(632, 98342, 'Lake City', 'Seattle', 'Lake Arena')
Insert into mydb.location values(633, 98934, 'Lloyd', 'Seattle', 'Downtown')
Insert into mydb.location values(634, 98245, 'Clive', 'Seattle', 'China Town')
Insert into mydb.location values(635, 98234, 'Westminster', 'Seattle', 'Pike Place')
Insert into mydb.location values(636, 98232, 'Buckingham', 'Seattle', 'Roger town')
Insert into mydb.location values(637, 98167, 'Issaquah', 'Seattle', 'Greater Issaquah')
Insert into mydb.location values(638, 98104, 'Sammasish', 'Seattle', 'Bellevue')
Insert into mydb.location values(639, 98196, 'Boren', 'Seattle', 'Clarence')
Select * from mydb.location;


-- Date Table

INSERT INTO mydb.date VALUES(1,CAST('2019-12-02' AS DATE));
INSERT INTO mydb.date VALUES(2,CAST('2019-08-24' AS DATE));
INSERT INTO mydb.date VALUES(3,CAST('2019-11-28' AS DATE));
INSERT INTO mydb.date VALUES(4,CAST('2019-10-13' AS DATE));
INSERT INTO mydb.date VALUES(5,CAST('2019-11-07' AS DATE));
INSERT INTO mydb.date VALUES(6,CAST('2019-09-23' AS DATE));
INSERT INTO mydb.date VALUES(7,CAST('2019-05-26' AS DATE));
INSERT INTO mydb.date VALUES(8,CAST('2019-07-14' AS DATE));
INSERT INTO mydb.date VALUES(9,CAST('2019-03-27' AS DATE));
INSERT INTO mydb.date VALUES(10,CAST('2019-02-05' AS DATE));
INSERT INTO mydb.date VALUES(11,CAST('2019-12-03' AS DATE));
INSERT INTO mydb.date VALUES(12,CAST('2019-08-25' AS DATE));
INSERT INTO mydb.date VALUES(13,CAST('2019-11-30' AS DATE));
INSERT INTO mydb.date VALUES(14,CAST('2019-10-14' AS DATE));
INSERT INTO mydb.date VALUES(15,CAST('2019-11-08' AS DATE));
INSERT INTO mydb.date VALUES(16,CAST('2019-09-24' AS DATE));
INSERT INTO mydb.date VALUES(17,CAST('2019-05-27' AS DATE));
INSERT INTO mydb.date VALUES(18,CAST('2019-07-15' AS DATE));
INSERT INTO mydb.date VALUES(19,CAST('2019-03-28' AS DATE));
INSERT INTO mydb.date VALUES(20,CAST('2019-02-06' AS DATE));
SELECT * FROM mydb.date;

-- FoodtruckLocationDate Table

INSERT INTO mydb.foodtrucklocationdate VALUES(1,1,630);
INSERT INTO mydb.foodtrucklocationdate VALUES(2,1,631);
INSERT INTO mydb.foodtrucklocationdate VALUES(2,2,631);
INSERT INTO mydb.foodtrucklocationdate VALUES(3,3,633);
INSERT INTO mydb.foodtrucklocationdate VALUES(4,4,635);
INSERT INTO mydb.foodtrucklocationdate VALUES(5,5,636);
INSERT INTO mydb.foodtrucklocationdate VALUES(5,6,636);
INSERT INTO mydb.foodtrucklocationdate VALUES(5,7,637);
INSERT INTO mydb.foodtrucklocationdate VALUES(5,8,637);
INSERT INTO mydb.foodtrucklocationdate VALUES(6,9,638);
INSERT INTO mydb.foodtrucklocationdate VALUES(7,10,638);
INSERT INTO mydb.foodtrucklocationdate VALUES(7,11,639);
INSERT INTO mydb.foodtrucklocationdate VALUES(7,12,630);
Insert into mydb.foodtrucklocationdate values(8,13,639);
Insert into mydb.foodtrucklocationdate values(8,8,638);
Insert into mydb.foodtrucklocationdate values(9,15,637);
Insert into mydb.foodtrucklocationdate values(10,16,636);
Insert into mydb.foodtrucklocationdate values(10,17,639);
SELECT * FROM mydb.foodtrucklocationdate;

-- Order Table
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(330, 1, 'cash', '2019-12-02 18:24:06 PM', FLOOR(RAND()*(10000-1000+1)), 1);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(331, 2, 'card', '2019-08-24 20:36:23', FLOOR(RAND()*(10000-1000+1)), 1);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(332, 3, 'venmo', '2019-11-28 12:38:27', FLOOR(RAND()*(10000-1000+1)), 2);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(333, 4, 'card',  '2019-10-13 11:02:34', FLOOR(RAND()*(10000-1000+1)), 3);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(334, 5, 'venmo', '2019-11-07 14:26:07', FLOOR(RAND()*(10000-1000+1)), 4);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(335, 6, 'Google Pay', '2019-03-27 15:36:10', FLOOR(RAND()*(10000-1000+1)), 5);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(336, 7, 'cash', '2019-02-05 19:28:10', FLOOR(RAND()*(10000-1000+1)), 6);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(337, 8, 'cash', '2019-07-14 19:28:10', FLOOR(RAND()*(10000-1000+1)), 7);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(338, 9, 'card', '2019-11-08 19:28:10', FLOOR(RAND()*(10000-1000+1)), 8);
Insert into mydb.[Order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(339, 10, 'cash', '2019-05-27 19:28:10', FLOOR(RAND()*(10000-1000+1)), 3);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(341,5, 'card', '2019-07-14 13:04:10', FLOOR(RAND()*(10000-1000+1)), 3);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(342,7, 'cash', '2019-12-03 20:21:09', FLOOR(RAND()*(10000-1000+1)), 7);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(343,7, 'cash', '2019-08-25 14:56:54', FLOOR(RAND()*(10000-1000+1)), 2);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(344,5, 'cash', '2019-11-07 15:36:34', FLOOR(RAND()*(10000-1000+1)), 1);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(345,1, 'cash', '2019-12-02 12:26:34', FLOOR(RAND()*(10000-1000+1)), 8);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(346,5, 'cash', '2019-05-26 12:26:34', FLOOR(RAND()*(10000-1000+1)), 6);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(347,5, 'cash', '2019-09-23 19:28:10', FLOOR(RAND()*(10000-1000+1)), 5);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(348,8, 'venmo', '2019-07-14 19:28:10', FLOOR(RAND()*(10000-1000+1)), 10);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(349,8, 'venmo', '2019-07-14 12:09:43', FLOOR(RAND()*(10000-1000+1)), 10);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(350,9, 'venmo', '2019-11-08 15:32:10', FLOOR(RAND()*(10000-1000+1)), 7);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(351,10, 'Google Pay', '2019-09-24 12:09:43', FLOOR(RAND()*(10000-1000+1)), 9);
Insert into mydb.[order] (OrderID, FoodtruckID, PaymentType, DateTime, TransactionID, CustomerID) values(352,10, 'Google Pay', '2019-05-27 13:26:43', FLOOR(RAND()*(10000-1000+1)), 9);
SELECT * FROM mydb.[order];

-- OrderItem Table

Insert into mydb.orderitem values(1,12,330,4,3,1);
INSERT INTO mydb.orderitem VALUES(2,16,331,4,4,1);
INSERT INTO mydb.orderitem VALUES(3,8,332,3,4,1);
INSERT INTO mydb.orderitem VALUES(4,9,332,4,3,1);
INSERT INTO mydb.orderitem VALUES(5,7,332,5,2,2);
INSERT INTO mydb.orderitem VALUES(6,10,332,3,4,2);
INSERT INTO mydb.orderitem VALUES(7,1,333,4,4,2);
INSERT INTO mydb.orderitem VALUES(8,2,333,4,4,2);
INSERT INTO mydb.orderitem VALUES(9,13,333,3,4,2);
INSERT INTO mydb.orderitem VALUES(10,14,333,2,4,3);
INSERT INTO mydb.orderitem VALUES(11,15,333,3,4,3);
INSERT INTO mydb.orderitem VALUES(12,17,334,1,4,4);
INSERT INTO mydb.orderitem VALUES(13,18,335,2,4,5);
INSERT INTO mydb.orderitem VALUES(14,11,336,3,4,6);
INSERT INTO mydb.orderitem VALUES(15,6,337,5,4,7);
INSERT INTO mydb.orderitem VALUES(16,5,337,4,4,7);
INSERT INTO mydb.orderitem VALUES(17,19,338,5,4,8);
INSERT INTO mydb.orderitem VALUES(18,3,339,5,4,3);
INSERT INTO mydb.orderitem VALUES(19,4,339,4,3,3);
insert into mydb.orderitem values(21, 17, 341, 4, 5, 3);
insert into mydb.orderitem values(22, 11, 342, 4, 3, 3);
insert into mydb.orderitem values(23, 11, 343, 4, 3, 2);
insert into mydb.orderitem values(24, 17, 344, 5, 2, 1);
insert into mydb.orderitem values(25, 12, 345, 5, 2, 8);
insert into mydb.orderitem values(26, 17, 346, 5, 4, 6);
insert into mydb.orderitem values(27, 17, 347, 4, 2, 5);
insert into mydb.orderitem values(28, 5, 348, 5, 3, 10);
insert into mydb.orderitem values(29, 6, 349, 5, 2, 10);
insert into mydb.orderitem values(30, 19, 350, 4, 3, 7);
insert into mydb.orderitem values(31, 3, 351, 4, 2, 9);
insert into mydb.orderitem values(32, 4, 352, 5, 2, 9);

SELECT * FROM mydb.orderitem;

-- FoodtruckStaff Table

insert into mydb.foodtruckstaff values(1,101,'Driver');
insert into mydb.foodtruckstaff values(1,110,'Chef');
insert into mydb.foodtruckstaff values(1,100,'Owner');
insert into mydb.foodtruckstaff values(2,102,'Driver');
insert into mydb.foodtruckstaff values(2,109,'Chef');
insert into mydb.foodtruckstaff values(2,100,'Owner');
insert into mydb.foodtruckstaff values(3,103,'Driver');
insert into mydb.foodtruckstaff values(3,108,'Chef');
insert into mydb.foodtruckstaff values(3,100,'Owner');
insert into mydb.foodtruckstaff values(4,104,'Driver');
insert into mydb.foodtruckstaff values(4,107,'Chef');
insert into mydb.foodtruckstaff values(4,100,'Owner');
insert into mydb.foodtruckstaff values(5,105,'Driver');
insert into mydb.foodtruckstaff values(5,106,'Chef');
insert into mydb.foodtruckstaff values(5,112,'Owner');
insert into mydb.foodtruckstaff values(6,106,'Driver');
insert into mydb.foodtruckstaff values(6,105,'Chef');
insert into mydb.foodtruckstaff values(6,111,'Owner');
insert into mydb.foodtruckstaff values(7,107,'Driver');
insert into mydb.foodtruckstaff values(7,104,'Chef');
insert into mydb.foodtruckstaff values(7,111,'Owner');
insert into mydb.foodtruckstaff values(8,108,'Driver');
insert into mydb.foodtruckstaff values(8,103,'Chef');
insert into mydb.foodtruckstaff values(8,111,'Owner');
insert into mydb.foodtruckstaff values(9,109,'Driver');
insert into mydb.foodtruckstaff values(9,102,'Chef');
insert into mydb.foodtruckstaff values(9,112,'Owner');
insert into mydb.foodtruckstaff values(10,110,'Driver');
insert into mydb.foodtruckstaff values(10,101,'Chef');
insert into mydb.foodtruckstaff values(10,112,'Owner');
SELECT * FROM mydb.foodtruckstaff;



-- Payslip Table

insert into mydb.payslip values(102,2,2000,CAST('10-01-2019' AS DATE))
insert into mydb.payslip values(109,2,3000,CAST('10-01-2019' AS DATE))
insert into mydb.payslip values(100,2,4000,CAST('10-01-2019' AS DATE))
insert into mydb.payslip values(104,4,1000,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(107,4,1500,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(100,4,2000,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(105,5,2000,CAST('12-01-2019' AS DATE))
insert into mydb.payslip values(106,5,3000,CAST('12-01-2019' AS DATE))
insert into mydb.payslip values(112,5,4000,CAST('12-01-2019' AS DATE))
insert into mydb.payslip values(106,6,2000,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(105,6,3000,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(111,6,4000,CAST('11-01-2019' AS DATE))
insert into mydb.payslip values(107,7,2000,CAST('07-01-2019' AS DATE))
insert into mydb.payslip values(104,7,3000,CAST('07-01-2019' AS DATE))
insert into mydb.payslip values(111,7,4000,CAST('07-01-2019' AS DATE))
insert into mydb.payslip values(108,8,2000,CAST('08-01-2019' AS DATE))
insert into mydb.payslip values(103,8,3000,CAST('08-01-2019' AS DATE))
insert into mydb.payslip values(111,8,4000,CAST('08-01-2019' AS DATE))
insert into mydb.payslip values(109,9,2000,CAST('05-01-2019' AS DATE))
insert into mydb.payslip values(102,9,3000,CAST('05-01-2019' AS DATE))
insert into mydb.payslip values(112,9,4000,CAST('05-01-2019' AS DATE))
insert into mydb.payslip values(110,10,2000,CAST('03-01-2019' AS DATE))
insert into mydb.payslip values(101,10,3000,CAST('03-01-2019' AS DATE))
insert into mydb.payslip values(112,10,4000,CAST('03-01-2019' AS DATE))
select * from mydb.payslip;



-- SuppliesCost Table

insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(1,531,CAST('01-12-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(2,532,CAST('08-23-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(2,530,CAST('05-23-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(3,533,CAST('11-29-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(4,534,CAST('10-12-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(4,536,CAST('11-12-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(5,535,CAST('11-06-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(6,536,CAST('09-22-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(6,534,CAST('10-22-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(6,539,CAST('11-22-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(7,537,CAST('05-25-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(7,534,CAST('06-25-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(8,538,CAST('07-13-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(8,537,CAST('08-13-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(9,539,CAST('03-26-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(9,535,CAST('04-27-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(10,530,CAST('02-04-2019' AS DATE));
insert into mydb.suppliescost(FoodtruckID,SuppliesID,DatePurchased) values(10,533,CAST('03-04-2019' AS DATE));
select * from mydb.suppliescost;
