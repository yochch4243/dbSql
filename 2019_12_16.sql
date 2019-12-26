--GROUPUNG SETS(col1, col2)
-- ������ ����� ����
-- �����ڰ� GROUP BY�� ������ ���� ����Ѵ�
-- ROLLUP�� �޸� ���⼺�� ���� �ʴ´�
-- GROUPING SETS(col1, col2) = GROUPING SETS(col2, col1)

-- GROUP BY col1
-- UNION ALL
-- GROUP BY col2

-- emp ���̺��� ������ job�� �޿�(sal) + ��(comm)��,
--                     deptno(�μ�)�� �޿�(sal) + ��(comm)�� ���ϱ�
-- �������(GROUP FUNCTION) : 2���� SQL �ۼ� �ʿ�(UNION / UNION ALL)
SELECT job, null deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL

SELECT '', deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

-- GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
-- ���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

-- job, deptno�� �׷����� �� sal + comm�� ��
-- mgr�� �׷����� �� sal + comm�� ��
-- GROUP BY job, deptno
-- UNION ALL
-- GROUP BY mgr
-- --> GROUPING SETS((job, deptno), mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
       GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

--CUBE (col1, col2, ....)
-- ������ �÷��� ��� ������ �������� GROUP NY subset�� �����
-- CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
-- CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
-- CUBE�� ������ �÷����� 2�� �������� ����� ������ ������ ������ �ȴ� (2 ^ n)
-- �÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ�� ������ ���� ��������� �ʴ´�.

-- job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sum_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);

--job, deptno
-- 1,    1   --> GROUP BY job, deptno
-- 1,    0   --> GROUP BY job
-- 0,    1   --> GROUP BY deptno
-- 0,    0   --> GROUP BY --emp ���̺��� ��� �࿡ ���� GROUP BY

-- GROUP BY ����
-- GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
-- ������ ������ �����غ��� ���� ����� ���� �� �� �ִ�.
-- GROUP BY job, ROLLUP(deptno), CUBE(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD(empnct NUMBER);


SELECT *
FROM emp;

SELECT *
FROM dept_test;

DELETE dept_test
WHERE deptno = 99;

DROP TABLE dept_test;


INSERT INTO dept_test VALUES(99, 'it1', 'daejeon');
INSERT INTO dept_test VALUES(98, 'it2', 'daejeon');

UPDATE dept_test
SET empnct = (SELECT COUNT(deptno)
              FROM emp
              WHERE dept_deptno = emp.deptno);

DELETE FROM dept_test
WHERE deptno NOT IN (SELECT deptno
                     FROM emp); 
                     
SELECT *
FROM emp_test;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test
SET sal = sal + 200
WHERE sal < (SELECT AVG(sal)
             FROM emp
             WHERE deptno = emp_test.deptno);

SELECT empno, ename , sal
FROM emp
WHERE sal < ANY (SELECT AVG(sal)
             FROM emp
             GROUP BY deptno);

SELECT AVG(sal)
FROM emp
GROUP BY deptno;

ROLLBACK;

SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--MERGE ������ �̿��� ������Ʈ
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON (a.deptno = b.deptno) 
    
WHEN MATCHED THEN 
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;
    
ROLLBACK;


MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON (a.deptno = b.deptno) 
WHEN MATCHED THEN 
    UPDATE SET sal = CASE
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                     END;
                     
SELECT *
FROM emp_test;
ROLLBACK;