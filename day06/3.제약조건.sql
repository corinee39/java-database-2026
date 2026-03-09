-- 제약조건

-- 1. NOT NULL
CREATE TABLE tbl_nn (
	login_id 	varchar2(20) 	NOT NULL,
	login_pwd	varchar2(20)	NOT NULL,
	tel 		varchar2(20)
);

SELECT * FROM tbl_nn;

INSERT INTO tbl_nn (login_id, login_pwd, tel)
VALUES ('psy98', '12345', NULL);

INSERT INTO tbl_nn (login_id, login_pwd, tel)
VALUES ('infi6', NULL, '010-6666-9999');

INSERT INTO tbl_nn (login_id, login_pwd)
VALUES ('abcd', '1357');

INSERT INTO tbl_nn (login_pwd, tel)
VALUES ('abcd', '010-0000-0000');

UPDATE tbl_nn SET
 login_pwd = NULL
 WHERE login_id = 'psy98';

ALTER TABLE tbl_nn
RENAME CONSTRAINT SYS_C008530 TO NN_tblnn_loginid;

-- 제약조건 삭제(실행하지말것)
ALTER TABLE TBL_NN
DROP CONSTRAINT NN_tblnn_loginid;


-- 2. UNIQUE 중복을 허용안함
CREATE TABLE tbl_unq (
	login_id 	varchar2(20) 	UNIQUE,
	login_pwd	varchar2(20)	NOT NULL,
	tel 		varchar2(20)
);

INSERT INTO tbl_unq (login_id, login_pwd, tel)
VALUES ('psy98', '12345', NULL);

INSERT INTO tbl_unq (login_id, login_pwd, tel)
VALUES (NULL, '12345', '010-0000-0000');

SELECT * FROM tbl_unq;

-- 3. PRIMARY KEY, UNIQUE이고 NOT NULL
CREATE TABLE tbl_pk (
	login_id 	varchar2(20) 	PRIMARY KEY ,
	login_pwd	varchar2(20)	NOT NULL,
	tel 		varchar2(20)
);

INSERT INTO tbl_pk (login_id, login_pwd, tel)
VALUES ('psy98', '12345', NULL);

INSERT INTO tbl_pk (login_id, login_pwd, tel)
VALUES (NULL, '12345', '010-0000-0000');

SELECT * FROM tbl_pk;

-- PK 생성 2
-- 하나 이상의 컬럼에 PK를 지정할 때
CREATE TABLE TBL_INFO(
	idx		NUMBER,
	code 	NUMBER,
	cnt 	varchar2(20),
	regdate	DATE DEFAULT sysdate,
	CONSTRAINT pk_tbl_info PRIMARY KEY (idx, code)
);

INSERT INTO tbl_info (idx, code, cnt)
VALUES (1, 10, 'test1');

INSERT INTO tbl_info (idx, code, cnt)
VALUES (1, 20, 'test2');

INSERT INTO tbl_info (idx, code, cnt)
VALUES (2, 10, 'test3');

SELECT * FROM tbl_info
 WHERE idx = 1
   AND code = 10;

-- 4. Foreign key - 타 테이블의 PK와 연관짓는 제약조건
SELECT * FROM dept;
SELECT * FROM emp;

-- FK를 참조하는 열에 존재하지 않는 데이터 입력
INSERT INTO emp (empno, ename, deptno)
VALUES (9999, '홍길동', NULL);

INSERT INTO emp (empno, ename, deptno)
VALUES (9998, '홍길순', 90);

INSERT INTO emp (empno, ename, deptno)
VALUES (9997, '성유고', 80);

-- FK 생성
CREATE TABLE dept_fk (  -- PK용
	deptno  NUMBER CONSTRAINT dept_fk_deptno_pk PRIMARY KEY,  -- PK 이름 지정
	dname   varchar2(20),
	loc 	varchar2(13)
);

CREATE TABLE emp_fk (  -- FK 지정용
	empno NUMBER PRIMARY KEY,  -- PK 이름 자동생성
	ename varchar2(20) NOT NULL,
	job   varchar2(10),
	mgr   NUMBER,
	deptno NUMBER CONSTRAINT emp_fk_deptno_fk REFERENCES dept_fk(deptno) NOT NULL
);

-- INSERT ALL - 오라클용
INSERT ALL
  INTO dept_fk (deptno, dname, loc) VALUES (10, 'DEV', 'SEOUL')
  INTO dept_fk (deptno, dname, loc) VALUES (20, 'ACCOUNTING', 'INCHEON')
  INTO dept_fk (deptno, dname, loc) VALUES (30, 'FINANCE', 'BUSAN')
SELECT * FROM dual;

SELECT * from dept_fk;

INSERT INTO emp_fk (empno, ename, deptno)
VALUES (1000, '김성규', 20);

INSERT INTO emp_fk (empno, ename, deptno, job, mgr)
VALUES (2000, '김명수', 30, 'PRESIDENT', NULL);

SELECT * FROM emp_fk;
  
DELETE FROM emp_fk WHERE deptno = 20;
DELETE FROM dept_fk WHERE deptno = 20;

-- 5. CHECK - 지정한 조건식에 일치하는 데이터만 입력가능
CREATE TABLE tbl_chk (
	login_id 	varchar2(20) 	PRIMARY KEY ,
	login_pwd	varchar2(20)	NOT NULL CHECK (LENGTH(login_pwd) > 7),
	tel 		varchar2(20)
);

INSERT INTO tbl_chk (login_id, login_pwd, tel)
VALUES ('sungkyu', 'P12345s!', '010-1234-5678');

-- 6. DEFAULT - 기본값 처리
CREATE TABLE tbl_dft (
	login_id 	varchar2(20) 	PRIMARY KEY ,
	login_pwd	varchar2(20)	DEFAULT '123456',
	tel 		varchar2(20),
	reg_date    DATE  DEFAULT sysdate
);

INSERT INTO tbl_dft (login_id, tel)
VALUES ('woohyun', '010-1234-5678');

SELECT * FROM tbl_dft;


-- 중요! CASCADE
CREATE TABLE dept_fk (  -- PK용
	deptno  NUMBER CONSTRAINT dept_fk_deptno_pk PRIMARY KEY,  -- PK 이름 지정
	dname   varchar2(20),
	loc 	varchar2(13)
);

CREATE TABLE emp_fk (  -- FK 지정용
	empno NUMBER PRIMARY KEY,  -- PK 이름 자동생성
	ename varchar2(20) NOT NULL,
	job   varchar2(10),
	mgr   NUMBER,
	deptno NUMBER CONSTRAINT emp_fk_deptno_fk REFERENCES dept_fk(deptno) NOT NULL
);

-- 테이블 생성시부터 cascade 제약조건 설정
CREATE TABLE emp_fk (  -- FK 지정용
	empno NUMBER PRIMARY KEY,  -- PK 이름 자동생성
	ename varchar2(20) NOT NULL,
	job   varchar2(10),
	mgr   NUMBER,
	deptno NUMBER NOT NULL
		CONSTRAINT emp_fk_deptno_fk 
		REFERENCES dept_fk(deptno) 
		ON DELETE CASCADE -- 부모의 PK값을 지우면 해당 데이터도 같이 삭제
);

SELECT * FROM dept_fk;
SELECT * FROM emp_fk;

-- 기존 제약조건 삭제
ALTER TABLE emp_fk
DROP CONSTRAINT emp_fk_deptno_fk;

-- cascade로 재설정
ALTER TABLE emp_fk
ADD CONSTRAINT emp_fk_deptno_fk
	FOREIGN KEY (deptno)
	REFERENCES dept_fk(deptno)
	ON DELETE CASCADE;

-- 전부 초기화. 자식테이블부터 삭제
TRUNCATE TABLE emp_fk;
TRUNCATE TABLE dept_fk;

INSERT ALL
  INTO dept_fk (deptno, dname, loc) VALUES (10, 'DEV', 'SEOUL')
  INTO dept_fk (deptno, dname, loc) VALUES (20, 'ACCOUNTING', 'INCHEON')
  INTO dept_fk (deptno, dname, loc) VALUES (30, 'FINANCE', 'BUSAN')
SELECT * FROM dual;

INSERT INTO emp_fk (empno, ename, deptno)
VALUES (1000, '김성규', 20);

INSERT INTO emp_fk (empno, ename, deptno, job, mgr)
VALUES (2000, '김명수', 30, 'PRESIDENT', NULL);

-- cascade의 핵심
DELETE FROM dept_fk
 WHERE deptno = 20;

SELECT * FROM dept_fk;
SELECT * FROM emp_fk;