create table EmployeeErrors
(EmployeeID Varchar (50), Firstname varchar(50), Lastname varchar(50))

Insert into EmployeeErrors Values
('1004	', 'Shittu', 'Hammed')


Select*
from EmployeeErrors

--TRIM, RTRIM, LTRIM
Select EmployeeID, TRIM (EmployeeID) AS FULLTRIM
from EmployeeErrors

Select EmployeeID, RTRIM (EmployeeID) AS FULLTRIM
from EmployeeErrors

Select EmployeeID, LTRIM (EmployeeID) AS FULLTRIM
from EmployeeErrors




--Replace
Select Lastname, REPLACE(Lastname, '- Fired', '') AS LastnameR
from EmployeeErrors




--Substring
Select SUBSTRING (Firstname, 1,2) as fname
from EmployeeErrors

Select Substring (err.Firstname, 1,3), Substring (dem.FirstName, 1,3)
from EmployeeErrors err
Full Join EmployeeDemographics dem
On Substring (err.Firstname, 1,3) = Substring (dem.FirstName, 1,3)




--Upper and Lower

Select*
from EmployeeErrors

Select Firstname, Upper(Firstname) as Layover
from EmployeeErrors






