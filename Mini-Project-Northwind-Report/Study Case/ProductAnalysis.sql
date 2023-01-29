SELECT
	Orders.OrderDate,
	Products.ProductName as 'Product Name',
	Categories.CategoryName as 'Category Name',
	count(Orders.OrderID) as 'Order',
	SUM([Order Details].UnitPrice) as 'Order Price',
	ROUND(SUM(Products.UnitPrice),2) as 'Product Price',
	ROUND(SUM(Products.UnitPrice - [Order Details].UnitPrice),2) as 'Gap Price',
	ROUND(SUM([Order Details].UnitPrice * [Order Details].Quantity),2) as 'Gross Product Sales',
	ROUND(SUM(([Order Details].UnitPrice - [Order Details].Discount) * [Order Details].Quantity),2) as 'Nett Product Sales'
INTO 
	ProductAnalysis
FROM 
	Orders
	JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	JOIN Products ON [Order Details].ProductID = Products.ProductID
	JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY
	Orders.OrderDate,
	Products.ProductName,
	Categories.CategoryName
