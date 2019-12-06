SELECT *
FROM dept;

-- dept테이블에 부서번호 99, 부서명 ddit, 위치 daejeon

INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : 테이블에 저장된 컬럼의 값을 변경
--UPDATE 테이블명 SET 컬럼명1 = 적용하려고 하는 값1, 컬럼명2 = 적용하려고 하는 값2..............
--[WHERE row 조회 조건] -- 조회조건에 해당하는 데이터만 없데이트가 된다.

--부서번호가 99번인 부서의 부서명을 대덕IT로, 지역을 영민빌딩으로 변경

--WHERE절없이 실행하면 제한 조건이 없기 떄문에 dept테이블의 모든 행에 대해 부서명, 위치정보를 수정한다.
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

--업데이트전에 업데이트 하려고 하는 테이블을 WHERE절에 기술한 조건으로 SELECT를 하여
--업데이트 대상 ROW를 확인해보기
SELECT *
FROM dept;
COMMIT;

--SUBQUERY를 이용한 UPDATE 
--emp 테이블에 신규 데이터 입력
--사원번호 9999, 사원이름 'brown', 업무 null
INSERT INTO emp(empno, ename) VALUES(9999,'brown');
COMMIT;
SELECT *
FROM emp;

--사원번호가 9999인 사원의 소속 부서와, 담당업무를 SMITH사원의 부서 업무로 업데이트
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                  job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

--DELETE : 조건에 해당하는 ROW를 삭제
--컬럼의 값을 삭제?? (NULL)값으로 변경하려면 --> NULL로 UPDATE

--DELETE 테이블명
--[WHERE 조건]

--UPDATE쿼리와 마찬가지고 DELETE 쿼리 실행전에는 해당 테이블을 WHERE조건을 동일하게 하여 
--SELECT를 실행, 삭제될 ROW를 먼저 확인해보자

--emp 테이블에 존재하는 사원번호 9999인 사원을 삭제
--WHERE절 기술없이 실행시키면 emp테이블의 모든 데이터가 삭제된다
DELETE emp
WHERE empno = 9999;
COMMIT;

--매니저가 7698인 모든 사원을 삭제
--서브쿼리를 사용
SELECT *
FROM emp
WHERE mgr = 7698;

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
                
--위 쿼리는 아래와 동일
DELETE emp WHERE mgr = 7698;
ROLLBACK;


--읽기 일관성 (ISOLATION LEVEL)
--DML문이 다른사용자에게 어떻게 영향을 미치는지 정의한 레벨(0~3)

--ISOLATION LEVEL2
--선행 트랜잭션에서 읽은 데이터
--(FOR UPDATE)를 수정, 삭제하지 못함

UPDATE dept SET dname = 'ddit';

--BOSTON 40
SELECT *
FROM dept
WHERE deptno = 40
FOR UPDATE;

--다른 트랜잭션에서 수정을 못하기 때문에 현 트랜잭션에서 해당 ROW는 항상 동일한 결과값으로 조회할 수 있다.
--하지만 후행 트랜잭션에서 신규 데이터 입력후 commit을 하면 현 트랜잭션에서 조회가 된다.(phantom read)

--ISOLATION LEVEL 3
--SERIALIZABLE READ
--트랜잭션의 데이터 조회기준이 트랜잭션 시작 시점으로 맞춰진다
--즉 후행 트랜잭션에서 데이터를 신규 입력, 수정, 삭제 후 COMMIT을 하더라도
--선행트랜잭션에서는 해당 데이터를 보지 않는다.

--트랜잭션 레벨수정(serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;

--dept테이블에 synonym을생성


--DDL : TABLE 생성
--CREATE TABLE [사용자명.]테이블명(
    /*컬럼명1 컬럼타입1,
    컬럼명1 컬럼타입2,....
    컬럼명N 컬럼타입N);*/
-- ranger_no NUMBER     : 레인저 번호
-- ranger_num VARCHAR29(50) : 레인저 이름
-- reg_dt DATE          : 레인저 등록일자
-- 테이블 생성 DDL : Data Defination Language(데이터 정의어)
-- DDL rollback이 없다(자동커밋되므로 rollback을 할 수 없다.)
CREATE TABLE ranger(
    rnager_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE);
DESC ranger;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--DDL문장은 ROLLBACK 처리가 불가하다.
ROLLBACK;
--WHERE table_name = 'ranger';
--오라클에서는 객체 생성시 소문자로 생성하더라도 내부적으로는 대문자로 관리한다.

INSERT INTO ranger VALUES(1, 'brown', SYSDATE);
--데이터가 조회되는것을 확인했음
SELECT *
FROM ranger;

--DML문은 DDL과 다르게 ROLLBACK이 가능하다.
ROLLBACK;

--DATE타입에서 필드 추출하기
--EXTRACT(필드명 FROM 컬럼/expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;

--테이블 생성시 컬럼 레벨 제약조건 생성
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR(14),
    loc VARCHAR2(13));
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR2(13));

--dept_test 테이블의 deptno 컬럼에 PRIMARY KEY제약조건이 있기 떄문에
--deptno가 동일한 데이터를 입력하거나 수정할 수 없다
--최초의 데이터이므로 입력성공
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test데이터에 deptno가 99인 데이터가있으므로
--PRIMARY KEY 제약조건에 의해 입력될 수 없다.
--ORA-00001 unique constraint 제약 위배
--위배되는 제약조건명 SYS-c007105 제약조건 위배
--SYS-c007105 제약조건을 어떤 제약조건인지 판단하기 힘드므로
--제약조건에 이름을 코딩룰에 의해 붙여주는편이 유지보수시 편하다
INSERT INTO dept_test VALUES(99, '대덕', '대전');

--테이블 삭제 후 제약조건 이름을 추가하여 재생성
--primary key : pk_테이블명
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR2(13));

--INSERT 구문 복사
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '대덕', '대전');

