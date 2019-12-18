-- WITH
-- WITH 블록이름 AS (
--      서브쿼리
-- )
-- SELECT *
-- FROM 블록이름

-- deptno, avg(sal) avg_sal
-- 해당 부서의 급여평균이 전체 직원의 급여 평균보다 높은 부서에 한해 조회
SELECT deptno, AVG(sal) avg_sal
FROM emp 
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

--WITH절을 사용하여 위의 쿼리를 작성
WITH dept_sal_avg AS(
    SELECT deptno, AVG(sal) avg_sal
    FROM emp 
    GROUP BY deptno),
    emp_sal_avg AS(
    SELECT AVG(sal) avg_sal  
    FROM emp)
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);

--계층쿼리
--달력 만들기
--CONNECT BY LEVEL <= N
--테이블의 ROW 건수를 N만큼 반복한다
--CONNECT BY LEVEL 절을 사용한 쿼리에서는 
--SELECT절에서 LEVEL이라는 특수 컬럼을 사용할 수 있다.
--계층을 표현하는 특수 컬럼으로 1부터 증가하며 ROWNUM과 유사하나
--추후 배우게 될 START WITH, CONNECT BY절에서 다른점을 배우게 된다.

--2019 11월은 30일까지 존재
--201911
--일자 + 정수 = 정수만큼 미래의 일자
--201911 --> 해당 연월의 날짜가 몇일까지 존재하는가?
-- 1- 일요일 2- 월요일 ...
SELECT /*일요일이면 날짜, 화요일이면 날짜,..... 토요일이면 날짜*/
        
        MAX(DECODE(d,1,dt)) s, MAX(DECODE(d,2,dt)) m, MAX(DECODE(d,3,dt)) t, MAX(DECODE(d,4,dt)) w,
        MAX(DECODE(d,5,dt)) th, MAX(DECODE(d,6,dt)) f, MAX(DECODE(d,7,dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) , 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL) , 'IW') iw --20191201
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
     GROUP BY dt - (d-1)
     ORDER BY dt - (d-1);

--201911 --> 30
--201912 --> 31
--202402 --> 29
--201902 --> 28

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT NVL(MIN(DECODE(dt, '01', sales_sum)), 0) jan, NVL(MIN(DECODE(dt, '02', sales_sum)), 0) feb,
       NVL(MIN(DECODE(dt, '03', sales_sum)),0) mar, NVL(MIN(DECODE(dt, '04', sales_sum)),0) apr,
       NVL(MIN(DECODE(dt, '05', sales_sum)), 0) may, NVL(MIN(DECODE(dt, '06', sales_sum)), 0) jun
FROM
(SELECT TO_CHAR(dt, 'MM') dt, SUM(sales) sales_sum
 FROM sales
GROUP BY TO_CHAR(dt, 'MM'));


create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

SELECT *
FROM dept_h
START WITH deptcd = 'dept0'     --시작점은 deptcd = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd
;
/*
    dept0(XX회사)
        dept0_00(디자인부)
            dept0_00_0(디자인팀)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_01_0_0(기획파트)
        dept0_02(정보시스템부)
            dept0_02_0(개발1팀)
            dept0_02_1(개발2팀)