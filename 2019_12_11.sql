--INDEX�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� ����� ���� �ִ� ���

SELECT rowid, emp.*
FROM emp;

SELECT rowid, empno
FROM emp;

--emp���̺��� ��� �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp���̺��� empnoĿ���� ��ȸ
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--���� �ε��� ����(pk_emp �������� ���� -> unique ������� --> pk_emp�ε��� ����)

--INDEX���� (�÷��ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���(emp.empno, dept.deptno)
--NON - UNIQUE INDEX (default) : �ε��� �÷��� ���� �ߺ��� �� �ִ� �ε��� (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp(empno); --? UNIQUE INDEX ����¹��

--���� ��Ȳ�̶� �޶��� ���� EMPNO�÷����� ������ �ε�����
--UNIQUE --> NONUNIQUE �ε����� �����
CREATE INDEX idx_n_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--7782
DELETE emp WHERE empno = 9999;
INSERT INTO emp (empno, ename) VALUES (7782, 'brown');
COMMIT;

--DEPT���̺��� PK_DEPT (PRIMARY KEY ���������� ������)
--PK_DEPT : deptno
SELECT *
FROM dept;

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'DEPT';

--emp���̺� job�÷����� non-unique�ε��� ����
--�ε����� : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp���̺��� �ε����� 2������
--1. empno
--2. job


--IDX_02 �ε���
--emp���̺��� �ε����� 2������
--1. empno
--2. job

SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';

--idx_n_emp_03
--emp ���̺��� job, ename �÷����� non-unique �ε��� ����
CREATE INDEX idx_n_emp_03 ON emp (job, ename);
SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--ename, job �÷����� emp ���̺� non-unique �ε��� ���� --> idx_n_emp_03 �÷��� �������ٲ�
CREATE INDEX idx_n_emp_04 ON emp(ename,job);
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp WHERE job = 'MANAGER'
OR ename LIKE 'j%';

SELECT *
FROM TABLE(dbms_xplan.display);

--JOIN ���������� �ε���
--emp ���̺��� empno�÷����� PRIMARY KEY ���������� ����
--dept ���̺��� deptno �÷����� PRIMARY KEY ���������� ����
--EMP ���̺��� PRIMARY KEY ������ ������ �����̹Ƿ� �����
DELETE emp WHERE ename = 'brown';
SELECT *
FROM emp
WHERE ename = 'brown';
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);

DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

--deptno �÷��� �������� unique �ε��� ����
CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test (deptno);

--dname �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_n_dept_test_02 ON dept_test(dname);

--deptno, dname �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_n_dept_test_03 ON dept_test(deptno,dname);

--idx2
DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

