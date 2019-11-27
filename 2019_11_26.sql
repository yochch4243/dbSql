-- 숫자 --> 문자열
-- 문자열 --> 숫자


--날짜 포맷 : YYYY, MM, DD, HH24,  SI, SS
--숫자 포맷 : 숫자표현 : 9, 자리맞춤을 위한 0표시 : 0, 화폐단위 : L
--           1000자리 구분 : , 소수점 : .
-- 숫자 --> 문자열 TO_CHAR(숫자, '포맷')
-- 숫자 포맷이 길어질 경우, 숫자 자리수를 충분히 표현.
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;

SELECT TO_CHAR(10000000000, '999,999,999,999')
FROM dual;

--NULL 처리 함수 : NVL, NVL2, NULLIF, COALSCE

--NVL(expr1, expr2) : 함수 인자 두개.
--expr1이 NULL이면 expr2를 반환
--expr1이 NULL이 아니면 exprl을 반환
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2리턴
--expr1 IS NULL expr3리턴

SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl2_comm,
       NVL2(comm, comm, -500) nvl_comm --NVL과 동일한 결과
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL을 리턴
--expr1 != expr2 expr1을 리턴
--comm 이 NULL일때 comm+500 = NULL
    --NULLIF(NULL,NULL) : NULL
--comm이 NULL이 아니때 comm+500 : comm+500
    --NULLIF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) nullif_comm
FROM emp;

--COALESCE(expr1, expr2, expr3 .....)
--인자중에 첫 번째로 등장하는 NULL이 아닌 exprN을 리턴
--expr1 IS NOT NULL expr1을 리턴하고
--expr1 IS NULL COALESCE(expr2, expr3 ......)
SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;

SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_N_1, COALESCE(mgr, 9999) mgr_n_2
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) nvl_reg_dt,
       COALESCE(reg_dt, sysdate) n_reg_dt
FROM users
WHERE userid NOT IN('brown');

--condition
--case
--emp.job 컬럼을 기준으로
--'SALESMAN'이면 sal * 1.05을 적용한 값 리턴
--'MANAGER'이면 sal * 1.10을 적용한 값 리턴
--'PRESIDENT'이면 sal * 1.20을 적용한 값 리턴
--위 세가지 직군이 아닐경우 sal 리턴
--empno, ename, sal ,job,  요율 적용한 급여 AS BONUS
SELECT empno, ename, sal, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bouns,
       comm,
       CASE
            WHEN comm IS NOT NULL THEN comm
            ELSE -10
       END case_null
       
       --NULL처리 함수 사용하지 않고 CASE절 이용하여
       --comm이 NULL일 경우 -10을 리턴하도록 구성
FROM emp;

--DECODE
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05, 'MANAGER', sal * 1.10, 'PRESIDENT', sal * 1.20, sal) bonus
FROM emp;

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


















































