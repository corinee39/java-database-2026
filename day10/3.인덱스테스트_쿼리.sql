-- 인덱스 테스트 시작!
SELECT count(*) FROM ORDERS_BIG;

-- 오라클 옵티마이저(최적화 기능) 추가설정
BEGIN
	DBMS_STATS.GATHER_TABLE_STATS(
		ownname => USER,
		tabname => 'ORDERS_BIG',
		CASCADE => TRUE
	);
END;


-- ORDERS_BIG 테이블 확인
/*
 * ORDER_ID에 PK 제약조건, 자동으로 인덱스 걸림
 * 나머지 컬럼은 전부 NOT NULL 제약조건
 * */

-- 전체 조회
SELECT *
  FROM ORDERS_BIG;

-- 인덱스가 없는 상태 조회
SELECT count(*)
  FROM ORDERS_BIG
 WHERE customer_id = 12345;

-- 실행계획(Execution Plan) 확인
-- 중급이상 DB개발자들이 확인하는 기능
explain plan FOR
SELECT count(*)
  FROM ORDERS_BIG
 WHERE customer_id = 12345;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- 위 실행계획에서 가장 유심히 볼 것 -> TABLE ACCESS FULL(FULL TABLE SCAN)
-- 300만건을 전부 읽어서 12345를 찾는 것

-- CUSTOMER ID에 인덱스 생성
CREATE INDEX IDX_ORDERS_BIG_CUSTOMER_ID
    ON ORDERS_BIG(CUSTOMER_ID);

-- 오라클 옵티마이저 재갱신설정
BEGIN
	DBMS_STATS.GATHER_TABLE_STATS(
		ownname => USER,
		tabname => 'ORDERS_BIG',
		CASCADE => TRUE
	);
END;

-- 인덱스가 있는 상태 조회
SELECT count(*)
  FROM ORDERS_BIG
 WHERE customer_id = 12345;

-- 실행계획 재확인
explain plan FOR
SELECT count(*)
  FROM ORDERS_BIG
 WHERE customer_id = 12345;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- TABLE ACCESS FULL이 INDEX RANGE SCAN으로 변경
-- 전체 COST가 5641정도에서 3으로 대폭 축소 -> 성능 개선

/* 인덱스 효과가 별로 없는 컬럼 */
-- STATUS 컬럼 - READY(준비), PAID(결제), SHIPPED(배송중), DONE(배송완료), CANCEL(취소)
SELECT count(*)
  FROM ORDERS_BIG
 WHERE status = 'PAID';

-- 실행계획
explain plan FOR
SELECT count(*)
  FROM ORDERS_BIG
 WHERE status = 'PAID';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- STATUS 컬럼 인덱스 부여
CREATE INDEX IDX_ORDERS_BIG_STAUTS
    ON ORDERS_BIG(STATUS);


-- 재실행
SELECT count(*)
  FROM ORDERS_BIG
 WHERE status = 'PAID';

-- 인덱스 생성 후 실행계획
explain plan FOR
SELECT count(*)
  FROM ORDERS_BIG
 WHERE status = 'PAID';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- 검색하는 데이터가 전체의 20% 정도이므로
-- INDEX RANGE SCAN을 해도 비용이 많이 줄지 않음


/* 복합 인덱스, 여러 컬럼에 인덱스 부여 */
SELECT *
  FROM ORDERS_BIG
 WHERE CUSTOMER_ID BETWEEN 12345 AND 23456
   AND ORDER_DATE BETWEEN '2024-01-01' AND '2024-12-31';

-- 실행계획
EXPLAIN PLAN FOR
SELECT *
  FROM ORDERS_BIG
 WHERE CUSTOMER_ID BETWEEN 12345 AND 23456
   AND ORDER_DATE BETWEEN '2024-01-01' AND '2024-12-31';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);


-- 복합인덱스 적용
CREATE INDEX IDX_ORDERS_BIG_CUST_DATE
  ON ORDERS_BIG(CUSTOMER_ID, ORDER_DATE);

-- 인덱스 적용 후 재실행
SELECT *
  FROM ORDERS_BIG
 WHERE CUSTOMER_ID BETWEEN 12345 AND 23456
   AND ORDER_DATE BETWEEN '2024-01-01' AND '2024-12-31';

-- 실행계획
EXPLAIN PLAN FOR
SELECT *
  FROM ORDERS_BIG
 WHERE CUSTOMER_ID BETWEEN 12345 AND 23456
   AND ORDER_DATE BETWEEN '2024-01-01' AND '2024-12-31';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- BETWEEN AND 쿼리는 인덱스의 도움을 못받을 수 있음
EXPLAIN PLAN FOR
SELECT *
  FROM ORDERS_BIG
 WHERE CUSTOMER_ID = 23456
   AND ORDER_DATE >= '2024-01-01';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);


-- 인덱스 확인 쿼리
SELECT *
  FROM USER_INDEXES
 WHERE TABLE_NAME = 'ORDERS_BIG';