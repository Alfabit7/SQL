/* 
1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
2. Заполните БД данными (поля и наполнение см. в презентации)
3. Выведите название, производителя и цену для товаров, количество которых превышает 2
4. Выведите весь ассортимент товаров марки “Samsung”
(по желанию) С помощью регулярных выражений найти:

5* Товары, в которых есть упоминание "Iphone"
6* Товары, в которых есть упоминание"Samsung"
7* Товары, в которых есть ЦИФРЫ
8* Товары, в которых есть ЦИФРА "8"

*/

-- Задание 1
-- Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными (поля и наполнение см. в презентации)

-- Проверяем есть ли база с названием homework_1, если есть удаляем её (тоже самое можно сделать для таблицы)
DROP DATABASE IF EXISTS homework_1;
-- Создаем базу данных homework_1
CREATE DATABASE homework_1; 
USE homework_1; -- Начинаем использовать базу данных

-- Создаем таблицу phones
CREATE TABLE phones(
	id INT AUTO_INCREMENT, NOT NULL PRIMARY KEY ,
	product_name VARCHAR(50) NOT NULL,
	manufactured VARCHAR (50) NOT NULL,
	product_count INT NOT NULL,
	price INT NOT NULL	
	);

 /* INT, VARCHAR(50 -кол-во символов) типы данных  UNIQUE -значение должно быть уникальным, NOT NULL обязательное для заполнения поле,  
  AUTO_INCREMENT автоматически генерирует уникальный номер для каждой новой строки 
  */

-- Задание 2
-- Заполните БД данными (поля и наполнение см. в презентации)
-- Наполняем базу значениями
INSERT INTO phones (product_name,manufactured,product_count, price)
VALUES 
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);



-- Задание 3
-- Выведите название, производителя и цену для товаров, количество которых превышает 2
USE homework_1;
SELECT product_name, manufactured, price, product_count FROM phones 
WHERE product_count>2;
-- SLECT выбираем столбцы(атрибуты), которые будем показывать , FROM- из таблицы phones, WHERE - показывать только те где столбец product_count имеет значения больше 2


-- Задание 4
-- Выведите весь ассортимент товаров марки “Samsung”

USE homework_1;
SELECT * FROM phones WHERE manufactured="Samsung"; 


-- Задание 5*
-- Товары, в которых есть упоминание "Iphone"
USE homework_1;
SELECT * FROM phones WHERE product_name LIKE "%Iphone%" OR  manufactured LIKE "%Iphone%";
-- Используем для выборки оператор LIKE "% search_query%" 


-- Задание 6*
-- Товары, в которых есть упоминание"Samsung"
USE homework_1;
SELECT * FROM phones WHERE product_name LIKE "%Samsung%" OR  manufactured LIKE "%Samsung%"; 


-- Задание 7*
-- Товары, в которых есть ЦИФРЫ
USE homework_1;
SELECT * 
FROM phones 
WHERE REGEXP_LIKE (product_name, '[:digit:]');
-- REGEXP_LIKE расширенная версия LIKE 


-- Задание 8*
-- Товары, в которых есть ЦИФРА "8"

USE homework_1;
SELECT * 
FROM phones 
WHERE REGEXP_LIKE (product_name, '8');