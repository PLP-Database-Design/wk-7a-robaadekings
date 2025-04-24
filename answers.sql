-- QUETION1
-- Create a new 1NF table
CREATE TABLE OrderDetails_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(Product) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        UNNEST(STRING_TO_ARRAY(Products, ',')) AS Product
    FROM ProductDetail
) AS split_products;

-- QUETION2




-- Create Orders table (contains order information)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (contains product information per order)
CREATE TABLE OrderItems (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;