
-- Create function to validate email format
CREATE FUNCTION func_email_format(@Email VARCHAR(50))
RETURNS BIT
AS
BEGIN
    IF @Email LIKE '%_@_%._%'
        RETURN 1;
    RETURN 0;
END;
GO

-- Create function to validate password policy
CREATE FUNCTION func_password_policy(@Password VARCHAR(255))
RETURNS BIT
AS
BEGIN
    IF LEN(@Password) >= 8
       AND @Password LIKE '%[A-Z]%'
       AND @Password LIKE '%[a-z]%'
       AND @Password LIKE '%[0-9]%'
       AND @Password LIKE '%[^A-Za-z0-9]%'
        RETURN 1;
    RETURN 0;
END;
GO

-- Create function to validate gender
CREATE FUNCTION func_gender(@Gender VARCHAR(10))
RETURNS BIT
AS
BEGIN
    IF @Gender IN ('Male', 'Female')
        RETURN 1;
    RETURN 0;
END;
GO

-- Create function to validate phone number format
CREATE FUNCTION func_phone_number(@Phone VARCHAR(20))
RETURNS BIT
AS
BEGIN
    IF @Phone NOT LIKE '%[^0-9]%'
        RETURN 1;
    RETURN 0;
END;
GO

-- Create function to match passwords
CREATE FUNCTION func_password_match(@Password VARCHAR(255), @ConfirmPassword VARCHAR(255))
RETURNS BIT
AS
BEGIN
    IF @Password = @ConfirmPassword
        RETURN 1;
    RETURN 0;
END;
GO

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
