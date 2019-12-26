--hash join
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;

-- dept ���� �д� ����
-- join �÷��� hash�Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�
-- 10 -->ccc1122 (hashvalue)
-- ó�� �д� ���̺��� ũ�Ⱑ �������� ����

-- emp���̺� ���� ���� ������ �����ϰ� ����
-- 10--> ccc1122 (hashvalue)

SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.deptno AND 99;

-- 10 ----> AAAAAA
-- 20 ----> BBBBBB
-- BETWEEN �϶��� ȿ������ ������ �� �ִ�.

-- �����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿� ��
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --���� ó������ ���������
      
      --�ٷ� �������̶� ���� ������� �޿���
       SUM(sal) OVER (ORDER BY sal
       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2
FROM emp
ORDER BY sal;

--ana 07
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum       
FROM emp;

--ROWS VS RANGE ���� Ȯ���ϱ�
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;

-- PL / SQL
-- PL / SQL �⺻����
-- DECLARE : �����, ������ �����ϴ� �κ�
-- BEGIN  : PL/SQL �� ������ ���� �κ�
-- EXCEPTION : ����ó���κ�

-- DBMS_OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON;
DECLARE  --�����
    -- java : Ÿ�� ������;
    -- pl/ sql : ������ Ÿ��;
    /*v_dname VARCHAR2(14);
    v_loc VARCHAR2(13);*/
    --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�.
    v_dname dept.dname %TYPE;
    v_loc dept.loc %TYPE;
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ��̸�, LOC������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    -- String a = "t";
    -- String b = "c";
    -- System.out.println(a + b);
    
    DBMS_OUTPUT.PUT_LINE(v_dname ||  v_loc);
END;
/  
-- / : PL/SQL ����� ����, ���� �ּ��޸� ����ȵ�

DESC dept;

--10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ��� ������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept 
-- �Ķ���͸� IN/OUT TYPE)
-- p_ �Ķ���� �̸�
(p_deptno IN dept.deptno%TYPE)
IS
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--����ó����(�ɼ�)
END;
/

EXEC PRINTDEPT(40);


CREATE OR REPLACE PROCEDURE printemp 

(p_empno IN emp.empno%TYPE)
IS

    ename emp.ename%TYPE;
    dname dept.dname%TYPE;
    
BEGIN
    SELECT ename, dname
    INTO ename, dname
    FROM emp, dept
    WHERE empno = p_empno
    AND emp.deptno = dept.deptno;
   
    
    DBMS_OUTPUT.PUT_LINE(ename || ' ' || dname);

END;
/
EXEC PRINTEMP(7654);

--PRO_2
CREATE OR REPLACE PROCEDURE registdept_test 

(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE)
IS
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
BEGIN
    INSERT INTO dept_test
    VALUES(p_deptno, p_dname, p_loc);
   
    DBMS_OUTPUT.PUT_LINE(deptno || dname || loc);
END;
/
EXEC registdept_test(99, 'ddit', 'daejeon');

 SELECT *
 FROM dept_test;

--PRO_3

CREATE OR REPLACE PROCEDURE UPDATEdept_test 

(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE)
IS
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
    loc dept.loc%TYPE; 
BEGIN
    UPDATE dept_test
    SET deptno = p_deptno, dname = p_dname , loc = p_loc
    WHERE deptno = 99;
   
    DBMS_OUTPUT.PUT_LINE(deptno || dname || loc);
END;
/
EXEC UPDATEdept_test(99, 'ddit_m', 'daejeon');

SELECT *
FROM dept_test;
