-- sum 합산 함수
SELECT sum(salary)
	FROM EMPLOYEE;

-- 아무 의미 없음
SELECT sum(DEPT_ID)
	FROM EMPLOYEE;

-- 각 레코드(한 줄, 로우, 행)로 개수를 구할 수 있음
SELECT count(*)
	FROM employee;

-- 특정 컬럼의 갯수로 구할 수 있음
SELECT count(SALARY)
	FROM employee;

SELECT count(DISTINCT DEPT_ID)
	FROM employee;

-- salary 합산 619,929
-- salary 개수 97
-- 전체 데이터 100
SELECT avg(salary)
	FROM EMPLOYEE;

SELECT min(salary), max(salary)
	FROM EMPLOYEE;

-- min, max는 날짜도 가능
SELECT min(hire_date), max(hire_date)
	FROM EMPLOYEE;

-- min, max는 문자열도 가능
SELECT min(EMP_NAME), max(EMP_NAME)
	FROM EMPLOYEE;