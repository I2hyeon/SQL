-- 문자열 함수
SELECT LOWER('HELLO WORDLS') FROM DUAL; -- SQL을 간단하게 연습하기 위한 가상 테이블

SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

-- LENGTH 문자열 길이
-- INSTR 문자열 찾기
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES;
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a') FROM EMPLOYEES; -- a가 있는 위치를 반환함, 없는 경우는 0을 반환

-- SUBSTR 문자열 자르기
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES; -- 3 미만 절삭, 3번째 위치에서 2개 자름

-- CONCAT 문자열 합치기
SELECT FIRST_NAME || LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD 범위를 지정하고 특정 문자로 채움
SELECT LPAD('ABC', 10, '*') FROM DUAL; -- ABC를 10칸 잡고 나머지 부부는 왼쪽에서 * 채움
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES; -- 오늘쪽에서 - 채움

-- LTRIM, RTRIM, TRIM - 공백 삭제 또는 문자 삭제
SELECT TRIM('                  HELLO WORLD           '), LTRIM('   HELLO WORLD             ') , RTRIM('       HELLO WORLD'           ) FROM DUAL;
SELECT TRIM('HELLO WORLD',' HE') FROM DUAL;

-- REPLACE 문자열 변경
SELECT REPLACE('서울 대구 대전 부산 찍고', ' ', '->') FROM DUAL; -- 공백을 -> 로 변경
SELECT REPLACE('서울 대구 대전 부산 찍고', ' ', '') FROM DUAL; -- 공백을 삭제
