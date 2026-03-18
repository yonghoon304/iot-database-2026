# 내장함수

# 수학함수
SELECT abs(-78),abs(+78);
  FROM DUAL; # 테이블을 사용하지 않을 때 사용하는 키워드(Oracle 문법)
  
# 반올림
SELECT round(3.141592,3);

# 고객별 평균 주문금액을 백원단위로 반올림하시오
SELECT o.custid AS "고객번호"
     , round(sum(saleprice)/count(*),-2) AS "평균금액"
  FROM Orders o
 GROUP BY o.custid;

SELECT ceil(3.14),floor(3.67),power(2,10);

# 나머지 함수
SELECT MOD(10,3);
# 2. 문자함수
# 결합함수, 파라미터 갯수에 제한이 없음
SELECT concat('최','용훈');

# 소문자,대문자 변환
SELECT lower('HELLO'), upper('hello');
	
# 자리수 채우기
SELECT LPAD('hello',10,'*')
     , RPAD('hello',10,'^'); # 주민번호 뒷자리 ******

# 문자열 대체
SELECT replace('hello world','hello','bye');

# 문자열 자르기
SELECT substr('hello world',7,5);

# 문자열 공백 없애기(중간 공백 제외), trim,ltrim,rtrim
SELECT concat('-',trim('      hello world        '),'-');

# 구분자로 지정하여 문자열합치기
SELECT concat_ws('-','2026','03','18');
SELECT concat_ws('-','hello','world');

# 알파벳을 아스키코드 변환
SELECT ascii('A');

# 문자열 길이리턴
# 한글 1글자는 UTF-8에서 3byte 차지, 글자길이와 저장되는 바이트길이는 다름
SELECT length('안녕하세요'),char_length('안녕하세요');

# 3. 날짜함수

# 날짜로 작성된 문자열을 날짜형식으로 변환
SELECT str_to_date('2026-03-18','%Y-%m-%d');

# 날짜문자열을 날짜포맷에 맞춰서 변경
SELECT date_format('2026-03-18','%Y-%m-%d')
	 , date_format('2026-03-18','%Y/%m/%d')
	 , date_format(now(),'%Y/%m/%d'); 

# 날짜 더하기
SELECT adddate(now(),INTERVAL 10 day)
     , date(now()),time(now());

# 날짜 간 날짜차이수
SELECT datediff(now(),'2026-04-13');

# 현재 일시
SELECT sysdate(),now();

# 날짜함수 포맷
/*
 * %Y : 네 자리 년도 2026
 * %y : 두 자리 년도 26
 * %m : 월
 * %M : 월 이름(January~December)
 * %b : 월 이름(Jan~Dec)
 * %d : 일
 * %w : 요일숫자
 * %W : 요일(0 일요일 ~6 토요일)
 * %a : 요일 이름 약자
 * %H : 24시간제
 * %H : 12시간제
 * %i : 분
 * %s : 초
 */
SELECT date_format(now(),
