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
--������ ���� SQL�� ���������� �����ϴ��� Ȯ��
CREATE SYNONYM fastfood FOR ych.fastfood;

SELECT *
FROM fastfood;

