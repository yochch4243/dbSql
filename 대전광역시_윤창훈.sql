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
