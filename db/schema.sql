-- 상가csv -> tb_store
-- - 상가업소번호              -> store_id 	TEXT
-- - 상호명                   -> store_name 	TEXT
-- - 지점명                   -> branch_name 	TEXT
-- - 상권업종대분류명           -> category_large		TEXT
-- - 상권업종중분류명           -> category_medium	TEXT
-- - 상권업종소분류명           -> category_small		TEXT
-- - 표준산업분류명             -> industry_name		TEXT
-- - 시도명                   -> province_name			TEXT
-- - 시군구명                 -> city_name				TEXT
-- - 행정동명                  -> district_name         TEXT

-- - 시도명                   -> province_name 	TEXT
-- - 시군구명                 -> city_name			TEXT
-- -읍면동면 			-> district_name 		TEXT
-- - 나이 			-> age				INT
-- - 남자                    -> male_population		INT
-- - 여자                    -> female_population	INT

CREATE TABLE tb_store (
    store_id VARCHAR(100) PRIMARY KEY,
    store_name VARCHAR(100),
    branch_name VARCHAR(100),
    category_large VARCHAR(50),
    category_medium VARCHAR(50),
    category_small VARCHAR(100),
    industry_name VARCHAR(100),
    province_name VARCHAR(30),
    city_name VARCHAR(30),
    district_name VARCHAR(30)
);

CREATE TABLE tb_population (
    province_name VARCHAR(100),
    city_name VARCHAR(100),
    district_name VARCHAR(100),
    age INTEGER,
    male_population INTEGER,
    female_population INTEGER,
    PRIMARY KEY(province_name, city_name, district_name, age)
);

CREATE INDEX idx_store_city_name
ON tb_store (city_name) ;
CREATE INDEX idx_population_city_name
ON tb_population (city_name) ;