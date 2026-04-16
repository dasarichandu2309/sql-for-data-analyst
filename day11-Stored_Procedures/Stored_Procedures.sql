CREATE DATABASE EMPLOYEEDBB;
USE EMPLOYEEDBB;
CREATE TABLE EMPLOYEES(
EMPID INT PRIMARY KEY,
EMPNAME VARCHAR(50),
DEPARTMENT VARCHAR(30),
SALARY DECIMAL(10,2)
); 

INSERT INTO EMPLOYEES VALUES
(101,'A','IT',50000),
(102,'B','HR',40000),
(103,'C','IT',60000),
(104,'D','FINANCE',45000),
(105,'E','IT',55000);

SELECT * FROM EMPLOYEES;

-- CREATE STORED PROCEDURE TO CALCULATE TOTAL SALARY BY DEPARTMENT

DELIMITER //
CREATE PROCEDURE TOTAL_SALARY(IN DEPT_NAME VARCHAR(50)) 
BEGIN
SELECT DEPARTMENT , SUM(SALARY)  AS TOTAL_SALARY
FROM EMPLOYEES
WHERE DEPARTMENT  = DEPT_NAME
GROUP BY DEPARTMENT;
END //
DELIMITER ;

CALL TOTAL_SALARY ('IT');
CALL TOTAL_SALARY('HR');
CALL TOTAL_SALARY('FINANCE');

-- CREATE PROCEDURE TO UPDATE SALARIES OF DEPARTMENT
DELIMITER //
CREATE PROCEDURE UPDATEDEPTSALARIES(
IN DEPT_NAME VARCHAR(50),
IN INCREMENT DECIMAL(10,2)
)
BEGIN 
UPDATE EMPLOYEES
SET SALARY = SALARY + INCREMENT
WHERE DEPARTMENT  = DEPT_NAME;

SELECT EMPID,EMPNAME,DEPARTMENT,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT = DEPT_NAME;
END //
DELIMITER ; 

CALL UPDATEDEPTSALARIES('IT',5000.00);

CREATE DATABASE ORGDB;
USE ORGDB;

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employee (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'HR', 50000, '2020-01-15'),
(2, 'Jane', 'Smith', 'Finance', 60000, '2018-03-12'),
(3, 'Sam', 'Brown', 'IT', 75000, '2019-05-22'),
(4, 'Lucy', 'Jones', 'HR', 53000, '2021-07-11'),
(5, 'Mike', 'Taylor', 'Finance', 65000, '2017-09-23'),
(6, 'Sara', 'Miller', 'IT', 78000, '2018-06-30');

SELECT EmployeeID, FirstName, LastName, Department, Salary,
    ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum
FROM Employee;

-- RANK()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rankk
FROM Employee;

-- DENSE RANK()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DenseRank
FROM Employee;

-- PERCENT RANK()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    PERCENT_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS PercentRank
FROM Employee;

-- NTILE()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    NTILE(4) OVER (PARTITION BY Department ORDER BY Salary DESC) AS Quartile
FROM Employee;

-- LEAD()
SELECT EmployeeID, FirstName, LastName, HireDate, Department, Salary,
    LEAD(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS NextSalary
FROM employee;

-- LAG()
SELECT EmployeeID, FirstName, LastName, HireDate, Department, Salary,
    LAG(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS PrevSalary
FROM Employee;

-- FIRST_VALUE()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    FIRST_VALUE(Salary) OVER (PARTITION BY Department ORDER BY Salary DESC) AS FirstSalary
FROM Employee;

-- LAST_VALUE()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    LAST_VALUE(Salary) OVER (
        PARTITION BY Department ORDER BY Salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS LastSalary
FROM Employee;

-- CUM_DIST()
SELECT EmployeeID, FirstName, LastName, Department, Salary,
    CUME_DIST() OVER (PARTITION BY Department ORDER BY Salary DESC) AS CumeDist
FROM Employee;

-- BULIT IN FUNCRTIONS
-- COALLESCE()
SELECT EmployeeID, FirstName, COALESCE(Salary, 0) AS SalaryOrZero FROM Employee;

-- NULLIF()
SELECT EmployeeID, FirstName, NULLIF(Salary, 60000) AS SalaryNullified FROM Employee;

-- CAST()
SELECT CAST('100' AS UNSIGNED);

SELECT CAST(10 AS DECIMAL(5,2));

SELECT CONVERT(NOW() , CHAR);

SELECT EmployeeID, FirstName,
    CAST(Salary AS CHAR) AS SalaryAsString,
    CONVERT(Salary, CHAR) AS SalaryAsStringConverted
FROM Employee;

-- IFNULL()
SELECT EmployeeID, FirstName, IFNULL(Salary, 0) AS SalaryIfNull FROM Employee;

-- TRIM(), LTRIM(), RTRIM()

SELECT TRIM('   HELLO     ');
SELECT LTRIM('    HELLO    ');
SELECT RTRIM('   HELLO    ');
SELECT EmployeeID,
    TRIM(FirstName) AS Trimmed,
    LTRIM(FirstName) AS LeftTrimmed,
    RTRIM(FirstName) AS RightTrimmed
FROM Employee;

-- GREATEST(),LEAST()
SELECT GREATEST(10,25,3,30);
SELECT LEAST(10,25,3,30);
SELECT EmployeeID, FirstName,
    GREATEST(Salary, 60000) AS GreatestSalary,
    LEAST(Salary, 60000) AS LeastSalary
FROM Employee;

-- GROUP_CONCAT()
SELECT Department, GROUP_CONCAT(FirstName) AS EmployeesInDepartment
FROM Employee
GROUP BY Department;





