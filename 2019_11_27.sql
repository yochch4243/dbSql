--cond1
SELECT empno, ename, DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') dname
FROM emp;

SELECT empno, ename
       ,CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
        END dename
FROM emp;

--cond 2
--건강검진 대상자 조회 쿼리
--1. 올해년도가 짝수 / 홀수년인지
--2. hiredate에서 입사년도가 짝수 / 홀수인지

--1. TO_CHAR(SYSDATE, 'YYYY')
--> 올해년도 구분( 0: 짝수년, 1 : 홀수년)
SELECT MOD( TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

--2.
SELECT empno, ename, 
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;

SELECT empno, ename, 
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(2020 , 2)
            THEN '건강검진대상자'
            ELSE '건강검진비대상자'
        END contact_to_doctor
FROM emp;

SELECT userid, usernm, alias, reg_dt,
        CASE
            WHEN MOD(TO_CHAR(reg_dt, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END contactdoctor
FROM users;

SELECT userid, usernm, alias, reg_dt,
       DECODE(MOD(TO_CHAR(reg_dt, 'YYYY'), 2) =  (MOD(TO_CHAR(SYSDATE , 'YYYY') ,2), '건강검진 대상자', '건강검진 비대상자') contactdoctor
FROM emp;

SELECT a.userid, a.usernm, a. alias, 
       DECODE(MOD(a.yyyy,2), MOD(a.this_yyyy, 2), '건강검진 대상자', '건강검진 비대상자')
FROM
(SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy, TO_CHAR(SYSDATE, 'YYYY') this_yyyy
FROM users;) a;

--GROUP FUNCTION 
--특정 컬럼이나, 표현을 기준으로 여러행의 값을 한 행의 결과로 생성
--COUNT- 건수, SUM- 합계, AVG- 평균, MAX- 최대값, MIN- 최소값
--전체 직원을 대상으로
--가장 높은 급여(14건의 --> 1건)
DESC emp;
SELECT MAX(sal) m_sal, -- 가장 높은 급여
       MIN(sal) min_sal, -- 가장 낮은 급여
       ROUND(AVG(sal), 2) avg_sal, -- 전 직원의 급여의 평균
       SUM(sal) sum_sal, --전 직원의 급여 총 합.
       COUNT(sal) count_sal,--급여 건수(NULL이 아닌값이면 1건
       COUNT(mgr) count_mgr, --직원의 관리자 건수 
       COUNT(*) count_row --특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을 때
FROM  emp;

-- 부서 번호별 그룹함수를 적용
SELECT deptno,
       MAX(sal) m_sal, -- 부서에서 가장 높은 급여
       MIN(sal) min_sal, -- 부서에서  가장 낮은 급여
       ROUND(AVG(sal), 2) avg_sal, -- 부서 직원의 급여의 평균
       SUM(sal) sum_sal, -- 부서 직원의 급여 총 합.
       COUNT(sal) count_sal,-- 부서의 급여 건수(NULL이 아닌값이면 1건
       COUNT(mgr) count_mgr, -- 부서직원의 관리자 건수 
       COUNT(*) count_row -- 부서의 조직원 수
FROM  emp
GROUP BY deptno;

SELECT deptno, enmae,
       MAX(sal) m_sal, -- 부서에서 가장 높은 급여
       MIN(sal) min_sal, -- 부서에서  가장 낮은 급여
       ROUND(AVG(sal), 2) avg_sal, -- 부서 직원의 급여의 평균
       SUM(sal) sum_sal, -- 부서 직원의 급여 총 합.
       COUNT(sal) count_sal,-- 부서의 급여 건수(NULL이 아닌값이면 1건
       COUNT(mgr) count_mgr, -- 부서직원의 관리자 건수 
       COUNT(*) count_row -- 부서의 조직원 수
FROM  emp
GROUP BY deptno,
GROUP BY ename;

--SELECT절에는 GROUP BY 절에 표현된 컬럼 이외의 컬럼이 올 수 없다.
--논리적으로 성립이 되지 않음(여러명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수갑들은 SELECT절에 표현이 가능
SELECT deptno, 1 , '문자열' , SYSDATE,
       MAX(sal) m_sal, -- 부서에서 가장 높은 급여
       MIN(sal) min_sal, -- 부서에서  가장 낮은 급여
       ROUND(AVG(sal), 2) avg_sal, -- 부서 직원의 급여의 평균
       SUM(sal) sum_sal, -- 부서 직원의 급여 총 합.
       COUNT(sal) count_sal,-- 부서의 급여 건수(NULL이 아닌값이면 1건
       COUNT(mgr) count_mgr, -- 부서직원의 관리자 건수 
       COUNT(*) count_row -- 부서의 조직원 수
FROM  emp
GROUP BY deptno;

--그룹함수에서는 NULL 컬럼은 계산에서 제외된다.
--emp 테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 NULL)
SELECT COUNT(comm) count_comm, --NULL이 아닌값의 개수
       SUM(comm) sum_comm, --NULL값을 제외, 300 + 500 + 1400 + 0 = 2200
       SUM(sal + comm) tot_sal_sum,
       sum(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE 절에는 GROUP함수를 표현 할 수 없다.
-- 1. 부서별 최대 급여 구하기
-- 2. 부서별 최대 급여값이 3000이 넘는 행만 구하기
--deptno, 최대급여
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000 -- ORA-00934 WHERE 절에는 GROUP 함수가 올 수 없다
GROUP BY deptno;

SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

SELECT MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal, 
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp;

SELECT deptno,MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp
GROUP BY deptno;

--grp 3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20 , 'RESEARCH', 30, 'SALES'),
       MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp
GROUP BY deptno;

--grp 4
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

--grp 5
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

--grp 6
--전체 직원수 구하기
SELECT COUNT(*)
FROM emp;

SELECT COUNT(deptno) cnt
FROM dept;

--gpr 7 직원이 속한 부서의 개수
SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

SELECT COUNT(DISTINCT deptno) cnt
FROM emp;

--JOIN
--1. 테이블 구조변경(컬럼 추가)
--2. 추가된 컬럼에 값을 update.
--dname 컬럼을 emp테이블에 추가
DESC emp;
DESC dept;
--컬럼 추가(dname, VARCHAR2(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;
SELECT *
FROM emp;
ROLLBACK;
UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;

SELECT *
FROM emp;

-- SALES --> MARKET SALES
-- 총 6건의 데이터 변경이 필요하다.
-- 값의 중복이 있는 형태(반 정규형)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

--emp 테이블, dept테이블 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;




























































