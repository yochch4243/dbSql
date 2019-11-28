--emp ���̺�, dept���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno
AND emp.deptno = 10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

--natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷����� ���� ���� ���� ��� ����.
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, ename, a.empno
FROM emp a NATURAL JOIN dept b;

--oracle����
ALTER TABLE emp DROP COLUMN dname;
SELECT deptno, ename, emp.empno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join �Ϸ��� �ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��� ��
--join �÷��� �ϳ��� ����ϰ� ���� ��.

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--oracle SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI SQL with ON
--�����ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ� �� 
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����

--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
--������ ������ ������ ��ȸ
--�����̸�, �������̸�

--ANSI
--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�.
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--oracle
--�����̸�, ������ ������ �̸�, ������ �������� ������ �̸�.
SELECT e.ename ��� , m.ename ������
FROM emp e, emp m
WHERE e.mgr = m.empno;


SELECT e.ename ���, m.ename ������, sm.ename ����, smm.ename
FROM emp e, emp m, emp sm, emp smm
WHERE e.mgr = m. empno
AND (m.mgr = sm.empno AND sm.mgr = smm.empno);

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
     JOIN emp t ON (m.mgr = t.empno)
     JOIN emp k ON (t.mgr = k.empno);
     
--������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�
--��, ������ ����� 7369~7698�� ������ ������� ��ȸ

SELECT *
FROM emp;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

-- NON-EQUI JOIN : ���� ������ =(equal)�� �ƴ� JOIN
-- != ,  BETWEEN AND

SELECT *
FROM salgrade;

SELECT  empno, ename, sal /*�޿� grade*/
FROM emp;

SELECT e.empno, e.ename, e.sal, m.grade
FROM emp e JOIN salgrade m ON(m.losal<= e.sal AND e.sal <= m.hisal);

--join0
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY emp.deptno;

--join0_1
-- ORACLE
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno NOT IN (20);

--ANSI SQL
SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno NOT IN (20);

--join0_2

--ANSI SQL
SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE sal > 2500;

--ORACLE

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500;


--join0_3
--ANSI SQL
SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE sal > 2500 AND empno > 7600;

--ORACLE
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600;

--join0_4
--ANSI SQL
SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH';

--ORACLE
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
AND dname = 'RESEARCH';





















































    










































