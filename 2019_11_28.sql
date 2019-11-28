--emp 테이블, dept테이블 조인
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

--natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로 같은 값을 가질 경우 조인.
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, ename, a.empno
FROM emp a NATURAL JOIN dept b;

--oracle문법
ALTER TABLE emp DROP COLUMN dname;
SELECT deptno, ename, emp.empno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join 하려고 하는 테이블간 동일한 이름의 컬럼이 두개 이상일 때
--join 컬럼을 하나만 사용하고 싶을 때.

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--oracle SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI SQL with ON
--조인하고자 하는 테이블의 컬럼 이름이 다를 때 
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인

--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
--직원의 관리자 정보를 조회
--직원이름, 관리자이름

--ANSI
--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름.
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--oracle
--직원이름, 직원의 관리자 이름, 직원의 관리자의 관리자 이름.
SELECT e.ename 사원 , m.ename 관리자
FROM emp e, emp m
WHERE e.mgr = m.empno;


SELECT e.ename 사원, m.ename 관리자, sm.ename 대장, smm.ename
FROM emp e, emp m, emp sm, emp smm
WHERE e.mgr = m. empno
AND (m.mgr = sm.empno AND sm.mgr = smm.empno);

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
     JOIN emp t ON (m.mgr = t.empno)
     JOIN emp k ON (t.mgr = k.empno);
     
--직원의 이름과, 해당 직원의 관리자 이름을 조회한다
--단, 직원의 사번이 7369~7698인 직원을 대상으로 조회

SELECT *
FROM emp;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

-- NON-EQUI JOIN : 조인 조건이 =(equal)이 아닌 JOIN
-- != ,  BETWEEN AND

SELECT *
FROM salgrade;

SELECT  empno, ename, sal /*급여 grade*/
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





















































    










































