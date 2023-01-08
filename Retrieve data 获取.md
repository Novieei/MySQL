--1-选择语句-在单一表格中检索数据
USE sql_store; --使用这一数据库，也可通过双击实现 --每条sql语句需;分隔
SELECT * --选取所有列 or --输入列名称选取特定列
FROM customers --明确想要查询的表
--WHERE customer_id = 1 --筛选查询结果
ORDER BY first_name --依据某列排序

--2-运算符
SELECT 
    last_name, 
    first_name, 
    points, 
    points + 10 AS discount_factor --+,-,*,/,%取余[运算顺序符合数学逻辑] --AS别名
FROM customers

--3-获取唯一值（不重复）
SELECT DISTINCT state
FROM customers

--4-WHERE子句-筛选
--常用筛选运算符：>,>=,<,<=,=,不等于'!=' or '<>'
SELECT *
FROM customers
WHERE state = 'VA' --字符串需加引号，日期值也需加引号

--5-多条件搜索-AND, OR, NOT
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR
      (points > 1000 AND state = 'VA')
--AND:两者都符合 OR:两者符合其一 NOT:否定条件 //逻辑运算符顺序：AND-OR
