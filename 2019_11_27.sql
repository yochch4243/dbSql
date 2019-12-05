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

--cond 2
--�ǰ����� ����� ��ȸ ����
--1. ���س⵵�� ¦�� / Ȧ��������
--2. hiredate���� �Ի�⵵�� ¦�� / Ȧ������

--1. TO_CHAR(SYSDATE, 'YYYY')
--> ���س⵵ ����( 0: ¦����, 1 : Ȧ����)
SELECT MOD( TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

--2.
SELECT empno, ename, 
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;

SELECT empno, ename, 
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(2020 , 2)
            THEN '�ǰ����������'
            ELSE '�ǰ�����������'
        END contact_to_doctor
FROM emp;

SELECT userid, usernm, alias, reg_dt,
        CASE
            WHEN MOD(TO_CHAR(reg_dt, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contactdoctor
FROM users;

SELECT userid, usernm, alias, reg_dt,
       DECODE(MOD(TO_CHAR(reg_dt, 'YYYY'), 2) =  (MOD(TO_CHAR(SYSDATE , 'YYYY') ,2), '�ǰ����� �����', '�ǰ����� ������') contactdoctor
FROM emp;

SELECT a.userid, a.usernm, a. alias, 
       DECODE(MOD(a.yyyy,2), MOD(a.this_yyyy, 2), '�ǰ����� �����', '�ǰ����� ������')
FROM
(SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy, TO_CHAR(SYSDATE, 'YYYY') this_yyyy
FROM users;) a;

--GROUP FUNCTION 
--Ư�� �÷��̳�, ǥ���� �������� �������� ���� �� ���� ����� ����
--COUNT- �Ǽ�, SUM- �հ�, AVG- ���, MAX- �ִ밪, MIN- �ּҰ�
--��ü ������ �������
--���� ���� �޿�(14���� --> 1��)
DESC emp;
SELECT MAX(sal) m_sal, -- ���� ���� �޿�
       MIN(sal) min_sal, -- ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, -- �� ������ �޿��� ���
       SUM(sal) sum_sal, --�� ������ �޿� �� ��.
       COUNT(sal) count_sal,--�޿� �Ǽ�(NULL�� �ƴѰ��̸� 1��
       COUNT(mgr) count_mgr, --������ ������ �Ǽ� 
       COUNT(*) count_row --Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ���� ��
FROM  emp;

-- �μ� ��ȣ�� �׷��Լ��� ����
SELECT deptno,
       MAX(sal) m_sal, -- �μ����� ���� ���� �޿�
       MIN(sal) min_sal, -- �μ�����  ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, -- �μ� ������ �޿��� ���
       SUM(sal) sum_sal, -- �μ� ������ �޿� �� ��.
       COUNT(sal) count_sal,-- �μ��� �޿� �Ǽ�(NULL�� �ƴѰ��̸� 1��
       COUNT(mgr) count_mgr, -- �μ������� ������ �Ǽ� 
       COUNT(*) count_row -- �μ��� ������ ��
FROM  emp
GROUP BY deptno;

SELECT deptno, enmae,
       MAX(sal) m_sal, -- �μ����� ���� ���� �޿�
       MIN(sal) min_sal, -- �μ�����  ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, -- �μ� ������ �޿��� ���
       SUM(sal) sum_sal, -- �μ� ������ �޿� �� ��.
       COUNT(sal) count_sal,-- �μ��� �޿� �Ǽ�(NULL�� �ƴѰ��̸� 1��
       COUNT(mgr) count_mgr, -- �μ������� ������ �Ǽ� 
       COUNT(*) count_row -- �μ��� ������ ��
FROM  emp
GROUP BY deptno,
GROUP BY ename;

--SELECT������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����.
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT���� ǥ���� ����
SELECT deptno, 1 , '���ڿ�' , SYSDATE,
       MAX(sal) m_sal, -- �μ����� ���� ���� �޿�
       MIN(sal) min_sal, -- �μ�����  ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, -- �μ� ������ �޿��� ���
       SUM(sal) sum_sal, -- �μ� ������ �޿� �� ��.
       COUNT(sal) count_sal,-- �μ��� �޿� �Ǽ�(NULL�� �ƴѰ��̸� 1��
       COUNT(mgr) count_mgr, -- �μ������� ������ �Ǽ� 
       COUNT(*) count_row -- �μ��� ������ ��
FROM  emp
GROUP BY deptno;

--�׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�.
--emp ���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NULL)
SELECT COUNT(comm) count_comm, --NULL�� �ƴѰ��� ����
       SUM(comm) sum_comm, --NULL���� ����, 300 + 500 + 1400 + 0 = 2200
       SUM(sal + comm) tot_sal_sum,
       sum(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE ������ GROUP�Լ��� ǥ�� �� �� ����.
-- 1. �μ��� �ִ� �޿� ���ϱ�
-- 2. �μ��� �ִ� �޿����� 3000�� �Ѵ� �ุ ���ϱ�
--deptno, �ִ�޿�
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000 -- ORA-00934 WHERE ������ GROUP �Լ��� �� �� ����
GROUP BY deptno;

SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

SELECT MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal, 
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp;

SELECT deptno,MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp
GROUP BY deptno;

--grp 3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20 , 'RESEARCH', 30, 'SALES'),
       MAX(sal) m_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_row
FROM emp
GROUP BY deptno;

--grp 4
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

--grp 5
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

--grp 6
--��ü ������ ���ϱ�
SELECT COUNT(*)
FROM emp;

SELECT COUNT(deptno) cnt
FROM dept;

--gpr 7 ������ ���� �μ��� ����
SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

SELECT COUNT(DISTINCT deptno) cnt
FROM emp;

--JOIN
--1. ���̺� ��������(�÷� �߰�)
--2. �߰��� �÷��� ���� update.
--dname �÷��� emp���̺� �߰�
DESC emp;
DESC dept;
--�÷� �߰�(dname, VARCHAR2(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;
SELECT *
FROM emp;
ROLLBACK;
UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;

SELECT *
FROM emp;

-- SALES --> MARKET SALES
-- �� 6���� ������ ������ �ʿ��ϴ�.
-- ���� �ߺ��� �ִ� ����(�� ������)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

--emp ���̺�, dept���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;




























































