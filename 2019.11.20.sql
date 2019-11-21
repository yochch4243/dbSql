--Ư�� ���̺��� �÷� ��ȸ
--1.DESC ���̺��
--2. SELECT *FROM user_tab_columns

--prod ���̺��� �÷���ȸ
DESC prod;

VARCHAR2, CHAR --> ���ڿ� (Character)
NUMBER --> ����
CLOB --> Character Large Object, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��.
            -- �ִ� ������ : VARCHAR2(4000), CLOB : 4GB
DATE --> ��¥(�Ͻ� = ��, ��, �� + �ð�, �� , ��

'2019/11/20 09:16:20' + 1 = ?

-- USERS ���̺��� ��� �÷��� ��ȸ
SELECT *
FROM users;

--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� �����÷�)
--��¥ + �������� ==> ���ڸ� ���� ��¥Ÿ���� ����� ���´�
--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�
--      col �� express [AS] ��Ī��
SELECT userid, usernm, reg_dt reg_date, reg_dt+5 AS after5day
FROM users;

DESC users;

--���ڻ��, ���ڿ���� (oracle: '', java : '', "")
--���̺� ���� ���� ���Ƿ� �÷����� ����
--���ڿ� ���� ���� (+, -, /,*)
--���ڿ� ���� ���� ( +�� ������������), ==> ||
SELECT 10-5, 'DB SQL ����',
        /* userid + '_modified', ���ڿ� ������ ���ϱ� �����̾���*/
        usernm || '_modified', reg_dt
FROM users;

--NULL : ���� �𸣴� ��
--NULL�� ���� �������� �׻� NULL�̴�
--DESCRIPTION ���̺�� : NOT NULL�� �����Ǿ��ִ� �÷����� ���� �ݵ�� ���� �Ѵ�

--users ���ʿ��� ������ ����
SELECT *
FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');
--�ʿ��� �����Ͱ� �������� ��쿡�� rollback�� �� �Ŀ� �ٽ� ������ commit���� Ȯ�����´�.
commit;

SELECT userid, usernm, reg_dt
FROM users;

--null ������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';
COMMIT;

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
--NULL���� ���� ������ ����� NULL�̴�
SELECT userid, usernm, reg_dt, reg_dt + 5
FROM users;

--select2
SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS ���̾���̵�, buyer_name AS �̸�
FROM buyer;

--���ڿ� �÷��� ���� (�÷� || �÷�, '���ڿ����' || �÷�)
--                 (CONCAT(�÷�, �÷�) )
SELECT userid, usernm,
        userid || usernm AS id_nm,
        CONCAT(userid, usernm) con_id_nm,
        -- ||�� �̿��� userid, uernm, pass ����
        userid || usernm|| pass id_nm_pass,
        -- CONCAT�� �̿��� userid, usernm, pass
        CONCAT(CONCAT(userid, usernm), pass) con_id_nm_pass
FROM users;

--����ڰ� ������ ���̺� ��� ��ȸ
SELECT table_name
FROM user_tables;

SELECT * FROM LPROD;
SELECT * FROM BUYPROD;
SELECT * FROM CART;
SELECT * FROM BUYER;
SELECT * FROM MEMBER;
SELECT * FROM NO_EXISTS_TABLE;
SELECT * FROM PROD;
SELECT * FROM USERS;

SELECT 'SELECT * FROM ' || table_name || ';' query,
        CONCAT(CONCAT('SELECT * FROM ', table_name), ';') query2
FROM user_tables;

--WHERE : ������ ��ġ�ϴ� �ุ ��ȸ�ϱ� ���� ���
--        �࿡ ���� ��ȸ������ �ۼ�
--WHERE���� ������ �ش� ���̺��� ��� �࿡ ���� ��ȸ
SELECT userid, usernm, alias, reg_dt
FROM users;

SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown';     --userid �÷��� 'brown'�� ��(row)�� ��ȸ

--emp���̺��� ��ü ������ ��ȸ (��� ��(row), ��(column))
SELECT *
FROM emp;

SELECT *
FROM dept;

--�μ���ȣ(deptno)�� 20���� ũ�ų� ���� �μ����� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 20;

--�����ȣ(empno)�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
SELECT *
FROM emp
WHERE empno >= 7700;

--����Ի����ڰ� 1982�� 1�� 1�� ������ ���
--���ڿ�--> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�', '��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : ��-��-��
--�̱� ��¥ ǥ�� : ��-��-�� (01-01-2000)
SELECT empno, ename, hiredate,
       2000 no, '���ڿ����' str, TO_DATE('19810101', 'yyyymmdd')
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd')

--���� ��ȸ (BETWEEN ���۱��� AND �������)
--���۱���, ��������� ����
--����߿��� �޿�(sal)1000���� ũ�ų� ���� 2000���� �۰ų� ���� ���������ȸ

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;

--where1. emp���̺��� �Ի����ڰ� 1982�� 1��1�����ĺ��� 1983�� 1�� 1�� �����λ���� ename, hiredate ��ȸ
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101', 'yyyymmdd') AND TO_DATE('19830101', 'yyyymmdd');

--where 2 where 1�� �ε�ȣ�����ڷ� ǥ��
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd')
AND hiredate <= TO_DATE('19830101', 'yyyymmdd');


