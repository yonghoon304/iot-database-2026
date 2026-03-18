# Sakila 영화 대여 시스템

# 1. ERD 확인

# 2. sakila 사용할 사용자 생성
# 	 반드시 관리자 계정에서 실행
CREATE USER 'sakila_user'@'%' identified BY 'my123456';

# 3. 권한 설정
GRANT ALL PRIVILEGES ON sakila.* TO 'sakila_user'@'%';
#    권한 완전 적용
flush PRIVILEGES;

# 4. sakila_user로 접속정보 생성

# 5. 전체 고객 수 조회하시오

SELECT count(*) AS "total customers"
  FROM customer c;

# 6. 가장 비싼 영화 top 10 
SELECT f.title 
     , f.replacement_cost 
  FROM film f
 ORDER BY f.replacement_cost DESC
 LIMIT 10;

# 7. 고객별 총 결제금액을 조회하시오.
SELECT c.customer_id "고객_번호"
	 , c.first_name AS "성"
     , sum(p.amount) AS "총_결제금액"
  FROM customer c
 INNER JOIN payment p
    ON c.customer_id =p.customer_id 
 GROUP BY c.customer_id,c.first_name 
 ORDER BY 총_결제금액 DESC;

# 8. 배우 중에 TOM MIRANDA 조회
SELECT *
  FROM actor a 
 WHERE a.first_name ='TOM'
   AND a.last_name ='MIRANDA';

# 9. 영화별 출연 조회 수 일반조인
SELECT f.film_id
	 , f.title
     , count(fa.actor_id)
  FROM film f, film_actor fa
 WHERE f.film_id =fa.film_id
 GROUP BY f.film_id 
 ORDER BY count(fa.actor_id) DESC;

# 9-1 left outer join 출연배우가 없는 영화 발견
SELECT f.film_id
	 , f.title
     , count(fa.actor_id)
  FROM film f
  LEFT OUTER JOIN film_actor fa
    on f.film_id =fa.film_id
 GROUP BY f.film_id 
 ORDER BY count(fa.actor_id) DESC;
  
# 9-2 배우없는 영화 확인
SELECT *
  FROM film_actor fa  
 WHERE fa.film_id in(257,323,803);

# 10. 카테고리별 영화
SELECT c.name
     , f.title 
  FROM category c
  JOIN film_category fc 
    ON c.category_id =fc.category_id 
  JOIN film f 
    ON fc.film_id =f.film_id;

# 10-1 카테고리별 영화 수
SELECT IFnull(c.name,'--합계') AS "카테고리"
     , count(fc.film_id ) AS "영화 개수"
  FROM category c
  JOIN film_category fc 
    ON c.category_id =fc.category_id 
  JOIN film f 
    ON fc.film_id =f.film_id
 GROUP BY c.name WITH ROLLUP;

