top 5 country per month
SELECT PY.*
FROM (SELECT customers.country, DATE_FORMAT(orders.orderdate, '%m-%y')  AS dateSales, COUNT(orders.orderNumber) AS CNT,
      ROW_NUMBER() OVER (PARTITION BY YEAR(orders.orderDate), MONTH(orders.orderDate) ORDER BY CNT DESC) AS rankMonth
      FROM customers 
      JOIN orders
           ON customers.customerNumber = orders.customerNumber
      GROUP BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, customers.country
      ORDER BY YEAR(orders.orderDate)DESC, MONTh (orders.orderDate)DESC, rankMonth ASC
     ) PY
     WHERE rankMonth <=5