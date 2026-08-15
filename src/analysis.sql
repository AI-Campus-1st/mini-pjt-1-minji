-- 충청남도 내 지역별(시도 별)에서 인구수가 많을수록 소상공인 상가 수도 많을 것이다. 
-- 상가 수 
SELECT city_name, COUNT(*) AS store_count
FROM tb_store
GROUP BY  city_name 
ORDER BY store_count DESC ;

-- 인구수 
SELECT city_name, sum(male_population + female_population) AS population_count
FROM tb_population
GROUP BY city_name 
ORDER BY population_count DESC ;

-- 조인
SELECT s.city_name, s.store_count, p.population_count
FROM (SELECT city_name, COUNT(*) AS store_count
    FROM tb_store
    GROUP BY  city_name ) AS s
    INNER JOIN  (SELECT city_name, 
            sum(male_population + female_population) AS population_count
        FROM tb_population
        GROUP BY city_name ) AS p 
ON s.city_name = p.city_name
GROUP BY p.city_name 
ORDER BY p.population_count DESC;

-- 20~30대 여성들이 많은 지역일 수록 카페가 많을 것이다.
-- 20~30대 여성
SELECT city_name, sum(female_population) AS female_20_30_count
FROM tb_population
WHERE age >= 20 And age <= 39
GROUP BY city_name
ORDER BY female_20_30_count DESC ;
-- 지역별 카페
SELECT city_name, COUNT(*) AS cafe_count
FROM tb_store
WHERE category_small LIKE '%카페%'
GROUP BY  city_name 
ORDER BY cafe_count DESC ;
-- join
SELECT f.city_name, c.cafe_count, f.female_20_30_count
FROM (SELECT city_name, sum(female_population) AS female_20_30_count
    FROM tb_population
    WHERE age >= 20 And age <= 39
    GROUP BY city_name) AS f
    INNER JOIN (SELECT city_name, COUNT(*) AS cafe_count
                FROM tb_store
                WHERE category_small LIKE '%카페%'
                GROUP BY  city_name ) AS c
ON  f.city_name = c.city_name
GROUP BY c.city_name
ORDER BY f.female_20_30_count DESC ;

-- 10대 이하 인구가 많은 지역일 수록 소아과가 많을 것이다.
-- 10대 이하 인구
SELECT city_name, sum(male_population + female_population) AS 10_count
FROM tb_population
WHERE age <=10
GROUP BY city_name
ORDER BY 10_count DESC ;

-- 소아과 수
SELECT city_name, COUNT(*) AS pedistrics_count
FROM tb_store
WHERE category_small LIKE '%소아과%'
GROUP BY city_name
ORDER BY pedistrics_count DESC ;

-- join
SELECT pe.city_name, ta.10_count, pe.pedistrics_count
FROM (SELECT city_name, sum(male_population + female_population) AS 10_count
    FROM tb_population
    WHERE age <=10
    GROUP BY city_name) AS ta
    INNER JOIN (SELECT city_name, COUNT(*) AS pedistrics_count
                FROM tb_store
                WHERE category_small LIKE '%소아과%'
                GROUP BY city_name) AS pe
ON ta.city_name = pe.city_name
ORDER BY ta.10_count DESC;

-- 10~20대 학생들이 많은 지역일 수록 스터디카페가 많을 것이다. 
-- 10~20대 
SELECT city_name, sum(male_population + female_population) AS 10_20_count
FROM tb_population
WHERE age >= 10 AND age <= 29
GROUP BY city_name
ORDER BY 10_20_count DESC ;

-- 스터디 카페 수
SELECT city_name, COUNT(*) AS study_cafe
FROM tb_store
WHERE category_small LIKE '%스터디 카페%'
GROUP BY city_name
ORDER BY study_cafe DESC ;

-- join
SELECT a.city_name, st.study_cafe, a.10_20_count
FROM (SELECT city_name, sum(male_population + female_population) AS 10_20_count
    FROM tb_population
    WHERE age >= 10 AND age <= 29
    GROUP BY city_name) AS a
    INNER JOIN (SELECT city_name, COUNT(*) AS study_cafe
                FROM tb_store
                WHERE category_small LIKE '%스터디 카페%'
                GROUP BY city_name) AS st
ON a.city_name = st.city_name
ORDER BY a.10_20_count  DESC ;

-- 인구가 많은 지역일 수록 편의점이 많을 것이다.
-- 시도 별 인구수 
SELECT city_name, sum(male_population + female_population) AS population_count
FROM tb_population
GROUP BY city_name 
ORDER BY population_count DESC ;

-- 편의점 갯수
SELECT city_name, COUNT(*) AS con_store
FROM tb_store
WHERE category_small LIKE '%편의점%'
GROUP BY city_name
ORDER BY con_store DESC ;

SELECT cs.city_name, pc.population_count, cs.con_store
FROM (SELECT city_name, 
    sum(male_population + female_population) AS population_count
    FROM tb_population
    GROUP BY city_name ) AS pc
    INNER JOIN (SELECT city_name, COUNT(*) AS con_store
                FROM tb_store
                WHERE category_small LIKE '%편의점%'
                GROUP BY city_name) AS cs
ON pc.city_name = cs.city_name
GROUP BY cs.city_name
ORDER BY pc.population_count DESC ;