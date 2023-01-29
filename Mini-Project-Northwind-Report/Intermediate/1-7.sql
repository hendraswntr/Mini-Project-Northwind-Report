--1.Tulis query untuk mendapatkan jumlah customer tiap bulan yang melakukan order pada tahun 1997.
SELECT 
	MONTH(OrderDate) as Bulan, 
	COUNT(DISTINCT CustomerID) as Jumlah_Customer 
FROM 
	Orders 
WHERE 
	YEAR(OrderDate) = 1997 
GROUP BY 
	MONTH(OrderDate)

--2.Tulis query untuk mendapatkan nama employee yang termasuk Sales Representative.
SELECT 
	FirstName, 
	LastName 
FROM 
	Employees 
WHERE 
	Title='Sales Representative'

--3.Tulis query untuk mendapatkan top 5 nama produk yang quantity nya paling banyak diorder pada bulan Januari 1997.
SELECT TOP 5 
	Products.ProductName, 
	SUM([Order Details].Quantity) as Quantity 
FROM 
	Products 
	INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID 
	INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE 
	MONTH(Orders.OrderDate) = 1 AND YEAR(Orders.OrderDate) = 1997
GROUP BY 
	Products.ProductName
ORDER BY Quantity DESC

--4.Tulis query untuk mendapatkan nama company yang melakukan order Chai pada bulan Juni 1997.
SELECT DISTINCT 
	Suppliers.CompanyName 
FROM 
	Suppliers
	INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
	INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
	INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE 
	Products.ProductName = 'Chai' AND MONTH(Orders.OrderDate) = 6 AND YEAR(Orders.OrderDate) = 1997

--5.Tulis query untuk mendapatkan jumlah OrderID yang pernah melakukan pembelian 
--(unit_price dikali quantity) <=100, 100<x<=250, 250<x<=500, dan >500.
SELECT 
	SUM(CASE WHEN UnitPrice*Quantity <= 100 THEN 1 ELSE 0 END) as '<=100',
	SUM(CASE WHEN UnitPrice*Quantity > 100 AND UnitPrice*Quantity <= 250 THEN 1 ELSE 0 END) as '100<x<=250',
	SUM(CASE WHEN UnitPrice*Quantity > 250 AND UnitPrice*Quantity <= 500 THEN 1 ELSE 0 END) as '250<x<=500',
	SUM(CASE WHEN UnitPrice*Quantity > 500 THEN 1 ELSE 0 END) as '>500'
FROM 
	[Order Details]

--6.Tulis query untuk mendapatkan Company name pada tabel customer yang melakukan pembelian di atas 500 pada tahun 1997.
SELECT DISTINCT 
	CompanyName 
FROM 
	Customers
	INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE 
	YEAR(Orders.OrderDate) = 1997 AND ([Order Details].Quantity * [Order Details].UnitPrice) > 500

--7.Tulis query untuk mendapatkan nama produk yang merupakan Top 5 sales tertinggi tiap bulan di tahun 1997.
SELECT 
	Bulan, 
	ProductName, 
	TotalSales
FROM (
	SELECT 
		MONTH(Orders.OrderDate) as Bulan, 
		ProductName,
		SUM([Order Details].UnitPrice*[Order Details].Quantity) as TotalSales,
		ROW_NUMBER() OVER (PARTITION BY MONTH(Orders.OrderDate) 
	ORDER BY 
		SUM([Order Details].UnitPrice*[Order Details].Quantity) DESC) as RN
	FROM 
		[Order Details]
		INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
		INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
	WHERE 
		YEAR(Orders.OrderDate) = 1997
	GROUP BY 
		MONTH(Orders.OrderDate), ProductName
	) as sub
WHERE 
	RN <= 5
ORDER BY 
	Bulan, 
	TotalSales DESC


