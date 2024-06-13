USE EmployeeOvertimeSalaryManagement;

--Insert 10 rows into jobs
EXEC InsertJob 'J1', 'Manager', 5000, 10000, 7000;
EXEC InsertJob 'J2', 'Developer', 4000, 9000, 6000;
EXEC InsertJob 'J3', 'Designer', 3000, 8000, 5000;
EXEC InsertJob 'J4', 'Tester', 2000, 7000, 4000;
EXEC InsertJob 'J5', 'Analyst', 4500, 9500, 6500;
EXEC InsertJob 'J6', 'Admin', 3500, 7500, 5500;
EXEC InsertJob 'J7', 'HR', 3200, 7200, 5200;
EXEC InsertJob 'J8', 'Support', 2500, 6500, 4500;
EXEC InsertJob 'J9', 'Sales', 3000, 7000, 5000;
EXEC InsertJob 'J10', 'Consultant', 4000, 9000, 6000;
GO

-- Insert 10 rows into regions
EXEC InsertRegion 'North America';
EXEC InsertRegion 'South America';
EXEC InsertRegion 'Europe';
EXEC InsertRegion 'Asia';
EXEC InsertRegion 'Africa';
EXEC InsertRegion 'Australia';
EXEC InsertRegion 'Antarctica';
EXEC InsertRegion 'Middle East';
EXEC InsertRegion 'Central America';
EXEC InsertRegion 'Caribbean';
GO

-- Insert 10 rows into countries
EXEC InsertCountry 'USA', 1;
EXEC InsertCountry 'Brazil', 2;
EXEC InsertCountry 'Germany', 3;
EXEC InsertCountry 'China', 4;
EXEC InsertCountry 'South Africa', 5;
EXEC InsertCountry 'Australia', 6;
EXEC InsertCountry 'Russia', 7;
EXEC InsertCountry 'Saudi Arabia', 8;
EXEC InsertCountry 'Mexico', 9;
EXEC InsertCountry 'Jamaica', 10;
GO

-- Insert 10 rows into locations
EXEC InsertLocation '123 Main St', '12345', 'New York', 'NY', 1;
EXEC InsertLocation '456 Elm St', '23456', 'Los Angeles', 'CA', 1;
EXEC InsertLocation '789 Oak St', '34567', 'Chicago', 'IL', 1;
EXEC InsertLocation '101 Pine St', '45678', 'Houston', 'TX', 1;
EXEC InsertLocation '202 Maple St', '56789', 'Phoenix', 'AZ', 1;
EXEC InsertLocation '303 Cedar St', '67890', 'Philadelphia', 'PA', 1;
EXEC InsertLocation '404 Walnut St', '78901', 'San Antonio', 'TX', 1;
EXEC InsertLocation '505 Birch St', '89012', 'San Diego', 'CA', 1;
EXEC InsertLocation '606 Pine St', '90123', 'Dallas', 'TX', 1;
EXEC InsertLocation '707 Oak St', '01234', 'San Jose', 'CA', 1;

-- Insert 10 rows into departments
EXEC InsertDepartment 'HR', 1;
EXEC InsertDepartment 'IT', 2;
EXEC InsertDepartment 'Finance', 3;
EXEC InsertDepartment 'Marketing', 4;
EXEC InsertDepartment 'Sales', 5;
EXEC InsertDepartment 'Operations', 6;
EXEC InsertDepartment 'Legal', 7;
EXEC InsertDepartment 'R&D', 8;
EXEC InsertDepartment 'Admin', 9;
EXEC InsertDepartment 'Support', 10;
GO

-- Insert 10 rows into employees
EXEC InsertEmployee 'John', 'Doe', 'male', 'john.doe@example.com', '1234567890', '2020-01-01', 6000, NULL, 'J1', 1;
EXEC InsertEmployee 'Jane', 'Doe', 'female', 'jane.doe@example.com', '2345678901', '2020-02-01', 7000, 1, 'J2', 2;
EXEC InsertEmployee 'Jim', 'Beam', 'male', 'jim.beam@example.com', '3456789012', '2020-03-01', 8000, 2, 'J3', 3;
EXEC InsertEmployee 'Jack', 'Daniels', 'male', 'jack.daniels@example.com', '4567890123', '2020-04-01', 5000, 3, 'J4', 4;
EXEC InsertEmployee 'Johnny', 'Walker', 'male', 'johnny.walker@example.com', '5678901234', '2020-05-01', 9000, 4, 'J5', 5;
EXEC InsertEmployee 'Jill', 'Valentine', 'female', 'jill.valentine@example.com', '6789012345', '2020-06-01', 6500, 5, 'J6', 6;
EXEC InsertEmployee 'Chris', 'Redfield', 'male', 'chris.redfield@example.com', '7890123456', '2020-07-01', 7000, 6, 'J7', 7;
EXEC InsertEmployee 'Claire', 'Redfield', 'female', 'claire.redfield@example.com', '8901234567', '2020-08-01', 6000, 7, 'J8', 8;
EXEC InsertEmployee 'Leon', 'Kennedy', 'male', 'leon.kennedy@example.com', '9012345678', '2020-09-01', 5500, 8, 'J9', 9;
EXEC InsertEmployee 'Ada', 'Wong', 'female', 'ada.wong@example.com', '0123456789', '2020-10-01', 6000, 9, 'J10', 10;
GO

-- Insert 10 rows into accounts table
EXEC InsertAccount 'jdoe', 'password1', 123456, '2024-01-01';
EXEC InsertAccount 'jsmith', 'password2', 234567, '2024-01-01';
EXEC InsertAccount 'ajohnson', 'password3', 345678, '2024-01-01';
EXEC InsertAccount 'bbrown', 'password4', 456789, '2024-01-01';
EXEC InsertAccount 'cdavis', 'password5', 567890, '2024-01-01';
EXEC InsertAccount 'dmiller', 'password6', 678901, '2024-01-01';
EXEC InsertAccount 'ewilson', 'password7', 789012, '2024-01-01';
EXEC InsertAccount 'ftaylor', 'password8', 890123, '2024-01-01';
EXEC InsertAccount 'ganderson', 'password9', 901234, '2024-01-01';
EXEC InsertAccount 'hthomas', 'password10', 123450, '2024-01-01';
GO

-- Insert 10 rows into permissions table
EXEC InsertPermission 'Read';
EXEC InsertPermission 'Write';
EXEC InsertPermission 'Execute';
EXEC InsertPermission 'Delete';
EXEC InsertPermission 'Create';
EXEC InsertPermission 'Update';
EXEC InsertPermission 'Manage';
EXEC InsertPermission 'Admin';
EXEC InsertPermission 'User';
EXEC InsertPermission 'Guest';
GO

-- Insert 10 rows into roles table
EXEC InsertRole 'Admin';
EXEC InsertRole 'User';
EXEC InsertRole 'Manager';
EXEC InsertRole 'HR';
EXEC InsertRole 'IT';
EXEC InsertRole 'Sales';
EXEC InsertRole 'Marketing';
EXEC InsertRole 'Finance';
EXEC InsertRole 'Support';
EXEC InsertRole 'Guest';
GO

-- Insert 10 rows into role_permissions table
EXEC InsertRolePermission 1, 1;
EXEC InsertRolePermission 1, 2;
EXEC InsertRolePermission 2, 1;
EXEC InsertRolePermission 3, 3;
EXEC InsertRolePermission 4, 4;
EXEC InsertRolePermission 5, 5;
EXEC InsertRolePermission 6, 6;
EXEC InsertRolePermission 7, 7;
EXEC InsertRolePermission 8, 8;
EXEC InsertRolePermission 9, 9;
GO

-- Insert 10 rows into account_roles table
EXEC InsertAccountRole 1, 1;
EXEC InsertAccountRole 2, 2;
EXEC InsertAccountRole 3, 3;
EXEC InsertAccountRole 4, 4;
EXEC InsertAccountRole 5, 5;
EXEC InsertAccountRole 6, 6;
EXEC InsertAccountRole 7, 7;
EXEC InsertAccountRole 8, 8;
EXEC InsertAccountRole 9, 9;
EXEC InsertAccountRole 10, 10;
GO


-- Insert 10 rows into employee_overtime table
EXEC InsertEmployeeOvertime 1, 'J1', '2024-01-01', 'Active', 5;
EXEC InsertEmployeeOvertime 2, 'J2', '2024-02-01', 'Active', 8;
EXEC InsertEmployeeOvertime 3, 'J3', '2024-03-01', 'Active', 10;
EXEC InsertEmployeeOvertime 4, 'J4', '2024-04-01', 'Active', 7;
EXEC InsertEmployeeOvertime 5, 'J5', '2024-05-01', 'Active', 6;
EXEC InsertEmployeeOvertime 6, 'J6', '2024-06-01', 'Active', 9;
EXEC InsertEmployeeOvertime 7, 'J7', '2024-07-01', 'Active', 4;
EXEC InsertEmployeeOvertime 8, 'J8', '2024-08-01', 'Active', 3;
EXEC InsertEmployeeOvertime 9, 'J9', '2024-09-01', 'Active', 5;
EXEC InsertEmployeeOvertime 10, 'J10', '2024-10-01', 'Active', 7;
