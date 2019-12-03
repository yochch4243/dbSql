--outerjoin 1
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
               ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));

--outerjoin 2
SELECT NVL(b.buy_date, TO_DATE('20050125', 'YYYYMMDD')) buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
               ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));

--outerjoin3           
SELECT NVL(b.buy_date, TO_DATE('20050125', 'YYYYMMDD')) buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty, 0) buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON(b.buy_prod = p.prod_id AND b.buy_date IN(TO_DATE('20050125', 'YYYYMMDD')));

--outerjoin 4
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT product.pid, pnm, NVL(cid, 1) cid, NVL(day , 0) day, NVL(cnt, 0) cnt
FROM cycle RIGHT OUTER JOIN product ON (cycle.pid = product.pid AND cid IN 1);

--outerjoin 5
SELECT *
FROM customer;

SELECT product.pid, pnm, NVL(cycle.cid, 1) cid, NVL(cnm, 'brown') cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle FULL OUTER JOIN customer ON(cycle.cid = customer.cid)
           RIGHT OUTER JOIN product ON (cycle.pid = product.pid AND customer.cid IN 1);
/*           
SELECT product.pid,product.pnm, :cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
FROM cycle, product
WHERE cycle.cid(+) = customer.cid
AND cycle.pid(+) = product.pid a, customer
WHERE
*/
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;

--���ù�������

SELECT *
FROM fastfood;

SELECT GB
FROM fastfood
GROUP BY GB;

--���ù��������� ���� ������ ����
--���� / �õ� / �ñ���/ ���ù�������(�Ҽ��� ��° �ڸ����� �ݿø�)
--1 / ����Ư���� / ���ʱ� 7.5

--�ش� �õ�, �ñ����� ��������� �Ǽ��� �ʿ�
SELECT ROWNUM rn, sido, sigungu, ���ù�������
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
ORDER BY ���ù������� DESC);









SELECT *
FROM fastfood
WHERE GB IN ('�Ե�����', '�Ƶ�����', '����ŷ');


SELECT sido, sigungu,

(SELECT sido, sigungu, COUNT(gb) gb
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu) b,

(SELECT sido, sigungu, COUNT(gb) g
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido, sigungu
ORDER BY sigungu) a

FROM fastfood; 
GROUP BY sido, sigungu, b.gb, a.g;


--�ϳ��� SQL�� �ۼ����� ������
--fastfood���̺��� �̿��Ͽ� �������� sql���� �����
--������ ����ؼ� �ۼ�
--              ��   ��   ��   K   ��������
--������ �����   7   2               0.3      
--������ ����    8   2   2            0.5
--������ ����    12  7   6   4        1.4
--������ ������   8   3   1           0.5
--������ �߱�    6   4   2   1        1.2

SELECT *
FROM fastfood
WHERE sido IN('����������')
AND gb IN('�Ե�����')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('����������')
AND gb IN('�Ƶ�����')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('����������')
AND gb IN('����ŷ')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('����������')
AND gb IN('KFC')
ORDER BY sigungu;














