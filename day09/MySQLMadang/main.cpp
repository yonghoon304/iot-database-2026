#include <iostream>
#include <mysql.h>
#include <windows.h>	// 콘솔처리
#include <clocale>		// 국가언어관련 Code Page(CP) CP949한글

using namespace std;

int main() {
	// 콘솔을 UTF-8로 설정
	SetConsoleOutputCP(CP_UTF8);
	SetConsoleCP(CP_UTF8);
	setlocale(LC_ALL, ".UTF8");

	// 필요변수 선언
	MYSQL Conn; // DB연결을 위한 구조체
	MYSQL* ConnPtr = NULL;	// 연결포인터, 연결 이후 사용할 포인터변수
	MYSQL_RES* Result = NULL;	// 결과값 포인터
	MYSQL_ROW Row;	// 한 행 데이터 담는 변수
	int Stat; // 현재 상태값

	// mysql 초기화
	mysql_init(&Conn);	// 연결 객체를 초기화
	// 아래의 정보로 mysql 서버에 접속 시도
	ConnPtr = mysql_real_connect(&Conn,"127.0.0.1",
		"madang","madang","madangdb",
		3306,NULL,0);
	
	// 접속이 실패하면
	if (ConnPtr == NULL) {
		cerr << "MySQL 연결 실패" << mysql_error(&Conn) << endl;
		return 1;
	}
	cout << "MySQL 연결 성공!" << endl;

	// MySQL 서버쪽 문자셋 UTF-8로 설정
	if (mysql_set_character_set(ConnPtr, "utf8mb4") != 0) {
		cerr << "MySQL 문자셋 설정 실패" << mysql_error(&Conn) << endl;
		return 1; // 접속 종료
	}
	cout << "MySQL 문자셋 설정 성공!" << endl;


	// madangdb의 Book 테이블 SELECT
	const char* Query = "SELECT bookid, bookname, publisher, price"
						"  FROM Book";
	Stat = mysql_query(ConnPtr, Query);

	// Stat에서 쿼리실행 오류시 Stat이 0이의 값이 들어감
	if (Stat != 0) {
		cerr << "MySQL 쿼리 실패" << mysql_error(ConnPtr) << endl;
		mysql_close(ConnPtr);	// 접속 종료
		return 1;
	}
	cout << "MySQL 쿼리 성공!" << endl;

	// Result SELECT문 결과를 메모리로 저장
	Result = mysql_store_result(ConnPtr);
	if (Result == NULL) {
		cerr << "MySQL 결과저장 실패" << mysql_error(ConnPtr) << endl;
		mysql_close(ConnPtr);	// 접속 종료
		return 1;
	}
	cout << "MySQL 결과저장 성공!" << endl;

	// 커서중 Fetch만 사용 데이터 로드
	while ((Row = mysql_fetch_row(Result)) != NULL) {
		cout << Row[0] << ", " << Row[1] << ", "
			<< Row[2] << ", " << (Row[3] ? Row[3] : "NULL") << endl;
	}
	mysql_free_result(Result); // 포인터 메모리해제
	mysql_close(ConnPtr);	// 서버 연결 끊기


	cout << "MySQL 연결 종료!!" << endl;


	return 0;
}