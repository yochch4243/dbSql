-- ���� --> ���ڿ�
-- ���ڿ� --> ����


--��¥ ���� : YYYY, MM, DD, HH24,  SI, SS
--���� ���� : ����ǥ�� : 9, �ڸ������� ���� 0ǥ�� : 0, ȭ����� : L
--           1000�ڸ� ���� : , �Ҽ��� : .
-- ���� --> ���ڿ� TO_CHAR(����, '����')
-- ���� ������ ����� ���, ���� �ڸ����� ����� ǥ��.
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;

SELECT TO_CHAR(10000000000, '999,999,999,999')
FROM dual;

--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALSCE

--NVL(expr1, expr2) : �Լ� ���� �ΰ�.
--expr1�� NULL�̸� expr2�� ��ȯ
--expr1�� NULL�� �ƴϸ� exprl�� ��ȯ
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2����
--expr1 IS NULL expr3����

SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl2_comm,
       NVL2(comm, comm, -500) nvl_comm --NVL�� ������ ���
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL�� ����
--expr1 != expr2 expr1�� ����
--comm �� NULL�϶� comm+500 = NULL
    --NULLIF(NULL,NULL) : NULL
--comm�� NULL�� �ƴ϶� comm+500 : comm+500
    --NULLIF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) nullif_comm
FROM emp;

--COALESCE(expr1, expr2, expr3 .....)
--�����߿� ù ��°�� �����ϴ� NULL�� �ƴ� exprN�� ����
--expr1 IS NOT NULL expr1�� �����ϰ�
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
--emp.job �÷��� ��������
--'SALESMAN'�̸� sal * 1.05�� ������ �� ����
--'MANAGER'�̸� sal * 1.10�� ������ �� ����
--'PRESIDENT'�̸� sal * 1.20�� ������ �� ����
--�� ������ ������ �ƴҰ�� sal ����
--empno, ename, sal ,job,  ���� ������ �޿� AS BONUS
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
       
       --NULLó�� �Լ� ������� �ʰ� CASE�� �̿��Ͽ�
       --comm�� NULL�� ��� -10�� �����ϵ��� ����
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


















































