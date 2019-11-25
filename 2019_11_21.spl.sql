-- col IN (value1, value2...)
-- col의 값이 IN연산자 안에 나열된 값중에 포함될 때 참으로 판정

--RDBS - 집합개념
--1.집합에는 순서가 없다
-- {1, 5, 7}, {5, 1, 7}

--2.집합에는 중복이 없다
-- {1, 1, 5, 7}, {5, 1, 7}

SELECT *
FROM emp
WHERE deptno IN (10, 20);  --emp 테이블의 직원의 소속부서가 10번 이거나 20번인 직원정보만 조회

--이거나 --> OR(또는)
--이고 --> AND(그리고)

-- IN --> OR
-- BETWEEN AND --> AND + 산술비교

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid = 'brown' OR userid = 'cony' OR userid = 'sally';

-- LIKE 연산자 : 문자열 매칭 연산
-- $ : 여러 문자(문자가 없을 수도 있다)
-- _ : 하나의 문자 

--emp 테이블에서 사원 이름이 S로 시작하는 사원정보만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--SMITH
--SCOTT
--첫 글자는 S로 시작하고 4번째 글자는 T
--두번째, 세번째, 다섯번째 문자는 어떤 문자든 올 수 있다.

SELECT *
FROM emp
--WHERE ename LIKE 'S__T_';
WHERE ename LIKE 'S%T_'; -- 'STE', 'STTTT', 'STESTS'

--where 4 조건에 맞는 데이터 조회 
--member 테이블에서 성이 [신]씨인 사람만 조회
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신__';

--where 5
--member 테이블에서 이름에 [이] 글자가 포함되는 회원정보 조회
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--컬럼 값이 NULL인 데이터 찾기
--emp 테이블에 보면 MGR 컬럼이 NULL인 데이터가 존재
SELECT *
FROM emp
WHERE MGR = 7698;  --MGR 컬럼 값이 7698인 사원 정보조회
WHERE MGR = NULL; --MGR 컬럼값이 NULL인 사원 정보조회( 조회되지 않음 )
WHERE MGR = IS NULL; -- NULL값 확인에는 IS NULL을 사용해야 함.

SELECT *
FROM emp
WHERE comm IS NOT NULL;

UPDATE emp SET comm =0
WHERE empno=7844;

COMMIT;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND : 조건을 동시에 만족
--OR : 조건을 한개만 충족하면 만족
-- emp 테이블에서 mgr가 7698 사번이고(AND) sal(급여)가 1000이상인 사원 정보조회
SELECT *
FROM emp
WHERE MGR = 7698
AND sal > 1000;

--emp 테이블에서 mgr가 7698이거나(OR), 급여가 1000보다 큰 사람.
SELECT *
FROM emp
WHERE mgr = 7698
OR sal > 1000;
 --emp 테이블에서 mgr이 7698, 7839가 아닌 직원 정보조회
 SELECT *
 FROM emp
 WHERE mgr NOT IN(7698,7839)
 OR mgr IS NULL;
 
 --where 7
 
 SELECT *
 FROM emp
 WHERE job = 'SALESMAN'
 AND hiredate >= TO_DATE('19810601', 'yyyymmdd');









































































