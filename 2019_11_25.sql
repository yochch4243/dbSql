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

--Dual ���̺� : sys ������ �ִ� ������ ��밡���� ���̺��̸�
-- �����ʹ� �� �ุ �����ϸ� �÷�(dummy)�� �ϳ� ���� ('X')

SELECT *
FROM dual;

--SINGLE ROW FUNCTION : ��� �ѹ��� FUNCTION�� ����
--1���� �� INPUT --> 1���� ������ OUTPUT (COLUMN)
-- 'Hello, World')

SELECT LOWER('Hello, World')
FROM dual;

--emp ���̺��� �� 14���� ������(����)�� ���� (14���� ��)
--�Ʒ� ������ ����� 14���� ��
SELECT LOWER('Hello, World') low , UPPER('Hello, World') upper,
       INITCAP('Hello, World')
FROM emp;

--�÷��� function ����
SELECT empno, LOWER(ename) low_enm
FROM emp
WHERE ename = UPPER('smith'); --���� �̸��� smith�� ����� ��ȸ�Ϸ��� �빮��/�ҹ���?

--���̺� �÷��� �����ص� ������ ����� ���� �� ������
--���̺� �÷����ٴ� ������� �����ϴ� ���� �ӵ��鿡�� ����
--�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰ� �Ǹ� ���� �޶����� �Ǿ� 
--�ε����� Ȱ���� �� ���� �ȴ�
--���� : FBI(Function Based Index)
SELECT empno, LOWER(ename) low_enm
FROM emp
WHERE LOWER(ename) = 'smith'; --�����ϴ� ������ �ƴ�, ���� ���� ����� ��.

--HELLO
--,
--WORLD
--HELLO, WORLD(�� ������ ���ڿ� ����� �̿�, CONCAT�Լ��� ����Ͽ� ���ڿ� ����)
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD') c1,
       'HELLO' || ', ' || 'WORLD' c2,
       
       --�����ε����� 1����, �����ε��� ���ڿ����� �����Ѵ�.
       SUBSTR('HELLO, WORLD', 1, 5) s1, --SUBSTR(���ڿ�, �����ε���, �����ε���)
       
       --INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ���, ������ ��� ������ �ε����� ����
       INSTR('HELLO, WORLD', 'O') i1,  --5, 9
       --'HELLO, WOLD' ���ڿ��� �ε��� ���Ŀ� �����ϴ� 'O' ���ڿ��� �ε��� ����
       INSTR('HELLO, WORLD', 'O', 6) i2,  -- ���ڿ��� Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ�
       INSTR('HELLO, WORLD', 'O') i3,
       
       --L/ RPAD  Ư�� ���ڿ��� ����/ �����ʿ� ������ ���ڿ� ���̺��� �����Ѹ�ŭ ���ڿ��� ä���ִ´�
       LPAD('HELLO, WORLD', 15, '*') L1,
       LPAD('HELLO, WORLD', 15) L2,
       RPAD('HELLO, WORLD', 15, '*') R1,
       
       --REPLACE(����ڿ�, �˻����ڿ�, ������ ���ڿ�
       --����ڿ����� �˻����ڿ��� �����ҹ��ڿ��� ġȯ
       REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1,
       
       --���ڿ� ��, ���� ������ ����
       '   HELLO, WORLD   ' before_trim,
       TRIM('   HELLO, WORLD   ') after_trim,
       TRIM('H' FROM 'HELLO, WORLD') after_trim2 --Ư�� ���ڸ� ����
       
FROM dept;

--���� �����Լ�
--ROUND : �ݿø� - ROUND(����, �ݿø��ڸ�)
--TRUNC : ���� - TRUNC(����, �����ڸ�)
--MOD : ������ ���� - MOD(������, ����) // MOD(5,2) : 1

SELECT ROUND(105.54, 1) r1, ----�ݿø� ����� �Ҽ��� ���ڸ����� ��������(�Ҽ��� ��° �ڸ����� �ݿø�)
       ROUND(105.55, 1) r2,
       ROUND(105.55, 0) r3, --�Ҽ��� ù° �ڸ����� �ݿø�
       ROUND(105.55, -1) r4 --���� ù��° �ڸ����� �ݿø�
FROM dual;

















