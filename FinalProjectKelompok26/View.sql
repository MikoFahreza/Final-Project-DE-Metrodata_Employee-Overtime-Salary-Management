-- View for jobs table
IF OBJECT_ID('ViewJobs', 'V') IS NOT NULL
    DROP VIEW ViewJobs;
GO

CREATE VIEW ViewJobs AS
SELECT 
    id,
    title,
    min_salary,
    max_salary,
    default_salary
FROM jobs;
GO

-- View for regions table
IF OBJECT_ID('ViewRegions', 'V') IS NOT NULL
    DROP VIEW ViewRegions;
GO

CREATE VIEW ViewRegions AS
SELECT 
    id,
    name
FROM regions;
GO

-- View for countries table
IF OBJECT_ID('ViewCountries', 'V') IS NOT NULL
    DROP VIEW ViewCountries;
GO

CREATE VIEW ViewCountries AS
SELECT 
    id,
    name,
    region
FROM countries;
GO

-- View for locations table
IF OBJECT_ID('ViewLocations', 'V') IS NOT NULL
    DROP VIEW ViewLocations;
GO

CREATE VIEW ViewLocations AS
SELECT 
    id,
    street_address,
    postal_code,
    city,
    state_province,
    country
FROM locations;
GO

-- View for departments table
IF OBJECT_ID('ViewDepartments', 'V') IS NOT NULL
    DROP VIEW ViewDepartments;
GO

CREATE VIEW ViewDepartments AS
SELECT 
    id,
    name,
    location
FROM departments;
GO

-- View for employees table
IF OBJECT_ID('ViewEmployees', 'V') IS NOT NULL
    DROP VIEW ViewEmployees;
GO

CREATE VIEW ViewEmployees AS
SELECT 
    id,
    first_name,
    last_name,
    gender,
    email,
    phone,
    hire_date,
    salary,
    manager,
    job,
    department
FROM employees;
GO

-- View for accounts table
IF OBJECT_ID('ViewAccounts', 'V') IS NOT NULL
    DROP VIEW ViewAccounts;
GO

CREATE VIEW ViewAccounts AS
SELECT 
    id,
    username,
    password,
    otp,
    is_used,
    is_expired
FROM accounts;
GO

-- View for permissions table
IF OBJECT_ID('ViewPermissions', 'V') IS NOT NULL
    DROP VIEW ViewPermissions;
GO

CREATE VIEW ViewPermissions AS
SELECT 
    id,
    name
FROM permissions;
GO

-- View for roles table
IF OBJECT_ID('ViewRoles', 'V') IS NOT NULL
    DROP VIEW ViewRoles;
GO

CREATE VIEW ViewRoles AS
SELECT 
    id,
    name
FROM roles;
GO
