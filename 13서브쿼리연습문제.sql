-- 서브쿼리 연습문제

--문제 1.
--EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
--EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요
--EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요.

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

--문제 2.
--DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id(부서아이디) 와
--EMPLOYEES테이블에서 department_id(부서아이디) 가 일치하는 모든 사원의 정보를 검색하세요.

SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--문제 3.
--- EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
--- EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 같은 모든 사원의 데이터를 출력하세요.
--- Steven과 동일한 부서에 있는 사람들을 출력해주세요.
--- Steven의 급여보다 많은 급여를 받는 사람들은 출력하세요.

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

--문제 4.
--EMPLOYEES테이블 DEPARTMENTS테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬

SELECT EMPLOYEE_ID 직원아이디,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 이름,
       E.DEPARTMENT_ID 부서아이디,
       D.DEPARTMENT_NAME 부서명
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 직원아이디;

--문제 5.
--문제 4의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT EMPLOYEE_ID 직원아이디,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 이름,
       E.DEPARTMENT_ID 부서아이디,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) 부서명
FROM EMPLOYEES E
ORDER BY 직원아이디;

--문제 6.
--DEPARTMENTS테이블 LOCATIONS테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 스트릿_어드레스, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬

SELECT D.DEPARTMENT_ID 부서아이디,
       D.DEPARTMENT_NAME 부서이름,
       L.STREET_ADDRESS 주소,
       L.CITY 도시
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY 부서아이디;  

--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT D.DEPARTMENT_ID 부서아이디,
       D.DEPARTMENT_NAME 부서이름,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) 주소,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) 도시
FROM DEPARTMENTS D
ORDER BY 부서아이디;  

--문제 8.
--LOCATIONS테이블 COUNTRIES테이블을 스칼라 쿼리로 조회하세요.
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬

SELECT L.LOCATION_ID 아이디,
       L.STREET_ADDRESS 주소,
       L.COUNTRY_ID 도시,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) 도시이름
FROM LOCATIONS L
ORDER BY 도시이름;

----------------------------------------------------------------------------------------------------
--문제 9.
--EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요

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

--문제 10.
--EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요.

SELECT RN,
       EMPLOYEE_ID,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 이름,
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

--문제 11.`
--COMMITSSION을 적용한 급여를 새로운 컬럼으로 만들고 10000보다 큰 사람들을 뽑아 보세요. (인라인뷰를 쓰면 됩니다)

SELECT *
FROM (
     SELECT SALARY + (SALARY * COALESCE(COMMISSION_PCT, 0)) AS 최종급여, 
            FIRST_NAME
      FROM EMPLOYEES
)
WHERE 최종급여 > 10000;

--------------------------------------------------------------------------------
-- 서브쿼리 응용편 연습문제

--문제12
--EMPLOYEES테이블, DEPARTMENTS 테이블을 left조인하여, 입사일 오름차순 기준으로 10-20번째 데이터만 출력합니다.
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 입사일, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 망가지면 안되요.

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
FROM ( -- 인라인뷰 자체를 테이블로 보기
     SELECT EMPLOYEE_ID,
            CONCAT( FIRST_NAME || ' ', LAST_NAME ) AS NAME,
            HIRE_DATE,
            DEPARTMENT_ID
     FROM EMPLOYEES E
     ORDER BY HIRE_DATE
) A
);

--문제13
--SA_MAN 사원의 급여 내림차순 기준으로 ROWNUM을 붙여주세요.
--조건) SA_MAN 사원들의 ROWNUM, 이름, 급여, 부서아이디, 부서명을 출력하세요.
--조건) 조인을 맨 마지막에 해보기

SELECT ROWNUM AS RN,
       A.*,
       D.DEPARTMENT_NAME
FROM ( -- 인라인 뷰는 테이블 자리 어디든 들어감
     SELECT FIRST_NAME,
            SALARY,
            DEPARTMENT_ID
     FROM EMPLOYEES
     WHERE JOB_ID = 'SA_MAN'
     ORDER BY SALARY DESC
) A
LEFT JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;


--문제14
--DEPARTMENTS테이블에서 각 부서의 부서명, 매니저아이디, 부서에 속한 인원수 를 출력하세요.
--조건) 인원수 기준 내림차순 정렬하세요.
--조건) 사람이 없는 부서는 출력하지 뽑지 않습니다.
--힌트) 부서의 인원수 먼저 구한다. 이 테이블을 조인한다.

SELECT D.MANAGER_ID,
       D.DEPARTMENT_NAME,
       A.*
FROM (
       SELECT DEPARTMENT_ID,
              COUNT(*) AS 부서인원수
       FROM EMPLOYEES E
       GROUP BY DEPARTMENT_ID
       HAVING DEPARTMENT_ID IS NOT NULL
       ) A
LEFT JOIN DEPARTMENTS D ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 부서인원수 DESC;


--문제15
--부서에 모든 컬럼, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--조건) 부서별 평균이 없으면 0으로 출력하세요

SELECT D.DEPARTMENT_ID 부서아이디,
       D.DEPARTMENT_NAME 부서명,
       D.MANAGER_ID 매니저아이디,
       D.LOCATION_ID 지역아이디,
       L.STREET_ADDRESS 주소,
       L.POSTAL_CODE 우편번호,
       COALESCE(AVG(SALARY), 0) AS 부서별평균연봉
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, D.LOCATION_ID, L.STREET_ADDRESS, L.POSTAL_CODE;


--문제16
--문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요

SELECT RN,
       B.*
FROM ( SELECT ROWNUM AS RN,
              A.*
       FROM (
       SELECT D.DEPARTMENT_ID 부서아이디,
              D.DEPARTMENT_NAME 부서명,
              D.MANAGER_ID 매니저아이디,
              D.LOCATION_ID 지역아이디,
              L.STREET_ADDRESS 주소,
              L.POSTAL_CODE 우편번호,
              COALESCE(AVG(SALARY), 0) AS 부서별평균연봉
        FROM DEPARTMENTS D
        LEFT JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, D.LOCATION_ID, L.STREET_ADDRESS, L.POSTAL_CODE
        ORDER BY D.DEPARTMENT_ID DESC) A
      ) B
WHERE RN BETWEEN 1 AND 10;

