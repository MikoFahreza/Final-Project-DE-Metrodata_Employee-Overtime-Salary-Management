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
EXEC InsertLocation '456 Elm St', '67890', 'Rio de Janeiro', '', 2;
EXEC InsertLocation '789 Oak St', '54321', 'Berlin', '', 3;
EXEC InsertLocation '101 Pine St', '09876', 'Beijing', '', 4;
EXEC InsertLocation '202 Maple St', '11223', 'Cape Town', '', 5;
EXEC InsertLocation '303 Cedar St', '44556', 'Sydney', '', 6;
EXEC InsertLocation '404 Birch St', '77889', 'Moscow', '', 7;
EXEC InsertLocation '505 Walnut St', '99001', 'Riyadh', '', 8;
EXEC InsertLocation '606 Cherry St', '22334', 'Mexico City', '', 9;
EXEC InsertLocation '707 Ash St', '55667', 'Kingston', '', 10;
GO

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

-- Insert 10 rows into job_histories table
EXEC InsertJobHistory 1, '2021-01-01', '2022-01-01', 'Active', 'J001', 1;
EXEC InsertJobHistory 2, '2021-02-01', '2022-02-01', 'Active', 'J002', 2;
EXEC InsertJobHistory 3, '2021-03-01', '2022-03-01', 'Active', 'J003', 3;
EXEC InsertJobHistory 4, '2021-04-01', '2022-04-01', 'Active', 'J004', 4;
EXEC InsertJobHistory 5, '2021-05-01', '2022-05-01', 'Active', 'J005', 5;
EXEC InsertJobHistory 6, '2021-06-01', '2022-06-01', 'Active', 'J006', 6;
EXEC InsertJobHistory 7, '2021-07-01', '2022-07-01', 'Active', 'J007', 7;
EXEC InsertJobHistory 8, '2021-08-01', '2022-08-01', 'Active', 'J008', 8;
EXEC InsertJobHistory 9, '2021-09-01', '2022-09-01', 'Active', 'J009', 9;
EXEC InsertJobHistory 10, '2021-10-01', '2022-10-01', 'Active', 'J010', 10;

-- Insert 10 rows into employee_overtime table
EXEC InsertEmployeeOvertime 1, 'Job1', '2024-01-01', 'Active', 5;
EXEC InsertEmployeeOvertime 2, 'Job2', '2024-02-01', 'Active', 8;
EXEC InsertEmployeeOvertime 3, 'Job3', '2024-03-01', 'Active', 10;
EXEC InsertEmployeeOvertime 4, 'Job4', '2024-04-01', 'Active', 7;
EXEC InsertEmployeeOvertime 5, 'Job5', '2024-05-01', 'Active', 6;
EXEC InsertEmployeeOvertime 6, 'Job6', '2024-06-01', 'Active', 9;
EXEC InsertEmployeeOvertime 7, 'Job7', '2024-07-01', 'Active', 4;
EXEC InsertEmployeeOvertime 8, 'Job8', '2024-08-01', 'Active', 3;
EXEC InsertEmployeeOvertime 9, 'Job9', '2024-09-01', 'Active', 5;
EXEC InsertEmployeeOvertime 10, 'Job10', '2024-10-01', 'Active', 7;
