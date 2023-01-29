SELECT
	[Order Details].OrderID,
	Orders.ShipVia as 'Ship Via',
	Orders.ShipCity as 'Ship City',
	Orders.ShipCountry as 'Ship Country',
	SUM([Order Details].Quantity) as'Product Sales',
	CASE 
		WHEN Orders.ShipVia = 1
			THEN 'Speedy Express'
		WHEN Orders.ShipVia = 2
			THEN 'United Package'
		WHEN Orders.ShipVia = 3
			THEN 'Federal Shipping'
	END AS 'Shipper Company',
	CASE 
		WHEN SUM([Order Details].Quantity) <= 50
			THEN 'Low'
		WHEN SUM([Order Details].Quantity) > 50 AND
			SUM([Order Details].Quantity) <= 100
			THEN 'Middle'
		WHEN SUM([Order Details].Quantity) > 100
			THEN 'Top'
	END AS 'Shipper Category'
INTO
	ShipperAnalysis
FROM 
	[Order Details]
	INNER JOIN Orders  ON  [Order Details].OrderID = Orders.OrderID
GROUP BY
	[Order Details].OrderID,
	Orders.ShipVia,
	Orders.ShipCity,
	Orders.ShipCountry

	