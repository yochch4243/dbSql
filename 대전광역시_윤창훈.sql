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
