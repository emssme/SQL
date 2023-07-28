--회원(member) 테이블 생성--
CREATE TABLE MEMBER(
	id VARCHAR(16) NOT NULL,
	pw VARCHAR(330) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	tel VARCHAR(13),
	regdate TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
	POINT INT DEFAULT 0,
	PRIMARY KEY (id));
	
--테이블 목록 보기--
SHOW TABLES;

--회원테이블 구조 보기--
DESC MEMBER;

--더미 데이터 추가--
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('admin','1234','관리자', 'admin@edu.com','010-1004-1004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('kim','4321','김영현', 'youngk@edu.com','010-4321-4321');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('park','5678','박성진', 'sungjin@edu.com','010-5678-5678');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('yoon','8765','윤도운', 'dowoon@edu.com','010-8765-8765');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('won','2345','김원필', 'wonpil@edu.com','010-2345-2345');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('jay','5432','박제형', 'jay@edu.com','010-5432-5432');

SELECT * FROM MEMBER;

CREATE TABLE board(
bno INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(200) NOT NULL,
content VARCHAR(1000) NOT NULL,
author VARCHAR(16),
resdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
cnt INT DEFAULT 0);

--게시판테이블--
DESC board;

--게시판 더미글 추가--
INSERT INTo board(title, content, author) VALUES ('더미글1', '여기는 더미글1 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글2', '여기는 더미글2 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글3', '여기는 더미글3 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글4', '여기는 더미글4 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글5', '여기는 더미글5 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글6', '여기는 더미글6 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글7', '여기는 더미글7 입니다.','admin');

INSERT INTo board(title, content, author) VALUES
('더미글8', '여기는 더미글8 입니다.','kim');

--게시판 테이블 검색
SELECT * FROM board;
SELECT * FROM MEMBER;

-- 삭제
DELETE FROM MEMBER WHERE id='jay'; --아이디 jay인 회원의 레코드 삭제

UPDATE board SET author = 'lee' WHERE bno=5; --글번호 5인 레코드의 작성자 아이디를 lee로 변경

COMMIT;

-- 7번글에 대한 작성자의 이름
SELECT * FROM MEMBER WHERE id ='admin';
select author FROM board where bno =7;

-- 유사검색
SELECT * FROM MEMBER WHERE NAME LIKE '김%';  -- 이름이 김으로 시작하는 사람 검색
SELECT * FROM MEMBER WHERE NAME LIKE '%원%'; -- 이름이 $원$인 사람 검색

-- 일치 검색
SELECT * FROM MEMBER WHERE NAME IN('김영현','윤도운'); --이름이 일치하는 사람 검색

--중복성 제거
SELECT distinct author FROM board;

-- 구간 검색
SELECT * FROM board WHERE bno >=3 AND bno <=6 --글번호 3이상 6이하인 게시글 검색
SELECT * FROM board WHERE bno BETWEEN 3 AND 6; --글번호 3이상 6이하인 게시글 검색
SELECT * FROM board LIMIT 2, 4; --글번호 2,4인 게시글 검색

-- 7번글에 대한 작성자의 이름
-- 이중쿼리(=, <=,>=, !=,,,): select문을 이중으로 사용
SELECT id, name from member WHERE id=(SELECT author FROM board WHERE bno=8);
-- 일치검색(in)
SELECT id, NAME FROM MEMBER WHERE id IN(SELECT author FROM board);
--불일치 검색(not ~in)
SELECT id, NAME FROM MEMBER WHERE id not IN(SELECT author FROM board);

--연관쿼리와 join
-- 연관쿼리
SELECT * FROM MEMBER a, board b;  -- 7*8 -> 56건 13개 항목
SELECT a.id, a.name, a.email, b.bno, b.title FROM MEMBER a, board b; -- 56건, 5개 항목
SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle FROM MEMBER a, board b; -- 게시판 항목이 p~로 바뀜
SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle FROM MEMBER a, board b WHERE a.id=b.author; 
-- 게시판에 글을 올린 회원 정보와 글정보를 모두 표시
SELECT a.id AS pid, a.name AS pname, a.email AS pemail, a.tel as ptel, b.bno AS pno, b.title AS ptitle FROM MEMBER a, board b WHERE a.id=b.author;

-- 내부 join
SELECT a. id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author;


-- 테이블 복제: 키에 대한 복제는 이루어지지 않음
CREATE TABLE board2 AS SELECT * FROM board; 

-- 기본키 추가
ALTER TABLE board2 ADD CONSTRAINT PRIMARY KEY (bno);
--컬럼 수정 - auto_increment 추가
ALTER TABLE board2 modify bno INT AUTO_INCREMENT;
SELECT * FROM board2
DESC board2;

CREATE VIEW writer_info AS (SELECT a. id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author);
SELECT * FROM writer_info;

-- sort(소트) = 분류, 순서정렬
SELECT * FROM board;

--정렬
SELECT * FROM board ORDER BY author ASC, cnt DESC;
-- 그룹화 및 집계(Gruop By -> count, sum, avg, max, min...
SELECT author, COUNT(author) FROM board GROUP BY author;

-- 테이블 만들기 및 예시 데이터 추가
-- 테이블명: 상품(product)
-- 상품코드: gcode - 정수 / 일련번호(기본키) - 필수입력
-- 상품명: gname -문자열(150) - 필수입력
-- 종류: gcate - 문자열(40)- 필수입력
-- 단가: gprice - 정수 - 필수입력
-- 수량: gqty - 정수 - 기본값:0
-- 등록일: regdate - 날짜 - 기본값: 오늘날짜 및 시간

-- 테이블명: 판매(sales)
-- 판매코드: pcode - 정수 /일련번호(기본키) - 필수입력
-- 상품코드: gcode - 정수 - 필수입력
-- 구매자: id - 문자열(15) - 필수입력
-- 수량: qty- 정수 - 기본값:1 - 필수입력
-- 구매단가: sprice - 정수 - 필수입력
-- 결제수단: stype - 정수 - 필수입력
-- 할인금액: distotal - 정수
-- 결제금액: paytotal - 정수
-- 총금액: stotal - 정수
-- 판매일: saledate - 날짜 - 기본값: 오늘 날짜 및 시간

-- 더미데이터는 본인이 임의로 각자 12건 이상 추가하되
-- 상품데이터는 교육, 서적, 동영상강의 등의 카테고리를 본인이 정하여 추가할 것.
-- 현재 회원과 현존하는 상품 내용을 기준으로 구매한 판매데이터를 추가할 것.

CREATE TABLE product(
gcode INT NOT NULL,
gname VARCHAR(150) NOT NULL,
gcate VARCHAR(40) NOT NULL,
gprice INT NOT NULL,
gqty INT DEFAULT 0,
regdate TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
PRIMARY KEY(gcode));

SHOW TABLES;
DESC product;

INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(1, '수학책','교과서',10000,100);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(2, '책상','가구',80000,10);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(3, '의자','가구',50000,10);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(4, '국어책','교과서',12000,100);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(5, '과학책','교과서',8000,80);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(6, '교육용테블릿PC','전자기기',300000,30);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(7, '음악책','교과서',7000,50);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(8, '미술책','교과서',7000,50);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(9, '음악책 부록 CD','교재부록',5000,20);
insert INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(10, '한국사','교과서',13000,100);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(11, '한국지도','교재부록',3000,15);
INSERT INTO product(gcode, gname, gcate, gprice, gqty) VALUES
(12, '사회책','교과서',8000,50);

SELECT * FROM product;

CREATE TABLE sales(
pcode INT NOT NULL PRIMARY KEY,
gcode INT NOT NULL,
id VARCHAR(15) NOT NULL,
qty INT DEFAULT 1 NOT NULL,
sprice INT NOT NULL,
stype INT NOT NULL,
distotal INT,
paytotal INT,
stotal INT,
saledate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);

DROP TABLE sales;

SHOW TABLES;
DESC sales;

INSERT INTO sales(pcode, gcode, id, qty, sprice, stype) VALUES(1,3,
