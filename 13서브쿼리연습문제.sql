-- �������� ��������

--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.

SELECT FIRST_NAME,
       SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT FIRST_NAME,
       SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.

SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--���� 3.
--- EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
--- EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
--- Steven�� ������ �μ��� �ִ� ������� ������ּ���.
--- Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.

SELECT FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

SELECT FIRST_NAME,
       DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');

SELECT FIRST_NAME,
       SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');

--���� 4.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����

SELECT EMPLOYEE_ID �������̵�,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID �μ����̵�,
       D.DEPARTMENT_NAME �μ���
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY �������̵�;

--���� 5.
--���� 4�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT EMPLOYEE_ID �������̵�,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID �μ����̵�,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) �μ���
FROM EMPLOYEES E
ORDER BY �������̵�;

--���� 6.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����

SELECT D.DEPARTMENT_ID �μ����̵�,
       D.DEPARTMENT_NAME �μ��̸�,
       L.STREET_ADDRESS �ּ�,
       L.CITY ����
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY �μ����̵�;  

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT D.DEPARTMENT_ID �μ����̵�,
       D.DEPARTMENT_NAME �μ��̸�,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) �ּ�,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) ����
FROM DEPARTMENTS D
ORDER BY �μ����̵�;  

--���� 8.
--LOCATIONS���̺� COUNTRIES���̺��� ��Į�� ������ ��ȸ�ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����

SELECT L.LOCATION_ID ���̵�,
       L.STREET_ADDRESS �ּ�,
       L.COUNTRY_ID ����,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) �����̸�
FROM LOCATIONS L
ORDER BY �����̸�;

----------------------------------------------------------------------------------------------------
--���� 9.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���

SELECT RN,
       FIRST_NAME
FROM (
      SELECT ROWNUM AS RN,
             A.*
      FROM (
            SELECT FIRST_NAME
            FROM EMPLOYEES
            ORDER BY FIRST_NAME DESC
      ) A
)
WHERE RN BETWEEN 41 AND 50;

--���� 10.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.

SELECT RN,
       EMPLOYEE_ID,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�,
       PHONE_NUMBER,
       HIRE_DATE
FROM (
     SELECT ROWNUM AS RN,
             A.*
       FROM (
            SELECT *
            FROM EMPLOYEES
            ORDER BY HIRE_DATE
            ) A
      )
WHERE RN BETWEEN 31 AND 40;

--���� 11.`
--COMMITSSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������. (�ζ��κ並 ���� �˴ϴ�)

SELECT *
FROM (
     SELECT SALARY + (SALARY * COALESCE(COMMISSION_PCT, 0)) AS �����޿�, 
            FIRST_NAME
      FROM EMPLOYEES
)
WHERE �����޿� > 10000;

--------------------------------------------------------------------------------
-- �������� ������ ��������

--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.

SELECT *
FROM (
    SELECT A.*,
           ROWNUM AS RN
    FROM (
         SELECT EMPLOYEE_ID,
         CONCAT( FIRST_NAME || ' ', LAST_NAME ) AS NAME,
         HIRE_DATE,
         DEPARTMENT_NAME
         FROM EMPLOYEES E
         LEFT JOIN DEPARTMENTS D
         ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
         ORDER BY HIRE_DATE
     ) A
)
WHERE RN > 10 AND RN <= 20;

SELECT *
FROM (
SELECT ROWNUM AS RN,
       A.*,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM ( -- �ζ��κ� ��ü�� ���̺�� ����
     SELECT EMPLOYEE_ID,
            CONCAT( FIRST_NAME || ' ', LAST_NAME ) AS NAME,
            HIRE_DATE,
            DEPARTMENT_ID
     FROM EMPLOYEES E
     ORDER BY HIRE_DATE
) A
);

--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.
--����) ������ �� �������� �غ���

SELECT ROWNUM AS RN,
       A.*,
       D.DEPARTMENT_NAME
FROM ( -- �ζ��� ��� ���̺� �ڸ� ���� ��
     SELECT FIRST_NAME,
            SALARY,
            DEPARTMENT_ID
     FROM EMPLOYEES
     WHERE JOB_ID = 'SA_MAN'
     ORDER BY SALARY DESC
) A
LEFT JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;


--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.

SELECT D.MANAGER_ID,
       D.DEPARTMENT_NAME,
       A.*
FROM (
       SELECT DEPARTMENT_ID,
              COUNT(*) AS �μ��ο���
       FROM EMPLOYEES E
       GROUP BY DEPARTMENT_ID
       HAVING DEPARTMENT_ID IS NOT NULL
       ) A
LEFT JOIN DEPARTMENTS D ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY �μ��ο��� DESC;


--����15
--�μ��� ��� �÷�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���

SELECT D.DEPARTMENT_ID �μ����̵�,
       D.DEPARTMENT_NAME �μ���,
       D.MANAGER_ID �Ŵ������̵�,
       D.LOCATION_ID �������̵�,
       L.STREET_ADDRESS �ּ�,
       L.POSTAL_CODE �����ȣ,
       COALESCE(AVG(SALARY), 0) AS �μ�����տ���
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, D.LOCATION_ID, L.STREET_ADDRESS, L.POSTAL_CODE;


--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

SELECT RN,
       B.*
FROM ( SELECT ROWNUM AS RN,
              A.*
       FROM (
       SELECT D.DEPARTMENT_ID �μ����̵�,
              D.DEPARTMENT_NAME �μ���,
              D.MANAGER_ID �Ŵ������̵�,
              D.LOCATION_ID �������̵�,
              L.STREET_ADDRESS �ּ�,
              L.POSTAL_CODE �����ȣ,
              COALESCE(AVG(SALARY), 0) AS �μ�����տ���
        FROM DEPARTMENTS D
        LEFT JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, D.LOCATION_ID, L.STREET_ADDRESS, L.POSTAL_CODE
        ORDER BY D.DEPARTMENT_ID DESC) A
      ) B
WHERE RN BETWEEN 1 AND 10;

