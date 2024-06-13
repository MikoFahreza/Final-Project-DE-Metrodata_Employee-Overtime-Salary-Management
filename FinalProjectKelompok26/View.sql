USE EmployeeOvertimeSalaryManagement;

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

-- View for employee details
IF OBJECT_ID('ViewEmployeeDetails', 'V') IS NOT NULL
    DROP VIEW ViewEmployeeDetails;
GO

CREATE VIEW ViewEmployeeDetails AS
SELECT 
    e.id AS employee_id,
    a.username,
    e.first_name + ' ' + e.last_name AS full_name,
    e.gender,
    e.email,
    e.phone,
    e.hire_date,
    e.salary,
    e.manager AS manager_id,
    m.first_name + ' ' + m.last_name AS manager_name,
    j.title AS job,
    d.name AS department,
    r.name AS role,
    l.city AS location,
    (
        SELECT TOP 1 status 
        FROM job_histories jh 
        WHERE jh.employee_id = e.id 
        ORDER BY jh.end_date DESC, jh.start_date DESC
    ) AS status
FROM 
    employees e
LEFT JOIN 
    accounts a ON e.id = a.id
LEFT JOIN 
    employees m ON e.manager = m.id
LEFT JOIN 
    jobs j ON e.job = j.id
LEFT JOIN 
    departments d ON e.department = d.id
LEFT JOIN 
    locations l ON d.location = l.id
LEFT JOIN 
    account_roles ar ON a.id = ar.account
LEFT JOIN 
    roles r ON ar.role = r.id
WHERE 
    r.id = (
        SELECT TOP 1 ar2.role 
        FROM account_roles ar2 
        WHERE ar2.account = a.id 
        ORDER BY ar2.role DESC
    )
GO

-- View for department details
IF OBJECT_ID('ViewDepartmentDetails', 'V') IS NOT NULL
    DROP VIEW ViewDepartmentDetails;
GO

CREATE VIEW ViewDepartmentDetails AS
SELECT 
    d.id AS department_id,
    d.name AS department_name,
    l.street_address,
    l.postal_code,
    l.city,
    l.state_province,
    c.name AS country,
    r.name AS region_name
FROM 
    departments d
LEFT JOIN 
    locations l ON d.location = l.id
LEFT JOIN 
    countries c ON l.country = c.id
LEFT JOIN 
    regions r ON c.region = r.id;
GO

-- View for account details
IF OBJECT_ID('ViewAccountDetails', 'V') IS NOT NULL
    DROP VIEW ViewAccountDetails;
GO

CREATE VIEW ViewAccountDetails AS
SELECT 
    a.id AS account_id,
    a.username,
    a.password,
    a.otp,
    CASE 
        WHEN a.is_expired < GETDATE() THEN 'true'
        ELSE 'false'
    END AS is_expired,
    CASE 
        WHEN a.is_used = 1 THEN 'true'
        ELSE 'false'
    END AS is_used,
    STUFF((
        SELECT DISTINCT ', ' + r.name
        FROM roles r
        INNER JOIN account_roles ar ON r.id = ar.role
        WHERE ar.account = a.id
        FOR XML PATH('')
    ), 1, 2, '') AS roles,
    STUFF((
        SELECT DISTINCT ', ' + p.name
        FROM permissions p
        INNER JOIN role_permissions rp ON p.id = rp.permission
        INNER JOIN roles r ON rp.role = r.id
        INNER JOIN account_roles ar ON r.id = ar.role
        WHERE ar.account = a.id
        FOR XML PATH('')
    ), 1, 2, '') AS permissions
FROM 
    accounts a;
GO



-- View for role_permissions table
IF OBJECT_ID('ViewRolePermissions', 'V') IS NOT NULL
    DROP VIEW ViewRolePermissions;
GO

CREATE VIEW ViewRolePermissions AS
SELECT 
    id,
    role,
    permission
FROM role_permissions;
GO

-- View for account_roles table
IF OBJECT_ID('ViewAccountRoles', 'V') IS NOT NULL
    DROP VIEW ViewAccountRoles;
GO

CREATE VIEW ViewAccountRoles AS
SELECT 
    id,
    account,
    role
FROM account_roles;
GO

-- View for job_histories table
IF OBJECT_ID('ViewJobHistories', 'V') IS NOT NULL
    DROP VIEW ViewJobHistories;
GO

CREATE VIEW ViewJobHistories AS
SELECT 
    employee_id,
    start_date,
    end_date,
    status,
    job,
    department
FROM job_histories;
GO

-- View for employee_overtime table
IF OBJECT_ID('ViewEmployeeOvertime', 'V') IS NOT NULL
    DROP VIEW ViewEmployeeOvertime;
GO

CREATE VIEW ViewEmployeeOvertime AS
SELECT 
    id,
    employee_id,
    job,
    month_year,
    status,
    overtime_count
FROM employee_overtime;
GO

