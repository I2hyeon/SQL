-- ���ڿ� �Լ�
SELECT LOWER('HELLO WORDLS') FROM DUAL; -- SQL�� �����ϰ� �����ϱ� ���� ���� ���̺�

SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

-- LENGTH ���ڿ� ����
-- INSTR ���ڿ� ã��
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES;
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a') FROM EMPLOYEES; -- a�� �ִ� ��ġ�� ��ȯ��, ���� ���� 0�� ��ȯ

-- SUBSTR ���ڿ� �ڸ���
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES; -- 3 �̸� ����, 3��° ��ġ���� 2�� �ڸ�

-- CONCAT ���ڿ� ��ġ��
SELECT FIRST_NAME || LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD ������ �����ϰ� Ư�� ���ڷ� ä��
SELECT LPAD('ABC', 10, '*') FROM DUAL; -- ABC�� 10ĭ ��� ������ �κδ� ���ʿ��� * ä��
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES; -- �����ʿ��� - ä��

-- LTRIM, RTRIM, TRIM - ���� ���� �Ǵ� ���� ����
SELECT TRIM('                  HELLO WORLD           '), LTRIM('   HELLO WORLD             ') , RTRIM('       HELLO WORLD'           ) FROM DUAL;
SELECT TRIM('HELLO WORLD',' HE') FROM DUAL;

-- REPLACE ���ڿ� ����
SELECT REPLACE('���� �뱸 ���� �λ� ���', ' ', '->') FROM DUAL; -- ������ -> �� ����
SELECT REPLACE('���� �뱸 ���� �λ� ���', ' ', '') FROM DUAL; -- ������ ����
