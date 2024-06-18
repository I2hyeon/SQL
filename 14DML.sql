-- INSERT
-- ���̺� ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;


-- 1ST
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);

-- DML���� Ʈ������� �׻� ��ϵǴµ�, ROLLBACK �̿��ؼ� �ǵ��� �� ����
ROLLBACK;

-- 2ND (�÷��� ��������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVERLOPER', 1700);
ROLLBACK;

-- INSERT ������ �������� �˴ϴ�
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES((SELECT MAX(DEPARTMENT_ID) + 10 FROM DEPARTMENTS, 'DEV');

-- INSERT ������ �������� (������)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ���̺� ���� ����

SELECT * FROM EMPS; -- �� ���̺� ���� ���̺��� Ư�� �����͸� �۴� ����

DESC EMPS;
INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; -- Ʈ������� �ݿ���
--------------------------------------------------------------------------------
-- UPDATE
SELECT * FROM EMPS;

-- ������Ʈ ������ ����ϱ� ������ SELECT�� �ش簪�� ������ ������ Ȯ���ϰ� ������Ʈ ó���ؾ� ��
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; -- KEY�� ���ǿ� ���°� �Ϲ�����
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

-- ������Ʈ ������ ����������
-- 1ST(���ϰ� ��������)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 2ND (������ ��������)
UPDATE EMPS SET (SALARY, COMMISSION_PCT, MANAVER_ID, DEPAREMENT_ID = (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 3ND (WHERE���� ��)
SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
UPDATE EMPS SET SALARY = 1000 WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--------------------------------------------------------------------------------
-- DELETE ����
-- Ʈ������� �ֱ� ������, �����ϱ� ���� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ������ ������
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- KEY�� ���ؼ� ����� ���� �����ϴ�

-- DELETE ������ ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;

--------------------------------------------------------------------------------
-- DELETE ���� ���� ����Ǵ� ���� �ƴմϴ�
-- ���̺��� ��������(FK)������ ������ �ִٸ� �������� �ʽ��ϴ� (�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; -- EMPLOYEES���� 100�� �����͸� FK�� ����ϰ� �־, ���� �� ����

--------------------------------------------------------------------------------
-- MERGE�� - Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT������ �����ϴ� ����

SELECT * FROM EMPS;

-- 1ST
MERGE INTO EMPS A
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B -- ��ĥ ���̺�
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID) -- ������ Ű
WHEN MATCHED THEN -- ��ġ�ϴ� ���
    UPDATE SET A.SALARY = B.SALARY, 
               A.COMMTSSION_PCT = B.COMMISSION_PCT,
               A.HIRE_DATE = SYSDATE
               -- ~����~
WHEN NOT MATCHED THEN -- ��ġ���� �ʴ� ���
    INSERT /*INTO*/ (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);

DESC EMPS;

-- 2ND - ������������ �ٸ� ���̺��� �������� �� �ƴ϶� ���� ���� ���� �� DUAL�� �� ���� �ֽ��ϴ�
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID = 107)
WHEN MATCHED THEN -- ��ġ�ϸ�
    UPDATE SET A.SALARY = 10000,
               A.COMMISSION_PCT = 0.1,
               A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN -- ��ġ���� ������
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES ('EXAMPLE', 'HONG', 'EXAMPLE', SYSDATE, 'DMA');

--------------------------------------------------------------------------------
DROP TABLE EMPS;

-- CTAS - ���̺� ���� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); -- �����ͱ��� ����

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ������ ����

