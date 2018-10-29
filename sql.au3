INSERT INTO `members` (`id`, `name`, `username`, `password`) VALUES ('1', 'test', 'user', 'pass');PW7Qkal&3ClKLlOKlFKq

DELETE FROM members WHERE id IN(1)

UPDATE `members` SET `password` = '".$pass."' WHERE `id` = '$user_id' LIMIT 1