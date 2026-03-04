-- DML

-- DEPT 테이블 복사, DEPT_TEMP 만들기
CREATE TABLE DEPT_TEMP
	AS SELECT * FROM DEPT;

-- 조회
SELECT * FROM DEPT_TEMP;

-- MARKETING 추가
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (50, 'MARKETING', 'SEOUL');

-- 에러 - 컬럼 갯수와 데이터 갯수 불일치
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (60, 'STOCK');

-- 에러 - 컬럼 데이터타입과 데이터형이 불일치
INSERT INTO dept_temp (deptno, dname, loc)
VALUES ('SEVEN', 'STOCK', 'BUSAN');

-- 이건 데이터 들어감
-- 실무에서는 컬럼명 빼먹지 말것
INSERT INTO dept_temp (deptno, dname)
VALUES (60, 'STOCK');

INSERT INTO dept_temp (deptno, dname, loc)
VALUES (70, 'TEST', NULL);

-- EMP를 복사해서 EMP_TEMP 생성
CREATE TABLE emp_temp
    AS SELECT * FROM emp;

SELECT * FROM emp_temp;

-- EMP_TEMP 모든 데이터 삭제
DELETE FROM emp_temp;