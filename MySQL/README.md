# MySQL

* [MySQL](https://www.mysql.com/).
* [MySQL Modeling](http://www.mysql.com/products/workbench/).

## Table of contents
- [Types](#types)
- [Create](#create)
- [Insert](#insert)
- [Delete](#delete)
- [Update](#update)
- [Select](#select)
- [Enum values](#enum-values)
- [Alter](#alter)
- [Indexes](#indexes)
- [Groups](#groups)
- [Joins](#joins)
- [Relations](#relations)
- [Cascade](#cascade)


## Types

```sql
# Numeric Data Types:
TINYINT         # 4 digits
SMALLINT        # 5 digits
MEDIUMINT       # 9 digits
INT             # 11 digits
BIGINT          # 20 digits
FLOAT(M,D)      # 10, 24 digits
DOUBLE(M,D)     # 16, 53 digits
DECIMAL(M,D)    

# Date and Time Types:
DATE            # YYYY-MM-DD
DATETIME        # YYYY-MM-DD HH:MM:SS
TIMESTAMP       # YYYYMMDDHHMMSS
TIME            # HH:MM:SS 
YEAR(M).        # year in 2-digit or 4-digit YEAR(2) YEAR(4)

# String Types:
CHAR(M)                     # fixed length 1-255 character
VARCHAR(M)                  # variable length 1-255 character
BLOB or TEXT                # variable length 1-65535 character
TINYBLOB or TINYTEXT        # variable length 1-255 character
MEDIUMBLOB or MEDIUMTEXT    # variable length 1-16777215 character
LONGBLOB or LONGTEXT        # variable length 1-4294967295 character
ENUM('A', 'B', 'C')         # values declared(1,2,..) or NULL
```

## Create
```sql
CREATE TABLE Users(
    name VARCHAR(128)
    email VARCHAR(128)
)
```

## Insert
```sql
INSERT INTO Users(name, email, ..., n) VALUES ('Nombraco', 'emailaco@mail.com', ..., n)
```

## Delete
```sql
DELETE FROM Users WHERE email='ted@umich.edu'
```

## Update
```sql
UPDATE Users SET name='Charles' WHERE email='csev@umich.edu'
```

## Select
```sql
SELECT * FROM Users
SELECT * FROM Users WHERE email='csev@umich.edu'
```

### Constraints

TODO

#### Primary Key
```sql
CREATE TABLE Orders(
    O_Id int NOT NULL,
    P_Id int,
    PRIMARY KEY (O_Id),
    FOREIGN KEY (P_Id) REFERENCES Persons(P_Id)
)
```

#### Not null
```sql
CREATE TABLE Orders(
    O_Id int NOT NULL,
)
```


## Enum values
```sql
CREATE TABLE shirts (
    name VARCHAR(40),
    size ENUM('x-small', 'small', 'medium', 'large', 'x-large')
);
```

## Alter
```sql
ALTER TABLE table_name
ADD column_name datatype

# Add attribute DateOfBirth to Users
ALTER TABLE Users
ADD DateOfBirth date
```

## Indexes
```sql
CREATE INDEX index_name
ON table_name (column_name)

CREATE INDEX UserLastNameIndex
ON Users (LastName)
```


## Groups
```sql
SELECT * FROM Users ORDER BY email
SELECT * FROM Users ORDER BY name
SELECT * FROM Users ORDER BY email DESC LIMIT 10
SELECT COUNT(*) FROM Users # Count
```

## Joins
From http://www.w3schools.com/sql/sql_join.asp
* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL JOIN

```sql
-- INNER JOIN (INNER JOIN is the same as JOIN)
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name=table2.column_name;

-- LEFT JOIN (some databases call as LEFT OUTER JOIN)
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;

-- RIGHT JOIN (some databases call as RIGHT OUTER JOIN)
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;

-- FULL JOIN
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

## Relations
### One-to-many relation
Put foerign key in the many side.


### Many-to-many relation
Se componen por 2 claves primarias ajenas. Las dos claves juntas se comportan como primaria compuesta.

```sql
CREATE TABLE Member (
    user_id     INTEGER,
    course_id   INTEGER,
    role        INTEGER,
    PRIMARY KEY(user_id, course_id)
)
```

## Cascade
```sql
CREATE TABLE inventory( 
    inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT,
    min_level INT,
    max_level INT,
    CONSTRAINT fk_inv_product_id
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE CASCADE
);
```


## Scripts

```sql
-- Given the following table 'decimals':
-- ** decimals table schema **
--     id
--     number1
--     number2
-- Return a table with two columns (abs, log) where the values in abs are the absolute values of number1 and the values in log are values from number2 in logarithm to base 64.
SELECT 
  ABS(d.number1) as abs,
  LOG(64, d.number2) as log
FROM decimals as d
```

```sql
-- Given the following table 'decimals':
-- ** decimals table schema **
--     id
--     number1
--     number2
-- Return a table with one column (towardzero) where the values are the result of number1 + number2 truncated towards zero.
SELECT 
 TRUNC(d.number1 + d.number2) as towardzero
FROM decimals as d
```

```sql
-- The query should output the following columns:
--     customer_id [int4]
--     email [varchar]
--     payments_count [int]
--     total_amount [float]
-- and has the following requirements:
--     only returns the 10 top customers, ordered by total amount spent from highest to lowest
SELECT
  customer.customer_id,
  customer.email,
  COUNT(payment.payment_id) AS payments_count,
  CAST(SUM(payment.amount) AS float) AS total_amount
FROM customer
JOIN payment
  ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_amount DESC
LIMIT 10
```