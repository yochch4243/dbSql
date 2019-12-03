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

--도시발전지수

SELECT *
FROM fastfood;

SELECT GB
FROM fastfood
GROUP BY GB;

--도시발전지수가 높은 순으로 나열
--순위 / 시도 / 시군구/ 도시발전지수(소수점 둘째 자리에서 반올림)
--1 / 서울특별시 / 서초구 7.5

--해당 시도, 시군구별 프랜차이즈별 건수가 필요
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as 도시발전지수 
FROM
(SELECT sido, sigungu, COUNT(*) cnt  --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('KFC', '맥도날드', '버거킹')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt  --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC);









SELECT *
FROM fastfood
WHERE GB IN ('롯데리아', '맥도날드', '버거킹');


SELECT sido, sigungu,

(SELECT sido, sigungu, COUNT(gb) gb
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu) b,

(SELECT sido, sigungu, COUNT(gb) g
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido, sigungu
ORDER BY sigungu) a

FROM fastfood; 
GROUP BY sido, sigungu, b.gb, a.g;


--하나의 SQL로 작성하지 마세요
--fastfood테이블을 이용하여 여러번의 sql실행 결과를
--손으로 계산해서 작성
--              롯   맥   버   K   발전지수
--대전시 대덕구   7   2               0.3      
--대전시 동구    8   2   2            0.5
--대전시 서구    12  7   6   4        1.4
--대전시 유성구   8   3   1           0.5
--대전시 중구    6   4   2   1        1.2

SELECT *
FROM fastfood
WHERE sido IN('대전광역시')
AND gb IN('롯데리아')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('대전광역시')
AND gb IN('맥도날드')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('대전광역시')
AND gb IN('버거킹')
ORDER BY sigungu;

SELECT *
FROM fastfood
WHERE sido IN('대전광역시')
AND gb IN('KFC')
ORDER BY sigungu;














