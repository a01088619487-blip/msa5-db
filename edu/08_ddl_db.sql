-- CRUD - 끄으읕

-- 오늘 부터  스키마즈? 를 제어하면서 배워볼것이다 ㅇ..ㅇ

--  스키마 구조의 첫번째는 local 좌측칸에 잇는곳에 로칼서버가 [데이터베이스] 여기서 DB생성을 한다
-- DB생성
CREATE DATABASE test;

-- DB 접근 / 선택                 --  session -- 내가 접속을 할때의 정보
USE test;
USE dbsample;
-- SELECT * FROM employees;  -- USE 라는 키워드로 선택할수 잇다
-- 순서가 상관없다?...

-- DB 삭제						-- transaction
DROP DATABASE test ;