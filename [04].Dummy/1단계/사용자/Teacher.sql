/********************************
-- 교사 정보 더미 데이터 10개
**********************************/
create sequence teacherSeq;
--drop sequence teacherSeq;
select * from tblTeacher;
--delete from tblTeacher;

insert into tblTeacher values (teacherSeq.nextVal,'윤준현','750311-1934502','bopemet481@naver.com','010-2233-1223','서울특별시 강동구 상암로 6(암사동)',5,'서경대학교','컴퓨터공학과','2021-01-04','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'서란','800210-2930011','diek193@naver.com','010-3345-1534','세종특별자치시 한누리대로 169(나성동)',10,'국민대학교','IT비즈니스과','2020-02-11','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'손혜린','721211-2190228','keidn12@gmail.com','010-3884-3975','경기도 파주시 한빛로 9(야당동)',8,'중앙대학교','전산학과','2009-07-09','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'장새론','760919-2903001','ikdjj99@gmail.com','010-8378-1934','서울특별시 동대문구 한빛로 50-4(용두동)',2,'이화여자대학교','전산학과','2011-12-30','전임강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'남궁용자','810529-1091812','ieikn87@daum.net','010-9874-5984','인천광역시 중구 제2터미널대로 332(운서동)',3,'홍익대학교','디자인학과','2010-10-19','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'복형원','680305-1129344','qert978@danm.net','010-9373-5967','경기도 과천시 경마공원대로 19(과천동)',7,'동국대학교','정보보호학과','2019-11-28','전임강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'이지훈','740910-1492098','jdoifn11@outlook.com','010-4951-6596','서울특별시 종로구 자하문로33나길 9(청운동, 에이스빌라)',6,'건국대학교','전산학과','2018-04-21','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'천민수','690508-1039487','ikdji88@outlook.com','010-9586-5866','서울특별시 종로구 자하문로33나길 35(청운동, 그린카운티빌)',2,'연세대학교','로봇공학과','2017-11-15','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'배호진','660944-1902094','oiej11@outlook.com','010-9477-9787','서울특별시 강남구 강남대로132길 25(논현동)',11,'명지대학교','전산학과','2020-11-28','강사','Y');
insert into tblTeacher values (teacherSeq.nextVal,'남궁성','690101-0398884','dgfhj99@naver.com','010-3947-5956','서울특별시 강남구 가로수길 5(신사동)',15,'고려대학교','컴퓨터공학과','2016-02-26','전임강사','Y');

commit;