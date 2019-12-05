--2018�� ����û ��ǥ �õ����� ���������ڷ�
--1.tax���̺��� �̿�/ �õ�/�õ����� �δ� �������� �Ű�� ���ϱ�
--2.�Ű���� ���� ������ ��ŷ �ο��ϱ�
--��ŷ    �õ�  �ñ��� �δ翬������Ű��
-- 1    ����Ư����   ���ʱ� 7000
-- 2    ����Ư����   ������ 6800
SELECT *
FROM
(SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM
(SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal DESC)) b,

(SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù������� 
FROM
(SELECT sido, sigungu, COUNT(*) cnt  --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('KFC', '�Ƶ�����', '����ŷ')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt  --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC)) a
WHERE a.rn(+) = b.rn
ORDER BY b.rn;

-- ���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ����� ���� �������� ����
-- ���ļ����� tax���̺��� id�÷�������

SELECT b.id, b.sido, b.sigungu, b.cal_sal, ���ù�������
FROM

(SELECT id, sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal DESC) b,


(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù������� 
FROM
(SELECT sido, sigungu, COUNT(*) cnt  --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('KFC', '�Ƶ�����', '����ŷ')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt  --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC) a
WHERE a.sido(+) = b.sido
AND a.sigungu(+) = b.sigungu
ORDER BY b.id;

SELECT *
FROM tax;

UPDATE tax set people = 70391
WHERE sido = '����������'
AND sigungu = '����';
COMMIT;

SELECT *
FROM fastfood;


SELECT ROWNUM rn, sido, sigungu, ���ù�������, cal_sal
FROM       
(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù������� , c.cal_sal
FROM 
(SELECT sido, sigungu, COUNT(*) cnt  --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('KFC', '�Ƶ�����', '����ŷ')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt  --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu) b,


(SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
FROM tax) c
WHERE a.sido = b.sido
AND a.sigungu = b. sigungu
AND b.sido = c.sido
AND b.sigungu = c.sigungu

ORDER BY cal_sal, ���ù������� DESC);


UPDATE TAX SET SIGUNGU = TRIM(SIGUNGU);
COMMIT;

-- SMITH�� ���� �μ� ã��

SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename IN 'SMITH'); 

SELECT empno, ename, deptno,
      (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname 
FROM emp;

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ���� ����
--�� ��, �� COLUMN�� ��ȸ�ؾ� �Ѵ�
SELECT empno, ename, deptno,
      (SELECT dname FROM dept) dname 
FROM emp;

--INLINE VIEW
--FROM ���� ���Ǵ� ���� ����

--SUBQUERY
--WHERE���� ���Ǵ� ��������

--sub 1 :��� �޿����� ���� �޿��� �޴°��
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
--sub 2 : ��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ�ϱ�
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--sub3 1. SMITH�� WARD�� ���� �μ� ��ȸ
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'WARD');

--sub3 2. 1���� ���� ������� �̿��Ͽ� �ش� �μ���ȣ�� ���ϴ� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));
-- SMITH�� WARD���� �޿��� ���� ������ȸ        
SELECT *
FROM emp
WHERE sal <= ANY (SELECT sal     -- 800, 1250 --> 1250���� ���� ���
                 FROM emp 
                 WHERE ename IN ('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE sal <= ALL (SELECT sal     -- 800, 1250 --> 800���� ���� ���
                 FROM emp 
                 WHERE ename IN ('SMITH', 'WARD'));
--������ ������ �����ʴ� ������� ��ȸ
SELECT*
FROM emp; --���������ȸ

SELECT empno, mgr
FROM emp;

--������ ������ �ϴ� �����ȸ
SELECT *
FROM emp
WHERE empno IN (SELECT mgr
                FROM emp);

--�����ڰ� �ƴ� ���
--NOT IN ������ ���� NULL�� �����Ϳ� �������� �ʾƾ� �����۵ȴ�.

SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1) --NULL���� �������� �������� �����ͷ� ġȯ
                    FROM emp);
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr  --IS NOT NULL�� ����� NULL�� �� ���� ���ش�
                    FROM emp
                    WHERE mgr IS NOT NULL);
                    
--pair wise
--ALLEN, CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
-- (7698, 30)
-- (7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN(SELECT mgr, deptno
                       FROM emp
                       WHERE empno IN (7499, 7782));

--�Ŵ����� 7698�̰ų� 7839�̸鼭
--�ҼӺμ��� 10���̰ų� 30���� �������� ��ȸ
-- 7698, 10
-- 7698, 30
-- 7839, 10
-- 7839, 30
SELECT *
FROM emp
WHERE mgr IN(SELECT mgr
             FROM emp
             WHERE empno IN (7499, 7782))
                       
AND deptno IN  (SELECT deptno
                FROM emp
                WHERE empno IN (7499, 7782));
                                        
--���ȣ ���� ���� ����
--���������� �÷��� ������������ ������� �ʴ� ������ ���� ����

--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������
--���������� ������������ �Ǵ��Ͽ� ������ �����Ѵ�.
--���������� emp���̺��� ���� �������� �ְ�, ���������� emp���̺��� ���� �������� �ִ�.

--���ȣ ���� ������������ ���������� ���̺��� ���� �������� ���������� ������ ������ �ߴٶ�� ǥ��(��������)
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ���� ���������� Ȯ���� ������ �ߴٶ�� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� ����������ȸ
--������ �޿� ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);

--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ
SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE m.deptno = deptno);


--10�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;


--20�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 20;


--30�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 30;





