-- Task 3:

-- Use a database

USE BigM_s5210032_s5204340;

-- I. List of names of all employee sorted by their hourly salary.

SELECT CONCAT (Emp_FName,' ',Emp_LName) AS 'Employee Name', CONCAT ('$', Emp_HourlySalary) AS 'Hourly Salary' from EMPLOYEE
    ORDER BY Emp_HourlySalary ASC;

-- II. The date on which the most recent customer order has been made.

SELECT CONCAT (CUSTOMER.Cust_FName,' ', CUSTOMER.Cust_LName) AS 'Customer Name', CUSTOMERORDER.CustOrd_Date AS 'Date'
    FROM CUSTOMER, CUSTOMERORDER WHERE CUSTOMER.Cust_Number = CUSTOMERORDER.Cust_Number
    ORDER BY CustOrd_Date DESC LIMIT 0,1;

-- III. List all the store names and their manager names, sorted in dictionary-order of the store name.

SELECT STORE.Str_Name AS 'Store Name', CONCAT (EMPLOYEE.Emp_FName, ' ', EMPLOYEE.Emp_LName) AS 'Manager Name' FROM STORE, EMPLOYEE
    WHERE STORE.StoreManagerID = EMPLOYEE.Emp_ID ORDER BY Str_Name ASC;

-- IV. List all customers that have not placed an order yet.

SELECT CUSTOMER.Cust_Number AS 'Customer Number', CONCAT (CUSTOMER.Cust_FName, ' ', CUSTOMER.Cust_LName) AS 'Customer Name'
    FROM CUSTOMER
    LEFT JOIN CUSTOMERORDER
    ON CUSTOMER.Cust_Number = CUSTOMERORDER.Cust_Number 
    WHERE CUSTOMER.Cust_Number NOT IN (SELECT CUSTOMERORDER.Cust_Number from CUSTOMERORDER);

-- V. A list containing the name of employees, who work as supervisors for 'Sports' departments in various stores.

SELECT S.Str_Name As 'Store Name', CONCAT (Emp_FName,' ',Emp_LName) AS 'Supervisors Of Sports Departments'
    FROM STORE AS S
    JOIN STOREDEPARTMENT AS SD ON S.Str_Num = SD.Str_Num
    JOIN EMPLOYEE AS E ON E.Emp_ID = SD.DeptSupervisorID
    JOIN DEPARTMENT AS D ON D.Dept_ID = SD.Dept_ID
    WHERE D.Dept_Name = 'Sports';

-- VI. A list containing the total quantity on hand for each product regardless of stores

SELECT P.Prod_Num AS 'Product Number', P.Prod_Desc AS 'Description', SUM(I.Inv_QntyOnHand) AS 'Quantity On Hand'
FROM INVENTORY AS I
JOIN PRODUCT AS P ON P.Prod_Num = I.ProductNum
GROUP BY I.ProductNum;


-- VII. A list showing each product sold (picked) on or before May 20, 2018.Show product number, name and quantity sold, sorted by product number and then quntity sold

SELECT P.Prod_Num AS 'Product Number', P.Prod_Desc AS 'Name', SUM(OL.OrdLn_Qnty) AS 'Quantity Sold'
FROM PRODUCT AS P
JOIN ORDERLINE AS OL ON P.Prod_Num = OL.Prod_Num
WHERE OL.OrdLn_DatePicked < '2018-05-20'
GROUP BY P.Prod_Num
ORDER BY P.Prod_Num, OL.OrdLn_Qnty;

-- VIII. A list of porducts (show product number, description and price) whose price is less than or equal to the average product price

SELECT Prod_Num AS 'Product Number', Prod_Desc AS 'Description', CONCAT('$', Prod_Price) AS 'Price'
FROM PRODUCT 
WHERE Prod_Price <= (SELECT AVG(Prod_Price) FROM PRODUCT);

-- IX. Increase each employee's salary by 7.5% and show the updated salary of all employee (name and salary)

SELECT CONCAT(Emp_FName, ' ', Emp_LName) AS 'Employee Name', CONCAT('$', CAST(1.075 * Emp_HourlySalary AS DECIMAL(7,2))) AS 'Salary Increased by 7.5%'
FROM EMPLOYEE;

-- X. Show the pay information (employee name, hours paid, amount paid) of all employees in the most recent pay date

SELECT CONCAT(E.Emp_FName, ' ', E.Emp_LName) AS 'Employee Name', CONCAT ('$', E.Emp_HourlySalary) AS 'Hours paid', CONCAT('$', PA.Pay_amount_gross) AS 'Amount Paid'
FROM EMPLOYEE AS E
JOIN PAYSLIP AS PA ON E.Emp_ID = PA.Emp_ID
WHERE Pay_date = (SELECT MAX(Pay_date) FROM PAYSLIP);

-- XI. Make a list of all "Medium" size Shirts and their price in ascending order of price. Show the product description and price

SELECT Prod_Desc AS 'Product Description', CONCAT('$', Prod_Price) AS 'Price'
FROM PRODUCT
WHERE Prod_Desc LIKE'%Shirt - M'
ORDER BY Prod_Price ASC;

-- XII.A list of supervisors (employee id, name) and all of their subordinates(employees id, name)

SELECT E.Emp_ID AS 'Employee ID', CONCAT(E.Emp_FName, ' ',E.Emp_LName) AS 'Employee Name', SUP.Emp_ID AS 'Supervisor ID', CONCAT(SUP.Emp_FName, ' ',SUP.Emp_LName) AS 'Supervisor Name'
FROM EMPLOYEE AS E
JOIN EMPLOYEE AS SUP ON E.SupvisorID = SUP.Emp_ID;


