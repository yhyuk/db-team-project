--과목 tblSubject
--과목번호, 과목명, 공통과목여부, 난이도, 분류, 선행학습필요여부, exist

CREATE sequence subjectSeq;
--DROP sequence subjectSeq;
--delete tblSubject;
--select * from tblSubject;

--=====================================================================
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '프로그래밍 기초', 'Yes', '중', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'Java 객체지향 프로그래밍', 'No', '중', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'C 프로그래밍', 'No', '중', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '데이터베이스 프로그래밍', 'No', '하', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'SQL 심화 및 PL/SQL', 'No', '하', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'Front-end 설계 및 구현', 'No', '상', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '클라이언트 화면 설계 및 인터랙티브 UI 구현', 'No', '중', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'Back-end 설계 및 구현', 'No', '하', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'Spring Framework 기반 백엔드 설계 및 구축', 'No', '중', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '멀티 플랫폼 기반 융합 실무 프로젝트', 'No', '하', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '임베디드 프로그래밍', 'No', '중', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '임베디드 융합 프로젝트', 'No', '중', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '클라우드 시스템 개요 및 AWS 서비스 요소', 'No', '중', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'AWS 클라우드 등록 설정 및 구축', 'No', '상', 'SW개발', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'AWS 프로젝트', 'No', '상', 'SW개발', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'Python 프로그래밍', 'No', '중', '인공지능', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '인공지능 기초', 'No', '중', '인공지능', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '텐서플로우 활용', 'No', '중', '인공지능', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '머신러닝', 'No', '상', '인공지능', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '딥러닝', 'No', '중', '인공지능', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '딥러닝을 통한 이미지처리', 'No', '중', '인공지능', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '딥러닝을 통한 추천알고리즘', 'No', '중', '인공지능', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '인공지능 프로젝트', 'No', '상', '인공지능', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '빅데이터 기초', 'No', '상', '빅데이터', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '빅데이터 플랫폼 구축', 'No', '중', '빅데이터', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'R을 활용한 통계 분석', 'No', '중', '빅데이터', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '데이터 가공 및 분석', 'No', '상', '빅데이터', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '데이터 시각화', 'No', '하', '빅데이터', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '데이터 분석기법 및 활용', 'No', '하', '빅데이터', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '빅데이터 분석 실무 프로젝트', 'No', '상', '빅데이터', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '공공데이터 분석기법을 활용한 데이터 융합 프로젝트', 'No', '중', '빅데이터', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '웹 프로그래밍', 'Yes', '상', '웹디자인', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '포토샵 활용', 'No', '하', '웹디자인', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'UI/UX 요구 분석', 'No', '중', '웹디자인', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'UI/UX 디자인 및 구현', 'No', '하', '웹디자인', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, 'UI/UX 분석 및 기획', 'No', '중', '웹디자인', 'No', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '애플리케이션 테스트 및 배포', 'No', '상', '웹디자인', 'Yes', default);
INSERT INTO tblSubject VALUES (subjectSeq.nextVal, '웹 서비스 구현 프로젝트', 'No', '하', '웹디자인', 'No', default);

commit;
