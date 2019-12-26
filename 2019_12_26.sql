-- EXCEPTION
-- ���� �߻��� ���α׷��� �����Ű�� �ʰ�
-- �ش� ���ܿ� ���� �ٸ� ������ ���� ��ų�� �ְԲ� ó���Ѵ�.

-- ���ܰ� �߻��ߴµ� ����ó���� ���°�� : pl/sql ����� ������ �Բ� ����ȴ�
-- �������� SELECT ����� �����ϴ� ��Ȳ���� ��Į�� ������ ���� �ִ� ��Ȳ

--emp ���̺��� ��� �̸��� ��ȸ
SET SERVEROUTPUT ON;
DECLARE
    -- ����̸��� ������ �� �ִ� ����
    v_ename emp.ename%TYPE;
BEGIN
    -- 14���� SELECT ����� ������ SQL --> ��Į�� ������ ������ �Ұ����ϴ�(����)
    SELECT ename
    INTO v_ename
    FROM emp;
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('�������� select ����� ����');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('WHEN OTHERS');
END;
/

-- ����� ���� ����
-- ����Ŭ���� ������ ������ ���� �̿ܿ��� �����ڰ� �ش� ����Ʈ���� �����Ͻ� �������� 
-- ������ ���ܸ� ����, ����� �� �ִ�.
-- ���� ��� SELECT ����� ���� ��Ȳ���� ����Ŭ������ NO_DATA_FOUND ���ܸ� ������
-- �ش� ���ܸ� ��� NO_EMP ��� �����ڰ� ������ ���ܷ� �������Ͽ� ���ܸ� ���� �� �ִ�.

--
DECLARE
    -- EMP ���̺��� ��ȸ ����� ���� �� ����� ����� ���� ����
    -- ���ܸ� EXCEPTION
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    
    -- NO_DATA_FOUND
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno = 7000;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            RAISE no_emp;   --java throw new NOEmpException()
    END;
    EXCEPTION
        WHEN no_emp THEN
            DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/

-- ����� �Է¹޾Ƽ� �ش� ������ �̸��� �����ϴ� �Լ�
-- getEmpName(7369) --> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
--�����
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
END;
/

SELECT getempname(7369)
FROM dual;


--function 1
CREATE OR REPLACE FUNCTION getDeptName (p_deptno dept.deptno%TYPE)
RETURN VARCHAR2 IS
--�����
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;
END;
/

SELECT getdeptname(10)
FROM dual;

--cache : 20
-- ������ ������ :
-- deptno (�ߺ� �߻�����) : �������� ���� ���ϴ�
-- empno (�ߺ��� ����) : �������� ����

-- emp ���̺��� �����Ͱ� 100������ ���
-- 100���߿��� deptno�� ������ 4��(10~40)
SELECT getdeptname(deptno), -- 4����
       getempname(empno)    -- row ����ŭ �����Ͱ� ����
FROM emp;

SELECT deptcd, LPAD(' ',(LEVEL -1) * 4, ' ') || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

CREATE OR REPLACE FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
--�����
    v_dname VARCHAR2(200);
BEGIN
    SELECT LPAD(' ',(p_lv -1) * 4, ' ') || p_dname
    INTO v_dname
    FROM dual;
    
    RETURN v_dname;
END;
/CREATE OR REPLACE FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
--�����
    v_dname VARCHAR2(200);
BEGIN
    /*
    SELECT LPAD(' ',(p_lv -1) * 4, ' ') || p_dname
    INTO v_dname
    FROM dual;
    */
    v_dname := LPAD(' ',(p_lv -1) * 4, ' ') || p_dname;

    RETURN v_dname;
END;
/

SELECT deptcd, indent(LEVEL, deptnm) deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM users;

-- users ���̺��� ��й�ȣ �÷��� ������ ������ ��
-- ������ ����ϴ� ��й�ȣ �÷� �̷��� �����ϱ� ���� ���̺�
CREATE TABLE users_history(
    userid VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt date
);

CREATE OR REPLACE TRIGGER make_history
    -- timing
    BEFORE UPDATE ON USERS
    FOR EACH ROW    -- ��Ʈ����, ���� ������ ���� ������ �����Ѵ�.
    -- ���� ������ ���� : OLD
    -- ���� ������ ���� : NEW
BEGIN
    -- users ���̺��� pass �÷��� ������ �� trigger ����
    IF :OLD.pass != :NEW.pass THEN
        INSERT INTO users_history
            VALUES (:OLD.userid, :OLD.pass, SYSDATE);
    END IF;
    -- �ٸ� �÷��� ���ؼ��� �����Ѵ�.
END;
/

-- USERS ���̺��� PASS�÷��� ���� ���� ��
-- TRIGGER�� ���ؼ� users_history ���̺� �̷��� �����Ǵ��� Ȯ��
SELECT *
FROM users_history;

UPDATE USERS SET pass = '1234'
WHERE userid = 'brown';








