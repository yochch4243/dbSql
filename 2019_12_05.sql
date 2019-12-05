INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

SELECT *
FROM dept;

--sub 4
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     WHERE emp.deptno = dept.deptno);
SELECT *
FROM cycle;
SELECT *
FROM product;
SELECT *
FROM customer;
                     
SELECT pid, pnm
FROM product
WHERE pid NOT IN  (SELECT pid
                   FROM cycle
                   WHERE cycle.pid = product.pid
                   AND cid =1); 

--sub 6
--cid = 2�� ���� �����ϴ� ��ǰ �� cid =1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ

SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);
            
--sub 7

SELECT cycle.cid || cnm cnm, cycle.pid, pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.cid = 1
AND cycle.pid IN (SELECT pid
                  FROM cycle
                  WHERE cid = 2);
                  
--�Ŵ����� �����ϴ� ����������ȸ
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 1
              FROM emp m
              WHERE m.empno = e.mgr);

--sub 8          
SELECT e.*
FROM emp e JOIN emp m ON (m.empno = e.mgr);

SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--sub 9
SELECT *
FROM product;
SELECT *
FROM cycle;

SELECT *
FROM product
WHERE EXISTS (SELECT 'x'
              FROM cycle
              WHERE product.pid = cycle.pid
              AND cid = 1);
              
--sub 10
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'x'
                  FROM cycle
                  WHERE product.pid = cycle.pid
                  AND cid = 1);
                  
--���տ���
--UNION : ������, �� ������ �ߺ����� �����Ѵ�.
--�������� SALESMAN�� ������ ������ȣ, �����̸� ��ȸ
--�� �̷� ������� �����ϱ� ������ �����տ����� �ϰ� �� ��� �ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--������ �÷����� �������� �����̴�
--���� �ٸ� ������ ������
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�
--���Ʒ� ����¸� �ٿ��ֱ⸸ �Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� �����ؾ��Ѵ�.
--�÷��� ������ �ٸ���� ������ ���� �ִ� ������� ������ �����ش�.
SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

--INTERSECT : ������
-- �� ���հ� �������� �����͸� ��ȸ

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');

--MINUS : ������
--��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ��������� ��� ���տ� ������ �ش�.


SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');

SELECT empno, ename
FROM
(SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')
ORDER BY job) 

UNION ALL

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;


--DML
--INSERT : ���̺� ���ο� �����͸� �Է�
SELECT *
FROM emp;

DELETE dept
WHERE deptno = 99;
COMMIT;

--INSERT�� �÷��� ������ ���
--������ �÷��� ���� �Է��� ��� ������ ������ ����Ѵ�.
--INSERT IN TO ���̺��(�÷�1, �÷�2 ....)
--             VALUE (��1, ��2 ......)
--dept ���̺� 99�� �μ���ȣ, ddit��� �μ���, daejeon�̶�� �������� ���� ������ �Է�
INSERT INTO dept(deptno, dname, loc)
       VALUES(99, 'ddit', 'daejeon');
       
ROLLBACK;

--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����
--dept���̺��� �÷����� : deptno, dname, location)
INSERT INTO dept(loc, deptno, dname)
       VALUES('daejeon', 99, 'ddit');
       
--�÷��� ������� �ʴ°�� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�.
DESC dept;
INSERT INTO dept VALUES(99, 'ddit', 'daejeon');


--��¥ �� �Է��ϱ�
--1.SYSDATE
--2.����ڷκ��� ���� ���ڿ��� DATEŸ������ �����Ͽ� �Է�

DESC emp;
INSERT INTO emp VALUES ( 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);
SELECT *
FROM emp;
--2019�� 12�� 2�� �Ի�
INSERT INTO emp VALUES ( 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL);
ROLLBACK;

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է� �� �� �ִ�.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL
FROM dual;

ROLLBACK;