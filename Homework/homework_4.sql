
-- Задание 1
-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

USE lesson_4;
SELECT 	user_id, COUNT(media_id) AS 'Кол-во лайков'
FROM likes 
	WHERE user_id IN 
		(SELECT user_id FROM profiles WHERE TIMESTAMPDIFF (YEAR , birthday, CURDATE()) > 12)
		GROUP BY user_id



-- Задание 2
/*
Определить кто больше поставил лайков (всего): мужчины или женщины.
В таблице LIKES user_id это кто ставит лайк, в таблице MEDIA user_id это кому ставят лайк
*/
		
USE lesson_4;
SELECT 
	COUNT(m.user_id) AS 'Кол-во лайков', 
	p.gender 
FROM media m 

JOIN profiles p  ON m.user_id = p.user_id
GROUP BY p.gender



-- Задание 3
/*Вывести всех пользователей, которые не отправляли сообщения.*/

USE lesson_4;
SELECT 
	u.id,
	CONCAT(u.firstname, '  ', u.lastname) AS 'Поль-ли которые не отправляли сообщения'
FROM users u 
WHERE u.id NOT IN (SELECT from_user_id FROM messages)


-- Задание 4
/*
 * Пусть задан некоторый пользователь. 
 Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.
 */

USE lesson_4;

SELECT from_user_id AS ' ID Пользователея', count(to_user_id) AS 'Кол-во отправленных сообщений' FROM messages 
WHERE to_user_id =1 AND from_user_id IN 


-- Друзья
(SELECT initiator_user_id  FROM friend_requests   -- ID друзей, заявку которых я подтвердил
WHERE target_user_id = 1 AND status ='approved'
UNION 
SELECT target_user_id FROM friend_requests
WHERE initiator_user_id = 1 AND status ='approved') -- ID друзей, подтвердивших мою заявку
GROUP BY from_user_id

