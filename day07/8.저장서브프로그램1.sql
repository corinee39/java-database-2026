-- PL/SQL 저장서브프로그램
-- python func_a()
CREATE OR REPLACE PROCEDURE prc_noparam
IS
	-- DECLARE 영역
	v_empno number(4) := 7788;
	v_ename varchar2(10);
BEGIN
	SELECT ename INTO v_ename
	  FROM emp
	 WHERE empno = v_empno;

	dbms_output.put_line('V_EMPNO = ' || v_empno);
	dbms_output.put_line('V_ENAME = ' || v_ename);
	
END prc_noparam;


-- 실행
CALL prc_noparam();


CALL prc_param(7698);