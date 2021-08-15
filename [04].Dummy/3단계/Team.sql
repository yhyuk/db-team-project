/********************************

-- tblTeam .sql
-- 팀번호  개설과목번호  팀장번호

**********************************/

create sequence teamSeq; 
--drop sequence teamSeq; 
select * from tblTeam;
delete from tblTeam;

--delete from tblTeam;
--select leaderseq, count(*) from tblTeam group by leaderseq having  count(*) > 1;



--개설과목 1번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1016,'Y');  
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,1,1026,'Y');

--개설과목 2번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,2,1026,'Y');

--개설과목 3번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,3,1026,'Y');

--개설과목 4번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,4,1026,'Y');

--개설과목 5번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,5,1026,'Y');

--개설과목 6번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,6,1026,'Y');

--개설과목 7번
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1001,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1006,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1011,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1016,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1021,'Y');
INSERT INTO tblTeam VALUES(teamSeq.nextVal,7,1026,'Y');

COMMIT;