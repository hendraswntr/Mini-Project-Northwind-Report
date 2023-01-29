--8.Buatlah view untuk melihat Order Details yang berisi OrderID, ProductID, 
--ProductName, UnitPrice, Quantity, Discount, Harga setelah diskon.
CREATE VIEW OrderDetailsView
AS
SELECT 
    [Order Details].OrderID,
    [Order Details].ProductID,
    Products.ProductName,
    [Order Details].UnitPrice,
    [Order Details].Quantity,
    [Order Details].Discount,
    ([Order Details].UnitPrice * [Order Details].Quantity * (1 - [Order Details].Discount)) as FinalPrice
FROM 
	[Order Details]
	INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
