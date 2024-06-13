USE EmployeeOvertimeSalaryManagement;

CREATE TRIGGER tr_insert_employee
ON employees
AFTER INSERT
AS
BEGIN
    INSERT INTO job_histories (employee_id, start_date, status, job, department)
    SELECT id, GETDATE(), 'Active', inserted.job, inserted.department
    FROM inserted;
END;
GO

CREATE TRIGGER tr_update_employee_job
ON employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(job)
    BEGIN
        INSERT INTO job_histories (employee_id, start_date, status, job, department)
        SELECT id, GETDATE(), 'Hand Over', inserted.job, inserted.department
        FROM inserted;
    END;
END;
GO

CREATE TRIGGER tr_delete_employee
ON employees
AFTER DELETE
AS
BEGIN
    INSERT INTO job_histories (employee_id, start_date, status, job, department)
    SELECT id, GETDATE(), 'Resign', deleted.job, deleted.department
    FROM deleted;
END;
GO


CREATE TRIGGER trgUpdateEmployeeSalary
ON employee_overtime
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @employee_id INT;
    DECLARE @month_year DATE;
    DECLARE @total_overtime_count INT;
    DECLARE @job_id VARCHAR(10);
    DECLARE @min_salary INT;
    DECLARE @max_salary INT;
    DECLARE @new_salary INT;

    -- Ambil data dari inserted
    SELECT TOP 1 
        @employee_id = employee_id,
        @month_year = month_year,
        @job_id = job
    FROM inserted;

    -- Hitung total overtime count untuk bulan tersebut
    SET @total_overtime_count = dbo.GetTotalOvertimeCount(@employee_id, @month_year);

    -- Ambil informasi salary dari tabel jobs
    SELECT 
        @min_salary = min_salary,
        @max_salary = max_salary
    FROM jobs
    WHERE id = @job_id;

    -- Hitung new salary berdasarkan total overtime count
    SELECT @new_salary = salary + @total_overtime_count * 100
    FROM employees
    WHERE id = @employee_id;

    -- Pastikan new salary tidak melebihi batas min dan max salary
    IF @new_salary < @min_salary
    BEGIN
        SET @new_salary = @min_salary;
    END

    IF @new_salary > @max_salary
    BEGIN
        SET @new_salary = @max_salary;
    END

    -- Update salary pada tabel employees
    UPDATE employees
    SET salary = @new_salary
    WHERE id = @employee_id;
END;
