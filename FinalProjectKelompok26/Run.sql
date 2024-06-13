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
SELECT * FROM ViewDepartmentDetails;
SELECT * FROM ViewAccountDetails;

EXEC DeleteEmployee 7;
GO
TRUNCATE TABLE job_histories
