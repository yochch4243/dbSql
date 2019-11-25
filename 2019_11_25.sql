--row 1
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

--row 2
SELECT ROWNUM, a.*
FROM 
(SELECT ROWNUM rn, empno, ename
FROM emp) a
WHERE rn BETWEEN 11 AND 14;

--row 3
SELECT rn, empno, ename
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

--Dual 테이블 : sys 계정에 있는 누구나 사용가능한 테이블이며
-- 데이터는 한 행만 존재하며 컬럼(dummy)도 하나 존재 ('X')

SELECT *
FROM dual;

--SINGLE ROW FUNCTION : 행당 한번의 FUNCTION이 실행
--1개의 행 INPUT --> 1개의 행으로 OUTPUT (COLUMN)
-- 'Hello, World')

SELECT LOWER('Hello, World')
FROM dual;

--emp 테이블에는 총 14건의 데이터(직원)가 존재 (14개의 행)
--아래 쿼리는 결과도 14개의 행
SELECT LOWER('Hello, World') low , UPPER('Hello, World') upper,
       INITCAP('Hello, World')
FROM emp;

--컬럼에 function 적용
SELECT empno, LOWER(ename) low_enm
FROM emp
WHERE ename = UPPER('smith'); --직원 이름이 smith인 사람을 조회하려면 대문자/소문자?

--테이블 컬럼을 가공해도 동일한 결과를 얻을 수 있지만
--테이블 컬럼보다는 상수쪽을 가공하는 것이 속도면에서 유리
--해당 컬럼에 인덱스가 존재하더라도 함수를 적용하게 되면 값이 달라지게 되어 
--인덱스를 활용할 수 없게 된다
--예외 : FBI(Function Based Index)
SELECT empno, LOWER(ename) low_enm
FROM emp
WHERE LOWER(ename) = 'smith'; --지향하는 쿼리가 아님, 위의 쿼리 사용할 것.

--HELLO
--,
--WORLD
--HELLO, WORLD(위 세가지 문자열 상수를 이용, CONCAT함수를 사용하여 문자열 결합)
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD') c1,
       'HELLO' || ', ' || 'WORLD' c2,
       
       --시작인덱스는 1부터, 종료인덱스 문자열까지 포함한다.
       SUBSTR('HELLO, WORLD', 1, 5) s1, --SUBSTR(문자열, 시작인덱스, 종료인덱스)
       
       --INSTR : 문자열에 특정 문자열이 존재하는지, 존재할 경우 문자의 인덱스를 리턴
       INSTR('HELLO, WORLD', 'O') i1,  --5, 9
       --'HELLO, WOLD' 문자열의 인덱스 이후에 등장하는 'O' 문자열의 인덱스 리턴
       INSTR('HELLO, WORLD', 'O', 6) i2,  -- 문자열의 특정 인덱스 이후부터 검색하도록 옵션
       INSTR('HELLO, WORLD', 'O') i3,
       
       --L/ RPAD  특정 문자열의 왼쪽/ 오른쪽에 설정한 문자열 길이보다 부족한만큼 문자열을 채워넣는다
       LPAD('HELLO, WORLD', 15, '*') L1,
       LPAD('HELLO, WORLD', 15) L2,
       RPAD('HELLO, WORLD', 15, '*') R1,
       
       --REPLACE(대상문자열, 검색문자열, 변경할 문자열
       --대상문자열에서 검색문자열을 변경할문자열로 치환
       REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1,
       
       --문자열 앞, 뒤의 공백을 제거
       '   HELLO, WORLD   ' before_trim,
       TRIM('   HELLO, WORLD   ') after_trim,
       TRIM('H' FROM 'HELLO, WORLD') after_trim2 --특정 문자를 제거
       
FROM dept;

--숫자 조작함수
--ROUND : 반올림 - ROUND(숫자, 반올림자리)
--TRUNC : 절삭 - TRUNC(숫자, 절삭자리)
--MOD : 나머지 연산 - MOD(피제수, 제수) // MOD(5,2) : 1

SELECT ROUND(105.54, 1) r1, ----반올림 결과가 소수점 한자리까지 나오도록(소수점 둘째 자리에서 반올림)
       ROUND(105.55, 1) r2,
       ROUND(105.55, 0) r3, --소수점 첫째 자리에서 반올림
       ROUND(105.55, -1) r4 --정수 첫번째 자리에서 반올림
FROM dual;

















