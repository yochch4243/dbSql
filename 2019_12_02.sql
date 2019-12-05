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
--france, belgium, denmark 3�� ������ ���ϴ� locations�� ����
--������ 5�� �ټ��� locations ������ �������ִ� ������ �����Ѵ�.
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

--OUTER join : join���ῡ �����ϴ��� ������ �Ǵ� ���̺��� �����ʹ� �������� �ϴ� join
--LEFT OUTER JOIN : ���̺� 1 LEFT OUTER JOIN ���̺� 2
--���̺� 1�� ���̺� 2�� ������ �� ���ο� �����ϴ��� ���̺� 1���� �����ʹ� ��ȸ�� �ǵ��� �Ѵ�.
--���ο� ������ �࿡�� ���̺�2�� �÷��� �������� �����Ƿ� null�� ǥ�õȴ�.

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
--�Ϲ����ΰ� �ٸ����� �÷��� (+) ǥ��
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;��ϴ� ���̺��� �÷�
--���� LEFT OUTER JOIN �Ŵ���
--      ON(����.�Ŵ�����ȣ = �Ŵ���.������ȣ)
--ORACLE OUTER
--WHERE ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) --�Ŵ����� �����Ͱ� �������� ����

--ansi outer
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno);
           
--ocacle outer
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--�Ŵ��� �μ���ȣ ����
--ANSI SQL WHERE���� ����� ����
-- -->OUTER ������ ������� ���� ��Ȳ
--OUTER JOIN�� ����Ǿ�� �ϴ� ���̺��� ��� �÷��� (+)�� �پ�� �Ѵ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--asi sql�� on���� ����� ���� ����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--emp���̺��� 14���� ������ �ְ� 14���� 10, 20, 30 �μ��߿� �� �μ��� ���Ѵ�
--������ dept���̺��� 10, 20, 30, 40�� �μ��� ����

--�μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�

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

--FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - �ߺ������� �ѰǸ� �����    
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




           
           





