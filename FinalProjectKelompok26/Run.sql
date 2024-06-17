USE EmployeeOvertimeSalaryManagement;

SELECT * FROM ViewJobs;
SELECT * FROM ViewRegions;
SELECT * FROM ViewCountries;
SELECT * FROM ViewLocations;
SELECT * FROM ViewDepartments;
SELECT * FROM ViewEmployees;
SELECT * FROM ViewAccounts;
SELECT * FROM ViewPermissions;
SELECT * FROM ViewRoles;
SELECT * FROM ViewRolePermissions;
SELECT * FROM ViewAccountRoles;
SELECT * FROM ViewJobHistories;
SELECT * FROM ViewEmployeeOvertime;
SELECT * FROM ViewEmployeeDetails;
SELECT * FROM ViewJobs;
SELECT * FROM ViewDepartmentDetails;z

EXEC DeleteEmployee 7;
GO


-- Insert 10 rows into employee_overtime table
EXEC InsertEmployeeOvertime 1, '2024-01-01', 5;
EXEC InsertEmployeeOvertime 1, '2024-02-01', 8;
EXEC InsertEmployeeOvertime 3, '2024-03-01', 10;
EXEC InsertEmployeeOvertime 4, '2024-04-01', 7;
EXEC InsertEmployeeOvertime 5, '2024-05-01', 6;
EXEC InsertEmployeeOvertime 6, '2024-06-01', 9;
EXEC InsertEmployeeOvertime 7, '2024-07-01', 4;
EXEC InsertEmployeeOvertime 8, '2024-08-01', 3;
EXEC InsertEmployeeOvertime 9, '2024-09-01', 5;
EXEC InsertEmployeeOvertime 10, '2024-10-01', 7;
GO