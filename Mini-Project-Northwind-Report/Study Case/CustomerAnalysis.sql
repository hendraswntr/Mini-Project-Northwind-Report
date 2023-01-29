SELECT 
    Customers.CompanyName as 'Company Name',
	Customers.ContactTitle as 'Contact Title',
	Customers.Country,
	Customers.City,
	COUNT(Orders.OrderID) as 'Total Order',
	SUM([Order Details].UnitPrice*[Order Details].Quantity) as 'Product Sales',
	CASE 
		WHEN SUM([Order Details].UnitPrice*[Order Details].Quantity) <= 10000
			THEN 'Low '
		WHEN SUM([Order Details].UnitPrice*[Order Details].Quantity) > 10000 AND
			SUM([Order Details].UnitPrice*[Order Details].Quantity) <= 100000
			THEN 'Middle '
		WHEN SUM([Order Details].UnitPrice*[Order Details].Quantity) > 100000
			THEN 'Top'
	END AS 'Customer Category'
INTO
	CustomerAnalysis
FROM 
    Customers
    INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY 
    Customers.CompanyName,
	Customers.ContactTitle,
	Customers.Country,
	Customers.City