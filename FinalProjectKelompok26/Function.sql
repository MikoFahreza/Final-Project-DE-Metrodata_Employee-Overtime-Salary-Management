CREATE FUNCTION GetTotalOvertimeCount (
    @employee_id INT,
    @month_year DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @total_overtime_count INT;
    
    SELECT @total_overtime_count = SUM(overtime_count)
    FROM employee_overtime
    WHERE employee_id = @employee_id
      AND FORMAT(month_year, 'yyyy-MM') = FORMAT(@month_year, 'yyyy-MM');
    
    RETURN ISNULL(@total_overtime_count, 0);
END;
