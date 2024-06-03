CREATE DATABASE EmployeeOvertimeSalaryManagement
GO

USE EmployeeOvertimeSalaryManagement

CREATE TABLE jobs (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    title VARCHAR(35) NOT NULL,
	min_salary INT,
	max_salary INT,
	default_salary INT
);

CREATE TABLE regions (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(25) NOT NULL
);

CREATE TABLE countries (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(25) NOT NULL,
	region INT NOT NULL
	CONSTRAINT fk_country_region FOREIGN KEY (region) REFERENCES regions(id)
);

CREATE TABLE locations (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30),
	state_province VARCHAR(25),
	country INT NOT NULL
	CONSTRAINT fk_location_country FOREIGN KEY (country) REFERENCES countries(id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(25) NOT NULL,
	location INT NOT NULL
	CONSTRAINT fk_department_location FOREIGN KEY (location) REFERENCES locations(id)
);

CREATE TABLE employees (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25),
	gender VARCHAR(10) DEFAULT 'male' NOT NULL,
	email VARCHAR(25),
	phone VARCHAR(20),
	hire_date DATE,
	salary INT,
	manager INT,
	job VARCHAR(10),
	department INT
	CONSTRAINT fk_employee_manager FOREIGN KEY (manager) REFERENCES employees(id),
	CONSTRAINT fk_employee_job FOREIGN KEY (job) REFERENCES jobs(id),
	CONSTRAINT fk_employee_department FOREIGN KEY (department) REFERENCES departments(id),
	CONSTRAINT chk_gender CHECK (gender IN ('male', 'female')),
    CONSTRAINT chk_email_format CHECK (email LIKE '%_@_%._%'),
    CONSTRAINT chk_phone_format CHECK (phone NOT LIKE '%[^0-9]%')
);

CREATE TABLE accounts (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    username VARCHAR(25) NOT NULL,
	password VARCHAR(255) NOT NULL,
	otp INT,
	is_used BIT,
	is_expired DATETIME
	CONSTRAINT fk_account_employee FOREIGN KEY (id) REFERENCES employees(id),
);

CREATE TABLE permissions (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE roles (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE role_permissions (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    role INT NOT NULL,
	permission INT NOT NULL
	CONSTRAINT fk_role_permission FOREIGN KEY (role) REFERENCES roles(id),
	CONSTRAINT fk_permission_role FOREIGN KEY (permission) REFERENCES permissions(id)
);

CREATE TABLE account_roles (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	account INT NOT NULL,
    role INT NOT NULL
	CONSTRAINT fk_account_role FOREIGN KEY (account) REFERENCES accounts(id),
	CONSTRAINT fk_role_account FOREIGN KEY (role) REFERENCES roles(id)
);

CREATE TABLE job_histories (
    employee_id INT PRIMARY KEY NOT NULL,
    start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	status VARCHAR(10),
	job INT,
	department INT
	CONSTRAINT fk_job_employee FOREIGN KEY (employee_id) REFERENCES employees(id),
	CONSTRAINT fk_job_department FOREIGN KEY (department) REFERENCES departments(id)
);

