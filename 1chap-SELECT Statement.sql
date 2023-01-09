-- 1-选择语句-在单一表格中检索数据
USE sql_store; -- 使用这一数据库，也可通过双击实现; 每条sql语句需;分隔
SELECT *  -- 选取所有列 or 输入列名称选取特定列
FROM customers -- 明确想要查询的表
-- WHERE customer_id = 1 筛选查询结果
ORDER BY first_name -- 依据某列排序

-- 2-数学运算符
SELECT 
    last_name, 
    first_name, 
    points, 
    points + 10 AS discount_factor -- +,-,*,/,%取余[运算顺序符合数学逻辑]; AS别名
FROM customers

-- 3-获取唯一值（不重复）
SELECT DISTINCT state
FROM customers

-- 4-WHERE子句-筛选
-- 常用筛选运算符：>,>=,<,<=,=,不等于'!=' or '<>'
SELECT *
FROM customers
WHERE state = 'VA' -- 字符串需加引号，日期值也需加引号

-- 5-多条件搜索-AND, OR, NOT $$连接的应是条件而非字符串
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR
      (points > 1000 AND state = 'VA')
-- AND:两者都符合 OR:两者符合其一 NOT:否定条件 //逻辑运算符顺序：AND-OR

-- 6-IN运算符
SELECT * From customers
WHERE state = 'VA' OR state = 'FL' OR state = 'GA'
-- equal with
SELECT * FROM customers
WHERE state IN ('VA', 'FL', 'GA') -- NOT IN is ok

-- 7-BETWEEN运算符
SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000 -- 包含临界值

-- 8-like运算符：检索遵循特定字符串模式的行
SELECT * FROM customers
WHERE last_name LIKE 'b%' -- %任意字符数，b%:以b开头的字符串;%b%:包含b的字符串；%b:以b结尾的字符串; _单个字符 ; NOT LIKE is ok

-- 9-REGEXP运算符(regular expression)
SELECT * FROM customers
WHERE last_name REGEXP 'field' -- 包含fieid的字符串
-- '^field': 以...开头; 'field$':以...结尾; '^field|mac|rose': 多个搜寻模式equal with OR; '[gim]e': ge, ie, me, 'e[a-h]'='e[abcdefgh]'

-- 10-IS NULL运算符：搜索缺失值
SELECT * FROM customers
WHERE phone IS NULL -- IS NOT NULL is ok

-- 11-ORDER BY子句
SELECT * FROM customers
ORDER BY state DESC, first_name  -- 默认升序
-- SELECT first_name, last_name, 10 AS points
-- FROM customers
-- ORDER BY 1, 2, points -- 1,2指选取列的顺序，也可按照别名排序

-- 12-LIMIT子句
SELECT * FROM customers
LIMIT 3 -- 返回三条数据（表默认的排序列，升序）
-- LIMIT 6, 3 -- 跳过六条数据后，返回三条（6称偏移量）

-- 选择语句的子句顺序:SELECT-FROM-WHERE-ORDER BY-LIMIT