CREATE TABLE faq(
fno INT PRIMARY KEY AUTO_INCREMENT,
question VARCHAR(1000),
answer VARCHAR(1000),
cnt INT DEFAULT 0);

SELECT * FROM faq;

INSERT INTO faq(question, answer) VALUES ('질문1', '답변1');
INSERT INTO faq(question, answer) VALUES ('질문2', '답변2');
INSERT INTO faq(question, answer) VALUES ('질문3', '답변3');
INSERT INTO faq(question, answer) VALUES ('질문4', '답변4');
INSERT INTO faq(question, answer) VALUES ('질문5', '답변5');

