-- 그룹함수
-- NULL이 제외된 데이터들에 대해서 적용됨
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY) FROM EMPLOYEES;

-- MAX, MIN는 날짜, 문자에도 적용됩니다
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

-- COUNT() 두 가지 사용방법
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

-- 부서가 80인 사람들 중 커미션이 가장 높은 사람
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

-- 그룹함수는 일반 컬럼과 동시에 사용 불가능 (오라클에서만)
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;

-- 그룹함수 뒤에 OVER()를 붙이면 일반컬럼과 동시에 사용이 가능함 (오라클에서만)
SELECT FIRST_NAME, AVG(SALARY) OVER(), COUNT(*) OVER(), SUM(SALARY) OVER() FROM EMPLOYEES;

--------------------------------------------------------------------------------
-- GROUP BY절 - WHERE절 ORDER절 사이에 적습니다
SELECT DEPARTMENT_ID, 
       SUM(SALARY),
       AVG(SALARY),
       MIN(SALARY),
       MAX(SALARY),
       COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
-- GROUP화 시킨 컬럼만 SELECT 구문에 적을 수 있습니다
SELECT DEPARTMENT_ID,
       FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; -- 에러

-- 2개 이상의 그룹화 (하위 그룹)
SELECT DEPARTMENT_ID, 
       JOB_ID,
       SUM(SALARY) AS "부서직무별급여합",
       AVG(SALARY) AS "부서직무별급여평균",
       COUNT(*) AS 부서인원수,
       COUNT(*) OVER() 전체카운트 -- COUNT(*) OVER() 사용하면 총 행의 개수를 출력 가능
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;
-- 그룹함수는 WHERE 절에 적을 수 없음
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 5000 -- 그룹의 조건을 적는 곳은 HAVING 이라고 따로 있음
GROUP BY DEPARTMENT_ID;
       
