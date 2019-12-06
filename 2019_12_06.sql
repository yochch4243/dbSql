SELECT *
FROM dept;

-- dept���̺� �μ���ȣ 99, �μ��� ddit, ��ġ daejeon

INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : ���̺� ����� �÷��� ���� ����
--UPDATE ���̺�� SET �÷���1 = �����Ϸ��� �ϴ� ��1, �÷���2 = �����Ϸ��� �ϴ� ��2..............
--[WHERE row ��ȸ ����] -- ��ȸ���ǿ� �ش��ϴ� �����͸� ������Ʈ�� �ȴ�.

--�μ���ȣ�� 99���� �μ��� �μ����� ���IT��, ������ ���κ������� ����

--WHERE������ �����ϸ� ���� ������ ���� ������ dept���̺��� ��� �࿡ ���� �μ���, ��ġ������ �����Ѵ�.
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

--������Ʈ���� ������Ʈ �Ϸ��� �ϴ� ���̺��� WHERE���� ����� �������� SELECT�� �Ͽ�
--������Ʈ ��� ROW�� Ȯ���غ���
SELECT *
FROM dept;
COMMIT;

--SUBQUERY�� �̿��� UPDATE 
--emp ���̺� �ű� ������ �Է�
--�����ȣ 9999, ����̸� 'brown', ���� null
INSERT INTO emp(empno, ename) VALUES(9999,'brown');
COMMIT;
SELECT *
FROM emp;

--�����ȣ�� 9999�� ����� �Ҽ� �μ���, �������� SMITH����� �μ� ������ ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                  job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ����?? (NULL)������ �����Ϸ��� --> NULL�� UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE������ ���������� DELETE ���� ���������� �ش� ���̺��� WHERE������ �����ϰ� �Ͽ� 
--SELECT�� ����, ������ ROW�� ���� Ȯ���غ���

--emp ���̺� �����ϴ� �����ȣ 9999�� ����� ����
--WHERE�� ������� �����Ű�� emp���̺��� ��� �����Ͱ� �����ȴ�
DELETE emp
WHERE empno = 9999;
COMMIT;

--�Ŵ����� 7698�� ��� ����� ����
--���������� ���
SELECT *
FROM emp
WHERE mgr = 7698;

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
                
--�� ������ �Ʒ��� ����
DELETE emp WHERE mgr = 7698;
ROLLBACK;


--�б� �ϰ��� (ISOLATION LEVEL)
--DML���� �ٸ�����ڿ��� ��� ������ ��ġ���� ������ ����(0~3)

--ISOLATION LEVEL2
--���� Ʈ����ǿ��� ���� ������
--(FOR UPDATE)�� ����, �������� ����

UPDATE dept SET dname = 'ddit';

--BOSTON 40
SELECT *
FROM dept
WHERE deptno = 40
FOR UPDATE;

--�ٸ� Ʈ����ǿ��� ������ ���ϱ� ������ �� Ʈ����ǿ��� �ش� ROW�� �׻� ������ ��������� ��ȸ�� �� �ִ�.
--������ ���� Ʈ����ǿ��� �ű� ������ �Է��� commit�� �ϸ� �� Ʈ����ǿ��� ��ȸ�� �ȴ�.(phantom read)

--ISOLATION LEVEL 3
--SERIALIZABLE READ
--Ʈ������� ������ ��ȸ������ Ʈ����� ���� �������� ��������
--�� ���� Ʈ����ǿ��� �����͸� �ű� �Է�, ����, ���� �� COMMIT�� �ϴ���
--����Ʈ����ǿ����� �ش� �����͸� ���� �ʴ´�.

--Ʈ����� ��������(serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;

--dept���̺� synonym������


--DDL : TABLE ����
--CREATE TABLE [����ڸ�.]���̺��(
    /*�÷���1 �÷�Ÿ��1,
    �÷���1 �÷�Ÿ��2,....
    �÷���N �÷�Ÿ��N);*/
-- ranger_no NUMBER     : ������ ��ȣ
-- ranger_num VARCHAR29(50) : ������ �̸�
-- reg_dt DATE          : ������ �������
-- ���̺� ���� DDL : Data Defination Language(������ ���Ǿ�)
-- DDL rollback�� ����(�ڵ�Ŀ�ԵǹǷ� rollback�� �� �� ����.)
CREATE TABLE ranger(
    rnager_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE);
DESC ranger;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--DDL������ ROLLBACK ó���� �Ұ��ϴ�.
ROLLBACK;
--WHERE table_name = 'ranger';
--����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ��� ���������δ� �빮�ڷ� �����Ѵ�.

INSERT INTO ranger VALUES(1, 'brown', SYSDATE);
--�����Ͱ� ��ȸ�Ǵ°��� Ȯ������
SELECT *
FROM ranger;

--DML���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�.
ROLLBACK;

--DATEŸ�Կ��� �ʵ� �����ϱ�
--EXTRACT(�ʵ�� FROM �÷�/expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;

--���̺� ������ �÷� ���� �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR(14),
    loc VARCHAR2(13));
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR2(13));

--dept_test ���̺��� deptno �÷��� PRIMARY KEY���������� �ֱ� ������
--deptno�� ������ �����͸� �Է��ϰų� ������ �� ����
--������ �������̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test�����Ϳ� deptno�� 99�� �����Ͱ������Ƿ�
--PRIMARY KEY �������ǿ� ���� �Էµ� �� ����.
--ORA-00001 unique constraint ���� ����
--����Ǵ� �������Ǹ� SYS-c007105 �������� ����
--SYS-c007105 ���������� � ������������ �Ǵ��ϱ� ����Ƿ�
--�������ǿ� �̸��� �ڵ��꿡 ���� �ٿ��ִ����� ���������� ���ϴ�
INSERT INTO dept_test VALUES(99, '���', '����');

--���̺� ���� �� �������� �̸��� �߰��Ͽ� �����
--primary key : pk_���̺��
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR2(13));

--INSERT ���� ����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���', '����');

