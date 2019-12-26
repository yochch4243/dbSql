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

--201910 : 35, 첫주의 일요일 : 20190929, 마지막주의 토요일 날짜 : 20191102
--일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
SELECT LDT - FDT + 1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
       7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
       TO_DATE(:yyyymm, 'YYYYMM') -
       (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
FROM dual);



SELECT
    MAX(DECODE(d, 1, dt)) 일, MAX(DECODE(d, 2, dt))월, MAX(DECODE(d, 3, dt)) 화,
    MAX(DECODE(d, 4, dt)) 수, MAX(DECODE(d, 5, dt)) 목, MAX(DECODE(d, 6, dt)) 금, MAX(DECODE(d, 7, dt)) 토
FROM
    (SELECT 
            --TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) 
            TO_DATE(:yyyymm, 'YYYYMM') -
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') -
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') -
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= (SELECT LDT - FDT + 1
                        FROM
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
                        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                        TO_DATE(:yyyymm, 'YYYYMM') -
                        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                        FROM dual)))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);
    
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL -1) * 3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'     --시작점은 deptcd = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LPAD('XX회사', 15, '*'),
       LPAD('XX회사', 15)
FROM dual;
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
*/
SELECT deptcd, LPAD(' ', (LEVEL -1) * 3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

-- 디자인팀 (dept0_00_0) 을 기준으로 상향식 계층쿼리 작성
-- 자기 부서의 부모부서와 연결을 한다.

SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '디자인%';

--조인조건은 한컬럼에서만 가능한가?
SELECT *
FROM tab_a, tab_b
WHERE tab_a.a = tab_b.a
AND tab_a.b = tab_b.b;

SELECT deptcd, LPAD(' ', (LEVEL -1) * 4) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '디자인%';

create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT LPAD(' ', (LEVEL -1) * 5) || s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;

SELECT LPAD(' ', (LEVEL -1) * 4) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch(가지치기)
-- 계층 쿼리의 실행순서
-- FROM --> START WITH ~ CONNECT BY --> WHERE
-- 조건을 CONNECT BY 절에 기술한 경우
-- . 조건에 따라 다음 ROW로 연결이 안되고 종료
-- 조건을 WHERE절에 기술한 경우
-- . START WITH ~ CONNECT BY 절에 의해 계층형으로 나온 결과에
--  WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회

--최상위 노드에서 하향식으로 탐색

--CONNECT BY절에 deptnm != '정보기획부' 조건을 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';


--WHERE 절에 deptnm != '정보기획부' 조건을 기술한 경우
--계층쿼리를 실행하고나서 최종 결과에 WHERE 절 조건을 적용
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--계층쿼리에서 사용 가능한 특수함수
-- CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회
SELECT deptcd, LPAD(' ', 4*(LEVEL -1)) || deptnm,
       CONNECT_BY_ROOT(deptnm) c_root
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row에서 현재 row까지 col값을 구분자로 연결해준 문자열
SELECT deptcd, LPAD(' ', 4*(LEVEL -1)) || deptnm, CONNECT_BY_ROOT(deptnm) c_root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--CONNECT_BY_ISLEAF : 해당 row가 마지막 노드인지(leaf node)
--leaf node : 1, node : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL -1)) || deptnm deptnm, CONNECT_BY_ROOT(deptnm) c_root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
       CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;

--실습 h6
SELECT seq, LPAD(' ', 4 * (LEVEL -1)) || title title
FROM BOARD_TEST
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq =  parent_seq;

SELECT board_test.*, null
FROM board_test;

--실습 h7
SELECT seq, LPAD(' ', 4 * (LEVEL -1)) || title title
FROM BOARD_TEST
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq =  parent_seq
ORDER BY seq DESC;

--실습 h8
SELECT null, seq, parent_seq, LPAD(' ', 4 * (LEVEL -1)) || title title 
FROM BOARD_TEST
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq =  parent_seq
ORDER SIBLINGS BY seq DESC;





