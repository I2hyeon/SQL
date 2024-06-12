-- WHERE 조건절 (로 행 제한)
SELECT  * FROM EMPLOYEES WHERE JOB-ID = 'IT_PROG';
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David';
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID <> 90; -- 같지 않다
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '06/03/07'; -- 날짜 비교도 분자열로 합니다
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '06/03/01'; -- 날짜도 대소 비교가 됩니다
 
 -- BETWEEN AND 연산자 ~ 사이에
 SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 5000 AND 10000; -- 이상 ~ 이하
 SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31';
 
 -- IN 연산자
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN(50, 60, 70);
 SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');
 
 -- LIKE 연산자 - 검색에 사용됨, 리터럴 문자 % _
 SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%'; -- 03으로 시작하는  
 SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03'; -- 03으로 끝나는
 SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03%'; -- 03이 포함된
 SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%'; -- MAN이 포함된
 
 SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '_a%'; -- a가 두번째 자리인
 
 
 -- NULL 값 찾기 IS NULL, IS NOT NULL
 SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL; -- 데이터가 안 나옴
 SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL; -- 보너스가 없는 사람
 SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL; -- 보너스가 있는 사람
 
 -- AND, OR - 엔드가 OR보다 빠름
 SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_BROG', 'FI_MGR');
 SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR';
 SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY >= 5000;
 SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 5000;
 
 SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR' AND SALARY >= 6000; -- AND가 먼저 동작됨
 SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR') AND SALARY >= 6000; -- OR가 소괄호로 인해 먼저 동작됨
 
 -- NOT 부정의 의미 - 연산 키워드와 사용됨
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (50, 60); -- 부서 아이디가 50, 60이 아닌
 SELECT * FROM EMPLOYEES WHERE JOB_ID NOT LIKE '%MAN%'; -- 직업명이 MAN이 아닌 사람
 
 ----------------------------------------------------------------------------------------
 -- ORDER BY
 SELECT * FROM EMPLOYEES ORDER BY SALARY; -- 아무것도 안 적으면 ASC(어센딩_올림차순) 입니다
 SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC; -- 내림차순
 
 SELECT FIRST_NAME, SALARY * 12 AS 연봉 FROM EMPLOYEES ORDER BY 연봉; -- 별칭을 ORDER 절에서 사용할 수 있음
 
 -- 정렬을 2개 이상의 컬럼으로 시킬 수 있음 
 -- 부서 번호가 높은 사람들 중에서, 급여가 높은 사람들 기준으로 정렬
 SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC, SALARY DESC;
 
 SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN') ORDER BY FIRST_NAME;
 