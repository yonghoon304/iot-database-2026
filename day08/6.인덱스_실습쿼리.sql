# 쿼리 실행 
# 1. 특정 고객의 최근 주문을 조회하시오
SELECT *
  FROM orders_big
 WHERE customer_id=123456
 ORDER BY order_date DESC;

# 2. 특정 기간에 특정 고객의 주문을 조회하시오
SELECT *
  FROM orders_big
 WHERE customer_id =23456
   AND order_date BETWEEN '2024-01-01' AND '2025-12-31';

# 3. Seoul에 금액조건에 정렬 조회
SELECT *
  FROM orders_big 
 WHERE city='Seoul'
   AND amount >=900000
 ORDER BY order_date DESC;

# 실행 계획
# 1. 실행계획
EXPLAIN analyze
SELECT *
  FROM orders_big
 WHERE customer_id=123456
 ORDER BY order_date DESC;
# 실행계획 결과
/* -> Sort: orders_big.order_date DESC  (cost=1.01e+6 rows=9.71e+6) (actual time=2622..2622 rows=26 loops=1)
    -> Filter: (orders_big.customer_id = 123456)  (cost=1.01e+6 rows=9.71e+6) (actual time=1124..2622 rows=26 loops=1)
        -> Table scan on orders_big  (cost=1.01e+6 rows=9.71e+6) (actual time=0.0771..2326 rows=10e+6 loops=1)
*/

# customer_id와 order_date에서 인덱스 걸리지 않아 scan에서 시간이 많이 소요
# 인덱스 추가
# 27초 인덱스 테이블 생성
CREATE INDEX idx_orders_customer_id ON orders_big(customer_id);

# 인덱스 추가후 실행계획
/*
-> Sort: orders_big.order_date DESC  (cost=28.6 rows=26) (actual time=5.09..5.09 rows=26 loops=1)
    -> Index lookup on orders_big using idx_orders_customer_id (customer_id=123456)  (cost=28.6 rows=26) (actual time=2.14..5.06 rows=26 loops=1)
*/

# 두번째 인덱스 추가 
CREATE INDEX idx_orders_order_date ON orders_big(order_date desc);
# 두번째 인덱스 추가 후 실행계획
/*
    -> Filter: (orders_big.order_date between '2024-01-01' and '2025-12-31')  (cost=53.5 rows=25.5) (actual time=0.04..0.177 rows=51 loops=1)
    -> Index lookup on orders_big using idx_orders_customer_id (customer_id=23456)  (cost=53.5 rows=51) (actual time=0.0374..0.165 rows=51 loops=1)
*/

