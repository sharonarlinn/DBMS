-- Lab Experiment 08: Implementation of Procedure ( insert, update and delete)
-- STUDENT NAME: Sharon Arlin
-- USN: 1RUA24BCA0081
-- SECTION: A

SELECT USER(),
@@hostname AS Host_Name,
  VERSION() AS MySQL_Version,
  NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- Scenario: Employee Management System
-- CREATE AND LOAD THE database DBLab008
-- Write your SQL query below Codespace:
create database DBLab008;
use DBLab008;
-- Task 1: Create the Employee Table
-- Create a table to store information about Employee.
-- Include the following columns:
--   empid INT PRIMARY KEY,
-- empname VARCHAR(50), 
-- age INT,
-- salary DECIMAL(10,2),
-- designation VARCHAR(30),
-- address VARCHAR(100),
-- date_of_join DATE
-- Write your SQL query below Codespace:
CREATE TABLE Employee (
 empid INT PRIMARY KEY,
empname VARCHAR(50),
 age INT,
 salary DECIMAL(10,2),
designation VARCHAR(30),
address VARCHAR(100),
date_of_join DATE
);

-- DESCRIBE THE SCHEMA -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
DESCRIBE Employee;
-- Field Type Null Key Default Extra
-- empid int NO PRI
-- empname varchar(50) YES
-- age int YES
-- salary decimal(10,2) YES
-- designation varchar(30) YES
-- address varchar(100) YES
-- date_of_join date YES

-- insert 10 records to the table
-- Write your SQL query below Codespace:
INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join) VALUES
(1, 'John Doe', 35, 50000.00, 'Manager', '123 Elm Street', '2010-05-10'),
(2, 'Jane Smith', 29, 30000.00, 'Developer', '456 Oak Avenue', '2018-07-23'),
(3, 'Mike Johnson', 42, 55000.00, 'Manager', '789 Pine Road', '2008-01-15'),
(4, 'Emily Davis', 22, 22000.00, 'Intern', '321 Maple Street', '2023-02-01'),
(5, 'Chris Lee', 31, 28000.00, 'Developer', '654 Cedar Lane', '2016-11-12'),
(6, 'Anna Brown', 38, 45000.00, 'Senior Developer', '987 Spruce Court', '2012-03-18'),
(7, 'David Wilson', 45, 60000.00, 'Manager', '135 Birch Blvd', '2005-09-30'),
(8, 'Laura Green', 26, 25000.00, 'Clerk', '246 Walnut Drive', '2019-06-07'),
(9, 'Peter White', 55, 70000.00, 'Director', '369 Aspen Way', '2000-12-21'),
(10, 'Sarah Black', 30, 32000.00, 'Developer', '159 Chestnut Street', '2017-04-14');



-- COPYPASTE OF THE OUTPUT in CSV Format and terminate with ;

-- perform the following procedures on the employee database and copy paste the output in the space provided
-- A. Insert Procedure

-- 1. Write a stored procedure named InsertEmployee to insert a new employee record into the Employee table with all fields as input parameters
DELIMITER $$

CREATE PROCEDURE InsertEmployee(
 IN p_empid INT,
IN p_empname VARCHAR(50),
IN p_age INT,
IN p_salary DECIMAL(10,2),
IN p_designation VARCHAR(30),
IN p_address VARCHAR(100),
IN p_date_of_join DATE
)
BEGIN
INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
END$$

DELIMITER ;

-- 2. Modify the insert procedure to ensure the employee’s age must be between 18 and 60.
      -- If not, display a message: "Invalid age, employee not added."
      DELIMITER $$

CREATE PROCEDURE InsertEmployeeWithAgeCheck(
IN p_empid INT,
IN p_empname VARCHAR(50),
IN p_age INT,
IN p_salary DECIMAL(10,2),
IN p_designation VARCHAR(30),
IN p_address VARCHAR(100),
IN p_date_of_join DATE
)
BEGIN
 IF p_age BETWEEN 18 AND 60 THEN
 INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
 ELSE
 SELECT 'Invalid age, employee not added.' AS Message;
 END IF;
END$$

DELIMITER ;

-- 3. Create a procedure that inserts a new employee record.
          -- If the salary is not provided, assign a default salary of 20000.
          DELIMITER $$

CREATE PROCEDURE InsertEmployeeWithDefaultSalary(
IN p_empid INT,
 IN p_empname VARCHAR(50),
 IN p_age INT,
 IN p_salary DECIMAL(10,2),
 IN p_designation VARCHAR(30),
 IN p_address VARCHAR(100),
 IN p_date_of_join DATE
)
BEGIN
 DECLARE v_salary DECIMAL(10,2);

 IF p_salary IS NULL OR p_salary = 0 THEN
SET v_salary = 20000.00;
 ELSE
SET v_salary = p_salary;
END IF;

INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
VALUES (p_empid, p_empname, p_age, v_salary, p_designation, p_address, p_date_of_join);
END$$

DELIMITER ;

-- 4. Write a procedure that inserts three new employee records in a single procedure using multiple INSERT statements.

-- B.  Update Procedure
DELIMITER $$

-- Update salary by empid
CREATE PROCEDURE UpdateSalary(IN p_empid INT, IN p_salary DECIMAL(10,2))
BEGIN
UPDATE Employee SET salary = p_salary WHERE empid = p_empid;
 SELECT 'Salary updated successfully.' AS Message;
END$$

-- Increase salary by 10% for Managers
CREATE PROCEDURE IncreaseManagerSalary()
BEGIN
 UPDATE Employee SET salary = salary * 1.10 WHERE designation = 'Manager';
SELECT 'Manager salaries increased by 10%.' AS Message;
END$$

-- Update designation by empid
CREATE PROCEDURE UpdateDesignation(IN p_empid INT, IN p_newdesignation VARCHAR(30))
BEGIN
UPDATE Employee SET designation = p_newdesignation WHERE empid = p_empid;
     SELECT 'Designation updated successfully.' AS Message;
END$$

-- Update address by empid
CREATE PROCEDURE UpdateAddress(IN p_empid INT, IN p_newaddress VARCHAR(100))
BEGIN
    UPDATE Employee SET address = p_newaddress WHERE empid = p_empid;
    SELECT 'Address updated successfully.' AS Message;
END$$

-- Conditional salary update if age > 40
CREATE PROCEDURE ConditionalSalaryUpdate(IN p_empid INT, IN p_salary DECIMAL(10,2))
BEGIN
    DECLARE emp_age INT;
    SELECT age INTO emp_age FROM Employee WHERE empid = p_empid;
    IF emp_age > 40 THEN
        UPDATE Employee SET salary = p_salary WHERE empid = p_empid;
        SELECT 'Salary updated successfully.' AS Message;
    ELSE
        SELECT 'Not eligible for salary update.' AS Message;
    END IF;
END$$

DELIMITER ;

/*
Update Salary:
Write a stored procedure named UpdateSalary to update an employee’s salary based on their empid.

Increment Salary by Percentage:
Create a procedure to increase the salary by 10% for all employees whose designation = 'Manager'.

Update Designation:
Write a procedure to update the designation of an employee by empid.
Example: Promote an employee from 'Clerk' to 'Senior Clerk'.

Update Address:
Write a procedure to update the address of an employee when empid is given as input.

Conditional Update (Age Check):
Create a procedure that updates salary only if the employee’s age > 40; otherwise, print "Not eligible for salary update."

*/
-- C. Delete Procedure
DELIMITER $$

-- Delete employee by empid
CREATE PROCEDURE DeleteEmployee(IN p_empid INT)
BEGIN
    DELETE FROM Employee WHERE empid = p_empid;
    SELECT 'Employee deleted successfully.' AS Message;
END$$

-- Delete employees by designation
CREATE PROCEDURE DeleteByDesignation(IN p_designation VARCHAR(30))
BEGIN
    DELETE FROM Employee WHERE designation = p_designation;
    SELECT CONCAT('Employees with designation ', p_designation, ' deleted successfully.') AS Message;
END$$

-- Delete employees with salary < 15000
CREATE PROCEDURE DeleteBySalaryRange()
BEGIN
    DELETE FROM Employee WHERE salary < 15000;
    SELECT 'Employees with salary less than 15000 deleted successfully.' AS Message;
END$$

-- Delete employees who joined before 2015
CREATE PROCEDURE DeleteByJoiningYear()
BEGIN
    DELETE FROM Employee WHERE YEAR(date_of_join) < 2015;
    SELECT 'Employees who joined before 2015 deleted successfully.' AS Message;
END$$

DELIMITER ;

/*


Delete by empid:
Write a stored procedure named DeleteEmployee to delete an employee record using their empid.

Delete by Designation:
Create a procedure that deletes all employees belonging to a specific designation (e.g., 'Intern').

Delete Based on Salary Range:
Write a procedure to delete employees whose salary is less than ₹15000.

Delete by Joining Year:
Write a procedure to delete employees who joined before the year 2015.
*/
-- End of Lab Experiment
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01