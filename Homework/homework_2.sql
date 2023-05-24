
-- Задание 1
/*Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными.*/
DROP DATABASE IF EXISTS  homework_2;
CREATE  DATABASE homework_2;
USE homework_2;


CREATE TABLE sales
(
id SERIAL,
Order_date DATE,
Count_product INT NOT NULL
);


INSERT INTO sales (Order_date, Count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

-- Задание 2
/*Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : меньше 100 - Маленький заказ; от 100 до 300 - Средний заказ; больше 300 - Большой заказ.*/

SELECT Order_date, Count_product,
CASE 
	WHEN Count_product<=100
		THEN 'Маленький заказ'
	WHEN count_product >= 100 AND count_product <= 300
			THEN 'Средний заказ'
		WHEN count_product > 300 
			THEN 'Большой заказ'
END AS Тип_заказа
FROM sales;


-- Задание 3
/*
Создайте таблицу “orders”, заполните ее значениями. Выберите все заказы. 
В зависимости от поля order_status выведите столбец full_order_status: OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
*/

USE homework_2;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
id SERIAL,
employee_id VARCHAR(45) NOT NULL,
amount DECIMAL NOT NULL,
order_status VARCHAR(10) NOT NULL
);


INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');


SELECT *,

CASE
	WHEN order_status ='OPEN'
		THEN 'Order is in open state'
	WHEN order_status ='CLOSED'
		THEN 'Order is closed'
	WHEN order_status ='CANCELLED'
		THEN 'Order is cancelled'
END AS full_order_status
FROM orders;


-- Задание 4
/*
Чем NULL отличается от 0?
*/
/*
Ответ
NULL это отсутствие значения а 0 это значение нуля или false в булевом типе данных
*/














