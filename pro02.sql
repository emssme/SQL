-- 테이블 생성
create table exam1(
	no INTEGER,
	name varchar(50)
	);

-- 컬럼 추가
alter table exam1 ADD COLUMN point integer;
alter table exam1 ADD COLUMN id varchar(100);

-- id의 컬럼명을 sid로 변경
alter table exam1 rename column id to sid;

-- name의 타입을 100글자 타입으로 변경 -컬럼 타입 변경
alter table exam1 alter column name type varchar(100);

-- shop 데이터베이스에 테이블 설계 및 생성
-- 공지사항 (noctie)
-- 컬럼명	참고	타입	제약조건
-- 번호 no 숫자(정수) 기본키,자동증가
-- 제목 title 가변문자(200) 널값허용안함
-- 내용 content 가변문자(200)
-- 작성일 resdate 날짜/시간 기본값:현재날짜/시간
-- 읽은 횟수 visited 숫자(정수) 기본값:0

create table notic(
	no serial primary key ,
	title varchar(200) not null,
	content varchar(1000),
	resdate timestamp default current_timestamp,
	visited integer default 0
	);
	
create table custom(
	id varchar(20) primary key,
	pw varchar(300) not null,
	name varchar(200) not null,
	point integer default 0,
	grade varchar(4) default 'F',
	tel varchar(11) not null,
	email varchar(100) not null,
	birth timestamp not null,
	regdate timestamp default current_timestamp
);

select * from custom;

insert into notice(title, content) values ('더미데이터1', '더미데이터1입니다.');
insert into notice(title, content) values ('더미데이터2', '더미데이터2입니다.');
insert into notice(title, content) values ('더미데이터3', '더미데이터3입니다.');
insert into notice(title, content) values ('더미데이터4', '더미데이터4입니다.');
insert into notice(title, content) values ('더미데이터5', '더미데이터5입니다.');
insert into notice(title, content) values ('더미데이터6', '더미데이터6입니다.');
insert into notice(title, content) values ('더미데이터7', '더미데이터7입니다.');
insert into notice(title, content) values ('더미데이터8', '더미데이터8입니다.');
insert into notice(title, content) values ('더미데이터9', '더미데이터9입니다.');
insert into notice(title, content) values ('더미데이터10', '더미데이터10입니다.');
insert into notice(title, content) values ('더미데이터11', '더미데이터11입니다.');
insert into notice(title, content) values ('더미데이터12', '더미데이터12입니다.');
insert into notice(title, content) values ('더미데이터13', '더미데이터13입니다.');
insert into notice(title, content) values ('더미데이터14', '더미데이터14입니다.');
insert into notice(title, content) values ('더미데이터15', '더미데이터15입니다.');
insert into notice(title, content) values ('더미데이터16', '더미데이터16입니다.');
insert into notice(title, content) values ('더미데이터17', '더미데이터17입니다.');

insert into custom(id, pw, name, tel, email, birth) 
values ('kim','1234','김보경','01012341234','kim@chunjae.com', '19970924');
insert into custom(id, pw, name, tel, email, birth) 
values ('lee','4321','이보경','01043214321','lee@chunjae.com', '19970925');
insert into custom(id, pw, name, tel, email, birth) 
values ('park','1111','박보경','01011111111','park@chunjae.com', '19970926');
insert into custom(id, pw, name, tel, email, birth) 
values ('shin','2222','신보경','01022222222','shin@chunjae.com', '19970927');
insert into custom(id, pw, name, tel, email, birth) 
values ('na','3333','나보경','01033333333','na@chunjae.com', '19970824');
insert into custom(id, pw, name, tel, email, birth) 
values ('kang','4444','강보경','01044444444','kang@chunjae.com', '19950924');
insert into custom(id, pw, name, tel, email, birth) 
values ('kil','5555','길보경','01055555555','kil@chunjae.com', '19970824');
insert into custom(id, pw, name, tel, email, birth) 
values ('yoon','6666','윤보경','01066666666','yoon@chunjae.com', '19970724');
insert into custom(id, pw, name, tel, email, birth) 
values ('ku','7777','구보경','01077777777','ku@chunjae.com', '19960924');
insert into custom(id, pw, name, tel, email, birth) 
values ('baek','8888','백보경','01088888888','baek@chunjae.com', '19960724');

