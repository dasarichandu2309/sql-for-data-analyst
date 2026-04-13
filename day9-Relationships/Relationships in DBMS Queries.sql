-- Create Database
CREATE DATABASE CompanyDB2;
USE CompanyDB2;

-- --------------------------------------
-- ONE-TO-ONE (1:1) Relationship
-- --------------------------------------
CREATE TABLE Employees1to1 (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30)
);

CREATE TABLE ID_Cards (
    CardID INT PRIMARY KEY,
    EmpID INT UNIQUE,
    IssueDate DATE,
    FOREIGN KEY (EmpID) REFERENCES Employees1to1(EmpID)
);

-- Insert Sample Data
INSERT INTO Employees1to1 VALUES
(1, 'John', 'HR'),
(2, 'Mary', 'IT'),
(3, 'Steve', 'Finance');

INSERT INTO ID_Cards VALUES
(101, 1, '2024-05-01'),
(102, 2, '2024-06-15'),
(103, 3, '2024-07-20');

-- --------------------------------------
-- ONE-TO-MANY (1:N) Relationship
-- --------------------------------------
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees1toN (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Insert Sample Data
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

INSERT INTO Employees1toN VALUES
(101, 'John', 1),
(102, 'Alice', 1),
(103, 'Bob', 2),
(104, 'Rita', 3),
(105, 'Steve', 3);

-- --------------------------------------
-- MANY-TO-MANY (M:N) Relationship
-- ----------------------------------------
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

CREATE TABLE StudentCourses (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Sample Data
INSERT INTO Students VALUES
(1, 'John'),
(2, 'Alice'),
(3, 'Bob');

INSERT INTO Courses VALUES
(101, 'Math'),
(102, 'Physics'),
(103, 'Chemistry');

INSERT INTO StudentCourses VALUES
(1, 101),
(1, 102),
(2, 101),
(2, 103),
(3, 102),
(3, 103);

-- ----------------------------------------
-- MANY-TO-ONE (N:1) Relationship
-- (Employees perspective of One-to-Many)
-- ----------------------------------------
-- Reusing Departments and Employees1toN tables
-- Many Employees → One Department
-- Already created and inserted above