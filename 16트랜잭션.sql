-- 트랜잭션
-- 오직 DML 문에 대해서만 트랙잭션을 수행할 있습니다 (DDL문은 자동커밋됨)

-- 오토커밋 확인
SHOW AUTOCOMMIT; 
-- 오토커밋 ON
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

--------------------------------------------------------------------------------
SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;

SAVEPOINT DEPT10; -- 세이브포인트(트랜잭션의 지점)

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;

SAVEPOINT DEPT20;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 30;

-- 세이브포인트로 돌아가기
ROLLBACK TO DEPT20; -- 세이브포인트명
ROLLBACK TO DEPT10;
ROLLBACK; -- 마지막 커밋 이후로 돌아감

SELECT * FROM DEPTS;

INSERT INTO DEPTS VALUES (280, 'AA', NULL, 1800);
COMMIT; -- 데이터 반영

-- 시험에서는 트랜잭션 4원칙 ACID