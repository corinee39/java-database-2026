SELECT * FROM RENTALTBL;

SELECT * FROM BOOKSTBL;

SELECT * FROM MEMBERTBL;

SELECT * FROM DIVTBL;

-- 1번
SELECT r.IDX AS "대여번호"
	 , m.NAMES AS "회원명"
	 , b.NAMES AS "책제목"
	 , r.RENTALDATE AS "대여일"
  FROM RENTALTBL r, MEMBERTBL m, BOOKSTBL b
 WHERE r.MEMBERIDX = m.IDX
   AND r.BOOKIDX = b.IDX
   AND r.RETURNDATE IS NULL;

-- 강사님 풀이
SELECT rt.idx AS "대여번호"
     , mt.names AS "회원명"
     , bt.names AS "책제목"
     , rt.rentaldate AS "대여일"
  FROM rentaltbl rt, membertbl mt, bookstbl bt
 WHERE rt.memberidx = mt.idx
   AND rt.bookidx = bt.idx
   AND rt.returndate IS NULL
 ORDER BY rt.idx;


-- 2번
SELECT d.DIVISION AS "분류코드"
	 , d.NAMES AS "분류명"
	 , NVL(count(b.DIVISION), 0) AS "도서수"
  FROM DIVTBL d, BOOKSTBL b
 where d.DIVISION = b.DIVISION (+)
 GROUP BY d.DIVISION, d.NAMES
 ORDER BY d.DIVISION;

-- 강사님 풀이
SELECT dt.division AS "분류코드"
     , dt.names AS "분류명"
     , count(bt.idx) AS "도서수"   -- count(*) 사용안됨!
  FROM divtbl dt
  LEFT OUTER JOIN bookstbl bt  
    ON dt.division = bt.division
 GROUP BY dt.division, dt.names;


-- 3번
SELECT r.BOOKIDX AS "책번호"
	 , b.NAMES AS "책제목"
	 , count(r.BOOKIDX) AS "대여횟수"
  FROM RENTALTBL r, BOOKSTBL b
 WHERE r.BOOKIDX = b.IDX
 GROUP BY r.BOOKIDX, b.NAMES
 ORDER BY count(r.BOOKIDX) DESC;

-- 강사님 풀이
SELECT bt.idx AS "책번호"
     , bt.names AS "책제목"
     , count(rt.idx) AS "대여횟수"
  FROM bookstbl bt, rentaltbl rt
 WHERE bt.idx = rt.bookidx
 GROUP BY bt.idx, bt.names
 ORDER BY count(rt.idx) DESC, bt.idx;


-- 4번
SELECT m.IDX AS "회원번호"
     , m.NAMES AS "회원명"
     , m.LEVELS AS "등급"
     , count(r.MEMBERIDX) AS "대여횟수"
  FROM MEMBERTBL m, RENTALTBL r
 WHERE m.IDX = r.MEMBERIDX
 GROUP BY m.IDX, m.NAMES, m.LEVELS
HAVING count(r.MEMBERIDX) > 1
 ORDER BY m.IDX;

-- 강사님 풀이
SELECT mt.idx AS "회원번호"
     , mt.names AS "회원명"
     , mt.levels AS "등급"
     , count(rt.idx) AS "대여횟수"
  FROM membertbl mt, rentaltbl rt
 WHERE mt.idx = rt.memberidx (+)
 GROUP BY mt.idx, mt.names, mt.levels
HAVING count(rt.idx) > 1
 ORDER BY mt.idx;


-- 5번
SELECT r.IDX AS "대여번호"
	 , m.NAMES AS "회원명"
	 , b.NAMES AS "책제목"
	 , TO_CHAR(r.RENTALDATE, 'yyyy-mm-dd') AS "대여일"
	 , TO_CHAR(r.RETURNDATE, 'yyyy-mm-dd') AS "반납일"
  FROM RENTALTBL r, MEMBERTBL m, BOOKSTBL b
 WHERE r.RENTALDATE > r.RETURNDATE
   AND r.MEMBERIDX = m.IDX
   AND r.BOOKIDX = b.IDX;

-- 강사님 풀이
SELECT rt.idx AS "대여번호"
     , mt.names AS "회원명"
     , bt.names AS "책제목"
     , to_char(rt.rentaldate, 'yyyy-mm-dd') AS "대여일"
     , to_char(rt.returndate, 'YYYY-MM-DD') AS "반납일"
  FROM rentaltbl rt, membertbl mt, bookstbl bt
 WHERE rt.memberidx = mt.idx
   AND rt.bookidx = bt.idx
   AND rt.rentaldate > rt.returndate;