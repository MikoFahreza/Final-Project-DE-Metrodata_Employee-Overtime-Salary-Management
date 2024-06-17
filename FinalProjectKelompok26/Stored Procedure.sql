USE EmployeeOvertimeSalaryManagement;
GO

--SP Login
CREATE PROCEDURE sp_login
    @username VARCHAR(25),
    @password VARBINARY(256)
AS
BEGIN
    -- Declare a variable to hold the result of password comparison
    DECLARE @is_valid BIT

    -- Check if the provided username and password match
    SELECT @is_valid = CASE WHEN password = @password THEN 1 ELSE 0 END
    FROM accounts
    WHERE username = @username

    -- If the user is valid, return success, otherwise return failure
    IF @is_valid = 1
    BEGIN
        SELECT 'Login successful' AS Message
    END
    ELSE
    BEGIN
        SELECT 'Login failed' AS Message
    END
END
GO

--SP Forgot Password
CREATE PROCEDURE sp_forgot_password
    @username VARCHAR(25),
    @new_password VARBINARY(256)
AS
BEGIN
    -- Check if the provided username exists
    IF EXISTS (SELECT 1 FROM accounts WHERE username = @username)
    BEGIN
        -- Update the password for the provided username
        UPDATE accounts
        SET password = @new_password
        WHERE username = @username

        SELECT 'Password updated successfully' AS Message
    END
    ELSE
    BEGIN
        SELECT 'Username not found' AS Message
    END
END
GO

--SP Generate OTP
CREATE PROCEDURE sp_generate_otp
    @username VARCHAR(25)
AS
BEGIN
    DECLARE @employee_id INT
    DECLARE @otp INT
    DECLARE @expiry DATETIME

    -- Check if the provided username exists
    IF EXISTS (SELECT 1 FROM accounts WHERE username = @username)
    BEGIN
        -- Get the employee ID associated with the username
        SELECT @employee_id = id FROM employees WHERE email = @username

        -- Generate a random OTP
        SET @otp = ABS(CHECKSUM(NEWID())) % 1000000 -- 6 digit OTP

        -- Set the OTP expiry time (e.g., 10 minutes from now)
        SET @expiry = DATEADD(MINUTE, 10, GETDATE())

        -- Insert or update the OTP details
        IF EXISTS (SELECT 1 FROM accounts WHERE id = @employee_id)
        BEGIN
            UPDATE accounts
            SET otp = @otp, is_used = 0, is_expired = @expiry
            WHERE id = @employee_id
        END
        ELSE
        BEGIN
            INSERT INTO accounts (username, otp, is_used, is_expired)
            VALUES (@username, @otp, 0, @expiry)
        END

        SELECT @otp AS OTP, 'OTP generated successfully' AS Message
    END
    ELSE
    BEGIN
        SELECT 'Username not found' AS Message
    END
END
GO

--SP Verify OTP
CREATE PROCEDURE sp_verify_otp
    @username VARCHAR(25),
    @otp INT
AS
BEGIN
    DECLARE @employee_id INT
    DECLARE @current_time DATETIME

    -- Get the current time
    SET @current_time = GETDATE()

    -- Check if the provided username exists
    IF EXISTS (SELECT 1 FROM accounts a JOIN employees e ON a.id = e.id WHERE e.email = @username)
    BEGIN
        -- Get the employee ID associated with the username
        SELECT @employee_id = e.id 
        FROM accounts a
        JOIN employees e ON a.id = e.id
        WHERE e.email = @username

        -- Validate the OTP
        IF EXISTS (
            SELECT 1 
            FROM accounts 
            WHERE id = @employee_id AND otp = @otp AND is_used = 0 AND is_expired > @current_time
        )
        BEGIN
            -- Mark the OTP as used
            UPDATE accounts
            SET is_used = 1
            WHERE id = @employee_id

            SELECT 'OTP validated successfully' AS Message
        END
        ELSE
        BEGIN
            SELECT 'Invalid or expired OTP' AS Message
        END
    END
    ELSE
    BEGIN
        SELECT 'Username not found' AS Message
    END
END
GO

--SP Update Password



-----------------------------------INSERT, UPDATE, DELETE--------------------------------------

--JOBS
--Drop the insert procedure if it already exists
IF OBJECT_ID('InsertJob', 'P') IS NOT NULL
    DROP PROCEDURE InsertJob;
GO
-- Create the insert procedure
CREATE PROCEDURE InsertJob
    @id VARCHAR(10),
    @title VARCHAR(35),
    @min_salary INT = 0,
    @max_salary INT = 0,
    @default_salary INT = 0
AS
BEGIN
    INSERT INTO jobs (id, title, min_salary, max_salary, default_salary)
    VALUES (@id, @title, @min_salary, @max_salary, @default_salary);
END;
GO


--Drop the update procedure if it already exists
IF OBJECT_ID('UpdateJob', 'P') IS NOT NULL
    DROP PROCEDURE UpdateJob;
GO
-- Create the update procedure
CREATE PROCEDURE UpdateJob
    @id VARCHAR(10),
    @title VARCHAR(35),
    @min_salary INT,
    @max_salary INT,
    @default_salary INT
AS
BEGIN
    UPDATE jobs
    SET title = @title,
        min_salary = @min_salary,
        max_salary = @max_salary,
        default_salary = @default_salary
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for jobs if it already exists
IF OBJECT_ID('DeleteJob', 'P') IS NOT NULL
    DROP PROCEDURE DeleteJob;
GO
-- Create the delete procedure for jobs
CREATE PROCEDURE DeleteJob
    @id VARCHAR(10)
AS
BEGIN
    DELETE FROM jobs
    WHERE id = @id;
END;
GO



--REGIONS
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertRegion', 'P') IS NOT NULL
    DROP PROCEDURE InsertRegion;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertRegion
    @name VARCHAR(25)
AS
BEGIN
    INSERT INTO regions (name)
    VALUES (@name);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateRegion', 'P') IS NOT NULL
    DROP PROCEDURE UpdateRegion;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateRegion
    @id INT,
    @name VARCHAR(25)
AS
BEGIN
    UPDATE regions
    SET name = @name
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for regions if it already exists
IF OBJECT_ID('DeleteRegion', 'P') IS NOT NULL
    DROP PROCEDURE DeleteRegion;
GO
-- Create the delete procedure for regions
CREATE PROCEDURE DeleteRegion
    @id INT
AS
BEGIN
    DELETE FROM regions
    WHERE id = @id;
END;
GO



--COUNTRIES
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertCountry', 'P') IS NOT NULL
    DROP PROCEDURE InsertCountry;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertCountry
    @name VARCHAR(25),
    @region INT
AS
BEGIN
    INSERT INTO countries (name, region)
    VALUES (@name, @region);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateCountry', 'P') IS NOT NULL
    DROP PROCEDURE UpdateCountry;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateCountry
    @id INT,
    @name VARCHAR(25),
    @region INT
AS
BEGIN
    UPDATE countries
    SET name = @name,
        region = @region
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for countries if it already exists
IF OBJECT_ID('DeleteCountry', 'P') IS NOT NULL
    DROP PROCEDURE DeleteCountry;
GO
-- Create the delete procedure for countries
CREATE PROCEDURE DeleteCountry
    @id INT
AS
BEGIN
    DELETE FROM countries
    WHERE id = @id;
END;
GO



--LOCATIONS

-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertLocation', 'P') IS NOT NULL
    DROP PROCEDURE InsertLocation;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertLocation
    @street_address VARCHAR(40),
    @postal_code VARCHAR(12),
    @city VARCHAR(30),
    @state_province VARCHAR(25),
    @country INT
AS
BEGIN
    INSERT INTO locations (street_address, postal_code, city, state_province, country)
    VALUES (@street_address, @postal_code, @city, @state_province, @country);
END;
GO

-- Drop the delete procedure for locations if it already exists
IF OBJECT_ID('DeleteLocation', 'P') IS NOT NULL
    DROP PROCEDURE DeleteLocation;
GO
-- Create the delete procedure for locations
CREATE PROCEDURE DeleteLocation
    @id INT
AS
BEGIN
    DELETE FROM locations
    WHERE id = @id;
END;
GO



-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateLocation', 'P') IS NOT NULL
    DROP PROCEDURE UpdateLocation;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateLocation
    @id INT,
    @street_address VARCHAR(40),
    @postal_code VARCHAR(12),
    @city VARCHAR(30),
    @state_province VARCHAR(25),
    @country INT
AS
BEGIN
    UPDATE locations
    SET street_address = @street_address,
        postal_code = @postal_code,
        city = @city,
        state_province = @state_province,
        country = @country
    WHERE id = @id;
END;
GO


--DEPARTMENTS
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertDepartment', 'P') IS NOT NULL
    DROP PROCEDURE InsertDepartment;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertDepartment
    @name VARCHAR(25),
    @location INT
AS
BEGIN
    INSERT INTO departments (name, location)
    VALUES (@name, @location);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateDepartment', 'P') IS NOT NULL
    DROP PROCEDURE UpdateDepartment;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateDepartment
    @id INT,
    @name VARCHAR(25),
    @location INT
AS
BEGIN
    UPDATE departments
    SET name = @name,
        location = @location
    WHERE id = @id;
END;
GO


--EMPLOYEES
-- Drop the insert procedure for employees if it already exists
IF OBJECT_ID('InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE InsertEmployee;
GO
-- Create the insert procedure
CREATE PROCEDURE InsertEmployee
    @first_name VARCHAR(25),
    @last_name VARCHAR(25),
    @gender VARCHAR(10),
    @email VARCHAR(25),
    @phone VARCHAR(20),
    @hire_date DATE,
    @salary INT,
    @manager INT,
    @job VARCHAR(10),
    @department INT
AS
BEGIN
    -- Get the default salary from the jobs table
    DECLARE @default_salary INT;
    SELECT @default_salary = default_salary
    FROM jobs
    WHERE id = @job;

    -- Insert the new employee with the provided department and default salary
    INSERT INTO employees (first_name, last_name, gender, email, phone, hire_date, salary, manager, job, department)
    VALUES (@first_name, @last_name, @gender, @email, @phone, @hire_date, @default_salary, @manager, @job, @department);
END;
GO

-- Drop the update procedure for employees if it already exists
IF OBJECT_ID('UpdateEmployee', 'P') IS NOT NULL
    DROP PROCEDURE UpdateEmployee;
GO
-- Create the update procedure
CREATE PROCEDURE UpdateEmployee
    @id INT,
    @first_name VARCHAR(25),
    @last_name VARCHAR(25),
    @gender VARCHAR(10),
    @email VARCHAR(25),
    @phone VARCHAR(20),
    @hire_date DATE,
    @salary INT,
    @manager INT,
    @job VARCHAR(10),
    @department INT
AS
BEGIN
    -- Get the default salary from the jobs table
    DECLARE @default_salary INT;
    SELECT @default_salary = default_salary
    FROM jobs
    WHERE id = @job;

    -- Update the employee details with the provided department and default salary
    UPDATE employees
    SET first_name = @first_name,
        last_name = @last_name,
        gender = @gender,
        email = @email,
        phone = @phone,
        hire_date = @hire_date,
        salary = @default_salary,  -- Update salary to default salary
        manager = @manager,
        job = @job,
        department = @department
    WHERE id = @id;
END;
GO


-- Drop the procedure if it already exists
IF OBJECT_ID('DeleteEmployee', 'P') IS NOT NULL
    DROP PROCEDURE DeleteEmployee;
GO
-- Create the delete procedure
CREATE PROCEDURE DeleteEmployee
    @employee_id INT
AS
BEGIN
    -- Start a transaction
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Check if the employee exists
        IF EXISTS (SELECT 1 FROM employees WHERE id = @employee_id)
        BEGIN
            -- Handle self-reference for manager
            UPDATE employees
            SET manager = NULL
            WHERE manager = @employee_id;

            -- Delete related data in account_roles
            DELETE FROM account_roles WHERE account IN (SELECT id FROM accounts WHERE id = @employee_id);
            
            -- Delete related data in accounts
            DELETE FROM accounts WHERE id = @employee_id;

            -- Delete related data in employee_overtime
            DELETE FROM employee_overtime WHERE employee_id = @employee_id;

            -- Delete the employee
            DELETE FROM employees WHERE id = @employee_id;
        END
        ELSE
        BEGIN
            PRINT 'Employee not found';
        END

        -- Commit the transactionS
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if any error occurs
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO





--ACCOUNTS
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertAccount', 'P') IS NOT NULL
    DROP PROCEDURE InsertAccount;
GO
-- Create the insert procedure
CREATE PROCEDURE InsertAccount
    @username VARCHAR(25),
    @password NVARCHAR(255), -- Password should be NVARCHAR for proper hashing
    @otp INT,
    @is_expired DATETIME
AS
BEGIN
    -- Declare a variable to store the hashed password
    DECLARE @hashedPassword VARBINARY(256);
    
    -- Hash the password using SHA-256 with conversion
    SET @hashedPassword = HASHBYTES('SHA2_256', CONVERT(NVARCHAR(255), @password));
    
    -- Insert the account with the hashed password
    INSERT INTO accounts (username, password, otp, is_expired)
    VALUES (@username, @hashedPassword, @otp, @is_expired);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateAccount', 'P') IS NOT NULL
    DROP PROCEDURE UpdateAccount;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateAccount
    @id INT,
    @username VARCHAR(25),
    @password NVARCHAR(255), -- Password should be NVARCHAR for proper hashing
    @otp INT,
    @is_used BIT,
    @is_expired DATETIME
AS
BEGIN
    -- Declare a variable to store the hashed password
    DECLARE @hashedPassword VARBINARY(256);

    -- Hash the password using SHA-256 with conversion
    SET @hashedPassword = HASHBYTES('SHA2_256', CONVERT(NVARCHAR(255), @password));

    -- Update the account with the hashed password
    UPDATE accounts
    SET username = @username,
        password = @hashedPassword,
        otp = @otp,
        is_used = @is_used,
        is_expired = @is_expired
    WHERE id = @id;
END;
GO


--PERMISSION
-- Drop the procedure if it already exists
IF OBJECT_ID('InsertPermission', 'P') IS NOT NULL
    DROP PROCEDURE InsertPermission;
GO
-- Create the insert procedure
CREATE PROCEDURE InsertPermission
    @name VARCHAR(100)
AS
BEGIN
    INSERT INTO permissions (name)
    VALUES (@name);
END;
GO

-- Drop the procedure if it already exists
IF OBJECT_ID('UpdatePermission', 'P') IS NOT NULL
    DROP PROCEDURE UpdatePermission;
GO
-- Create the update procedure
CREATE PROCEDURE UpdatePermission
    @id INT,
    @name VARCHAR(100)
AS
BEGIN
    UPDATE permissions
    SET name = @name
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for permissions if it already exists
IF OBJECT_ID('DeletePermission', 'P') IS NOT NULL
    DROP PROCEDURE DeletePermission;
GO
-- Create the delete procedure for permissions
CREATE PROCEDURE DeletePermission
    @id INT
AS
BEGIN
    DELETE FROM permissions
    WHERE id = @id;
END;
GO



--ROLES
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertRole', 'P') IS NOT NULL
    DROP PROCEDURE InsertRole;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertRole
    @name VARCHAR(50)
AS
BEGIN
    INSERT INTO roles (name)
    VALUES (@name);SS
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateRole', 'P') IS NOT NULL
    DROP PROCEDURE UpdateRole;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateRole
    @id INT,
    @name VARCHAR(50)
AS
BEGIN
    UPDATE roles
    SET name = @name
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for roles if it already exists
IF OBJECT_ID('DeleteRole', 'P') IS NOT NULL
    DROP PROCEDURE DeleteRole;
GO
-- Create the delete procedure for roles
CREATE PROCEDURE DeleteRole
    @id INT
AS
BEGIN
    DELETE FROM roles
    WHERE id = @id;
END;
GO



--ROLE PERMISSIONS
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertRolePermission', 'P') IS NOT NULL
    DROP PROCEDURE InsertRolePermission;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertRolePermission
    @role INT,
    @permission INT
AS
BEGIN
    INSERT INTO role_permissions (role, permission)
    VALUES (@role, @permission);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateRolePermission', 'P') IS NOT NULL
    DROP PROCEDURE UpdateRolePermission;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateRolePermission
    @id INT,
    @role INT,
    @permission INT
AS
BEGIN
    UPDATE role_permissions
    SET role = @role,
        permission = @permission
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for role_permissions if it already exists
IF OBJECT_ID('DeleteRolePermission', 'P') IS NOT NULL
    DROP PROCEDURE DeleteRolePermission;
GO
-- Create the delete procedure for role_permissions
CREATE PROCEDURE DeleteRolePermission
    @id INT
AS
BEGIN
    DELETE FROM role_permissions
    WHERE id = @id;
END;
GO



--ACCOUNT ROLES
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertAccountRole', 'P') IS NOT NULL
    DROP PROCEDURE InsertAccountRole;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertAccountRole
    @account INT,
    @role INT
AS
BEGIN
    INSERT INTO account_roles (account, role)
    VALUES (@account, @role);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateAccountRole', 'P') IS NOT NULL
    DROP PROCEDURE UpdateAccountRole;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateAccountRole
    @id INT,
    @account INT,
    @role INT
AS
BEGIN
    UPDATE account_roles
    SET account = @account,
        role = @role
    WHERE id = @id;
END;
GO

-- Drop the delete procedure for account_roles if it already exists
IF OBJECT_ID('DeleteAccountRole', 'P') IS NOT NULL
    DROP PROCEDURE DeleteAccountRole;
GO
-- Create the delete procedure for account_roles
CREATE PROCEDURE DeleteAccountRole
    @id INT
AS
BEGIN
    DELETE FROM account_roles
    WHERE id = @id;
END;
GO



--JOB HISTORY
-- Drop the insert procedure if it already exists
IF OBJECT_ID('InsertJobHistory', 'P') IS NOT NULL
    DROP PROCEDURE InsertJobHistory;
GO
-- Create the insert procedure
CREATE PROCEDURE InsertJobHistory
    @employee_id INT,
    @start_date DATE,
    @end_date DATE,
    @status VARCHAR(10),
    @job VARCHAR(10),
    @department INT
AS
BEGIN
    INSERT INTO job_histories (employee_id, start_date, end_date, status, job, department)
    VALUES (@employee_id, @start_date, @end_date, @status, @job, @department);
END;
GO

-- Drop the update procedure if it already exists
IF OBJECT_ID('UpdateJobHistory', 'P') IS NOT NULL
    DROP PROCEDURE UpdateJobHistory;
GO
-- Create the update procedure
CREATE PROCEDURE UpdateJobHistory
    @employee_id INT,
    @start_date DATE,
    @end_date DATE,
    @status VARCHAR(10),
    @job VARCHAR(10),
    @department INT
AS
BEGIN
    UPDATE job_histories
    SET start_date = @start_date,
        end_date = @end_date,
        status = @status,
        job = @job,
        department = @department
    WHERE employee_id = @employee_id;
END;
GO

-- Drop the delete procedure for job_histories if it already exists
IF OBJECT_ID('DeleteJobHistory', 'P') IS NOT NULL
    DROP PROCEDURE DeleteJobHistory;
GO
-- Create the delete procedure for job_histories
CREATE PROCEDURE DeleteJobHistory
    @employee_id INT
AS
BEGIN
    DELETE FROM job_histories
    WHERE employee_id = @employee_id;
END;
GO



--EMPLOYEE EVERTIME

-- Drop the insert procedure for employee_overtime if it already exists
IF OBJECT_ID('InsertEmployeeOvertime', 'P') IS NOT NULL
    DROP PROCEDURE InsertEmployeeOvertime;
GO

-- Create the insert procedure
CREATE PROCEDURE InsertEmployeeOvertime
    @employee_id INT,
    @month_year DATE,
    @overtime_count INT
AS
BEGIN
    INSERT INTO employee_overtime (employee_id, month_year, overtime_count)
    VALUES (@employee_id, @month_year, @overtime_count);
END;
GO


-- Drop the update procedure for employee_overtime if it already exists
IF OBJECT_ID('UpdateEmployeeOvertime', 'P') IS NOT NULL
    DROP PROCEDURE UpdateEmployeeOvertime;
GO

-- Create the update procedure
CREATE PROCEDURE UpdateEmployeeOvertime
    @id INT,
    @employee_id INT,
    @month_year DATE,
    @overtime_count INT
AS
BEGIN
    UPDATE employee_overtime
    SET employee_id = @employee_id,
        month_year = @month_year,
        overtime_count = @overtime_count
    WHERE id = @id;
END;
GO


-- Drop the delete procedure for employee_overtime if it already exists
IF OBJECT_ID('DeleteEmployeeOvertime', 'P') IS NOT NULL
    DROP PROCEDURE DeleteEmployeeOvertime;
GO

-- Create the delete procedure
CREATE PROCEDURE DeleteEmployeeOvertime
    @id INT
AS
BEGIN
    DELETE FROM employee_overtime
    WHERE id = @id;
END;
GO



