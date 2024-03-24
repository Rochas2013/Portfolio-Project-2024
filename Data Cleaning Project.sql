-- Cleaning datas in SQL
select*
from Cleaning

--Changing the date format in the project.

select SaleDateConverted, (Convert (date,saledate)) DATE
from Cleaning
Order by SaleDateConverted

UPDATE Cleaning
SET SaleDateConverted = (Convert (date,saledate))

Alter Table Cleaning
Add SaleDateConverted date

--Populate Property Address Data

Select *
From Cleaning
--Where PropertyAddress is null
Order by ParcelID

Select A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL (A.PropertyAddress, B.PropertyAddress) PropertyAdd
From Cleaning	A
Join Cleaning	B
	ON A.ParcelID = B.ParcelID
	And A.UniqueID <> B.UniqueID
Where A.PropertyAddress is null

UPDATE A
SET PropertyAddress = ISNULL (A.PropertyAddress, B.PropertyAddress)
From Cleaning	A
Join Cleaning	B
	ON A.ParcelID = B.ParcelID
	And A.UniqueID <> B.UniqueID
Where A.PropertyAddress is null

--Breaking out address into individual columns (Address, City, State)

Select *
From Cleaning
--Where PropertyAddress is null

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)), LEN (PropertyAddress) as Addresses
From Cleaning

UPDATE Cleaning
SET PopAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

Alter Table Cleaning
Add PopAddress nvarchar(255)

UPDATE Cleaning
SET PopCITY = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)), LEN (PropertyAddress)

Alter Table Cleaning
Add PopCity nvarchar(255)



Select OwnerAddress
From Cleaning
--Where OwnerAddress is null

Select 
PARSENAME(Replace(OwnerAddress,',','.'),3) AS Address
,PARSENAME(Replace(OwnerAddress,',','.'),2) AS City
,PARSENAME(Replace(OwnerAddress,',','.'),1) AS State
From Cleaning
--where owneraddress is null

UPDATE Cleaning
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)

Alter Table Cleaning
Add OwnerSplitAddress nvarchar(255)

UPDATE Cleaning
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

Alter Table Cleaning
Add OwnerSplitCity nvarchar(255)

UPDATE Cleaning
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)

Alter Table Cleaning
Add OwnerSplitState nvarchar(255)

Select *
from cleaning

--Change Y and N to Yes and No in 'SoldAsVacant' Field

Select SoldAsVacant
from cleaning
--Where SoldAsVacant is null


Select DISTINCT(SoldAsVacant), Count (SoldAsVacant)
from cleaning
Group by SoldAsVacant
Order by 2 desc

--Using Case statement to change the variables to Yes and No.

Select SoldAsVacant,
CASE
When SoldAsVacant = 'N' Then 'No'
When SoldAsVacant = 'Y' Then 'Yes'
Else SoldAsVacant
	END AS SOLDVACANT
From Cleaning

UPDATE cleaning
SET SoldAsVacant = CASE
When SoldAsVacant = 'N' Then 'No'
When SoldAsVacant = 'Y' Then 'Yes'
Else SoldAsVacant
	END

SELECT*
From cleaning

--Removing Duplicates

WITH Sparit AS (
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
				UniqueID
				) row_num
From Cleaning
--Order by ParcelID
)
Select* --We first create the select variable then replace with delete so as to get rid of the duplicates from the table then select again to see if all is clear.
from Sparit
where row_num > 1
--Order by PropertyAddress

--Deleting Unused Columns.

Select*
from cleaning

Alter Table Cleaning
Drop Column PropertyAddress, SaleDate, OwnerAddress