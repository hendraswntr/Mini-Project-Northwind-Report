--9.Buatlah procedure Invoice untuk memanggil CustomerID, CustomerName/company name, 
--OrderID, OrderDate, RequiredDate, ShippedDate jika terdapat inputan CustomerID tertentu.
CREATE PROCEDURE Invoice (@CustomerID INT)
AS
BEGIN
    SELECT 
        Customers.CustomerID,
        Customers.CompanyName as CustomerName,
        Orders.OrderID,
        Orders.OrderDate,
        Orders.RequiredDate,
        Orders.ShippedDate
    FROM Orders
    INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
    WHERE Orders.CustomerID = @CustomerID
END
EXEC Invoice @CustomerID = 'value'
