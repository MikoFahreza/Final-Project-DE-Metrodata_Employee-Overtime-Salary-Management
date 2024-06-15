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



-- Drop the trigger if it already exists
IF OBJECT_ID('tr_delete_employee', 'TR') IS NOT NULL
    DROP TRIGGER tr_delete_employee;
GO
-- Trigger for updating job history on employee deletion
CREATE TRIGGER tr_delete_employee
ON employees
AFTER DELETE
AS
BEGIN
    UPDATE jh
    SET end_date = GETDATE(),
        status = 'Resign'
    FROM job_histories jh
    INNER JOIN deleted d ON jh.employee_id = d.id;
END;
GO


--Trigger untuk update salary saat insert overtime
IF OBJECT_ID('tr_insert_employee_overtime', 'TR') IS NOT NULL
    DROP TRIGGER tr_insert_employee_overtime;
GO
CREATE TRIGGER tr_insert_employee_overtime
ON employee_overtime
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @employee_id INT;
    DECLARE @overtime_count INT;
    DECLARE @new_salary INT;

    -- Ambil nilai dari inserted row
    SELECT @employee_id = employee_id, @overtime_count = overtime_count
    FROM inserted;

    -- Hitung salary baru
    SET @new_salary = dbo.CalculateNewSalary(@employee_id, @overtime_count);

    -- Update nilai salary di tabel employees
    UPDATE employees
    SET salary = @new_salary
    WHERE id = @employee_id;
END;
GO
