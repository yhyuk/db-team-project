/********************************
-- 과정정보 더미 데이터 12개
**********************************/
create sequence processSeq;
--drop sequence processSeq;
select * from tblProcess;
delete from tblProcess;

insert into tblProcess values (processSeq.nextVal,'(디지털컨버전스) Java 기반 임베디드 플랫폼 연동 융합 개발자 양성 과정',5.5,'강남캠퍼스','상',4394400,'A','정보기술개발','정보처리기사',94,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'(디지털컨버전스) 자바 기반 AWS 클라우드 활용 Full-Stack 개발자 양성 과정',6,'강남캠퍼스','중',5379600,'B','정보기술개발','정보처리기사',98,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'파이썬 프로그래밍 빅데이터 분석입문활용',7,'강남캠퍼스','상',539440,'B','정보기술개발','DAP',93,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'Java를 활용한 반응형 웹 개발자 양성과정',6,'강북캠퍼스','중',537960,'B','정보기술개발','정보처리기사',98,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'웹퍼블리셔(HTML5+CSS3)',7,'강북캠퍼스','중',537960,'B','디지털디자인','웹디자인기능사',98,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'(디지털컨버전스) UI/UX디자인 웹퍼블리셔,프론트엔드 개발자 양성과정',6,'강북캠퍼스','중',5929200,'C','정보기술개발','정보처리기사',94,'재직','Y');
insert into tblProcess values (processSeq.nextVal,'인공지능을 활용한 이미지 기반 자율주행 시스템 개발자 양성 과정',7,'강북캠퍼스','상',9746880,'A','정보기술개발','JDLA E',98,'재직','Y');
insert into tblProcess values (processSeq.nextVal,'SQLD 개발자 자격증 시험준비',5.5,'강남캠퍼스','중',395280,'B','DB엔지니어링','DAP',92,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'디자인 편집 일러스트레이터 기본과정',6,'강남캠퍼스','하',537960,'C','시각디자인','GTQ1급',98,'재직','Y');
insert into tblProcess values (processSeq.nextVal,'4차 산업혁명 경영학-인문학으로 보는 4차 산업혁명',6,'강북캠퍼스','하',5049800,'B','정보기술컨설팅','ERP정보관리사',92,'재직','Y');
insert into tblProcess values (processSeq.nextVal,'(2D그래픽)포토샵 (Photoshop) 응용과정',7,'강남캠퍼스','상',1685700,'A','시각디자인','GTQ1급',92,'취업','Y');
insert into tblProcess values (processSeq.nextVal,'Oracle로 배우는 실전 데이터관리',5.5,'강남캠퍼스','중',5049000,'B','정보기술개발','DAP',97,'취업','Y');

commit;
