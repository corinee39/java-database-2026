-- 문자열 함수
-- 대문자, 소문자, 첫글자만 대문자 변환 함수
SELECT c.CUST_NAME 
				 , lower(c.CUST_NAME ) AS "고객명"
				 , INITCAP(lower(c.CUST_NAME )) AS "고객명"
				 , c.CITY
				 , upper(c.CITY) AS "도시명"
	FROM CUSTOMER c ;

-- where 절에도 사용가능
SELECT *
	FROM CUSTOMER c 
	WHERE lower(c.CITY) = 'seoul';

-- 문자열 길이
SELECT city, length(city) AS "글자길이"
	FROM CUSTOMER;

-- 문자열 추출
SELECT EMP_NAME, SUBSTR(EMP_NAME, 4, 1) 
	FROM EMPLOYEE;

-- 문자열에서 찾기
SELECT instr('HELLO, ORACLE!', 'L') AS "첫번째L위치"
				 , instr('HELLO, ORACLE!', 'L', 5) AS "5번째이후 L위치"
				 , instr('HELLO, ORACLE!', 'L', 2, 2) AS "2번째위치 이후 두번째 나타나는 L위치"
	FROM dual;

