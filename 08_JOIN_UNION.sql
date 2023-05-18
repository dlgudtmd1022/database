-/*
	조인(JOIN)
    2개 이상의 테이블을 결합, 여러 ㅌ테이블에 나누어 삽입된 연관된 데이터를 결합해주는 기능
    같은 내용의 컬럼이 존재해야만 사용할 수 있음.
    
    SELECT 테이블1.컬럼1, 테이블1.컬럼2 ... 테이블2.컬럼1, 테이블2.컬럼2...
    FROM 테이블1 JOIN 구문 테이블2
    ON 테이블1.공통컬럼 = 테이블2.공통컬럼;

	WHERE구문을 이용해 ON절로 합쳐진 결과 컬럼에 대한 필터링이 가능합니다.
*/

-- 예제 데이터를 삽입하기 위한 테이블 2개 생성(외래키는 걸지 않겠습니다.)
CREATE TABLE member_tbl (
	mem_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_name VARCHAR(10) NOT NULL,
    mem_addr VARCHAR(10) NOT NULL
);

CREATE TABLE purchase_tbl(
	pur_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_num INT,
    pur_date DATETIME DEFAULT now(),
    pur_price INT
);

-- 예제 데이터 삽입
INSERT INTO member_tbl VALUES
	(null, '김회원', '서울'),
    (null, '박회원', '경기'),
    (null, '최회원', '제주'),
    (null, '박성현', '경기'),
    (null, '이성민', '서울'),
    (null, '강영호', '충북');
    
INSERT INTO purchase_tbl VALUES
	(null, 1, '2023-05-12', 50000),
    (null, 3, '2023-05-12', 20000),
    (null, 4, '2023-05-12', 10000),
    (null, 1, '2023-05-13', 40000),
    (null, 1, '2023-05-14', 30000),
    (null, 3, '2023-05-14', 30000),
    (null, 5, '2023-05-14', 50000),
    (null, 5, '2023-05-15', 60000),
    (null, 1, '2023-05-15', 15000);
 
SELECT * FROM member_tbl;
SELECT * FROM purchase_tbl; 

SELECT member_tbl.mem_num, member_tbl.mem_name, member_tbl.mem_addr,
		purchase_tbl.pur_date, purchase_tbl.pur_num, purchase_tbl.pur_price
FROM member_tbl INNER JOIN purchase_tbl
ON member_tbl.mem_num = purchase_tbl.mem_num;

-- buy_tbl과 user_tbl이 원래 있었는데, 그 둘을 조인해주세요.
-- user_tbl에서 조회할 컬럼 : user_name, user_address, user_num
-- buy_tbl에서 조회할 컬럼 : buy_num, prod_name, prod_cate, price, amount
SELECT user_tbl.user_name, user_tbl.user_address, user_tbl.user_num,
	buy_tbl.buy_num, buy_tbl.prod_name, buy_tbl.prod_cate, buy_tbl.price,
    buy_tbl.amount
FROM
	user_tbl INNER JOIN buy_tbl
ON user_tbl.user_num = buy_tbl.user_num;

-- 테이블명을 전부 적으면 귀찮기 때문에, 테이블명을 별칭으로 줄여서 써보겠습니다.
-- FROM절에서 테이블명을 지정할 때, FROM 테이블명 별칭1 JOIN 테이블명 별칭2
-- 형식을 사용하면 별칭을 테이블명 대신 쓸 수 있스니다.
SELECT m.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m INNER JOIN purchase_tbl p
ON m.mem_num = p.mem_num;

-- buy_tbl과 user_tbl이 원래 있었는데, 그 둘을 조인해주세요.
-- 이 문제에 대해서도 테이블 별칭을 쓰는 구문으로 바꿔서 작성해보세요.
SELECT abc.user_name, abc.user_address, abc.user_num,
	def.buy_num, def.prod_name, def.prod_cate, def.price,
    def.amount
FROM
	user_tbl abc INNER JOIN buy_tbl def
ON abc.user_num = def.user_num;

-- LEFT JOIN, RIGHT JOIN은, JOIN절 왼쪽이나 오른쪽 테이블은 전부 데이터를 남기고
-- 반대쪽방향 테이블은 교집합만 남깁니다.
SELECT p.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m RIGHT JOIN purchase_tbl p
ON m.mem_num = p.mem_num;

SELECT * FROM purchase_tbl;

-- RIGHT JOIN 확인을 위한 데이터 생성
INSERT INTO purchase_tbl VALUES 
	(null, 8, '2023-05-16', 25000),
    (null, 9, '2023-05-16', 25000),
    (null, 8, '2023-05-17', 35000);

-- MySQL에서는 FULL OUTER JOIN을 지원하지 않습니다.
-- 따라서 뒤에서 배울 UNION이라는 구문을 응용해 처리합니다.

-- 조인할 컬럼명이 동일하다면, ON 대신 USING(공통컬럼명) 구문을 대신 써도 됩니다.
SELECT p.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m LEFT JOIN purchase_tbl p
USING (mem_num);

-- CROSS JOIN은 조인 대상인 테이블1과 테이블2간의 모든 ROW의 조합쌍을 출력합니다.
-- 그래서 결과 ROW의 개수는 테이블1의 ROW개수 * 테이블2의 ROW개수가 됩니다.

-- 테스트 코드를 돌려보고, 예제 테이블을 다시 만들어보겠습니다.
SELECT u.user_num, b.buy_num FROM
	user_tbl u, buy_tbl b;-- ,로 나열시 cross join 구문 생략 가능
-- user_tbl 10개로우, buy_tbl은 3개로우 = 크로스조인 결과 로우는 30개
SELECT COUNT(*) FROM
	user_tbl CROSS JOIN buy_tbl;

-- 좀 더 이해하기 쉬운 예시
CREATE TABLE phone_volume(
	volume varchar(3),
    model_name varchar(10)
);

CREATE TABLE phone_color(
	color varchar(5)
);

INSERT INTO phone_volume VALUES
	(128, 'galaxy'),
    (256, 'galaxy'),
    (512, 'galaxy'),
    (128, 'iphone'),
    (256, 'iphone'),
    (512, 'iphone');

INSERT INTO phone_color VALUES
	('빨간색'),
    ('파란색'),
    ('노란색'),
    ('회색');

-- 여러분들이 직접 크로스조인 결과를 보면서 모든 조합쌍이 나왔는지 체크해주세요.
SELECT * FROM phone_volume CROSS JOIN phone_color;

-- SELF조인은 자기 테이블 내부 자료를 참조하는 컬럼이 있을때
-- 해당 자료를 온전하게 노출시키기 위해서 사용하는 경우가 대부분입니다.
-- 예시로는 사원 목록중 자기 자신과 직속상사를 나타내거나 게시판에서 원본글과 답변글을 나타내는 경우
-- 연관된 자료를 한 테이블 형식으로 조회하기 위해 사용합니다.
CREATE TABLE staff(
	staff_num INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(20),
    staff_job VARCHAR(20),
    staff_salary INT,
    staff_supervisor INT
);

INSERT INTO staff VALUES
	(NULL, '설민경', '개발', 30000, NULL),
    (NULL, '윤동석', '총무', 25000, NULL),
    (NULL, '하영선', '인사', 18000, NULL),
    (NULL, '오진호', '개발', 5000, 1),
    (NULL, '류민지', '개발', 4500, 4),
    (NULL, '권기남', '총무', 4000, 2),
    (NULL, '조예지', '인사', 3200, 3),
    (NULL, '배성은', '개발', 3500, 5);

-- SELF JOIN을 이용해 직원이름과 상사이름이 같이 나오게 만들어보겠습니다.
-- SELF JOIN은 테이블 자기 자신을 자기가 참조하도록 만들기 때문에
-- JOIN시 테이블명은 좌, 우 같은 이름으로, AS를 이용해서 부여한 별칭은 다르게 해서
-- 좌측과 우측 테이블을 구분하면 됩니다. 이외에는 모두 같습니다.
SELECT
	r.staff_num, l.staff_name as 상급자이름, r.staff_name as 하급자이름
FROM
	staff as l INNER JOIN staff as r
ON
	l.staff_num = r.staff_supervisor;

SELECT * FROM staff;

-- UNION은 SELECT문 두 개를 위 아래로 배치해서 양쪽 결과를 붙여줍니다.
-- 수직적확장을 고려할때 주로 사용합니다.
-- 고양이 테이블 생성
CREATE TABLE CAT (
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
    animal_type VARCHAR(20)
);
-- 강아지 테이블 생성
CREATE TABLE DOG (
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
	animal_type VARCHAR(20)
);

-- 고양이 2마리, 강아지 2마리 넣기
INSERT INTO cat VALUES
	('룰루', 4, '룰맘', '고양이'),
    ('어완자', 5, '양정', '고양이');
INSERT INTO dog VALUES
	('턱순이', 7, '이영수', '강아지'),
    ('구슬이', 8, '이영수', '강아지');

-- UNION으로 결과 합치기
SELECT * FROM CAT
UNION
SELECT * FROM DOG;