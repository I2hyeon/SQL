-- 제약조건 연습문제

--문제1.

--다음과 같은 테이블을 생성하고 데이터를 insert해보세요.
--테이블 제약조건은 아래와 같습니다. 

--조건) M_NAME 는 가변문자형 20byte, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형 5자리, PRIMARY KEY 이름(mem_memnum_pk) 
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, UNIQUE KEY 이름:(mem_regdate_uk)
--조건) GENDER 고정문자형 1byte, CHECK제약 (M, F)
--조건) LOCA 숫자형 4자리, FOREIGN KEY ? 참조 locations테이블(location_id) 이름:(mem_loca_loc_locid_fk)

CREATE TABLE MS (
    M_NAME VARCHAR2(20)  CONSTRAINT MEM_MEMNAME_NN NOT NULL, 
    M_NUM NUMBER(5)      CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE        CONSTRAINT MEM_REGDATE_UK UNIQUE NOT NULL,
    GENDER CHAR(1)     CONSTRAINT MEM_MEMGENDER_CK CHECK (GENDER IN ('F', 'M')),
    LOCA NUMBER(4)     CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO MS VALUES('AAA', 1, TO_DATE('2018-07-01', 'YYYY-MM-DD'), 'M', 1800);
INSERT INTO MS VALUES('BBB', 2, TO_DATE('2018-07-02', 'YYYY-MM-DD'), 'F', 1900);
INSERT INTO MS VALUES('CCC', 3, TO_DATE('2018-07-03', 'YYYY-MM-DD'), 'M', 2000);
INSERT INTO MS VALUES('DDD', 4, TO_DATE(SYSDATE, 'YYYY-MM-DD'), 'M', 2000);

SELECT * FROM MS;



--문제2.

--도서 대여 이력 테이블을 생성하려 합니다.
--도서 대여 이력 테이블은 대여번호(숫자) PK, 대출도서번호(문자), 대여일(날짜), 반납일(날짜), 반납여부(Y/N)를 가집니다.
--적절한 테이블을 생성해 보세요.

CREATE TABLE BOOKS (
    B_NUM NUMBER(6)    CONSTRAINT BOOKS_B_NUM_PK PRIMARY KEY,
    B_CHAR CHAR(10)    CONSTRAINT BOOKS_B_CHAR_NK UNIQUE NOT NULL,
    DATE1 DATE         CONSTRAINT BOOKS_DATE1 NOT NULL,
    DATE2 DATE         CONSTRAINT BOOKS_DATE2 NOT NULL,
    B_RETURN CHAR(1)   CONSTRAINT BOOKS_B_RETURN_CK CHECK (B_RETURN IN ('Y', 'N'))
);

SELECT * FROM BOOKS;

INSERT INTO BOOKS VALUES(127912, 'ABCDE', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-21', 'YYYY-MM-DD'), 'N');  