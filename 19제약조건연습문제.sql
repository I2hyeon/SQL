-- �������� ��������

--����1.

--������ ���� ���̺��� �����ϰ� �����͸� insert�غ�����.
--���̺� ���������� �Ʒ��� �����ϴ�. 
 
--����) M_NAME �� ���������� 20byte, �ΰ��� ������� ����
--����) M_NUM �� ������ 5�ڸ�, PRIMARY KEY �̸�(mem_memnum_pk) 
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, UNIQUE KEY �̸�:(mem_regdate_uk)
--����) GENDER ���������� 1byte, CHECK���� (M, F)
--����) LOCA ������ 4�ڸ�, FOREIGN KEY ? ���� locations���̺�(location_id) �̸�:(mem_loca_loc_locid_fk)

CREATE TABLE MS (
    M_NAME VARCHAR2(20)  NOT NULL, 
    M_NUM NUMBER(5)      CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE        CONSTRAINT MEM_REGDATE_UK UNIQUE NOT NULL,
    GENDER CHAR(1)       CONSTRAINT MEM_MEMGENDER_CK CHECK (GENDER IN ('F', 'M')),
    LOCA NUMBER(4)       CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

-- ALTER TABLE MS ADD CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY (M_NUM);
-- ALTER TABLE MS ADD CONSTRAINT MEM_LOCA_LOC_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID);

INSERT INTO MS VALUES('AAA', 1, TO_DATE('2018-07-01', 'YYYY-MM-DD'), 'M', 1800);
INSERT INTO MS VALUES('BBB', 2, TO_DATE('2018-07-02', 'YYYY-MM-DD'), 'F', 1900);
INSERT INTO MS VALUES('CCC', 3, TO_DATE('2018-07-03', 'YYYY-MM-DD'), 'M', 2000);
INSERT INTO MS VALUES('DDD', 4, TO_DATE(SYSDATE, 'YYYY-MM-DD'), 'M', 2000);

SELECT * FROM MS;



--����2.

--���� �뿩 �̷� ���̺��� �����Ϸ� �մϴ�.
--���� �뿩 �̷� ���̺��� �뿩��ȣ(����) PK, ���⵵����ȣ(����), �뿩��(��¥), �ݳ���(��¥), �ݳ�����(Y/N)�� �����ϴ�.
--������ ���̺��� ������ ������.

CREATE TABLE BOOKS (
    B_NUM NUMBER(10)    CONSTRAINT BOOKS_B_NUM_PK PRIMARY KEY,
    B_CHAR VARCHAR2(30)    CONSTRAINT BOOKS_B_CHAR_NK UNIQUE NOT NULL,
    DATE1 DATE DEFAULT SYSDATE,        
    DATE2 DATE         CONSTRAINT BOOKS_DATE2 NOT NULL,
    B_RETURN CHAR(1)   CONSTRAINT BOOKS_B_RETURN_CK CHECK (B_RETURN IN ('Y', 'N'))
);

SELECT * FROM BOOKS;

INSERT INTO BOOKS VALUES(127912, 'ABCDE', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-21', 'YYYY-MM-DD'), 'N');  