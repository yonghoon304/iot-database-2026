# sakila DB연습

# 1. 한 번도 대여되지 않은 영화를 조회하시오
SELECT f.title ,r.rental_id
  FROM film f
  LEFT JOIN inventory i 
    ON f.film_id =i.film_id 
  LEFT JOIN rental r
    ON i.inventory_id =r.inventory_id
 WHERE r.rental_id IS NULL;

# MySQL 조인은 내부조인을 외부조인으로 변경하는데 시간 많이  소요
# from절에 조인보다 JOIN문으로 쓰는걸 추천

# 2. 가장 많이 대여된 영화를 조회하시오
SELECT f.title,count(r.rental_id) AS "총_렌트_수"
  FROM film f
  JOIN inventory i 
    ON f.film_id =i.film_id 
  JOIN rental r
    ON i.inventory_id =r.inventory_id
 GROUP BY f.film_id 
 ORDER BY 총_렌트_수 DESC
 LIMIT 1;

# 3. 직원별 총 매출
SELECT s.staff_id ,s.first_name ,s.last_name 
     , round(sum(p.amount),1) AS "총_매출"
  FROM staff s
  JOIN payment p
    ON s.staff_id =p.staff_id
 GROUP BY s.staff_id ,s.first_name ,s.last_name
 ORDER BY 총_매출 DESC;

# 4. TOM MIRANDA 배우가 출연한 영화목록을 조회하시오
SELECT f.film_id ,f.title
     , f.language_id
     , (SELECT name FROM `language` l  WHERE l.language_id =f.language_id ) AS "영화언어"
  FROM film f 
  JOIN film_actor fa 
    ON f.film_id =fa.film_id 
  JOIN actor o
    ON fa.actor_id = o.actor_id 
 WHERE o.first_name ='TOM'
   AND o.last_name ='MIRANDA';
   
# 5. 새 고객 Gildong Hong을 추가하세요
SELECT * FROM customer;

# customer id는 Auto Increment로 직접 추가할 필요 없음
INSERT INTO customer(store_id,first_name ,last_name ,email,address_id,active,create_date)
VALUES (2,'Gildong','Hong','gildong@naver.com',5,1,now());

# 6. Gildong Hong의 이메일 주소를 수정하세요.
UPDATE customer
   SET email = 'gildong.hong@gamil.com'
 WHERE customer_id=601;

# 7. Gildong Hong 비활성단계로 수정하세요
UPDATE customer
   SET active =0
 WHERE customer_id=601;

# 8. 삭제(실행 안함)
DELETE FROM customer
 WHERE customer_id=;