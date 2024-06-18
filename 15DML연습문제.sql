-- DML 연습문제


--문제 1.
--DEPTS테이블을 데이터를 포함해서 생성하세요.
--DEPTS테이블의 다음을 INSERT 하세요.

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 2);

INSERT INTO DEPTS VALUES(280, '개발', NULL, 1800);
INSERT INTO DEPTS VALUES(290, '회계부', NULL, 1800);
INSERT INTO DEPTS VALUES(300, '재정', 301, 1800);
INSERT INTO DEPTS VALUES(310, '인사', 302, 1800);
INSERT INTO DEPTS VALUES(320, '영업', 303, 1700);

SELECT * FROM DEPTS;
ROLLBACK;


--문제 2.
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
--2. department_id가 290인 데이터의 manager_id를 301로 변경
--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
--1800으로 변경하세요
--4. 부서번호 (290, 300, 310, 320)의 매니저 아이디를 301로 한번에 변경하세요.

UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = '개발';
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800 WHERE DEPARTMENT_NAME = '인사'; 
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID IN (290, 300, 310, 320);

--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
--2. 부서명 NOC를 삭제하세요

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = ;

--문제4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제해 보세요.
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고, 새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.

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

--문제 5
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
--2. jobs_it 테이블에 아래 데이터를 추가하세요
--3. obs_it은 타겟 테이블 입니다
--jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요.

SELECT * FROM JOBS;
CREATE TABLE OBS_IT AS (SELECT * FROM JOBS WHERE 1 = 2);
INSERT INTO OBS_IT VALUES('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO OBS_IT VALUES('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO OBS_IT VALUES('SEC_DEV', '보안개발팀', 6000, 19000);


