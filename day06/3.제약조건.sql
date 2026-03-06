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

-- 제약조건 삭제
