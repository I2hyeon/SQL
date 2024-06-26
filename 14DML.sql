-- INSERT
-- 테이블 구조를 빠르게 확인하는 방법
DESC DEPARTMENTS;


-- 1ST
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);

-- DML문은 트랜잭션이 항상 기록되는데, ROLLBACK 이용해서 되돌릴 수 있음
ROLLBACK;

-- 2ND (컬럼명만 지정가능)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVERLOPER', 1700);
ROLLBACK;

-- INSERT 구문도 서브쿼리 됩니다
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES((SELECT MAX(DEPARTMENT_ID) + 10 FROM DEPARTMENTS, 'DEV');

-- INSERT 구문의 서브쿼리 (여러행)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- 테이블 구조 복사

SELECT * FROM EMPS; -- 이 테이블에 원본 테이블의 특정 데이터를 퍼다 나름

DESC EMPS;
INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; -- 트랜잭션을 반영함
--------------------------------------------------------------------------------
-- UPDATE
SELECT * FROM EMPS;

-- 업데이트 구문을 사용하기 전에는 SELECT로 해당값이 고유한 행인지 확인하고 업데이트 처리해야 함
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; -- KEY를 조건에 적는게 일반적임
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

-- 업데이트 구문의 서브쿼리절
-- 1ST(단일갑 서브쿼리)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 2ND (여러값 서브쿼리)
UPDATE EMPS SET (SALARY, COMMISSION_PCT, MANAVER_ID, DEPAREMENT_ID = (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 3ND (WHERE에도 됨)
SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
UPDATE EMPS SET SALARY = 1000 WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--------------------------------------------------------------------------------
-- DELETE 구문
-- 트랜잭션이 있긴 하지만, 삭제하기 전에 반드시 SELECT문으로 삭제 조건에 해당하는 데이터를 꼭 확인하는 습관을 들이자
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- KEY를 통해서 지우는 편이 좋습니다

-- DELETE 구문도 서브쿼리
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;

--------------------------------------------------------------------------------
-- DELETE 문이 전부 실행되는 것은 아닙니다
-- 테이블이 연관관계(FK)제약을 가지고 있다면 지워지지 않습니다 (참조무결성 제약)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; -- EMPLOYEES에서 100번 데이터를 FK로 사용하고 있어서, 지울 수 없다

--------------------------------------------------------------------------------
-- MERGE문 - 타겟테이블 데이터가 있으면 UPDATE, 없으면 INSERT구문을 수행하는 병합

SELECT * FROM EMPS;

-- 1ST
MERGE INTO EMPS A
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B -- 합칠 테이블
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID) -- 연결할 키
WHEN MATCHED THEN -- 일치하는 경우
    UPDATE SET A.SALARY = B.SALARY, 
               A.COMMTSSION_PCT = B.COMMISSION_PCT,
               A.HIRE_DATE = SYSDATE
               -- ~생략~
WHEN NOT MATCHED THEN -- 일치하지 않는 경우
    INSERT /*INTO*/ (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);

DESC EMPS;

-- 2ND - 서브쿼리절로 다른 테이블을 가져오는 게 아니라 직접 값을 넣을 때 DUAL을 쓸 수도 있습니다
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID = 107)
WHEN MATCHED THEN -- 일치하면
    UPDATE SET A.SALARY = 10000,
               A.COMMISSION_PCT = 0.1,
               A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN -- 일치하지 않으면
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES ('EXAMPLE', 'HONG', 'EXAMPLE', SYSDATE, 'DMA');

--------------------------------------------------------------------------------
DROP TABLE EMPS;

-- CTAS - 테이블 구조 복사
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); -- 데이터까지 복사

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- 구조만 복사

