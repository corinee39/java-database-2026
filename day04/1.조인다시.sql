-- 조인 한번 더
SELECT d.DEPTNO, d.DNAME, d.LOC
	  , e.EMPNO, e.ENAME, e.JOB
	  , to_char(e.HIREDATE, 'yyyy-mm-dd') AS HIREDATE 
	  , e.SAL
  FROM DEPT d, EMP e 
  WHERE d.DEPTNO = e.DEPTNO;

SELECT e.EMPNO, e.ENAME, e.JOB
	  , to_char(e.HIREDATE, 'yyyy-mm-dd') AS HIREDATE 
	  , e.SAL
	  , d.DEPTNO, d.DNAME, d.LOC
  FROM DEPT d, EMP e 
 WHERE d.DEPTNO = e.DEPTNO
 ORDER BY e.EMPNO ASC;

-- 셀프조인
-- e1 상사를 찾는 테이블
-- e2 상사 테이블
SELECT e1.empno, e1.ename, e1.mgr
	  , e2.empno AS mgr_empno
	  , e2.ename AS mar_ename
  FROM emp e1, emp e2
 WHERE e1.mgr = e2.empno;

-- 외부조인 - 등가조인에 일치하지 않는 데이터도 조회
-- MGR 상사가 있는지 확인
SELECT e1.empno, e1.ename, e1.mgr
	  , e2.empno AS mgr_empno
	  , e2.ename AS mar_ename
  FROM emp e1, emp e2
 WHERE e1.mgr = e2.empno (+);

-- 잘못된 조인. e2의 empno를 상사 컬럼으로, e1의 mgr를 부하 컬럼으로 외부조인
SELECT e1.empno, e1.ename, e1.mgr
	  , e1.hiredate
	  , e2.empno AS mgr_empno
	  , e2.ename AS mar_ename
  FROM emp e1, emp e2
 WHERE e1.mgr (+) = e2.empno;

SELECT e2.empno AS mgr_empno
      , e2.ename AS mgr_ename
      , e1.empno AS emp_empno
      , e1.ename AS emp_ename
      , e1.hiredate
  FROM emp e1, emp e2
 WHERE e1.mgr (+) = e2.empno;

-- 외부조인 두번째 예제
-- 일반 내부조인
SELECT d.deptno, d.dname, d.loc
	  , e.empno, e.ename, e.job
	  , e.hiredate, e.sal
  FROM dept d, emp e
 WHERE d.deptno = e.deptno;

-- 왼쪽 외부조인
SELECT d.deptno, d.dname, d.loc
	  , e.empno, e.ename, e.job
	  , e.hiredate, e.sal
  FROM dept d, emp e
 WHERE d.deptno = e.deptno (+);

-- 오른쪽 외부조인
SELECT d.deptno, d.dname, d.loc
	  , e.empno, e.ename, e.job
	  , e.hiredate, e.sal
  FROM emp e, dept d
 WHERE e.deptno (+) = d.deptno;

SELECT d.deptno, d.dname, d.loc
	  , e.empno, e.ename, e.job
	  , e.hiredate, e.sal
  FROM dept d, emp e
 WHERE d.deptno (+) = e.deptno;

-- 왼쪽 외부조인
SELECT d.deptno, d.dname, d.loc
	  , e.empno, e.ename, e.job
	  , e.hiredate, e.sal
  FROM dept d, emp e
 WHERE d.deptno = e.deptno (+)
   AND e.empno IS NULL;