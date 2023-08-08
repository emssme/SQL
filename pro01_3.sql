USE edu;

-- 기존 테이블 존재 시 현재 테이블을 참조하는 테이블도 삭제
DROP TABLE if EXISTS qna;

-- 질문 및 답변 테이블 생성
CREATE TABLE qna(qno INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(200) NOT NULL,
content VARCHAR(1000),
author VARCHAR(16),
resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
cnt INT DEFAULT 0,
lev INT DEFAULT 0,  -- 질문(0), 답변(1)
par INT,   -- 부모 글번호 -> 질문(자신 레코드의 qno), 답변


FOREIGN KEY(author) REFERENCES member(id) ON DELETE CASCADE
);



SELECT * FROM qna;
-- 해당 지문 및 답변 글을 삭제시에 참조하고 있는 sales 테이블의 데이터도 같이 삭제하라
DELETE FROM qna WHERE qno=? CASCADE;

-- 해당 회원이 묻고답하기qna에 글을 남기고, 회원탈퇴를 시도하는 경우에는 묻고 답하기에 남긴 글도 같이 제거해야 한다.
DELETE FROM member WHERE id=?;  -- 탈퇴가 되지 않음(묻고 답하기에 글이 있어서)

DELETE FROM member WHERE id=?;  -- 탈퇴를 허용ㅎ면서 묻고답하기의 글도 같이 연쇄삭제 처리

-- 더미 데이터 작성
INSERT INTO qna(title, content, author, lev) VALUEs ('질문1','오늘 시험 쉽게나오나요?','kim',0);
INSERT INTO qna(title, content, author, lev, par) VALUEs ('질문1에 대한 답변','몰라','kim',1,1);
INSERT INTO qna(title, content, author, lev) VALUEs ('질문2','오늘밥?','park',0);
INSERT INTO qna(title, content, author, lev, par) VALUEs ('질문2에 대한 답변', '몰라용','admin',1,2);
INSERT INTO qna(title, content, author, lev) VALUES ('질문3','집에 언제가요?','yoon',0);
INSERT INTO qna(title, content, author, lev, par) VALUES ('질문3에 대한 답변','몰라요', 'kim',1,3);

UPDATE qna SET par=qno WHERE lev=0 and qno =10;
UPDATE qna SET par=10 WHERE qno=9;

SELECT * FROM qna ORDER BY par DESC, lev ASC, qno ASC ;

COMMIT;

SELECT a.qno AS qno, a.title AS title, a.content AS content, a.author AS author, a.resdate AS resdate, a.cnt AS cnt, a.lev AS lev, a.par AS par, b.name AS NAME FROM qna a, member b WHERE a.author=b.id ORDER BY a.par DESC, a.lev ASC, a.qno ASC;
-- 만약 외래키로 인해 발생한다
-- 판매 테이블에서 묻고 답하기와 연관되어 있다. -> 판매테이블에서 묻고답하기 테이블의 qno 또는 author를 기준으로 참조하고 있음.
COMMIT;


CREATE VIEW qnalist AS (SELECT a.qno AS qno, a.title AS title, a.content AS content, a.author AS author, a.resdate AS resdate, a.cnt AS cnt, a.lev AS lev, a.par AS par, b.name AS NAME FROM qna a, member b WHERE a.author=b.id ORDER BY a.par DESC, a.lev ASC, a.qno ASC);

SELECT * FROM qnalist;