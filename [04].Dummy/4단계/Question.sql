--시험 문제 tblQuestion
--문제번호, 시험번호, 문제, 답, 점수, 유형, exist

CREATE sequence questionSeq;
--DROP sequence questionSeq;
--delete tblQuestion;
--select * from tblQuestion;

--=====================================================================
--**개설과정1**
--시험1(개설과정1 - 개설과목1 -> 과목1: 프로그래밍 기초)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, '산술 연산자에 대해서 설명할 수 있다.', 'Yes', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, '비교 연산자에 대해서 설명할 수 있다.', 'Yes', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, '논리 연산자에 대해서 설명할 수 있다.', 'Yes', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, '대입 연산자에 대해서 설명할 수 있다.', 'Yes', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, '조건 연산자에 대해서 설명할 수 있다.', 'Yes', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, 'int num = 10000000000; //이 코드는 실행이 가능하다.', 'No', 25, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, 'char c = "A"; //이 코드는 실행이 가능하다.', 'No', 25, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, 'System.out.print("10 + 20 = " + 10 + 20); //이 코드의 결과는 "10 + 20 = 30"이다.', 'No', 25, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 1, 'System.out.print(010); //이 코드의 결과는 8이다.', 'Yes', 25, '실기', default);

--시험2(개설과정1 - 개설과목2 -> 과목32: 웹 프로그래밍)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, '처음으로 웹 브라우저를 만든 사람은?', '팀 버너스리', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, '최초로 만들어진 웹 브라우저의 이름은 무엇인가?', 'WorldWideWeb', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, '웹 페이지를 작성할 때 문서의 구조와 콘텐츠 표현에 사용되는 언어는 무엇인가?', 'HTML', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, '웹 페이지를 작성할 때 문서의 모양 표현에 사용되는 언어는 무엇인가?', 'CSS', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, '웹 페이지의 동적 변경 및 응용프로그램 작성할 때 사용되는 언어는 무엇인가?', 'Javascript', 20, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 2, 'Javascript에서 생성자 함수로 생성하는 객체 모두에 메소드를 추가할 때 사용하는 속성은 prototype이다.', 'Yes', 100, '실기', default);

--시험3(개설과정1 - 개설과목3 -> 과목2: Java 객체지향 프로그래밍)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 3, '부모 클래스의 public 멤버는 자식 클래스의 public 멤버가 된다.', 'Yes', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 3, '부모 클래스의 private 멤버는 상속이 되지 않는다.', 'No', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 3, '프로젝트 구현 시 클래스 상속을 사용해봤다.', 'Yes', 50, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 3, '프로젝트 구현 시 toString() 메소드를 재정의를 구현해봤다.', 'Yes', 50, '실기', default);

--시험4(개설과정1 - 개설과목4 -> 과목3: C 프로그래밍
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 4, '필기문제1', '필기문제1-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 4, '필기문제2', '필기문제2-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 4, '실기문제1', '실기문제1-답', 50, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 4, '실기문제2', '실기문제2-답', 50, '실기', default);

--시험5(개설과정1 - 개설과목5 -> 과목10: 멀티 플랫폼 기반 융합 실무 프로젝트)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 5, '필기문제1', '필기문제1-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 5, '필기문제2', '필기문제2-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 5, '실기문제1', '실기문제1-답', 50, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 5, '실기문제2', '실기문제2-답', 50, '실기', default);

--시험6(개설과정1 - 개설과목6 -> 과목11: 임베디드 프로그래밍)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 6, '필기문제1', '필기문제1-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 6, '필기문제2', '필기문제2-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 6, '실기문제1', '실기문제1-답', 50, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 6, '실기문제2', '실기문제2-답', 50, '실기', default);

--시험7(개설과정1 - 개설과목7 -> 과목8: Back-end 설계 및 구현)
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 7, '필기문제1', '필기문제1-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 7, '필기문제2', '필기문제2-답', 50, '필기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 7, '실기문제1', '실기문제1-답', 50, '실기', default);
INSERT INTO tblQuestion VALUES (questionSeq.nextVal, 7, '실기문제2', '실기문제2-답', 50, '실기', default);

commit;
