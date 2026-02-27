-- 곱셈연산자, 비교연산자
-- 동등연산자 = ( == 아님! )
SELECT EMP_NAME
				 , SALARY, SALARY * 12 AS "ANNUAL"
				 , HIRE_DATE 
	FROM EMPLOYEE
 WHERE ( SALARY * 12 ) = 40200 ;

-- NOT
SELECT EMP_NAME
				 , SALARY
				 , SALARY * 12 AS "ANNUAL"
				 , HIRE_DATE 
	FROM EMPLOYEE
WHERE NOT ( SALARY * 12 ) = 40200 ;

-- IN = OR와 동일
SELECT e.*
	FROM EMPLOYEE e 
 WHERE e.DEPT_ID = 1 OR e.DEPT_ID = 4;

SELECT e.*
	FROM EMPLOYEE e 
 WHERE e.DEPT_ID IN (1, 4);

-- BETWEEN
-- hire_date는 날짜형이지만 날짜 타입의 문자열과 비교 가능
-- 2022년 한 해동안 입사한 직원정보 조회
SELECT *
	FROM EMPLOYEE e 
 WHERE e.HIRE_DATE  >= '2022-01-01'
		AND e.HIRE_DATE  <= '2022-12-31';

SELECT *
	FROM EMPLOYEE e 
 WHERE e.HIRE_DATE BETWEEN  '2022-01-01' AND '2022-12-31';

SELECT *
	FROM EMPLOYEE e 
WHERE e.SALARY  BETWEEN  3000 AND 6000;

-- LIKE - 문자열에 패턴을 검색
-- % _ 중 현업에서는 % 제일 많이 사용
-- Seoul: _eo__, %eo%, _eo% 전부 동일하게 검색
SELECT *
	FROM CUSTOMER
	WHERE city  LIKE '%eo%';

-- NULL 비교
-- empty와 다름!!
SELECT *
	FROM CUSTOMER
	WHERE city IS NULL; -- ' ' empty 와 다름

-- 집합연산
-- 가상 테이블 - 조인, 유니온처럼 쿼리 결과로 나오는 테이블
	SELECT prod_name, price
		FROM PRODUCT
		WHERE price >= 45000
		UNION  -- UNION ALL은 중복제거없이 모두 출력
	SELECT emp_name, salary
		FROM EMPLOYEE
		WHERE SALARY  >= 9000;

-- 교집합 UNION 대신 INTERSECT 사용