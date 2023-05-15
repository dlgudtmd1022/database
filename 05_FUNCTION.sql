SELECT *  FROM user_tbl;

INSERT INTO user_tbl VALUES
(null, 'alex', 1986, 'NY', 173 , '2020-11-01'),
(null, 'Smith', 1992, 'Texas', 181 , '2020-11-05'),
(null, 'Emma', 1995, 'Tampa', 168 , '2020-12-13'),
(null, 'JANE', 1996, 'LA', 157 , '2020-12-15');

-- 문자열 함수를 활용해서, 하나의 컬럼을 여러 형식으로 조회해보겠습니다.
SELECT
	user_name,
	UPPER(user_name) AS 대문자유저명,
    LOWER(user_name) AS 소문자유저명,
    LENGTH(user_name) AS 문자길이,
    SUBSTR(user_name,1 ,2) AS 첫글자두번째글자,
    CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 4글자 이상인 유저만 출력alter
-- LENGTH는 byte 길이이므로 한글은 한 글자에 3바이트로 간주
-- 따라서 CHAR_LENGTH()를 이용하면 그냥 글자숫자로 처리
SELECT * FROM user_tbl WHERE CHAR_LENGTH(user_name) >= 4;

-- 함수 도움 없이 4글자만 뽑는 방법
SELECT * FROM user_tbl WHERE user_name like '____';
-- 4글자 이상 뽑는 방법
SELECT * FROM user_tbl WHERE user_name like '%____';