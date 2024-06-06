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
