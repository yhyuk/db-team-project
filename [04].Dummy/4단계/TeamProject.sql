/********************************
-- 팀별 프로젝트 데이터
**********************************/
-- 총 개설된 실제 데이터(과정) 3개 
-- -> 7개 8개 8개 과목 
-- -> 총 23개 프로젝트 
-- -> 6개조 
-- -> 138개

CREATE SEQUENCE tpSeq;
DROP SEQUENCE tpSeq;
SELECT * FROM tblTeamProject;
delete  from tblTeamProject;
/****************************************************************************************************************
         실제 데이터
****************************************************************************************************************/
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 1, '우리는 1조', '처음 시작하는 1조프로젝트입니다');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 2, '2조 짱', 'java를 활용한 콘솔 프로젝트');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 3, '3group project', '회사 사원 관리를 위한 프로젝트');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 4, '4조는 최고다!!', '우리가 java로 만든 프로젝트');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 5, 'java 5조', '키오스크를 모방한 java 프로젝트');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 1, 6, '6조 프로젝트', '오아시스에 한개의 자판기 프로젝트');

/****************************************************************************************************************
         더미 데이터
****************************************************************************************************************/
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 7, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 8, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 9, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 10, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 11, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 2, 12, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 13, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 14, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 15, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 16, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 17, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 3, 18, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 19, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 20, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 21, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 22, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 23, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 4, 24, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 25, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 26, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 27, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 28, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 29, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 5, 30, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 31, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 32, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 33, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 34, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 35, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 6, 36, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 37, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 38, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 39, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 40, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 41, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 7, 42, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 43, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 44, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 45, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 46, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 47, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 8, 48, '6조 PROJECT', '내용');


INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 49, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 50, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 51, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 52, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 53, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 9, 54, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 55, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 56, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 57, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 58, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 59, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 10, 60, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 61, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 62, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 63, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 64, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 65, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 11, 66, '6조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 67, '1조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 68, '2조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 69, '3조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 70, '4조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 71, '5조 PROJECT', '내용');
INSERT INTO tblTeamProject (seq, projectSeq, teamSeq, name, content) VALUES (tpSeq.nextVal, 12, 72, '6조 PROJECT', '내용');
COMMIT;
