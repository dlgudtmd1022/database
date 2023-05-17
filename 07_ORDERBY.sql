-- ORDER BY는 SELECT문의 질의겨로가를 정렬할때 사용합니다.
-- ORDER BY 절 다음에는 어떤 컬럼을 기준으로 어떤 방식으로 정렬할지 적어줘야 합니다.


-- 다음은 user_tbl에 대해서 키순으로 내림차순 정렬한 예시입니다.
SELECT * FROM user_tbl ORDER BY user_height DESC;

-- user_tbl에 대해서, 키순으로 오름차순 정렬해 주시되, 키가 동률이라면 체중순으로 내림차순정렬
SELECT * FROM user_tbl ORDER BY user_height ASC, user_weight DESC;

-- 이름을 가나다라 순으로 정보를 정렬하되, un이라는 별칭을 활용
SELECT user_num, user_name AS un, user_birth_year, user_address
	FROM user_tbl
    ORDER BY un ASC;

-- 컬럼 번호를(왼쪽부터 1번부터 시작, 우측을 갈수록 1씩 증가) 이용해서도 정렬 가능합니다.
SELECT user_num, user_name AS un, user_birth_year, user_address
	FROM user_tbl
    ORDER BY un ASC;
    
-- 지역별 키 평균을 내림차순으로 정렬해서 보여주세요.
SELECT user_address, AVG(user_height) AS 키평균 FROM user_tbl GROUP BY user_address ORDER BY 키평균 DESC; 

-- 경기 지역 사람들만 체중을 기준으로 내림차순 정렬해주세요.
-- 나머지 지역은 정렬기준이 없습니다.
SELECT  * FROM user_tbl;

SELECT user_name, user_birth_year, user_address, user_height, user_weight
FROM user_tbl
ORDER BY
	CASE user_address -- 지역컬럼에서
		WHEN '경기' THEN user_weight
        ELSE NULL
	END DESC;

-- 생년도가 1992년인 사람은 키 기준 오름차순,
-- 생년도가 1998인 사람은 이름 기준 오름차순으로 정렬해서 출력
-- 나머지들은 조건 적용을 받지 않습니다.

SELECT * FROM user_tbl
ORDER BY CASE user_birth_year
	WHEN 1992 THEN user_height
    WHEN 1998 THEN user_name
    ELSE NULL
    END ASC;
