USE [StoredProcTARge23]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[spSearchEmployees]
@FirstName nvarchar(100) = NULL,
@LastName nvarchar(100) = NULL,
@Gender nvarchar(50) = NULL,
@Salary int = NULL
As
Begin
	Select * from Employees where
	(FirstName = @FirstName OR @FirstName IS NULL) AND
	(LastName = @LastName OR @LastName IS NULL) AND
	(Gender = @Gender OR @Gender IS NULL) AND
	(Salary = @Salary OR @Salary IS NULL)
End

Select * from Employees


-- Insert four random records into the Employees table
INSERT INTO Employees (FirstName, LastName, Gender, Salary)
VALUES 
    ('John', 'Doe', 'Male', 50000),
    ('Jane', 'Smith', 'Female', 60000),
    ('Michael', 'Johnson', 'Male', 55000),
    ('Emily', 'Williams', 'Female', 58000);

EXEC spSearchEmployees @FirstName = 'John';

ALTER PROCEDURE [dbo].[spSearchEmployees]
    @FirstName NVARCHAR(100) = NULL,
    @LastName NVARCHAR(100) = NULL,
    @Gender NVARCHAR(50) = NULL,
    @Salary INT = NULL
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE
        (FirstName = COALESCE(@FirstName, FirstName)) AND
        (LastName = COALESCE(@LastName, LastName)) AND
        (Gender = COALESCE(@Gender, Gender)) AND
        (Salary = @Salary OR @Salary IS NULL);
END


--Uus
Create Procedure spSearchEmployeesGoodDynamicSQl
@FirstName nvarchar(100) = NULL,
@LastName nvarchar(100) = NULL,
@Gender nvarchar(50) = NULL,
@Salary int = NULL
As
Begin
	Declare @sql nvarchar(max)
	Declare @sqlParams nvarchar(max)

	Set @sql = 'Select * from Employees where 1 = 1'

	If (@FirstName is not null)
		Set @sql = @sql + ' and FirstName=@FN'
	If (@LastName is not null)
		Set @sql = @sql + ' and LastName=@LN'
	If (@Gender is not null)
		Set @sql = @sql + ' and Gender=@Gen'
	If (@Salary is not null)
		Set @sql = @sql + ' and Salary=@Sal'
	Execute sp_executesql @sql,
	N'@FN nvarchar(50), @LN nvarchar(50), @Gen nvarchar(50), @sal int',
	@FN=FirstName, @LN=@LastName, @Gen=@Gender, @Sal=@Salary
End
Go
