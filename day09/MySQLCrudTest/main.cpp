// MySQL CRUD
#define NOMINMAX

#include <iostream>
#include <mysql.h>
#include <Windows.h>
#include <clocale>
#include <string>
#include <limits>

using namespace std;

// 메뉴 출력
void printMenu() {
	cout << "========================================" << endl;
	cout << "             MySQL CRUD 예제            " << endl;
	cout << "========================================" << endl;
	cout << "1. 조회" << endl;
	cout << "2. 추가" << endl;
	cout << "3. 수정" << endl;
	cout << "4. 삭제" << endl;
	cout << "5. 종료" << endl;
	cout << "선택 > " << endl;

}

// 입력 버퍼 클리어
void clearInput() {
	cin.clear();
	cin.ignore(numeric_limits<streamsize>::max(),'\n');	// #define NOMINMAX

}

// MySQL 접속
MYSQL* connectDB() {
	MYSQL* conn = mysql_init(NULL);	// 초기화 인자는 옵션
	// 초기화 실패
	if (conn == NULL) {
		cerr << "MySQL 초기화 실패" << endl;
		return NULL;	// 함수 탈출
	}
	// 접속 시도
	conn = mysql_real_connect(
		conn,
		"127.0.0.1", "madang", "madang", "madangdb",
		3306, NULL, 0
	);
	// 접속 실패
	if (conn == NULL) {
		cerr << "MySQL 접속 실패" <<mysql_error(conn)<< endl;
		return NULL;	// 함수 탈출
	}
	// MySQL 서버 문자셋 생략(다 되어 있음)

	return conn;
}

// SELECT 조회함수
void selectBook(MYSQL* conn) {
	const char* query = "SELECT bookid,bookname,publisher,price From Book";

	if (mysql_query(conn, query) != 0) {
		cerr << "SELECT 에러 : " << mysql_error(conn) << endl;
		return;

	}
	MYSQL_RES* result = mysql_store_result(conn);
	if (result == NULL) {
		cerr << "Result 에러 : " << mysql_error(conn) << endl;
		return;
	}
	MYSQL_ROW row;
	cout << "\n========================================\n";
	cout << "\n================도서 정보===============\n";
	cout << "bookid\tbookname\tpublisher\tprice\n";
	cout << "\n----------------------------------------\n";

	// 조회에만 아래 로직
	while ((row = mysql_fetch_row(result)) != NULL) {
		cout << row[0] << '\t' << row[1] <<'\t'
			<< row[2] << '\t' << (row[3]?row[3]:"0") << endl;
	}
	cout << endl;
	mysql_free_result(result);

}

// INSERT 실행함수
void insertBook(MYSQL* conn) {
	string bookid;	// PK Autoincremnent면 필요없음
	string bookname;
	string publisher;
	string price;

	clearInput();
	cout << "\n순번 > ";
	getline(cin, bookid);

	// 숫자 입력시 cin.fail 처리필요

	cout << "책 제목 > ";
	getline(cin, bookname);

	cout << "출판사 > ";
	getline(cin, publisher);

	cout << "가격 > ";
	getline(cin,price);

	// bookid,price는 int형, > to_string으로 형변환
	string query = "INSERT INTO Book VALUES (" + bookid + ", '" +
		bookname + "', '" +
		publisher + "', " +
		price + ")";
	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "INSERT 에러 : " << mysql_error(conn) << endl;
		return;
	}
	cout << mysql_affected_rows(conn) << "건 INSERT 완료\n\n";

}

// UPDATE 실행함수
void updateBook(MYSQL* conn) {
	string bookid;
	string bookname;
	string publisher;
	string price;

	clearInput();
	cout << "\n순번 > ";
	getline(cin, bookid);

	cout << "책 제목 > ";
	getline(cin, bookname);

	cout << "출판사 > ";
	getline(cin, publisher);

	cout << "가격 > ";
	getline(cin, price);

	string query = "UPDATE Book SET bookname = '"
		+bookname+"', publisher = '"
		+publisher+"', price = "
		+price+" WHERE bookid = "+bookid;

	// 쿼리실행
	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "UPDATE 에러 : " << mysql_error(conn) << endl;
		return;
	}
	uint64_t count = mysql_affected_rows(conn);

	if (count == 0) {
		cout << "해당 bookid 데이터가 없습니다.\n\n";
	}
	else
		cout << count << "건 UPDATE 완료" << endl;
}

// DELETE 실행함수
void deleteBook(MYSQL* conn) {
	string bookid;

	clearInput();
	cout << "\nbookid >";
	getline(cin, bookid);

	string query = "DELETE FROM Book WHERE bookid = " + bookid;

	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "DELETE 에러 : " << mysql_error(conn) << endl;
		return;
	}
	uint64_t count = mysql_affected_rows(conn);

	if (count == 0) {
		cout << "해당 bookid 데이터가 없습니다.\n\n";
	}
	else
		cout << count << "건 DELETE 완료" << endl;

}

int main()
{	// 콘솔 utf-8 설정
	SetConsoleOutputCP(CP_UTF8);
	SetConsoleCP(CP_UTF8);
	setlocale(LC_ALL,".UTF8");

	// DB연결
	MYSQL* conn = connectDB();
	if (conn == NULL) {
		return 1;	// 종료
	}
	cout << "MySQL 연결 성공" << endl;

	while (true) {
		int menu =0;
		// 메뉴출력
		printMenu();
		cin >> menu;

		// 숫자 이외 잘못된 입력
		if (cin.fail()) {
			clearInput();
			cout << "메뉴는 숫자로 입력 \n\n";
			continue;
		}

		switch (menu) {
		case 1: 
			// SELECT 
			selectBook(conn);
			break;
		case 2:
			// INSERT
			insertBook(conn);
			break;
		case 3:
			// UPDATE
			updateBook(conn);
			break;
		case 4:
			// DELETE
			deleteBook(conn);
			break;
		case 5:
			// 프로그램 종료
			// 접속종료
			cout << "프로그램 종료" << endl;
			mysql_close(conn);
			return 0;

		default :
			cout << "잘못된 메뉴 선택\n\n";
			break;
		}
	}



	// 접속종료
	mysql_close(conn);
	return 0;
}
