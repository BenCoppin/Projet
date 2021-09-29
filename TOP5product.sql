--top 5 country per month

SELECT PY. product , quantityStock, quantityOrdered, CONCAT(annee, "/", mois) AS dateSales, rang
FROM (SELECT products.productName AS product, products.quantityInStock AS quantityStock, 
            orderdetails.quantityOrdered AS quantityOrdered, 
            YEAR(orders.orderdate) AS annee,
            MONTH(orders.orderdate) AS mois,
            ROW_NUMBER() OVER (PARTITION BY YEAR(orders.orderDate), MONTH(orders.orderDate) ORDER BY orderdetails.quantityOrdered  DESC) AS Rang
        FROM products
      JOIN orderdetails ON orderdetails.productCode = products.productCode
      JOIN orders ON orders.orderNumber = orderdetails.orderNumber
      GROUP BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, products.productName
      ORDER BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, Rang ASC
     ) PY
     WHERE Rang <=5