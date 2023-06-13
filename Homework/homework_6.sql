/*Для решения задач используйте базу данных lesson4
Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного)
пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
 "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
(по желанию)* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
 communities и messages в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа.*/

-- Задание 1
/*Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного)
пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).*/

USE lesson_4;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
id BIGINT  PRIMARY KEY,
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(50)
);

DROP PROCEDURE IF EXISTS sp_add_user;
DELIMITER //
CREATE PROCEDURE sp_add_user(
user_id INT,
OUT res VARCHAR(150))

BEGIN

	DECLARE `answer_rollback` BIT DEFAULT b'0';
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `answer_rollback` = b'1';
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	END;
    
    START TRANSACTION;

    	 INSERT INTO users_old (id, firstname, lastname, email)
         SELECT id, firstname, lastname, email FROM users u WHERE  u.id = user_id;
	    
        
	IF `answer_rollback` THEN
		SET res = CONCAT('УПС. Ошибка: ', code, ' Текст ошибки: ', error_string);
		ROLLBACK;
	ELSE
		SET res = 'O K';
		COMMIT;
	END IF;
END//
DELIMITER ;
    
USE lesson_4;
CALL sp_add_user(9, @res);
SELECT * FROM users_old;
SELECT @user_id, @res


-- Задание 2
/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
 "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/
 
USE lesson_4;
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(50) READS SQL DATA 
BEGIN
	DECLARE answer_hello VARCHAR(50); -- ответ пользователю
    DECLARE crt  TIME ;    SET crt = CURRENT_TIME();
	SET answer_hello = CASE 
    WHEN crt >= '06:00:00'AND crt<='12:00:00' THEN  'Доброе утро'
    WHEN crt >'12:00:00'AND crt<='18:00:00' THEN  'Добрый день'
    ELSE 'Добрый вечер'
    END;    
RETURN answer_hello;
END//
DELIMITER ;

-- вызов функции
SELECT hello();


-- Задание 3
/*(по желанию)* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
 communities и messages в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа.
 *Тригер вешается на определенную таблицу */

USE lesson_4;
DROP TABLE IF EXISTS logs;

CREATE TABLE logs(
id INT PRIMARY KEY AUTO_INCREMENT ,
dt_tm TIMESTAMP,
name_table VARCHAR(30)
)ENGINE=ARCHIVE;

-- Тригер вешается на определенную таблицу на несколько таблиц не сработало 
-- Триггер  users
DROP TRIGGER IF EXISTS insert_table_users;
DELIMITER //
CREATE TRIGGER insert_table_users
AFTER INSERT ON users
FOR EACH ROW

BEGIN 
CALL sp_add_logs('users');
END //
DELIMITER ;

-- Триггер  communities
DROP TRIGGER IF EXISTS insert_table_communities;
DELIMITER //
CREATE TRIGGER insert_table_communities
AFTER INSERT ON communities
FOR EACH ROW

BEGIN 
CALL sp_add_logs('communities');
END //
DELIMITER ;

-- Триггер  messages
DROP TRIGGER IF EXISTS insert_table_messages;
DELIMITER //
CREATE TRIGGER insert_table_messages
AFTER INSERT ON messages
FOR EACH ROW

BEGIN 
CALL sp_add_logs('messages');
END //
DELIMITER ;

-- Процедура для триггеров 
DROP PROCEDURE IF EXISTS sp_add_logs;
DELIMITER //
CREATE PROCEDURE sp_add_logs(IN table_name VARCHAR(255))

BEGIN
	INSERT INTO logs (dt_tm, name_table)
	VALUES 
	(
		CURRENT_TIMESTAMP(),
		table_name 
	); 
END//
DELIMITER ;



USE lesson_4;
INSERT INTO users (firstname, lastname, email) 
VALUES 
('Rebden', 'Nf44inow', 'a5e@sdfexm5ple.org');

USE lesson_4;
INSERT INTO `communities` (name) 
VALUES ('!!!!а')

USE lesson_4;
INSERT INTO messages  (from_user_id, to_user_id, body, created_at) VALUES
(8, 2, 'Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.',  DATE_ADD(NOW(), INTERVAL 1 MINUTE))






































 
 