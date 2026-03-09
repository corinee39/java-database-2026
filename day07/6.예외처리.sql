-- 예외처리
DECLARE
	v_wrong NUMBER;
BEGIN
	SELECT dname INTO v_wrong
	  FROM dept
	 WHERE deptno = 10;
EXCEPTION
-- 	WHEN value_error THEN
-- 		DBMS_OUTPUT.PUT_LINE('예외처리: 수치/값 오류 발생');
	WHEN OTHERS THEN
 		DBMS_OUTPUT.PUT_LINE('예외처리: 기타 오류 발생');
 		DBMS_OUTPUT.PUT_LINE('SQLCODE:' || TO_CHAR(SQLCODE));
 		DBMS_OUTPUT.PUT_LINE('SQLERRM:' || SQLERRM);
END;
