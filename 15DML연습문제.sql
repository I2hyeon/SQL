-- DML ��������


--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
--DEPTS���̺��� ������ INSERT �ϼ���.

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 2);

INSERT INTO DEPTS VALUES(280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES(290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES(320, '����', 303, 1700);

SELECT * FROM DEPTS;
ROLLBACK;


--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. �μ���ȣ (290, 300, 310, 320)�� �Ŵ��� ���̵� 301�� �ѹ��� �����ϼ���.

UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = '����';
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800 WHERE DEPARTMENT_NAME = '�λ�'; 
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID IN (290, 300, 310, 320);

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = ;

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

SELECT * FROM DEPTS2;
CREATE TABLE DEPTS2 AS (SELECT * FROM DEPTS);
DELETE FROM DEPTS2 WHERE DEPARTMENT_ID > 200;
ROLLBACK;
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;

MERGE INTO DEPTS D
USING DUAL
WHEN MATCHED THEN
    UPDATE SET D.DEPARTMENT_NAME,
               D.MANAGER_ID,
               D.LOCATION_ID
WHEN NOT MATCHED THEN 
    INSERT (DEPARTMEN_ID, DEPARTMENT_NAME, MANAVER_ID, LOCATION_ID)
    VALUES ();

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
--3. obs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

SELECT * FROM JOBS;
CREATE TABLE OBS_IT AS (SELECT * FROM JOBS WHERE 1 = 2);
INSERT INTO OBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO OBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO OBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);


