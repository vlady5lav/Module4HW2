--------------------------ДОМАШКА-----------------------------

----------------------ЗАДАНИЕ №1------------------------------
--Вывести всю информацию из таблицы Sales.Customer 
--------------------------------------------------------------

GO
SELECT *
FROM Sales.Customer

----------------------ЗАДАНИЕ №2------------------------------
--Вывести всю информацию из таблицы Sales.Store отсортированную 
--по Name в алфавитном порядке
--------------------------------------------------------------

GO
SELECT *
FROM Sales.Store
ORDER BY Name

----------------------ЗАДАНИЕ №3------------------------------
--Вывести из таблицы HumanResources.Employee всю информацию
--о десяти сотрудниках, которые родились позже 1989-09-28
--------------------------------------------------------------

GO
SELECT TOP 10 *
FROM HumanResources.Employee
WHERE BirthDate > '1989-09-28'

----------------------ЗАДАНИЕ №4------------------------------
--Вывести из таблицы HumanResources.Employee сотрудников
--у которых последний символ LoginID является 0.
--Вывести только NationalIDNumber, LoginID, JobTitle.
--Данные должны быть отсортированы по JobTitle по убыванию
--------------------------------------------------------------

GO
SELECT NationalIDNumber, LoginID, JobTitle
FROM HumanResources.Employee
WHERE LoginID LIKE '%0'
ORDER BY JobTitle DESC

----------------------ЗАДАНИЕ №5------------------------------
--Вывести из таблицы Person.Person всю информацию о записях, которые были 
--обновлены в 2008 году (ModifiedDate) и MiddleName содержит
--значение и Title не содержит значение 
--------------------------------------------------------------

GO
SELECT *
FROM Person.Person
WHERE DATEPART(yy, ModifiedDate) = 2008
AND MiddleName IS NOT NULL
AND TITLE IS NULL

/*
--Another variants:
--1)
WHERE CONVERT(VARCHAR(25), ModifiedDate, 120) LIKE '2008-%'

--2)
DECLARE @start DATETIME, @end DATETIME
SELECT @start = '2008-01-01', @end = '2008-12-31'
SELECT *
FROM Person.Person

WHERE ModifiedDate >= @start
AND ModifiedDate <= @end

--or

WHERE ModifiedDate BETWEEN @start and @end
*/

----------------------ЗАДАНИЕ №6------------------------------
--Вывести название отдела (HumanResources.Department.Name) БЕЗ повторений
--в которых есть сотрудники
--Использовать таблицы HumanResources.EmployeeDepartmentHistory и HumanResources.Department
--------------------------------------------------------------

GO
-- noncorrelated subquery
SELECT d.Name AS DepartmentName
FROM HumanResources.Department d
-- alias 'd' is assigned for better readability
WHERE d.DepartmentID in
(
SELECT e.DepartmentID
FROM HumanResources.EmployeeDepartmentHistory e
)
ORDER BY DepartmentName

/*
--Another variant:
GO
SELECT DISTINCT
(
SELECT d.Name
FROM HumanResources.Department d
-- alias 'd' is assigned for better readability
WHERE d.DepartmentID = e.DepartmentID
)
AS DepartmentName
FROM HumanResources.EmployeeDepartmentHistory e
*/

----------------------ЗАДАНИЕ №7------------------------------
--Сгрупировать данные из таблицы Sales.SalesPerson по TerritoryID
--и вывести сумму CommissionPct, если она больше 0
--------------------------------------------------------------

GO
SELECT TerritoryID, SUM(CommissionPct) AS CommissionPctSum
FROM Sales.SalesPerson
GROUP BY TerritoryID
HAVING SUM(CommissionPct) > 0

----------------------ЗАДАНИЕ №8------------------------------
--Вывести всю информацию о сотрудниках (HumanResources.Employee) 
--которые имеют самое большое кол-во 
--отпуска (HumanResources.Employee.VacationHours)
--------------------------------------------------------------

GO
SELECT *
FROM HumanResources.Employee
WHERE VacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)

----------------------ЗАДАНИЕ №9------------------------------
--Вывести всю информацию о сотрудниках (HumanResources.Employee) 
--которые имеют позицию (HumanResources.Employee.JobTitle)
--'Sales Representative' или 'Network Administrator' или 'Network Manager'
--------------------------------------------------------------

GO
SELECT *
FROM HumanResources.Employee
WHERE JobTitle IN ('Sales Representative', 'Network Administrator', 'Network Manager')

----------------------ЗАДАНИЕ №10-----------------------------
--Вывести всю информацию о сотрудниках (HumanResources.Employee) и 
--их заказах (Purchasing.PurchaseOrderHeader). ЕСЛИ У СОТРУДНИКА НЕТ
--ЗАКАЗОВ ОН ДОЛЖЕН БЫТЬ ВЫВЕДЕН ТОЖЕ!!!
--------------------------------------------------------------

GO
SELECT *
FROM HumanResources.Employee e
LEFT JOIN Purchasing.PurchaseOrderHeader p
ON e.BusinessEntityID = p.EmployeeID
