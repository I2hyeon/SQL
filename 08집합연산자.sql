-- 집합연산자
/*
 UNION = 합집합 (중복X)
 UNION ALL = 합집합 (중복O)
 INTERSECT = 교집합
 MINUS = 차집합
 
 컬럼 개수가 일치해야 집합연산자 사용이 가능합니다
 */
 
 SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
 UNION
 SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;
 
 ------------------------------------------------------------------------------

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
UNION ALL
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

--------------------------------------------------------------------------------SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
INTERSECT
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

--------------------------------------------------------------------------------
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
MINUS
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

--------------------------------------------------------------------------------
-- 집합 연산자는 dUAL같은 가상 데이터를 만들어서 합칠 수도 있습니다
SELECT 2000, 'HONG', '서울시' AS 지역 FROM DUAL
UNION ALL
SELECT 300, 'LEE', '경기도' FROM DUAL
UNION ALL
SELECT EMPLOYEE_ID, LAST_NAME, '서울시' FROM EMPLOYEES;

--------------------------------------------------------------------------------
-- 분석 함수
-- 분석함수 OVER(정렬 방법)

SELECT FIRST_NAME,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) AS 중복순서계산,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) AS 중복없는등수,
       ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 일련번호,
       ROWNUM AS 조회가된순서
FROM EMPLOYEES;

-- ROWNUM은 ORDER 시킬 때 결과가 바뀝니다

SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES 
ORDER BY SALARY DESC;






