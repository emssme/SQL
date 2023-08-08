-- 트랜잭션(Transaction)
USE shop;

--재고테이블
CREATE TABLE inven(ino INT PRIMARY KEY AUTO_INCREMENT, pid VARCHAR(20), qty INT);

--판매테이블
CREATE TABLE sale(sno INT PRIMARY KEY AUTO_INCREMENT, pid VARCHAR(20), qty INT);

SHOW TABLES;

--입고
INSERT INTO inven(pid, qty) VALUES ('a001',12);
INSERT INTO inven(pid, qty) VALUES ('b001',25);
INSERT INTO inven(pid, qty) VALUES ('c001',18);

INSERT INTO inven(pid, qty) VALUES ('a001',11);
INSERT INTO inven(pid, qty) VALUES ('b001',7);
INSERT INTO inven(pid, qty) VALUES ('c001',14);

SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid;
-- 재고파악
CREATE VIEW pro_view1 AS (SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid);

SELECT * FROM inven;
SELECT * FROM pro_view1;

--판매
INSERT INTO sale(pid, qty) VALUES ('a001',14);

UPDATE inven SET qty = qty- 14 WHERE pid = 'a001';

DELETE FROM inven WHERE qty < 0;
--트랜잭션 처리가 되지않으면 재고처리 시스템에 문제가 발생하므로 이러한 경우 간혹 차집합으로 연산하는 경우가 있음. 그러나 테이블의 변화를 예측하기가 힘든 경우가 발생하기때문에 사용하지 않는 것이 좋다.
create view jk as SELECT * FROM inven except SELECT * FROM sale;

SELECT * FROM inven;

START TRANSACTION;

SAVEPOINT a;

INSERT INTO sale(pid, qty) VALUES ('a001',5);

UPDATE inven SET qty = qty-5 WHERE pid = 'a001' AND ino =(SELECT MIN(ino) FROM inven WHERE pid = 'a001' and qty>=5 GROUP BY pid);

SELECT * FROM inven;

COMMIT;

ROLLBACK;  -- 전부 롤백(commit

ROLLBACK TO a; -- 해당 savepoint 내용만 롤백

CREATE TABLE student(sno INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(100), kor INT, eng INT, mat INT);

INSERT INTO student(sno, sname, kor, eng, mat) VALUES (1, '이진기', 80, 90, 70);
INSERT INTO student(sno, sname, kor, eng, mat) VALUES (2, '김종현', 95, 80, 80);
INSERT INTO student(sno, sname, kor, eng, mat) VALUES (3, '김기범', 90, 100, 75);
INSERT INTO student(sno, sname, kor, eng, mat) VALUES (4, '최민호', 80, 85, 85);
INSERT INTO student(sno, sname, kor, eng, mat) VALUES (5, '이태민', 80, 90, 80);

SELECT * FROM student;

SELECT sname AS '이름', kor+eng+mat AS '총점', (kor+eng+mat)/3 AS '평균' from student;

SELECT sname AS 'name', kor+eng+mat AS 'tot', ROUND((kor+eng+mat)/3) AS 'avg', if((kor+eng+mat)/3>=80,'합격','보충대상자')AS 'pan' FROM student;
-- round(반올림), roundup(올림), rounddown(내림)
-- if(조건, 참, 거짓)

SELECT
	sname AS 'name', 
	kor+eng+mat AS 'tot', 
	ROUND((kor+eng+mat)/3) AS 'avg', 
	if((kor+eng+mat)/3>=80,'합격','보충대상자')AS 'pan', 
	case 
		when ROUND((kor+eng+mat)/3) BETWEEN 90 AND 100 then 'A'
		when ROUND((kor+eng+mat)/3) BETWEEN 80 AND 89 then 'B'
		when ROUND((kor+eng+mat)/3) BETWEEN 70 AND 79 then 'C'
		ELSE 'F'
	END AS 'hak'
	FROM student;
	
	-- case
	--		when 조건 then	결과
	--		when 조건 then	결과
	--		when 조건 then	결과
	-- else 
	-- end
	
-- if, case 는 select에서 사용 가능