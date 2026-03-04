-- scott 계정!
-- 부서번호와 직군 그룹화
SELECT deptno, job
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY deptno, job
  ORDER BY deptno;

-- ROLLUP 함수 적용한 그룹화
SELECT deptno
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY deptno
  ORDER BY deptno;

SELECT deptno
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY ROLLUP(deptno)
  ORDER BY deptno;

-- ROLLUP 첫번째 컬럼의 값으로 소계, 전체 총계를 도출
SELECT deptno, job
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY ROLLUP(deptno, job)
  ORDER BY deptno;

SELECT deptno, job
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY ROLLUP(deptno), job
  ORDER BY deptno;

SELECT deptno, job
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY job, ROLLUP(deptno)
  ORDER BY job;

-- CUBE 각각의 컬럼별로 소계, 전체 총계를 도출
SELECT deptno, job
	  , count(*)
	  , max(sal)
	  , avg(sal)
  FROM emp
  GROUP BY CUBE(deptno, job)
  ORDER BY deptno;

-- GROUPING 함수: SELECT절에 GROUPING 적용
-- 실무에서는 각 그룹(다중행) 함수에 별명을 지정 사용
SELECT deptno, job
	  , count(*) AS "직원수"
	  , max(sal) AS "최고급여"
	  , avg(sal) AS "최소급여"
	  , GROUPING(job) AS "JOB_GRID"
	  , GROUPING(deptno) AS "DEP_GRID"
	  , GROUPING_ID(deptno, job) AS "DEP_JOB_GRID"
  FROM emp
  GROUP BY ROLLUP(deptno, job)
  ORDER BY deptno;

-- ROLLUP, CUBE를 몰라도 SubQuery로 구현 가능

-- PIVOT
-- 부서별, 직책별로 그룹화 최고 급여 조회, 피벗없이 일반적 방법
SELECT deptno, job, max(sal)
  FROM emp
  GROUP BY deptno, job
  ORDER BY deptno, job;

-- PIVOT 함수 사용
SELECT *
  FROM (SELECT deptno, job, sal
		  FROM emp) -- subquery
  pivot (max(sal) FOR deptno IN (10, 20, 30))
  ORDER BY job;

-- PIVOT 몰라도 CASE - WHEN으로 구현 가능