--h5
SELECT LPAD(' ', (LEVEL -1) * 4) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--실습 h9
SELECT null, seq, parent_seq, LPAD(' ', 4 * (LEVEL -1)) || title title 
FROM BOARD_TEST
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq =  parent_seq
ORDER BY CONNECT_BY_ROOT(seq) DESC, seq asc;

--사원이름, 사원번호, 전체직원건수
SELECT ename, empno, COUNT(*), SUM(sal)
FROM emp
GROUP BY ename, empno;

SELECT ename, sal, deptno, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 30
ORDER BY sal desc)

UNION ALL

SELECT ename, sal, deptno, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 20
ORDER BY sal desc)

UNION ALL

SELECT ename, sal, deptno, ROWNUM sal
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 10
ORDER BY sal desc)
ORDER BY deptno,sal desc;




--교수님 방법 ana0
SELECT ename, sal, deptno, rn sal_rank
FROM
(SELECT ename, sal, deptno, ROWNUM j_rn
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc)) a,

(SELECT rn, ROWNUM j_rn
FROM
(SELECT b.*, a.rn
FROM
(SELECT ROWNUM rn
FROM dual
CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp);) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE b.cnt >= a.rn;
ORDER BY b.deptno, a.rn))b
WHERE a.j_rn = b.j_rn;

--위의 쿼리를 분석함수를 이용하여 작성
SELECT ename, sal, deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) row_rank
FROM emp;

SELECT empno, ename, sal, deptno,
        RANK() OVER (ORDER BY sal desc, empno) rank,
        DENSE_RANK() OVER (ORDER BY sal desc, empno) dense_rank,
        ROW_NUMBER() OVER (ORDER BY sal desc, empno) row_rank
        
FROM emp;


SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno
ORDER BY deptno;


SELECT a.empno, a.ename, a.deptno, b.cnt
FROM
(SELECT empno, ename, deptno
FROM emp) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY cnt;

--사원번호, 사원이름, 부서번호, 부서의 직원 수
SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;
--ana 02
SELECT empno, ename, sal, deptno,
       ROUND(AVG(sal) OVER(PARTITION BY deptno),2) dept_avg_sal
FROM emp;
--ana 03
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER(PARTITION BY deptno) dept_max_sal
FROM emp;
--ana 04
SELECT empno, ename, sal, deptno,
       MIN(sal) OVER(PARTITION BY deptno) dept_min_sal
FROM emp;

--전체 사원을 대상으로 급여순위가 자신보다 한 단계 낮은 사람의 급여
-- (급여가 같을 경우 입사일자가 빠른 사람이 높은 순위)
SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp
ORDER BY sal DESC, hiredate;

SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp
ORDER BY sal DESC, hiredate;

SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal  
FROM emp;

(SELECT ROWNUM rn, empno,ename, sal
FROM emp
ORDER BY sal) a,

SELECT empno, ename, sal
FROM emp;


