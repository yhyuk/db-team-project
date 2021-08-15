/********************************

-- tblProject.sql
-- 프로젝트 데이터
-- 프로젝트번호   개설과목번호  프로젝트주제  프로젝트설명  난이도     제출방법    시작날짜    종료날짜

**********************************/

create sequence projectSeq; 
--drop sequence projectSeq; 
select * from tblProject;
--delete from tblProject;

--------------
--과정1 (7과목)
--------------

INSERT INTO tblProject VALUES(projectSeq.nextval, 1,'Java 콘솔 프로젝트',
'지금까지 수업한 내용을 바탕으로 Java콘솔로 각 팀마다 주제를 정하여 시스템프로그램을 만들어 보기 바랍니다.',
'하','업로드','2021-02-12','2021-02-19','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 2,'Spring 프로젝트',
'스프링 프레임워크(Spring Framework)는 자바 플랫폼을 위한 오픈소스 애플리케이션 프레임워크를 이용하여 만들어 보기 바랍니다.',
'중','업로드','2021-02-22','2021-03-01','Y');

------여기까지 공통과목 2개



INSERT INTO tblProject VALUES(projectSeq.nextval, 3,'java와 javaFX 활용하여 POS 시스템 구현 ',
'Java언어와 JavaFX를 활용하여 매장POS시스템(주제:자유)을 만들어 보시기 바랍니다.',
'중','발표','2021-03-27','2021-04-01','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 4,'C프로젝트 회사 프로그램 만들기(1)',
'첨부한 요구사항 파일을 분석하여 C언어를 이용한 회사프로그램을 작성해 봅시다 요구조건
(DB, Server 사용 X 프로젝트 생성 가능, 삭제 가능, 완료 기능)',
'중','발표','2021-04-24','2021-05-03','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 5,'스마트 펙토리 시스템 개발프로젝트',
'HW 간의 통신을 위한 Driver, 모듈들을 구체화합니다. 호환성이나 유지보수의 기능성을 판별하여 작업을 진행합니다.',
'상','메일','2021-05-12','2021-05-31','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 6,'아두이노 로봇 프로젝트',
'아두이노를 이용하여 조별로 로봇을 만들어 경주를 하는 프로젝트를 만들어주세요. ',
'상','발표','2021-06-20','2021-07-02','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 7,'express로 frontend, backend 연동하기',
'영화예매순위 사이트를 만들어 봅시다 제출은 구글 드라이브에 올려주시기 바랍니다.',
'중','업로드','2021-08-01','2021-08-20','Y');


--------------
--과정2 (8과목)
--------------

INSERT INTO tblProject VALUES(projectSeq.nextval, 8,'Java 콘솔 프로젝트',
'지금까지 수업한 내용을 바탕으로 Java콘솔로 각 팀마다 주제를 정하여 시스템프로그램을 만들어 보기 바랍니다.',
'하','업로드','2021-02-12','2021-02-19','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 9,'Spring 프로젝트',
'스프링 프레임워크(Spring Framework)는 자바 플랫폼을 위한 오픈소스 애플리케이션 프레임워크를 이용하여 만들어 보기 바랍니다.',
'중','업로드','2021-02-22','2021-03-01','Y');

------여기까지 공통과목 2개


INSERT INTO tblProject VALUES(projectSeq.nextval, 10,'물체인식하는 프로젝트 만들기',
'구글API연동해서 사물을 카메라로 비추면 무슨 사물인지 맞추는 머신러닝 프로젝트를 만들어 보세요.',
'하','업로드','2021-04-30','2021-05-03','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 11,'소셜 미디어 게시물을 기반으로 한 우울증 감정 분석서비스',
'첨부한 파일을 바탕으로 소셜미디어 계정 게시물을 분석하여 우을증을 분석하는 우울증 중재 서비스를 만드세요.',
'중','업로드','2021-05-20','2021-05-31','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 12,'CNN을 이용한 수기 방정식 풀이',
'데이터를 바탕으로 기계를 훈련하여 손으로 쓴 숫자와 수학 기호로 손으로 쓴 방정식을 풀이하는 서비스를 만드세요.',
'상','발표','2021-07-30','2021-08-05','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 13,'기분을 감지하고 그에 따라 노래를 제안하는 얼굴 인식',
'첨부한 API를 활용하여 사람의 얼굴을 인식하여 기분을 감지해내고 노래를 제 안하는 서비스를 만드세요.',
'상','메일','2021-07-30','2021-08-20','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 14,'딥 러닝을 이용한 음악 생성',
'딥러닝을 이용하여 컴퓨터작곡가를 만들어보세요.',
'상','발표','2021-08-01','2021-09-25','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 15,'오래된 손상된 릴 그림에 대한 이미지 재생',
'딥 러닝으로 흑백 이미지에 색을 입히는 프로젝트를 완성하세요.',
'상','발표','2021-09-30','2021-10-20','Y');




--------------
--과정3 (8과목)
--------------

INSERT INTO tblProject VALUES(projectSeq.nextval, 16,'Java 콘솔 프로젝트',
'지금까지 수업한 내용을 바탕으로 Java콘솔로 각 팀마다 주제를 정하여 시스템프로그램을 만들어 보기 바랍니다.',
'하','업로드','2021-02-12','2021-02-19','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 17,'Spring 프로젝트',
'스프링 프레임워크(Spring Framework)는 자바 플랫폼을 위한 오픈소스 애플리케이션 프레임워크를 이용하여 만들어 보기 바랍니다.',
'중','업로드','2021-02-22','2021-03-01','Y');

------여기까지 공통과목 2개

INSERT INTO tblProject VALUES(projectSeq.nextval, 18,'포토샵활용 포스터 만들기(1)',
'팀원들과 상의하에 공익광고 포스터를 만들어 보세요.',
'하','업로드','2021-06-10','2021-06-30','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 19,'UI/UX 프로젝트 요구분석 프로젝트',
'주제를 선정하여 UI/UX요구분석을 도출 합니다. 사용자 조사를 통해 고객 페르소나를 분석합니다.',
'중','메일','2021-07-01','2021-07-28','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 20,'UI/UX 프로젝트 디자인 및 구현 프로젝트',
'시중 어플리케이션을 참고하여 각 팀의 서비스를 최대한으로 발휘할 수 있도록 디자인 심미성을 올려주세요. ',
'중','업로드','2021-08-01','2021-08-19','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 21,'UI/UX 조별 피드백',
'다른 조의 프로젝트에대해 평가를 해주세요. (장점, 단점을 최대한 자세하게 분석해주시기 바랍니다) ',
'하','발표','2021-08-30','2021-09-12','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval, 22,'애플리케이션 프로젝트 최종 발표',
'팀별 피드백을 수용하여 최종 결과물을 산출하세요',
'중','발표','2021-09-12','2021-09-30','Y');

INSERT INTO tblProject VALUES(projectSeq.nextval,23,'웹 프로젝트 최종 발표',
'최종 프로젝트를 완성하여 발표하세요.',
'중','발표','2021-10-01','2021-10-26','Y');


commit;