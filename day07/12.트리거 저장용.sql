-- 트리거 테스트용 emp 테이블 생성 
CREATE TABLE emp_trg 
AS SELECT * FROM emp;


-- DML트리거 AFTER 테이블 생성
CREATE TABLE emp_trg_log (
	tablename varchar2(20),		-- dml이 수행된 테이블명
	dml_type varchar2(10),
	empno number(4),
	user_name varchar2(30),
	change_date DATE 			-- dml 수행한 일시
);


-- emp_trg에 실행
INSERT INTO emp_trg
VALUES (9997, 'EMPORI', 'CLERK', 7788, sysdate, 1200, NULL, 20);

-- 수정
UPDATE emp_trg 
   SET mgr = 9999
 WHERE empno = 9997;

-- 삭제 시
DELETE FROM emp_trg
 WHERE empno = 9998;


SELECT * FROM emp_trg;

-- 트리거가 로그를 남겨줌
SELECT * FROM emp_trg_log;
