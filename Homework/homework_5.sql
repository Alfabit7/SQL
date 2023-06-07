/*

Для решения задач используйте базу данных lesson_4
(скрипт создания, прикреплен к 4 семинару).
1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь, указав указать имя и фамилию пользователя,
 количество отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат отправления между соседними сообщениями, 
получившегося списка. (используйте LEAD или LAG)
**/

-- Задание 1
/*
Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
*/

USE lesson_4;
CREATE OR REPLACE VIEW view_users AS
SELECT u.id, CONCAT(u.firstname, ' ',  u.lastname) AS name,  p.hometown, p.gender  FROM users u
JOIN profiles p ON u.id=p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) > 20

-- Выводим представление view_users
SELECT name, gender FROM view_users;


-- Задание 2
/*
Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь, указав  имя и фамилию пользователя,
количество отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
Кол-во сообщений 
*/

USE lesson_4;
SELECT 
	count_mess,
	DENSE_RANK() OVER (ORDER BY count_mess DESC) AS ranc_count_mess,
	name
FROM
	(SELECT
		COUNT(m.from_user_id) AS 'count_mess',
		CONCAT (u.firstname,' ', lastname) AS 'name'
	FROM messages m
	JOIN users u ON u.id =m.from_user_id 
	GROUP BY m.from_user_id
	ORDER BY count_mess DESC) AS list



-- Задание 3
/*
Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат отправления между соседними сообщениями, 
получившегося списка. (используйте LEAD или LAG)
*/
			
USE lesson_4;
SELECT 
created_at,
lag_created,
	TIMESTAMPDIFF(minute,created_at, lag_created)  AS diff_minut
FROM 
		(SELECT 
			created_at,
			LEAD(created_at,1,CURDATE()) OVER w AS lag_created
		FROM messages m 
		WINDOW w AS (ORDER BY  created_at)) AS List


-- Не понимаю почему код ниже, не работает ? 
/*
USE lesson_4;
SELECT 
	created_at,
	LEAD(created_at,1, curdate()) OVER w AS lag_created,
	TIMESTAMPDIFF(minute,created_at, lag_created)  AS diff_minut

FROM messages m 
WINDOW w AS (ORDER BY  created_at)

*/





