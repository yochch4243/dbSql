SELECT *
FROM ych.users;

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES
WHERE OWNER = 'YCH';

SELECT *
FROM ych.fastfood;
--sem.fastfood --> fastfood
--생성후 다음 SQL이 정상적으로 동작하는지 확인
CREATE SYNONYM fastfood FOR ych.fastfood;

SELECT *
FROM fastfood;

