--Cleaning data in SQL Queries

Select *
From [Portfolio project]..[Nashville housing]

--Changing sale date

Select saledateconverted, CONVERT(date,saledate)
From [Portfolio project]..[Nashville housing]

Update [Nashville housing]
SET saledate = CONVERT(date,saledate)

ALTER TABLE [Nashville housing]
Add saledateconverted date;

Update [Nashville housing]
SET saledateconverted = CONVERT(date,saledate)

-- fill in property address data

Select *
From [Portfolio project]..[Nashville housing]
--Where Propertyaddress is null
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio project]..[Nashville housing] a
JOIN [Portfolio project]..[Nashville housing] b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio project]..[Nashville housing] a
JOIN [Portfolio project]..[Nashville housing] b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]


-- Making the property address into their own individual columns (Address, City, State)

Select propertyaddress
From [Portfolio project]..[Nashville housing]
--Where propertyaddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address

From [Portfolio project]..[Nashville housing]

ALTER TABLE [Nashville housing]
Add PropertySplitAddress Nvarchar(255);

Update [Nashville housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE [Nashville housing]
Add PropertySplitCity Nvarchar(255);

Update [Nashville housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) 

Select *
From [Portfolio project]..[Nashville housing]

Select OwnerAddress
From [Portfolio project]..[Nashville housing]

Select
Parsename(REPLACE(OwnerAddress,',','.') , 3)
,Parsename(REPLACE(OwnerAddress,',','.') , 2)
,Parsename(REPLACE(OwnerAddress,',','.') , 1)
From [Portfolio project]..[Nashville housing]



ALTER TABLE [Nashville housing]
Add OwnerSplitAddress Nvarchar(255);

Update [Nashville housing]
SET OwnerSplitAddress = Parsename(REPLACE(OwnerAddress,',','.') , 3)

ALTER TABLE [Nashville housing]
Add OwnerSplitCity Nvarchar(255);

Update [Nashville housing]
SET OwnerSplitCity = Parsename(REPLACE(OwnerAddress,',','.') , 2) 

ALTER TABLE [Nashville housing]
Add OwnerSplitState Nvarchar(255);

Update [Nashville housing]
SET OwnerSplitState = Parsename(REPLACE(OwnerAddress,',','.') , 1)

Select *
From [Portfolio project]..[Nashville housing]

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(soldasvacant), Count(soldasvacant)
From [Portfolio project]..[Nashville housing]
Group by soldasvacant
order by 2

Select soldasvacant
, CASE When soldasvacant = 'Y' THEN 'Yes'
When soldasvacant = 'n' THEN 'No'
ELSE soldasvacant
END
From [Portfolio project]..[Nashville housing]

Update [Nashville housing]
SET soldasvacant = CASE When soldasvacant = 'Y' THEN 'Yes'
When soldasvacant = 'n' THEN 'No'
ELSE soldasvacant
END

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
PARTITION BY ParcelID, 
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
ORDER BY 
UniqueID
) row_num


From [Portfolio project]..[Nashville housing]
--ORDER BY ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress


-- Deleteing unused columns



Select *
From [Portfolio project]..[Nashville housing]

Alter table [Portfolio project]..[Nashville housing]
Drop column Owneraddress, taxdistrict, Propertyaddress

Alter table [Portfolio project]..[Nashville housing]
Drop column Saledate