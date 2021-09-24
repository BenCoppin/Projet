SELECT PY.*
FROM (SELECT SUM(products.quantityInStock * products.buyPrice) AS Turnover,
                       date_format(orders.orderDate,'%Y-%M') AS dateSales,
                       products.productVendor AS Seller,
                       products.quantityInStock AS quantity,
                       products.buyPrice AS price,
      ROW_NUMBER() OVER (PARTITION BY YEAR(orders.orderDate), MONTH(orders.orderDate) ORDER BY Turnover DESC) AS rankMonth
      FROM orderdetails
      JOIN products ON products.productCode = orderdetails.productCode
      JOIN orders ON orderdetails.orderNumber = orders.orderNumber
      GROUP BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, seller
      ORDER BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, rankMonth ASC
     ) PY
     WHERE rankMonth <=2