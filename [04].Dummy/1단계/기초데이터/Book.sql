/********************************
-- 교재 더미 데이터 50개
**********************************/
create sequence bookSeq;
--drop sequence bookSeq;
select * from tblBook;
--delete from tblBook;

-------------- 풀스택 자바기반 관련 프로그래밍 교재----------------------------------------------
-----------------10개------------------------------------------
INSERT INTO tblBook values (bookSeq.nextval, 'Do it! 점프 투 파이썬','박응용','이지스퍼블',360,'2019-06-11',16920);
INSERT INTO tblBook values (bookSeq.nextval, 'Do it! HTML+CSS+자바스크립트','고경희','이지스퍼블',648,'2019-04-21',27000);
INSERT INTO tblBook values (bookSeq.nextval, 'Do it! 안드로이드 앱프로그래밍','정재곤','이지스퍼블',848,'2018-03-21',36000);
INSERT INTO tblBook values (bookSeq.nextval, '자바 ORM 표준 JPA 프로그래밍','김영한','프레임워크',736,'2015-07-28',38700);
INSERT INTO tblBook values (bookSeq.nextval, '혼자 공부하는 첫 프로그래밍(파이썬)','문현일','한빛미디어',412,'2020-06-30',15300);
INSERT INTO tblBook values (bookSeq.nextval, '생활코딩! React 리액트 프로그래밍','이고잉','위키북스',601,'2020-01-13',22500);
INSERT INTO tblBook values (bookSeq.nextval, '스프링5 프로그래밍 입문','최범균','가메출판사',398,'2017-01-31',18900);
INSERT INTO tblBook values (bookSeq.nextval, '자바 웹 프로그래밍 Next Step','박재성','로드북',562,'2020-12-03',27000);
INSERT INTO tblBook values (bookSeq.nextval, 'C포자를 위한 본격 C 언어 프로그래밍 ','허경용','제이펍',499,'2020-03-23',11500);
INSERT INTO tblBook values (bookSeq.nextval, '모던 자바스크립트 Deep Dive','이웅모','위키북스',710,'2018-09-03',42500);
-----------------20개------------------------------------------
INSERT INTO tblBook values (bookSeq.nextval, '불친절한 PL/SQL 프로그래밍','정희락','디비안',386,'2021-04-10',38000);
INSERT INTO tblBook values (bookSeq.nextval, '스프링 부트 실전 활용 마스터','오명운','책만',402,'2021-01-11',25500);
INSERT INTO tblBook values (bookSeq.nextval, 'JDBC API를 이용한 데이터베이스 프로그래밍','김미희','한국학술정보',500,'2020-11-02',33200);
INSERT INTO tblBook values (bookSeq.nextval, 'Java의 정석','남궁성','도우출판',1022,'2016-02-01',27000);
INSERT INTO tblBook values (bookSeq.nextval, 'C언어의 정석','남궁성','도우출판',1012,'2016-08-24',22500);
INSERT INTO tblBook values (bookSeq.nextval, 'Do it! 오라클로 배우는 데이터베이스 입문','이지훈','이지스퍼블',424,'2018-10-30',22500);
INSERT INTO tblBook values (bookSeq.nextval, 'HTML5 웹 프로그래밍 입문','윤인성','한빛아카데미',398,'2019-07-20',24000);
INSERT INTO tblBook values (bookSeq.nextval, '쉽게 배우는 JSP 웹 프로그래밍','송미영','한빛아카데미',504,'2018-10-08',26460);
INSERT INTO tblBook values (bookSeq.nextval, '스프링 MVC 프로그래밍','김인희','에이콘',1001,'2013-09-13',36200);
INSERT INTO tblBook values (bookSeq.nextval, '오라클 SQL과 PL/SQL을 다루는 기술','홍형경','길벗',361,'2015-07-29',19600);
-----------------30개------------------------------------------
INSERT INTO tblBook values (bookSeq.nextval, '혼자 공부하는 자바스크립트','윤인성','한빛미디어',501,'2021-01-29',21600);
INSERT INTO tblBook values (bookSeq.nextval, '자바 프로젝트 필수 유틸리티','배효진','한빛미디어',412,'2018-05-21',31500);
INSERT INTO tblBook values (bookSeq.nextval, '팀 개발을 위한 Git, GitHub 시작하기','정호영','한빛미디어',512,'2020-01-29',16200);
INSERT INTO tblBook values (bookSeq.nextval, '처음 해보는 Servlet 과 JSP 웹 프로그래밍','오정임','루비페이퍼',719,'2017-03-12',25200);
INSERT INTO tblBook values (bookSeq.nextval, '백견불여일타 JSP과Servlet : Oracle과Eclipse','성윤정','로드북',980,'2014-07-02',24300);
INSERT INTO tblBook values (bookSeq.nextval, '실전 스프링 부트 REST API 개발 MyBatis + MySQL 개정판','향단코드','온노트',397,'2021-04-30',10000);
INSERT INTO tblBook values (bookSeq.nextval, '디자이너에 의한 디자이너를 위한 실무코딩(HTML+CSS)','엄태성','비제이퍼블릭',702,'2021-03-01',26550);
INSERT INTO tblBook values (bookSeq.nextval, 'HTML/CSS 입문 예제 중심','황재호','인포앤북',674,'2020-11-14',25300);
INSERT INTO tblBook values (bookSeq.nextval, '모던 웹을 위한 JavaScript + jQuery 입문','윤인성','한빛미디어',509,'2017-05-01',22400);
INSERT INTO tblBook values (bookSeq.nextval, '객체지향 프로그래밍','김동헌','e비지북스',511,'2019-02-08',17550);




--------------------- 빅데이터, 데이터, 인공지능, SQLD 관련 교재----------------------------------
-----------------40개------------------------------------------
INSERT INTO tblBook values (bookSeq.nextval, 'Do it! 쉽게 배우는 R 데이터 분석','김영우','이지스퍼블',676,'2017-07-06',18000);
INSERT INTO tblBook values (bookSeq.nextval, '데이터 분석가와 개발자를 위한MS SQL Server 기본에서 실무까지','김정현 외','위드클라우드',1006,'2020-09-01',23700);
INSERT INTO tblBook values (bookSeq.nextval, '데이터 기반 비즈니스 모델 개발 ','심재억','커뮤니케이션',556,'2017-07-10',9800);
INSERT INTO tblBook values (bookSeq.nextval, '보안 빅데이터 분석 플랫폼 구축과 활용','김대용','에이콘출판사',981,'2019-12-12',28000);
INSERT INTO tblBook values (bookSeq.nextval, '모두를 위한 PostgreSQL','정승호 외','BJ퍼블릭',676,'2021-02-27',25200);
INSERT INTO tblBook values (bookSeq.nextval, '국가공인 SQLD 자격검정 핵심노트','조시형 외','디비안',976,'2020-12-31',20900);
INSERT INTO tblBook values (bookSeq.nextval, ' SQLD,SQLP 연습문제 300','김민제','e퍼블',666,'2017-12-01',4800);
INSERT INTO tblBook values (bookSeq.nextval, '이기적 SQL 개발자 이론서+기출문제','임호진','영진닷컴',544,'2020-04-16',19800);
INSERT INTO tblBook values (bookSeq.nextval, '혼자 공부하는 머신러닝+딥러닝','박해선','한빛미디어',998,'2020-12-11',23400);
INSERT INTO tblBook values (bookSeq.nextval, 'Splunk를 활용한 시큐리티 모니터링','서진원','에이콘출판사',676,'2017-07-06',18000);

--------------------- 웹기반 디자인 교재----------------------------------
-----------------50개------------------------------------------
INSERT INTO tblBook values (bookSeq.nextval, '웹 퍼블리셔를 위한 워드프레스 입문과 완성','박승제 외','제이펍',862,'2013-03-01',33300);
INSERT INTO tblBook values (bookSeq.nextval, '맛있는 디자인 포토샵-일러스트레이터 CC','박정아 외','한빛미디어',398,'2021-01-11',19800);
INSERT INTO tblBook values (bookSeq.nextval, '2021 시나공 GTQ 포토샵 1급','길벗안앤디','길벗',765,'2021-01-11',17100);
INSERT INTO tblBook values (bookSeq.nextval, 'Hello Coding HTML5+CSS3','황재호','한빛미디어',887,'2018-03-01',17820);
INSERT INTO tblBook values (bookSeq.nextval, '편집디자인 프로젝트 ','이혜진','길벗',744,'2017-03-27',24800);
INSERT INTO tblBook values (bookSeq.nextval, '버려지는 디자인 통과되는 디자인 : 편집 디자인','이민기 외','길벗',502,'2017-10-10',15300);
INSERT INTO tblBook values (bookSeq.nextval, '된다! 일러스트레이터','모나미 외','이지스퍼블',399,'2020-11-11',16200);
INSERT INTO tblBook values (bookSeq.nextval, '어도비 포토샵 라이트룸 클래식 CC','스콧겔비','정보문화사',546,'2018-10-30',25200);
INSERT INTO tblBook values (bookSeq.nextval, '웹디자인기능사 실기 7일 완성','김승일','e퍼블',138,'2019-05-03',3000);
INSERT INTO tblBook values (bookSeq.nextval, '반응형 웹디자인','이단 마콧','웹액츄얼리',409,'2017-11-21',15300);

commit;
