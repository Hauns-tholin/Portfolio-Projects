--Online retail business sales

SELECT *
FROM Onlinesales

-- Finding total sales for each category 


SELECT SUM([total net sales])
FROM Onlinesales
Where [Product type] = 'etc...'


-- finding category plus total sales for each category

SELECT Distinct [product type], SUM([total net sales]) OVER (partition by [product type]) [total net sales],sum([total net sales]) OVER () [total net sales]
FROM onlinesales

--Total sales $333,644.42
--Christmas $14,460.81
--Recycled Art $3,704.16
--Easter $34.20
--NULL $560.5
--Fair Trade Gifts $2204.64
--Gift Baskets $19.50
--Home Decor $25,699.99
--Textiles $1,679.10
--Soapstone $4,629.09
--Basket $134,791.39
--Kitchen $15,336.82
--Accessories $3,785.38
--Skin Care $2,571.80
--Art & Sculpture $84,480.85
--Jewelry $29,572.85
--Furniture $1,864.96
--One-of-a-Kind $2,108.01
--Music $2,418.90
--Kids $3,721.34

--Finding how much products where sold in each category

SELECT Distinct [product type], Sum([net quantity]) OVER (partition by [product type]) [net quantity],sum([net quantity]) OVER () [net quantity]
FROM onlinesales

-- Total products sold - 6,950
--NULL 8
--Accessories - 84 
--Art & Sculpture - 1,427
--Basket - 1461
--Christmas - 575
--Easter - 1
--Fair Trade Gifts - 110
--Furniture - 27
--Gift Baskets - 1
--Home Decor - 404
--Jewelry - 991
--Kids - 140
--Kitchen - 809
--Music - 98
--One-of-a-Kind - 12
--Recycled Art - 99
--Skin Care - 101
--Soapstone - 199
--Textiles - 43

--Finding how much profit was lost due to returns and total loss due to returns

SELECT Distinct [product type], Sum(Returns) OVER (partition by [product type]) [Returns],sum([Returns]) OVER () [Returns]
FROM onlinesales

--Total revenue lost due to Returns -$9,559.15
--NULL - 0
--Accessories - 0 
--Art & Sculpture - -$2,879.93
--Basket - -$4,439.69
--Christmas - -$670
--Easter - 0
--Fair Trade Gifts - 0
--Furniture - 0
--Gift Baskets - 0
--Home Decor -$423.35
--Jewelry -$509.20
--Kids - 0
--Kitchen - -$328.07
--Music - $142.41
--One-of-a-Kind - 0
--Recycled Art - 0
--Skin Care - 0
--Soapstone - -$69.50
--Textiles - -$97

SELECT Distinct [product type], Sum(discounts) OVER (partition by [product type]) [discounts],sum([discounts]) OVER () [discounts]
FROM onlinesales

--Total revenue lost due to discounts on products and total lost revenue from returns

--Total discounts - $-11,213.78
--NULL	0
--Accessories	$-107.02
--Art & Sculpture	$-2,955.82
--Basket	$-4,584.42
--Christmas	$-345.19
--Easter	$-3.80
--Fair Trade Gifts	$-53.33
--Furniture	$-169.04
--Gift Baskets	0
--Home Decor	$-991.21
--Jewelry	$-965.85
--Kids	$-116.66
--Kitchen	$-431.11
--Music	$-82.19
--One-of-a-Kind	$-71.99
--Recycled Art	$-88.64
--Skin Care	$-37.7
--Soapstone	$-96.91
--Textiles	$-112.90
