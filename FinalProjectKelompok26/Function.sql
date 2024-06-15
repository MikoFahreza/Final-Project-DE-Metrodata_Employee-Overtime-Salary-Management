--Menghitung total gaji setelah lembur
CREATE FUNCTION CalculateNewSalary (
    @employee_id INT,
    @overtime_count INT
)
RETURNS INT
AS
BEGIN
    DECLARE @default_salary INT;
    DECLARE @new_salary INT;

    -- Ambil nilai default_salary dari tabel jobs berdasarkan pekerjaan karyawan
    SELECT @default_salary = j.default_salary
    FROM employees e
    JOIN jobs j ON e.job = j.id
    WHERE e.id = @employee_id;

    -- Hitung salary baru
    SET @new_salary = @default_salary + (1.0 / 173.0 * @default_salary * @overtime_count);

    RETURN @new_salary;
END;
GO
