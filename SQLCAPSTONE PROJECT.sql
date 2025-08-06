CREATE DATABASE Testing;
USE Testing;


  
-- List all suplliers in UK
Select 
     Id,
     CompanyName,
     ContactName,
     City,
     Country,
     Phone,
     Fax
FROM
    Supplier
WHERE 
    Country = 'UK'
GROUP BY
     Id,
     CompanyName,
     ContactName,
     City,
     Country,
     Phone,
     Fax;

-- List the First name, Last name and city for all customers.Concatenate the first and last name separated by a space and a comma as a single column
SELECT
      CONCAT
      (FirstName, ', ',LastName)
   As CustomerName,
      City
FROM
  Customer;

  -- List all customers in Sweden
  

  SELECT
   Id,
   FirstName,
   LastName,
   City,
   Country,
   Phone
FROM
   Customer
WHERE 
   Country = 'Sweden';

   -- List all supplier in alphabetical orders

   Select 
     Id,
     CompanyName,
     ContactName,
     City,
     Country,
     Phone,
     Fax
FROM
    Supplier
ORDER BY CompanyName ASC;

-- 5 List all supplier with their products

SELECT 
     S.Id,
     S.CompanyName,
     S.ContactName,
     S.City,
     S.Country,
     S.Phone,
     S.Fax,
     P.ProductName
FROM
   dbo.Supplier S
JOIN dbo.Product P ON P.SupplierId = S.Id
ORDER BY S.CompanyName;
    

    -- 6. List all orders with customer information

   
  SELECT
    O.Id,
    O.OrderDate,
    O.OrderNumber,
    O.TotalAmount,
    C.FirstName,
    C.LastName,
    C.City,
    C.Country,
    C.Phone
FROM
    [Order] O
JOIN
   Customer C ON O.CustomerId = C.Id;

   -- 7. List all orders with Product name,Quantity and Price, Sorted by Order Number

SELECT
    O.OrderDate,
    O.OrderNumber,
    P.ProductName,
    OI.Quantity,
    OI.UnitPrice

FROM
    [Order] O

JOIN
   OrderItem OI ON O.Id = OI.OrderId
JOIN
   Product P ON ProductId = P.Id
ORDER BY
   O.OrderNumber;
 
 -- 8. Use a Case Statement to show availability of product

 SELECT
       ProductName,
       IsDiscontinued,
CASE
      WHEN IsDiscontinued = 1 THEN 'Not Available'
      ELSE 'Available'
    END AS Availability
FROM
    Product;

    -- 9. Use Case to show supplier spoken language

    SELECT
        CompanyName,
        Country,

     CASE
         WHEN Country = 'USA' THEN 'English'
         WHEN Country = 'UK'   THEN 'English'
         WHEN Country = 'FRANCE'   THEN 'French'
         WHEN Country = 'SPAIN'   THEN 'Spanish'
         WHEN Country = 'ITALY'   THEN 'Italian'
         WHEN Country = 'CANADA'   THEN 'English'
         WHEN Country = 'SWEDEN'   THEN 'Swedish'
         ELSE 'Unknown'
    END AS Language
FROM
    Supplier;

    -- 10. List all Product that are packaged in jars

    SELECT
         ProductName,
         Package
   FROM
         Product
    WHERE Package LIKE '%Jar%';

    -- 11. List ProductName, UnitPrice and Packages for products that starts with Ca

    SELECT
         ProductName,
         UnitPrice,
         Package
    FROM
        Product
    WHERE ProductName LIKE 'Ca%';

--12. List the number of products from each supplier, sorted high to low

    SELECT
        S.CompanyName,
        COUNT (P.Id) AS NumberOfProduct
   FROM
       Supplier S
   JOIN
       Product P ON S.Id = P.Id
    GROUP BY S.CompanyName
    ORDER BY NumberOfProduct DESC;

-- 13. List the number of customers in each country

  SELECT
        Country,
    COUNT(Id) AS NumberOfCustomers

    FROM
        Customer
    GROUP BY Country;

-- 14. List the number customers in each country sorted high to low.

SELECT
        Country,
        COUNT (Id) AS NumberOfCustomers
   FROM
       Customer

    GROUP BY Country
    ORDER BY NumberOfCustomers DESC;


    -- 15. List the Total Order Amount for each customer, sorted high to low.

  SELECT
       C.Id,
       C.FirstName,
       C.LastName,
        
        SUM(OI.Quantity * OI.UnitPrice) AS TotalOrderAmount
    FROM
     Customer C
     
     
    JOIN 
        [Order] O ON C.Id = O.Id 
    JOIN
        OrderItem OI ON O.Id = OI.Id
    GROUP BY C.Id, C.FirstName, C.LastName
    ORDER BY TotalOrderAmount DESC;

    -- 16. List all countries with more than 2 suppliers.

    SELECT
         Country,
        COUNT(*) AS SupplierCount
    FROM
        Supplier
    GROUP BY 
       Country
    HAVING
       COUNT(*) > 2;

    -- 17. List the number of customers in each country.Only include countries with more than 10 customers

    SELECT
        Country,
        COUNT(*) AS CustomersCount
    FROM
       Customer
    GROUP BY
       Country
    HAVING
      COUNT(*) > 10;
    -- 18. List the number of customers in each country, except USA, sorted high to low. Only include countries with more than 10 customers

    SELECT
       Country,
       COUNT(*) AS CustomerCount
    FROM
       Customer
    WHERE
        Country <> 'USA'
    GROUP BY
        Country

   HAVING
        COUNT(*) > 9
   ORDER BY
        CustomerCount DESC;
    -- 19. List customers with average orders between $1000 and $1200

    SELECT
          C.Id,
          C.FirstName,
          C.LastName,
          AVG(OI.QUANTITY * OI.UnitPrice) AS AverageOrders
    FROM
       Customer C
    JOIN
      [Order] O ON C.Id = O.Id
    JOIN 
       OrderItem OI ON C.Id = OI.Id
     GROUP BY
        C.Id, C.FirstName, C.LastName
    HAVING
       AVG(OI.Quantity * OI.UnitPrice) BETWEEN 1000 AND 1200;
    --20.  Get the numbers of orders and total amount sold between Jan 1,2013 and Jan 31, 2013

    SELECT 
         COUNT(DISTINCT O.Id) AS TotalOrders,
         SUM(OI.Quantity * OI.UnitPrice) AS TotalAmountSold
    FROM
        [Order] O
    JOIN
        OrderItem OI ON O.Id = OI.ID
    WHERE 
       O.OrderDate >= '2010-01-01'

       -- BUSINESS INSIGHTS
       --- Focus on countries with many suppliers for bulk procument or cost negotiation
       --- Sweden and other non-US countries have a decent customer base, there's growth potential outside the U.S
       --- Patronize countries outside the U.S for targeted marketing,promotions and localized services
       ---Understanding the suppliers language improves communication and can guide localized support teams.
       --- Create loyalty programs or dedicated account managers for these customers to retain and upsell.
       --- Set up automated inventory alerts for out-of-stock products and plan timely restocking.
       --- Run A/B testing on packaging formats to see which influences customer purchases most.
       --- Use total sales between eacch months trends for forecasting and to set monthly/quarterly targets.

       ---- 