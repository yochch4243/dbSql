SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT *
FROM locations;

--join 8
SELECT c.region_id, region_name, country_name
FROM countries c JOIN regions r ON (c.region_id = r.region_id)
WHERE region_name IN 'Europe';

--join 9
--france, belgium, denmark 3개 국가에 속하는 locations가 없다
--나머지 5개 다수의 locations 정보를 가지고있는 국가가 존재한다.
SELECT c.region_id, region_name, country_name, city
FROM countries c JOIN regions r ON (c.region_id = r.region_id)
               JOIN locations l ON(c.country_id = l.country_id)
WHERE region_name IN 'Europe';               

SELECT *
FROM departments;

--join 10
SELECT c.region_id, region_name, country_name, city, department_name
FROM countries c JOIN regions r ON (c.region_id = r.region_id)
               JOIN locations l ON(c.country_id = l.country_id)
               JOIN departments d ON (d.location_id = l.location_id)
WHERE region_name IN 'Europe';


--join 11
SELECT c.region_id, region_name, country_name,city, department_name, first_name || last_name name
FROM countries c JOIN regions r ON (c.region_id = r.region_id)
                 JOIN locations l ON(c.country_id = l.country_id)
                 JOIN departments d ON (d.location_id = l.location_id)
                 JOIN employees e ON(d.department_id = e.department_id);
SELECT *
FROM employees;

SELECT *
FROM jobs;

--join 12
SELECT employee_id, first_name name, e.job_id, job_title
FROM employees e JOIN jobs j ON(e.job_id = j.job_id);

--join 13

SELECT e.employee_id, e.first_name || e.last_name mgr_name, e.first_name || e.last_name name, j.job_id, j.job_title
FROM employees e, jobs j, employees m
WHERE j.job_id = e.job_id
AND m.manager_id = e.employee_id;

--OUTER join : join연결에 실패하더라도 기준이 되는 테이블의 데이터는 나오도록 하는 join
--LEFT OUTER JOIN : 테이블 1 LEFT OUTER JOIN 테이블 2
--테이블 1과 테이블 2를 조인할 때 조인에 실패하더라도 테이블 1쪽의 데이터는 조회가 되도록 한다.
--조인에 실패한 행에서 테이블2의 컬럼은 존재하지 않으므로 null로 표시된다.

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno);
           
--
SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno AND m.deptno = 10);
           
           SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno)
WHERE m.deptno = 10;

--ORACLE outer join syntax
--일반조인과 다른점은 컬럼명에 (+) 표시
--(+)표시 : 데이터가 존재하지 않는데 나와야하는 테이블의 컬럼
--직원 LEFT OUTER JOIN 매니저
--      ON(직원.매니저번호 = 매니저.직원번호)
--ORACLE OUTER
--WHERE 직원.매니저번호 = 매니저.직원번호(+) --매니저쪽 데이터가 존재하지 않음

--ansi outer
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno);
           
--ocacle outer
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--매니저 부서번호 제한
--ANSI SQL WHERE절에 기술한 형태
-- -->OUTER 조인이 적용되지 않은 상황
--OUTER JOIN이 적용되어야 하는 테이블의 모든 컬럼에 (+)가 붙어야 한다
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--asi sql의 on절에 기술한 경우와 동일
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--emp테이블에는 14명의 직원이 있고 14명은 10, 20, 30 부서중에 한 부서에 속한다
--하지만 dept테이블에는 10, 20, 30, 40번 부서가 존재

--부서번호, 부서명, 해당부서에 속한 직원수가 나오도록 쿼리를 작성

/*
10 ACCOUNTING   3  
20 RESEARCH     5
30 SALES        6
40 OPERATIONS   0

10 3
20 5
30 6
*/

SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT dept.deptno, dept.dname, COUNT(emp.deptno)
FROM dept LEFT OUTER JOIN emp ON(emp.deptno = dept.deptno)
GROUP BY dept.deptno, dept.dname
ORDER BY dept.deptno;

SELECT dept.deptno, dept.dname, COUNT(emp.deptno)
FROM emp LEFT OUTER JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY dept.deptno, dept.dname
ORDER BY dept.deptno;

--RIGHT OUTER JOIN

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno);

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m
           ON (e.mgr = m.empno);

--FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복데이터 한건만 남기기    
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m
           ON (e.mgr = m.empno);
           
SELECT *
FROM buyprod;

SELECT *
FROM prod;

--outerjoin 1
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
               ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));
               
--outerjoin 2
SELECT NVL(b.buy_date, TO_DATE('20050125', 'YYYYMMDD')) buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
               ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));

--outerjoin3           
SELECT NVL(b.buy_date, TO_DATE('20050125', 'YYYYMMDD')) buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty, 0) buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));

--outerjoin 4
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT product.pid, pnm, NVL(cid, 1) cid, NVL(day , 0) day, NVL(cnt, 0) cnt
FROM cycle RIGHT OUTER JOIN product ON (cycle.pid = product.pid AND cid IN 1);

--outerjoin 5
SELECT *
FROM customer;

SELECT product.pid, pnm, NVL(cycle.cid, 1) cid, NVL(cnm, 'brown') cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle FULL OUTER JOIN customer ON(cycle.cid = customer.cid)
           RIGHT OUTER JOIN product ON (cycle.pid = product.pid AND customer.cid IN 1);




           
           





