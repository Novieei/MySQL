-- 1-inner joins: 内连接
SELECT * FROM  orders -- FROM orders o 给表设置别名，别名可简化前缀书写，赋予别名后需使用别名代替全名 
JOIN cusomers
	ON orders.customer_id = customers.customer_id
-- 基于customer_id列连接两表；SELECT 多张列表中相同列时需加前缀

-- 2-joining across databases: 跨数据库连接
SELECT * FROM order_items oi
JOIN sql_inventory.products p -- 需要给不在当前查询数据库的表前加前缀
	ON oi.product_id = p.product_id
    
-- 3-self join: 自连接
USE sql_hr;
SELECT 
	e.employee_id,
	e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m -- 同一个表，但要使用不同别名
	ON e.reports_to = m.employee_id
    
-- 4-joining multiple tables: 多表连接
SELECT * FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id
    
-- 5-compoud join conditions: 复合连接条件 （单列中数据存在重复的情况，无法唯一识别）
SELECT * FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id

-- 6-implicit join syntax: 隐式连接语法
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.cutomer_id
-- equal with inner join, 不推荐使用，忘记输入连接条件会交叉连接

-- 7-outer joins: 外连接 (left and right)
SELECT * FROM customers c
JOIN orders o
	ON c.customers_id = o.customers_id -- 本身包含了筛选的意义，即只有下过订单的顾客才会被返回结果

SELECT * 
FROM customers c
LEFT JOIN orders o -- 左表的数据都会被返回，不管ON后条件正确与否；RIGHT即右表的数据都...
	ON c.customers_id = o.customers_id

-- 8-多表外连接
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.cusstomer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
    
-- 9-self outer joins: 自外连接
USE sql_hr;
SELECT * FROM employee e
LEFT JOIN employee m
	ON e.reports_to = m.manager_id

-- 10-using 子句
SELECT o.order_id,
       c.first_name,
       sh.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id 
    USING (customer_id) -- 当连接列的名称相同时，可用USING简化书写; 复合连接条件：USING (order_id, product_id)
LEFT JOIN shippers sh USING (shipper_id)

 -- 11-Natural joins: 自然连接
 SELECT * FROM orders o
 NATURAL JOIN customers c -- 让数据引擎自己看着办，基于共同列连接
 
 -- 12-cross join: 交叉连接
 -- 显式语法
 SELECT * FROM customers c
 CROSS JOIN products p -- 类似于穷尽组合
 -- 隐式语法
 SELECT *
 FROM cutomers c, products p
 
 -- 13-Unoin: 联合-结合多张表的行
 SELECT
	o.order_id,
    order_date,
    'Archived' AS status
FROM orders o
WHERE order_date < '2019-01-01'
UNION -- 合并多段查询结果; 第一段查询决定列名
SELECT
	o.order_id,
    order_date,
    'Active' AS status
FROM orders o
WHERE order_date >= '2019-01-01'
