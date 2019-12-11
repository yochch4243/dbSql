--INDEX만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어 낼수 있는 경우

SELECT rowid, emp.*
FROM emp;

SELECT rowid, empno
FROM emp;

--emp테이블의 모든 컬럼을 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp테이블의 empno커럼을 조회
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--기존 인덱스 제거(pk_emp 제약조건 삭제 -> unique 제약삭제 --> pk_emp인덱스 삭제)

--INDEX종류 (컬럼중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스(emp.empno, dept.deptno)
--NON - UNIQUE INDEX (default) : 인덱스 컬럼의 값이 중복될 수 있는 인덱스 (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp(empno); --? UNIQUE INDEX 만드는방법

--위쪽 상황이랑 달라진 것은 EMPNO컬럼으로 생성된 인덱스가
--UNIQUE --> NONUNIQUE 인덱스로 변경됨
CREATE INDEX idx_n_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--7782
DELETE emp WHERE empno = 9999;
INSERT INTO emp (empno, ename) VALUES (7782, 'brown');
COMMIT;

--DEPT테이블에는 PK_DEPT (PRIMARY KEY 제약조건이 설정됨)
--PK_DEPT : deptno
SELECT *
FROM dept;

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'DEPT';

--emp테이블에 job컬럼으로 non-unique인덱스 생성
--인덱스명 : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp테이블에는 인덱스가 2개존재
--1. empno
--2. job


--IDX_02 인덱스
--emp테이블에는 인덱스가 2개존재
--1. empno
--2. job

SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';

--idx_n_emp_03
--emp 테이블의 job, ename 컬럼으로 non-unique 인덱스 생성
CREATE INDEX idx_n_emp_03 ON emp (job, ename);
SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--ename, job 컬럼으로 emp 테이블에 non-unique 인덱스 생성 --> idx_n_emp_03 컬럼의 순서가바뀜
CREATE INDEX idx_n_emp_04 ON emp(ename,job);
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp WHERE job = 'MANAGER'
OR ename LIKE 'j%';

SELECT *
FROM TABLE(dbms_xplan.display);

--JOIN 쿼리에서의 인덱스
--emp 테이블에는 empno컬럼으로 PRIMARY KEY 제약조건이 존재
--dept 테이블은 deptno 컬럼으로 PRIMARY KEY 제약조건이 존재
--EMP 테이블은 PRIMARY KEY 제약을 삭제한 상태이므로 재생성
DELETE emp WHERE ename = 'brown';
SELECT *
FROM emp
WHERE ename = 'brown';
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);

DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

--deptno 컬럼을 기준으로 unique 인덱스 생성
CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test (deptno);

--dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_n_dept_test_02 ON dept_test(dname);

--deptno, dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_n_dept_test_03 ON dept_test(deptno,dname);

--idx2
DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

