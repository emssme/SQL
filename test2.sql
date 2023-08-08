SELECT * FROM buy;
SELECT * FROM product;
SELECT * FROM customer;

-- 테이블 목록보기
SHOW TABLES;

-- sql 파일 실행하여 sql 명령을 실행하기
SOURCE test2.sql;

DESC customer;

customer cus = NEW customer();
cus.setCustomerid(request.getParameter("customerid"));
cus.setCustomername(request.getParameter("customername"));
cus.setCustomertype(request.getParameter("customertype"));
cus.setCountry(request.getParameter("country"));
cus.setCity(request.getParameter("city"));
cus.setState(request.getParameter("state"));
cus.setPostcode(Integer.parseInt(request.getParameter("postcode")));
cus.setReigiontype(request.getParameter("reigiontype"));
cusInsert(cus);

SELECT * FROM customer;

-- 고객 등록
INSERT INTO customer VALUE('AK-10880','Alien Kim','Consumer','South Korea', 'Seoul', 'Seoul',18517,'East');

SELECT * FROM customer WHERE customername LIKE '%Kim%' AND city='seoul';

-- 웹에서 회원등록
public void cusInsert(customer cus){
	INSERT INTO customer VALUE(?,?,?,?,?,?,?,?);
	pstmt.setString(1, cus.getCustomerid());
	pstmt.setString(2, cus.getCustomername());
	pstmt.setString(3, cus.getCustomertype());
	pstmt.setString(4, cus.getCountry());
	pstmt.setString(5, cus.getCity());
	pstmt.setString(6, cus.getState());
	pstmt.setInt(7, cus.getPostcode());
	pstmt.setString8, cus.getReigiontype());
}

-- 고객 정보 변경
UPDATE customer SET country='America', city='Los Angels', state = 'Los Angels' WHERE customerid = 'AK-10880';
SELECT * FROM customer WHERE customername LIKE '%Kim%';
COMMIT;

--웹에서 데이터 변경
UPDATE customer SET country=?, city=?, state = ? WHERE customerid = ?;
pstmt.setString(1, cus.getCountry());
pstmt.setString(2, cus.getCity());
pstmt.setString(3, cus.getState());
pstmt.setString(4, cus.getCustomerid());

-- 고객 삭제
DELETE FROM customer WHERE customerid='AK-10880';

-- 웹에서 고객 삭제
DELETE FROM customer WHERE customerid=?;
pstmt.setString(1, customerid());

USE shop;

SHOW TABLES;

SELECT * FROM buy;
SELECT * FROM product;
SELECT * FROM customer;

-- customerid 별로 그룹화 하여 customerid, 제품거래건수, 총수량, 평균 할인율 출력하라

SELECT customerid, COUNT(*) AS '제품거래건수', SUM(quantity) AS '총수량', AVG(discount) AS '평균할인율' FROM buy GROUP BY customerid;

-- buy 테이블에서 할인율이 가장 적은 거래 정보를 수량(quantity)의 내림차순으로 출력하시오
-- 단 수량이 같은 경우 주문일(orderdate)을 오름차순으로 하시오
SELECT * FROM buy WHERE discount = (SELECT MIN(discount) FROM buy) ORDER BY quantity DESC, orderdate ASC;

-- 배송일(shipdate)의 년도별로 총수량의 합계와 총수량의 평균, 총수량의 최대값을 집계하시오(년도를 추출하는 함수는 year임.)
SELECT YEAR(shipdate) AS '년도', SUM(quantity) AS '총합계', AVG(quantity) AS '총평균', MAX(quantity) AS '최대배송량' FROM buy GROUP BY YEAR(shipdate);

-- 주문일(orderdate)의 년도와 월별로 주문수량(quantity)의 합계와  평균 할인율을 집계하시오(date_format 함수를 사용.)
-- date_format(컬럼, 형식)
SELECT DATE_FORMAT(orderdate, '%Y-%m') AS '년월', SUM(quantity) AS '합계', AVG(discount) AS '평균할인율' FROM buy GROUP BY DATE_FORMAT(orderdate, '%Y-%m') HAVING SUM(quantity) !=0;

-- 제품번호(productid)가 FUR로 시작하는 가구 종류를 구매한 고객정보 중에서 고객명(customername), 국가(country), 도시(city)를 출력하되, 고객id(customerid)의 내림차순으로 하고, 고객id가 같은 경우 주문수량(quantity)의 오름차순으로 할것.
-- 이중쿼리, 연관쿼리, 내부조인 등 원하는 방식으로 해결할 것.
-- 연관쿼리
SELECT a.customername, a.country, a.city FROM customer a, buy b WHERE a.customerid = b.customerid AND b.productid LIKE 'FUR%'ORDER BY a.customerid DESC, b.quantity ASC;
-- 내부조인
SELECT a.customername, a.country, a.city FROM customer a INNER join buy b on a.customerid = b.customerid where b.productid LIKE 'FUR%' ORDER BY a.customerid DESC, b.quantity ASC;

 -- 제품(product) 테이블로부터 가격(price)가 40 이상인 제품을 검색하여 제품2(product2) 테이블을 생성하시오.
 create table product2 AS (SELECT * FROM product WHERE price >= 40);
 SELECT * from product2;
 
 CREATE TABLE product3 AS (SELECT * FROM product WHERE price < 40);
 --제품3(product3) 테이블로 부터 price가 0인 레코드를 삭제하시오.
 DELETE FROM product3 WHERE price <= 0;
 SELECT * from product3;
 
 -- 제품명(productname)에 ""가 있는 데이터의 큰따옴표 제거
 
UPDATE product SET productname = SUBSTRING(productname ,2, LENGTH(productname)-1) WHERE productname LIKE '\"%';
UPDATE product2 SET productname = SUBSTRING(productname ,2, LENGTH(productname)-1) WHERE productname LIKE '\"%';
UPDATE product3 SET productname = SUBSTRING(productname ,2, LENGTH(productname)-1) WHERE productname LIKE '\"%';

-- 합집합
-- UNION: 중복을 제거
-- UNION ALL: 중복 포함하여 합집합
SELECT * FROM product2 union SELECT * FROM product3;
create VIEW uni_tab1 AS (SELECT productid, price FROM product2 UNION SELECT productid, price FROM product3);
SELECT * FROM uni_tab1;

-- 교집합
create VIEW int_tab1 AS (SELECT productid, price FROM product2 intersect SELECT productid, price FROM product3);
SELECT * FROM int_tab1;

-- 차집합
create VIEW exc_tab1 AS (SELECT productid, price FROM product Except SELECT productid, price FROM product2);
SELECT * FROM exc_tab1;


-- 제품2(product2)와 제품3(product3)의 테이블 데이터를 합집합하여 전체상품(totpro)의 테이블을 생성하시오.
-- 제품(product)와 제품3(product3)의 테이블 데이터를 차집합하여 제거상품(revpro)의 테이블을 생성하시오.
-- 제품(product)와 제품2(product2)의 테이블을 교집합하여 인기상품(hotpro)의 테이블을 생성하시오.

CREATE table totpro AS (SELECT * FROM product2 UNION SELECT * FROM product3);
CREATE table revpro AS (SELECT * from product except SELECT * from product3);
CREATE table hotpro AS (SELECT * from product intersect SELECT * FROM product2);
SELECT * FROM totpro;
SELECT * FROM revpro;
SELECT * FROM hotpro;

DESC buy;
SELECT * FROM buy;

-- 특정 고객의 주문정보를 검색
SELECT * FROM buy WHERE customerid = 'BH-11710';
SELECT * FROM buy WHERE customerid = ?;
pstmt.setString(1, customerid);

-- 특정 고객의 본인 정보
selec * FROM customer WHERE customerid = 'BH-11710';

-- DAO(Data Access Object) - CustomDAO
public Customer myInfo(STRING customerid){
	string SQL = "SELECT * FROM customer WHERE customerid = ?";
	pstmt.setString(1, customerid);
	rs = pstmt.excute(SQL);
	Customer cus = NEW Customer
	if(rs.next()){
		cus.setCustomerid(rs.getString("customerid"));
		cus.setCustomerName(rs.getString("customername"));
		....productid.
	}
	RETURN cus;
}

-- Controller(Ctrl)
"http://localhost:8081/mypage?customerid=BH-11710"
STRING customerid = request.getParameter("customerid");

CustomDAO dao = NEW CustomDAO();
Customer cus = dao.myInfo(customerid);
...
patcher.forward(cus);

-- View(.jsp)
Customer cus = (Customer)request.getParameter("cus");

<p>id: <%=cus.getCustomerid(); %></p>
