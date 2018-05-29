# SQL- Structured Query Language

First I pulled a few data files from [The Star Wars API](https://swapi.co/api/).

```{bash}
curl https://swapi.co/api/films/ -o swFilms.json
curl https://swapi.co/api/planets/ -o swPlanets.json
curl https://swapi.co/api/people/ -o swPeople.json
curl https://swapi.co/api/species/-o swSpecies.json
curl https://swapi.co/api/vehicles/ -o swVehicles.json
curl https://swapi.co/api/starships/ -o swStarships.json
```

[JSON conversion to CSV](https://konklone.io/json/).

```{r eval=FALSE}
library(RSQLite)
db <- dbConnect(RSQLite::SQLite(), dbname = "sql.sqlite")
```
```{r eval=FALSE}
# TO USE PYTHON 
# library(devtools)
# devtools::install_github("rstudio/reticulate")
# library(reticulate)
# os <- import("os")
# os$listdir(".")
# py_install("pandas")

# Python 
# ```{python, engine="/anaconda/bin/python"}
# import pandas
# ```
```

# SQL in R

```{r}
library(tidyverse)
library(DBI)
#library(dplyr)
#library(dbplyr)

# Create an ephemeral in-memory RSQLite database
swapi <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")
planets <- read_csv("/Users/jeffreylong/R/starWars/planets.csv")
dbWriteTable(swapi, "planets", planets)
dbListTables(swapi)
dbListFields(swapi, "planets")
dbReadTable(swapi, "planets")

# Submit Queries
planets.frozen <- dbSendQuery(swapi, "SELECT * FROM planets WHERE climate = 'frozen'")
planets.temperate <- dbSendQuery(swapi, "SELECT * FROM planets WHERE climate = 'temperate'")

# Fetch Results:
planetsFrozen <- dbFetch(planets.frozen)
planetsTemperate <- dbFetch(planets.temperate)

# Or Fetch Bit by Bit/ if Large Database
# while(!dbHasCompleted(planets.temperate)){
#   chunk <- dbFetch(planets.temperate, n = 5)
#   print(nrow(chunk))
# }

#dbClearResult(swapi)
#dbDisconnect(swapi)

library(ggplot2)
g = ggplot(planetsTemperate, aes(diameter, orbital_period , color = rotation_period)) +
  geom_point() +
  xlab("Diameter") +
  ylab("Orbital Period") +
  ggtitle("Star Wars Planets")

g

head(planetsTemperate)
```

```{sql, connection=swapi}
SELECT "name", "rotation_period", "orbital_period", "diameter", "climate", "gravity", "terrain", "surface_water", "population", SUM(CASE WHEN ("climate" = 'frozen') THEN (1.0) ELSE (0.0) END) AS "frozen_planets", SUM(CASE WHEN ("climate" = 'temperate') THEN (1.0) ELSE (0.0) END) AS "temperate_planets", SUM(CASE WHEN ("climate") LIKE 'temperate%' THEN (1.0) ELSE (0.0) END) AS "temperate_plus_other_planets"
FROM ("planets") 
GROUP BY "name"
```


## Building a Database

```{r eval=FALSE}
# Create It
CREATE DATABASE salespersonOrdersDB;
# Delete Database
DROP DATABASE salespersonOrdersDB;
# Create a Table from another Table
CREATE TABLE new_table_name AS
    SELECT column1, column2,...
    FROM existing_table_name
    WHERE ....;
# Delete Table
DROP TABLE table_name;
    # Delete Data in Table, but not the Table itself
    TRUNCATE TABLE table_name;
# Add Variable to Table
ALTER TABLE table_name
ADD column_name datatype;
    # e.g. 
    ALTER TABLE Salesperson
    ADD DateOfBirth year;
# Delet Variable (column) from Table
ALTER TABLE table_name
DROP COLUMN column_name;
# Modify Column
ALTER TABLE table_name
MODIFY COLUMN column_name datatype;
    # e.g. 
    ALTER TABLE Salesperson
    ALTER COLUMN DateOfBirth date;
#Constraints
CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype constraint,
    ....
);
    # Constraints:
    # NOT NULL - Ensures that a column cannot have a NULL value
    # UNIQUE - Ensures that all values in a column are different
    # PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
    # FOREIGN KEY - Uniquely identifies a row/record in another table
    # CHECK - Ensures that all values in a column satisfies a specific condition
    # DEFAULT - Sets a default value for a column when no value is specified
    # INDEX - Used to create and retrieve data from the database very quickly

    ### Aggregate Functions:
    # AVG – calculates the average of a set of values.
    # COUNT – counts rows in a specified table or view.
    # MIN – gets the minimum value in a set of values.
    # MAX – gets the maximum value in a set of values.
    # SUM – calculates the sum of values.
    # FIRST - returns the first value
    # LAST - returns the last value

```


```{bash eval=FALSE}
# Install MySQL 
brew info mysql
brew install mysql
brew tap homebrew/services
brew services start mysql
brew services list
mysql -V
# mysqladmin -u root password somethingStrong
# then store it in a completely obvious place in a README
brew services start mysql

(sql) > pwd
/Users/jeffreylong/sql
(sql) > mysql_secure_installation

Securing the MySQL server deployment.

Enter password for user root: 

VALIDATE PASSWORD PLUGIN can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD plugin?

Press y|Y for Yes, any other key for No: y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 2
Using existing password for root.

Estimated strength of the password: 100 
Change the password for root ? ((Press y|Y for Yes, any other key for No) : n

 ... skipping.
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : n

 ... skipping.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : n

 ... skipping.
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done! 

## Database Management Software- SequelPro
## Connection Details
# Name: local
# Host: 127.0.0.1
# Username: root
# Password: somethingStrong
```


```{bash}
mysql -u root -p
#somethingStrong

CREATE DATABASE salespersonOrdersDB;
CREATE TABLE salespersonOrdersDB.Salesperson (
    ID int AUTO_INCREMENT,
    Name varchar(255) NOT NULL UNIQUE,
    Age int,
    Salary int,
    PRIMARY KEY (ID),
    CHECK (Age>=18)
);
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
    VALUES ('12','Jeff','45','140000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
  VALUES ('1','Abe','61','140000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
  VALUES ('2','Bob','34','44000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
  VALUES ('5','Chris','34','40000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
  VALUES ('7','Dan','41','52000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)
  VALUES ('8','Ken','57','115000');
INSERT INTO salespersonOrdersDB.Salesperson (ID,Name,Age,Salary)     
  VALUES ('11','Joe','38','38000');

CREATE TABLE salespersonOrdersDB.Orders (
    Number int,
    order_date date,
    cust_id int,
    salesperson_id int,
    Amount int,
    PRIMARY KEY (Number),
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson(ID)
);
INSERT INTO salespersonOrdersDB.Orders (Number,order_date,cust_id,salesperson_id,Amount)
  VALUES ('10','1996-08-02','4','2','540'),
  ('20','1999-01-30','4','8','1800'),
  ('30','1995-07-14','9','1','460'),
  ('40','1998-01-29','7','2','2400'),
  ('50','1998-02-03','6','7','600'),
  ('60','1998-03-02','6','7','720'),
  ('70','1998-05-06','9','7','150');

SELECT * FROM salespersonOrdersDB.Orders WHERE order_date>'1998-03-02';
+--------+------------+---------+----------------+--------+
| Number | order_date | cust_id | salesperson_id | Amount |
+--------+------------+---------+----------------+--------+
|     60 | 1998-03-02 |       6 |              7 |    720 |
+--------+------------+---------+----------------+--------+

CREATE VIEW salespersonOrdersDB.Stars AS
    SELECT ID, Name, Age
    FROM salespersonOrdersDB.Salesperson
    WHERE Salary > (SELECT AVG(Salary) FROM salespersonOrdersDB.Salesperson);
    
SELECT * FROM salespersonOrdersDB.Stars;
+----+------+------+
| ID | Name | Age  |
+----+------+------+
|  1 | Abe  |   61 |
|  8 | Ken  |   57 |
| 12 | Jeff |   45 |
+----+------+------+
SELECT * FROM salespersonOrdersDB.Orders WHERE order_date>'1998-03-02';
+--------+------------+---------+----------------+--------+
| Number | order_date | cust_id | salesperson_id | Amount |
+--------+------------+---------+----------------+--------+
|     20 | 1999-01-30 |       4 |              8 |   1800 |
|     70 | 1998-05-06 |       9 |              7 |    150 |
+--------+------------+---------+----------------+--------+
SELECT * FROM salespersonOrdersDB.Orders WHERE order_date<'1998-03-02';
+--------+------------+---------+----------------+--------+
| Number | order_date | cust_id | salesperson_id | Amount |
+--------+------------+---------+----------------+--------+
|     10 | 1996-08-02 |       4 |              2 |    540 |
|     30 | 1995-07-14 |       9 |              1 |    460 |
|     40 | 1998-01-29 |       7 |              2 |   2400 |
|     50 | 1998-02-03 |       6 |              7 |    600 |
+--------+------------+---------+----------------+--------+
SELECT * FROM salespersonOrdersDB.Salesperson;
+----+-------+------+--------+
| ID | Name  | Age  | Salary |
+----+-------+------+--------+
|  1 | Abe   |   61 | 140000 |
|  2 | Bob   |   34 |  44000 |
|  5 | Chris |   34 |  40000 |
|  7 | Dan   |   41 |  52000 |
|  8 | Ken   |   57 | 115000 |
| 11 | Joe   |   38 |  38000 |
| 12 | Jeff  |   45 | 140000 |
+----+-------+------+--------+

SELECT Name
FROM salespersonOrdersDB.Salesperson, salespersonOrdersDB.Orders
WHERE salesperson_id = ID
GROUP BY salesperson_id
HAVING COUNT( salesperson_id ) >1;
+------+
| Name |
+------+
| Bob  |
| Dan  |
+------+
2 rows in set (0.00 sec)

SELECT Name
FROM salespersonOrdersDB.Salesperson, salespersonOrdersDB.Orders
WHERE salesperson_id = ID
GROUP BY salesperson_id
HAVING COUNT( salesperson_id ) >=1;
+------+
| Name |
+------+
| Abe  |
| Bob  |
| Dan  |
| Ken  |
+------+
4 rows in set (0.00 sec)


CREATE TABLE salespersonOrdersDB.Customer (
    ID int,
    Name varchar(255),
    City varchar(255),
    Industry_Type varchar(255)
);
INSERT INTO salespersonOrdersDB.Customer (ID,Name,City,Industry_Type)
  VALUES ('4','Samsonic',	'pleasant',	'J'),
('6',	'Panasung',	'oaktown',	'J'),
('7',	'Samony',	'jackson',	'B'),
('9',	'Orange',	'Jackson',	'B');

ALTER TABLE salespersonOrdersDB.Customer ADD PRIMARY KEY (ID);
ALTER TABLE salespersonOrdersDB.Orders ADD FOREIGN KEY (cust_id) REFERENCES Customer(ID);

SELECT salesperson_id, MAX(Amount) AS MaxOrder FROM salespersonordersdb.Orders GROUP BY salesperson_id;
+----------------+----------+
| salesperson_id | MaxOrder |
+----------------+----------+
|              1 |      460 |
|              2 |     2400 |
|              7 |      720 |
|              8 |     1800 |
+----------------+----------+

SELECT salesperson_id, Number AS OrderNum, Amount 
FROM salespersonordersdb.Orders  
JOIN ( 
SELECT salesperson_id, MAX(Amount) AS MaxOrder 
FROM salespersonordersdb.Orders 
GROUP BY salesperson_id 
) AS TopOrderAmountsPerSalesperson 
USING (salesperson_id)  
WHERE Amount = MaxOrder;
+----------------+----------+--------+
| salesperson_id | OrderNum | Amount |
+----------------+----------+--------+
|              8 |       20 |   1800 |
|              1 |       30 |    460 |
|              2 |       40 |   2400 |
|              7 |       60 |    720 |
+----------------+----------+--------+

# To avoid not being able to select a non-aggregated column with a group by. 
# Join will give the OrderNumber matching both salesperson ID and amount. 

SELECT salesperson_id, Name, Number AS OrderNumber, Orders.Amount 
FROM salespersonordersdb.Orders 
JOIN salespersonordersdb.Salesperson  
ON salespersonordersdb.Salesperson.ID = salespersonordersdb.Orders.salesperson_id 
JOIN ( SELECT salesperson_id, MAX( Amount ) AS MaxOrder 
FROM salespersonordersdb.Orders 
GROUP BY salesperson_id ) AS TopOrderAmountsPerSalesperson 
USING ( salesperson_id )  
WHERE Amount = MaxOrder;
+----------------+------+-------------+--------+
| salesperson_id | Name | OrderNumber | Amount |
+----------------+------+-------------+--------+
|              8 | Ken  |          20 |   1800 |
|              1 | Abe  |          30 |    460 |
|              2 | Bob  |          40 |   2400 |
|              7 | Dan  |          60 |    720 |
+----------------+------+-------------+--------+

INSERT INTO salespersonOrdersDB.Orders (Number,order_date,cust_id,salesperson_id,Amount)
  VALUES ('80','1994-02-19','7','2','2400');
  

SELECT salesperson_id, Name, Number AS OrderNumber, Orders.Amount 
FROM salespersonordersdb.Orders 
JOIN salespersonordersdb.Salesperson  
ON salespersonordersdb.Salesperson.ID = salespersonordersdb.Orders.salesperson_id 
JOIN ( SELECT salesperson_id, MAX( Amount ) AS MaxOrder 
FROM salespersonordersdb.Orders 
GROUP BY salesperson_id, Amount ) AS TopOrderAmountsPerSalesperson 
USING ( salesperson_id )  
WHERE Amount = MaxOrder;
+----------------+------+-------------+--------+
| salesperson_id | Name | OrderNumber | Amount |
+----------------+------+-------------+--------+
|              2 | Bob  |          10 |    540 |
|              8 | Ken  |          20 |   1800 |
|              1 | Abe  |          30 |    460 |
|              2 | Bob  |          40 |   2400 |
|              7 | Dan  |          50 |    600 |
|              7 | Dan  |          60 |    720 |
|              7 | Dan  |          70 |    150 |
|              2 | Bob  |          80 |   2400 |
+----------------+------+-------------+--------+

SELECT salesperson_id, Salesperson.Name, Number AS OrderNumber, Amount
FROM salespersonordersdb.Orders
JOIN salespersonordersdb.Salesperson 
ON salespersonordersdb.Salesperson.ID = salespersonordersdb.Orders.salesperson_id
JOIN ( 
SELECT salesperson_id, MAX( Amount ) AS MaxOrder
FROM salespersonordersdb.Orders
GROUP BY salesperson_id
) AS TopOrderAmountsPerSalesperson
USING ( salesperson_id ) 
WHERE Amount = MaxOrder
GROUP BY salesperson_id, Amount;

SELECT salespersonOrdersDB.Orders.salesperson_id, salespersonOrdersDB.Salesperson.Name, 
salespersonOrdersDB.Orders.Number AS OrderNumber, salespersonOrdersDB.Orders.Amount
FROM salespersonOrdersDB.Orders
JOIN salespersonOrdersDB.Salesperson 
ON salespersonOrdersDB.Salesperson.ID = salespersonOrdersDB.Orders.salesperson_id
JOIN (
SELECT salesperson_id, MAX( Amount ) AS MaxOrder
FROM salespersonOrdersDB.Orders
GROUP BY salesperson_id
) AS TopOrderAmountsPerSalesperson
USING ( salesperson_id ) 
WHERE Amount = MaxOrder
GROUP BY salesperson_id, Amount, OrderNumber;
+----------------+------+-------------+--------+
| salesperson_id | Name | OrderNumber | Amount |
+----------------+------+-------------+--------+
|              1 | Abe  |          30 |    460 |
|              2 | Bob  |          40 |   2400 |
|              2 | Bob  |          80 |   2400 |
|              7 | Dan  |          60 |    720 |
|              8 | Ken  |          20 |   1800 |
+----------------+------+-------------+--------+

# Drop OrderNumber to avoid 
# ERROR 1055 (42000): Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'salespersonordersdb.Orders.Number' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# and get a unique value for each salesperson

SELECT salespersonOrdersDB.Orders.salesperson_id, salespersonOrdersDB.Salesperson.Name, salespersonOrdersDB.Orders.Amount
FROM salespersonOrdersDB.Orders
JOIN salespersonOrdersDB.Salesperson 
ON salespersonOrdersDB.Salesperson.ID = salespersonOrdersDB.Orders.salesperson_id
JOIN (
SELECT salesperson_id, MAX( Amount ) AS MaxOrder
FROM salespersonOrdersDB.Orders
GROUP BY salesperson_id
) AS TopOrderAmountsPerSalesperson
USING ( salesperson_id ) 
WHERE Amount = MaxOrder
GROUP BY salesperson_id, Amount;
+----------------+------+--------+
| salesperson_id | Name | Amount |
+----------------+------+--------+
|              1 | Abe  |    460 |
|              2 | Bob  |   2400 |
|              7 | Dan  |    720 |
|              8 | Ken  |   1800 |
+----------------+------+--------+
```


```{sql}
CREATE DATABASE Starbucks;
CREATE TABLE Starbucks.Starbucks_Employees (
    ID int,
    Name varchar(255),
    Age int,
    HourlyRate int,
    StoreID int
);
INSERT INTO Starbucks.Starbucks_Employees (ID,Name,Age, HourlyRate,StoreID)
  VALUES ('1',	'Abe',	'61',	'14',	'10'),
  ('2',	'Bob',	'34',	'10',	'30'),
  ('5',	'Chris',	'34',	'9',	'40'),
  ('7',	'Dan',	'41',	'11',	'50'),
  ('8',	'Ken',	'57',	'11',	'60'),
  ('11',	'Joe',	'38',	'13',	'70');

CREATE TABLE Starbucks.Starbucks_Stores ( store_id int, city varchar(255) );
INSERT INTO Starbucks.Starbucks_Stores ( store_id, city)
  VALUES ('10', 'San Francisco'),
  ('20', 'Los Angeles'),
  ('30', 'San Francisco'),
  ('40', 'Los Angeles'),
  ('50', 'San Francisco'),
  ('60', 'New York'),
  ('70','San Francisco');

# return the count of employees in a given city and max hourly rate
SELECT count(*) as num_employees,
MAX(HourlyRate), city 
FROM Starbucks.Starbucks_Employees 
JOIN Starbucks.Starbucks_Stores 
ON Starbucks_Employees.StoreID = Starbucks_Stores.store_id 
GROUP BY city;
+---------------+-----------------+---------------+
| num_employees | MAX(HourlyRate) | city          |
+---------------+-----------------+---------------+
|             1 |               9 | Los Angeles   |
|             1 |              11 | New York      |
|             4 |              14 | San Francisco |
+---------------+-----------------+---------------+

# Return the number of rows in each group created 
# by the unique combination of the HourlyRate and city columns
SELECT count(*) as num_employees, HourlyRate, city 
FROM Starbucks.Starbucks_Employees 
JOIN Starbucks.Starbucks_Stores 
ON Starbucks_Employees.StoreID = Starbucks_Stores.store_id 
GROUP BY city, HourlyRate;
+---------------+------------+---------------+
| num_employees | HourlyRate | city          |
+---------------+------------+---------------+
|             1 |          9 | Los Angeles   |
|             1 |         11 | New York      |
|             1 |         10 | San Francisco |
|             1 |         11 | San Francisco |
|             1 |         13 | San Francisco |
|             1 |         14 | San Francisco |
+---------------+------------+---------------+

SELECT city, count(*) as stores  FROM Starbucks.Starbucks_Stores GROUP BY city; 
+---------------+--------+
| city          | stores |
+---------------+--------+
| Los Angeles   |      2 |
| New York      |      1 |
| San Francisco |      4 |
+---------------+--------+

```

```{r eval=FALSE}

# Common SQL Commands

# SELECT - extracts data from a database
# UPDATE - updates data in a database
# DELETE - deletes data from a database
# INSERT INTO - inserts new data into a database
# CREATE DATABASE - creates a new database
# ALTER DATABASE - modifies a database
# CREATE TABLE - creates a new table
# ALTER TABLE - modifies a table
# DROP TABLE - deletes a table
# CREATE INDEX - creates an index (search key)
# DROP INDEX - deletes an index

# Note: The Northwind database is the Iris (R) dataset for SQL.
# Note: Case of SQL commands does not matter.
# Note: Semicolon is used to end an SQL statement.


# SELECT Syntax
# SELECT column1, column2, ...
# FROM table_name;
# e.g.
SELECT * FROM Customers


# DISTINCT Syntax
# SELECT DISTINCT column1, column2, ...
# FROM table_name;
# e.g.
SELECT DISTINCT Country FROM Customers;
# Country
# Germany
# Mexico
# UK
SELECT COUNT(DISTINCT Country) FROM Customers;
# 21


# WHERE Syntax
# SELECT column1, column2, ...
# FROM table_name
# WHERE condition;
# Note: The WHERE clause can also used in UPDATE, DELETE statement, etc..
# e.g.
SELECT * FROM Customers
WHERE Country='Ireland';
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 37	Hungry Owl All-Night Grocers	Patricia McKenna	8 Johnstown Road	Cork		Ireland

# Operator Description
# =	Equal
# <>	Not equal. Note: In some versions of SQL this operator may be written as !=
# >	Greater than
# <	Less than
# >=	Greater than or equal
# <=	Less than or equal
# BETWEEN	Between an inclusive range
# LIKE	Search for a pattern
# IN	To specify multiple possible values for a column


# AND, OR, NOT, IS NULL, IS NOT NULL Syntax
# SELECT column1, column2, ...
# FROM table_name
# WHERE condition1 AND condition2 AND condition3 ...;
## WHERE condition1 OR condition2 OR condition3 ...;
### WHERE NOT condition;
#### WHERE column1 IS NULL;
##### WHERE column2 IS NOT NULL;
# e.g.
SELECT * FROM Customers
WHERE Country='France' AND (City='Lyon' OR City='Paris');
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 57	Paris spécialités	Marie Bertrand	265, boulevard Charonne	Paris	75012	France
# 74	Spécialités du monde	Dominique Perrier	25, rue Lauriston	Paris	75016	France
# 84	Victuailles en stock	Mary Saveley	2, rue du Commerce	Lyon	69004	France
# e.g.
SELECT COUNT(*) AS Not_North_America FROM Customers
WHERE NOT Country='Canada' AND NOT Country='USA' AND NOT Country='Mexico';
# Not_North_America
# 70

# ORDER BY Keyword Syntax
# SELECT column1, column2, ...
# FROM table_name
# ORDER BY column1, column2, ... ASC|DESC;
SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 64	Rancho grande	Sergio Gutiérrez	Av. del Libertador 900	Buenos Aires	1010	Argentina
# 54	Océano Atlántico Ltda.	Yvonne Moncada	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	1010	Argentina
# 12	Cactus Comidas para llevar	Patricio Simpson	Cerrito 333	Buenos Aires	1010	Argentina


# INSERT INTO Syntax
# INSERT INTO table_name (column1, column2, column3, ...)
# VALUES (value1, value2, value3, ...);
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('DJ Jedi Jeff', 'Jeffrey Long', '42 Castro St', 'San Francisco', '94114', 'USA');


# UPDATE Syntax
# UPDATE table_name
# SET column1 = value1, column2 = value2, ...
# WHERE condition;
# Note: If you omit the WHERE clause, all records in the table will be updated!
UPDATE Customers
SET CustomerName= 'Daniele Lasher', ContactName = 'Jeffrey Long', Address= NULL, City= 'San Francisco', PostalCode= '94114', Country= 'USA'
WHERE CustomerID = 1;
SELECT * FROM Customers
WHERE CustomerID=1;
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 1	Daniele Lasher	Jeffrey Long	null	San Francisco	94114	USA
SELECT * FROM Customers
WHERE Address IS NULL;
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 1	Daniele Lasher	Jeffrey Long	null	San Francisco	94114	USA


# DELETE Syntax
# DELETE FROM table_name
# WHERE condition;
# Note: If you omit the WHERE clause, all records in the table will be deleted!
DELETE FROM Customers
WHERE ContactName='Jeffrey Long' AND Address IS NULL;


# SELECT TOP Syntax
# Note: Not all database systems support the SELECT TOP clause. 
# MySQL supports the LIMIT clause to select a limited number of records
SELECT Amount
FROM salespersonOrdersDB.Orders
WHERE Amount > 50
LIMIT 2;
+--------+
| Amount |
+--------+
|    540 |
|   1800 |
+--------+


# MIN, MAX Syntax
# SELECT MIN(column_name)
# FROM table_name
# WHERE condition;
SELECT MAX(Price) AS LargestPrice
FROM Products; 


# COUNT, AVG, SUM Syntax
# SELECT COUNT|AVG|SUM(column_name)
# FROM table_name
# WHERE condition;
SELECT AVG(Price)
FROM Products;
# AVG(Price)
# 28.866363636363637


# LIKE Syntax
# SELECT column1, column2, ...
# FROM table_name
# WHERE columnN LIKE pattern;
% - The percent sign represents zero, one, or multiple characters
_ - The underscore represents a single character
# Note: combine any number of conditions using AND or OR operators.
# LIKE Operator	Description
WHERE CustomerName LIKE 'j%'	# Finds any values that start with "j"
WHERE CustomerName LIKE '%j'	# Finds any values that end with "j"
WHERE CustomerName LIKE '%ef%'	# Finds any values that have "ef" in any position
WHERE CustomerName LIKE '_e%'	# Finds any values that have "e" in the second position
WHERE CustomerName LIKE 'j_%_%'	# Finds any values that start with "j" and are at least 3 characters in length
WHERE ContactName LIKE 'j%g'	# Finds any values that start with "j" and ends with "g"
# Finding myself
SELECT *
FROM Customers
WHERE ContactName LIKE 'je%f%f_e% %L_%ng';
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 92	DJ Jedi Jeff	Jeffrey Long	42 Castro St	San Francisco	94114	USA
SELECT * FROM salespersonOrdersDB.Salesperson WHERE Name LIKE 'A%';
+----+------+------+--------+
| ID | Name | Age  | Salary |
+----+------+------+--------+
|  1 | Abe  |   61 | 140000 |
+----+------+------+--------+


# IN Syntax
# SELECT column_name(s)
# FROM table_name
# WHERE column_name IN (value1, value2, ...);
# Note: IN is shorthand for multiple OR conditions.
# Or
# SELECT column_name(s)
# FROM table_name
# WHERE column_name IN (SELECT STATEMENT);
SELECT * FROM Products WHERE ProductID IN (SELECT ProductID FROM OrderDetails WHERE Quantity > 89);
# ProductID	ProductName	SupplierID	CategoryID	Unit	Price
# 35	Steeleye Stout	16	1	24 - 12 oz bottles	18
# 55	Pâté chinois	25	6	24 boxes x 2 pies	24
# 61	Sirop d'érable	29	2	24 - 500 ml bottles	28.5
SELECT * FROM OrderDetails WHERE Quantity > 89;
# OrderDetailID	OrderID	ProductID	Quantity
# 103	10286	35	100
# 401	10398	55	120
# 512	10440	61	


# BETWEEN, NOT BETWEEN Syntax
# SELECT column_name(s)
# FROM table_name
# WHERE column_name BETWEEN value1 AND value2;
SELECT * FROM Products WHERE Price BETWEEN 10 AND 12;
ProductID	ProductName	SupplierID	CategoryID	Unit	Price
# 3	Aniseed Syrup	1	2	12 - 550 ml bottles	10
# 21	Sir Rodney's Scones	8	3	24 pkgs. x 4 pieces	10
# 46	Spegesild	21	8	4 - 450 g glasses	12
# 74	Longlife Tofu	4	7	5 kg pkg.	10
SELECT * FROM Products
WHERE (Price BETWEEN 10 AND 20)
AND NOT CategoryID IN (1,2,3,7,8);
# ProductID	ProductName	SupplierID	CategoryID	Unit	Price
# 31	Gorgonzola Telino	14	4	12 - 100 g pkgs	12.5
# 42	Singaporean Hokkien Fried Mee	20	5	32 - 1 kg pkgs.	14
# 57	Ravioli Angelo	26	5	24 - 250 g pkgs.	19.5
SELECT * FROM Products
WHERE ProductName BETWEEN 'Chartreuse verte' AND 'Chef Anton_s Gumbo Mix'
ORDER BY ProductName;
# ProductID	ProductName	SupplierID	CategoryID	Unit	Price
# 39	Chartreuse verte	18	1	750 cc per bottle	18
# 4	Chef Anton's Cajun Seasoning	2	2	48 - 6 oz jars	22
# 5	Chef Anton's Gumbo Mix	2	2	36 boxes	21.35
SELECT * FROM Orders
WHERE OrderDate BETWEEN #07-04-1996# AND #07-09-1996#;
# OrderID	CustomerID	EmployeeID	OrderDate	ShipperID
# 10248 	90 	5 	7/4/1996 	3 
# 10249 	81 	6 	7/5/1996 	1 
# 10250 	34 	4 	7/8/1996 	2 


# Alias Syntax
# SELECT column_name AS alias_name
# FROM table_name;
# Note: Alias is a temp name for a column or table, only lasts for duration of query.
SELECT TOP 2 CustomerName AS [Customer Name], Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;
# Customer Name	Address
# Alfreds Futterkiste 	Obere Str. 57, 12209 Berlin, Germany 
# Ana Trujillo Emparedados y helados 	Avda. de la Constitución 2222, 05021 México D.F., Mexico 
SELECT CustomerName AS [Customer Name], Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers
WHERE CustomerName BETWEEN 'Al%' AND 'Ao%';
# Customer Name	Address
# Alfreds Futterkiste 	Obere Str. 57, 12209 Berlin, Germany 
# Ana Trujillo Emparedados y helados 	Avda. de la Constitución 2222, 05021 México D.F., Mexico 
# Antonio Moreno Taquería 	Mataderos 2312, 05023 México D.F., Mexico 
SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;
# OrderID	OrderDate	CustomerName
# 10355	1996-11-15	Around the Horn
# 10383	1996-12-16	Around the Horn

# Joins Diagram
# https://www.w3schools.com/sql/sql_join.asp


# Inner Join Syntax
# SELECT column_name(s)
# FROM table1
# INNER JOIN table2 ON table1.column_name = table2.column_name;
# Note: The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns.
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
# OrderID	CustomerName	ShipperName
# 10248	Wilman Kala	Federal Shipping
# 10249	Tradição Hipermercados	Speedy Express
# 10250	Hanari Carnes	United Package
# 10251	Victuailles en stock	Speedy Express
# 10252	Suprêmes délices	United Package
# 10253	Hanari Carnes	United Package


# Left Join Syntax
# SELECT column_name(s)
# FROM table1
# LEFT JOIN table2 ON table1.column_name = table2.column_name;
# Note: The LEFT JOIN keyword returns all records from the left table (table1), and the matched records from the right table (table2).
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;
# CustomerName	OrderID
# Ana Trujillo Emparedados y helados	10308
# Antonio Moreno Taquería	10365
# Around the Horn	10355
# Around the Horn	10383
# B's Beverages	10289
# Berglunds snabbköp	10278
# Berglunds snabbköp	10280
# Berglunds snabbköp	10384
# Blauer See Delikatessen	null
# Blondel père et fils	10265
# Blondel père et fils	10297
mysql> SELECT * FROM salespersonOrdersDB.Salesperson AS s LEFT JOIN salespersonOrdersDB.Orders AS o ON s.ID = o.salesperson_id;
+----+-------+------+--------+--------+------------+---------+----------------+--------+
| ID | Name  | Age  | Salary | Number | order_date | cust_id | salesperson_id | Amount |
+----+-------+------+--------+--------+------------+---------+----------------+--------+
|  2 | Bob   |   34 |  44000 |     10 | 1996-08-02 |       4 |              2 |    540 |
|  8 | Ken   |   57 | 115000 |     20 | 1999-01-30 |       4 |              8 |   1800 |
|  1 | Abe   |   61 | 140000 |     30 | 1995-07-14 |       9 |              1 |    460 |
|  2 | Bob   |   34 |  44000 |     40 | 1998-01-29 |       7 |              2 |   2400 |
|  7 | Dan   |   41 |  52000 |     50 | 1998-02-03 |       6 |              7 |    600 |
|  7 | Dan   |   41 |  52000 |     60 | 1998-03-02 |       6 |              7 |    720 |
|  7 | Dan   |   41 |  52000 |     70 | 1998-05-06 |       9 |              7 |    150 |
|  2 | Bob   |   34 |  44000 |     80 | 1994-02-19 |       7 |              2 |   2400 |
|  5 | Chris |   34 |  40000 |   NULL | NULL       |    NULL |           NULL |   NULL |
| 11 | Joe   |   38 |  38000 |   NULL | NULL       |    NULL |           NULL |   NULL |
| 12 | Jeff  |   45 | 140000 |   NULL | NULL       |    NULL |           NULL |   NULL |
+----+-------+------+--------+--------+------------+---------+----------------+--------+


# Right Join Syntax
# SELECT column_name(s)
# FROM table1
# RIGHT JOIN table2 ON table1.column_name = table2.column_name;
# Note: The RIGHT JOIN keyword returns all records from the right table (table2), and the matched records from the left table (table1).
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;
# OrderID	LastName	FirstName
#  	West 	Adam 
# 10248 	Buchanan 	Steven 
# 10249 	Suyama 	Michael 
# 10250 	Peacock 	Margaret 
# 10251 	Leverling 	Janet 
# 10252 	Peacock 	Margaret 
# 10253 	Leverling 	Janet 


# Full Join Syntax
# SELECT column_name(s)
# FROM table1
# FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;
# Note: The FULL OUTER JOIN keyword returns all the rows from the left table, and all the rows from the right table.
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;


# Self Join Syntax
# SELECT column_name(s)
# FROM table1 T1, table1 T2
# WHERE condition;
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City 
ORDER BY A.City;


# UNION, UNION ALL Syntax
# SELECT column_name(s) FROM table1
# UNION
# SELECT column_name(s) FROM table2;
# Note: UNION operator is used to combine the result-set of two or more SELECT statements.
# Note: Each SELECT statement within UNION must have the same number of columns
# Note: The columns must also have similar data types
# Note: The columns in each SELECT statement must also be in the same order
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;
# Number of Records: 120
SELECT City FROM Customers
ORDER BY City;
# Number of Records: 91
SELECT City FROM Suppliers
ORDER BY City;
# Number of Records: 29
# Note: UNION selects only distinct values. 
# Note: UNION ALL also selects duplicate values.
SELECT City, Country FROM Customers
WHERE Country='Ireland'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='Ireland'
ORDER BY City;
# City	Country
# Cork	Ireland


# Group By Syntax
# SELECT column_name(s)
# FROM table_name
# WHERE condition
# GROUP BY column_name(s)
# ORDER BY column_name(s);
# Note: Used with aggregate functions (e.g. COUNT, MAX, MIN, SUM, AVG) to group the result-set by one or more columns.
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
# COUNT(CustomerID)	Country
# 14	USA
# 11	France
# 10	Germany
# 9	Brazil
SELECT Shippers.ShipperName,COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;
# ShipperName	NumberOfOrders
# Federal Shipping	68
# Speedy Express	54
# United Package	74


# Having Syntax
# SELECT column_name(s)
# FROM table_name
# WHERE condition
# GROUP BY column_name(s)
# HAVING condition
# ORDER BY column_name(s);
# Note: HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions.
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) >= 10
ORDER BY COUNT(CustomerID) DESC;
# COUNT(CustomerID)	Country
# 14	USA
# 11	France
# 10	Germany
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;
# LastName	NumberOfOrders
# Davolio	29


# Exists
# SELECT column_name(s)
# FROM table_name
# WHERE EXISTS
# (SELECT column_name FROM table_name WHERE condition);
# Note: EXISTS operator is used to test for the existence of any record in a subquery.
# Note: The EXISTS operator returns true if the subquery returns one or more records.
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE SupplierId = Suppliers.supplierId AND Price = 22);
# SupplierName
# New Orleans Cajun Delights


# ANY, ALL Syntax
# SELECT column_name(s)
# FROM table_name
# WHERE column_name operator ANY|ALL
# (SELECT column_name FROM table_name WHERE condition);
# Note: The ANY and ALL operators are used with a WHERE or HAVING clause.
# Note: The ANY operator returns true if any of the subquery values meet the condition.
# Note: The ALL operator returns true if all of the subquery values meet the condition.
# Note: The operator must be a standard comparison operator (=, <>, !=, >, >=, <, or <=).
SELECT ProductName
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity > 99);
# ProductName
# Steeleye Stout 
# Pâté chinois 
## Note Broken link: https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all2&ss=-1


# SELECT INTO Syntax
# SELECT *|column1, column2, column3, ...
# INTO newtable [IN externaldb]
# FROM oldtable
# WHERE condition;
SELECT * INTO CustomersBackup2017
FROM Customers;
# Note: Creates a backup of Customers table.
SELECT Customers.CustomerName, Orders.OrderID
INTO CustomersOrderBackup2017
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
# Note: Copies data from more than one table into a new table.


# INSERT INTO SELECT Syntax
# INSERT INTO table2
# SELECT * FROM table1
# WHERE condition;
# # or
# INSERT INTO table2 (column1, column2, column3, ...)
# SELECT column1, column2, column3, ...
# FROM table1
# WHERE condition;
INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers
WHERE Country='Brazil';


# IFNULL(), COALESCE() MySQL Syntax
SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
FROM Products;
# Note: MySQL IFNULL() function returns an alternative value if an expression is NULL
SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
FROM Products


# COMMENTS
# Note: Single line comments start with --.
# Note: Multi-line comments start with /* and end with */.
# Note: To ignore just a part of a statement, also use the /* */ comment.
SELECT * FROM Customers WHERE (CustomerName LIKE 'L%'
OR CustomerName LIKE 'R%' /*OR CustomerName LIKE 'S%'
OR CustomerName LIKE 'T%'*/ OR CustomerName LIKE 'W%')
AND Country='USA'
ORDER BY CustomerName;
# CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
# 43	Lazy K Kountry Store	John Steel	12 Orchestra Terrace	Walla Walla	99362	USA
# 45	Let's Stop N Shop	Jaime Yorres	87 Polk St. Suite 5	San Francisco	94117	USA
# 48	Lonesome Pine Restaurant	Fran Wilson	89 Chiaroscuro Rd.	Portland	97219	USA
# 65	Rattlesnake Canyon Grocery	Paula Wilson	2817 Milton Dr.	Albuquerque	87110	USA
# 89	White Clover Markets	Karl Jablonski	305 - 14th Ave. S. Suite 3B	Seattle	98128	USA

```


