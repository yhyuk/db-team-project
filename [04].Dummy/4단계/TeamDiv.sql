/********************************

-- tblTeamDiv.sql
-- 팀원
-- 팀번호  교육생번호

**********************************/
create sequence teamdivSeq; 
--drop sequence teamdivSeq; 
select * from tblTeamDiv;
--delete from tblTeamDiv;
--select studentseq, count(*) from tblTeamDiv group by studentseq having  count(*) > 1;

--select * from tblStudent;

INSERT INTO tblTeamDiv VALUES(1,1001,'Y');
INSERT INTO tblTeamDiv VALUES(1,1002,'Y');
INSERT INTO tblTeamDiv VALUES(1,1003,'Y');
INSERT INTO tblTeamDiv VALUES(1,1004,'Y');
INSERT INTO tblTeamDiv VALUES(1,1005,'Y');


INSERT INTO tblTeamDiv VALUES(2,1006,'Y');
INSERT INTO tblTeamDiv VALUES(2,1007,'Y');
INSERT INTO tblTeamDiv VALUES(2,1008,'Y');
INSERT INTO tblTeamDiv VALUES(2,1009,'Y');
INSERT INTO tblTeamDiv VALUES(2,1010,'Y');


INSERT INTO tblTeamDiv VALUES(3,1011,'Y');
INSERT INTO tblTeamDiv VALUES(3,1012,'Y');
INSERT INTO tblTeamDiv VALUES(3,1013,'Y');
INSERT INTO tblTeamDiv VALUES(3,1014,'Y');
INSERT INTO tblTeamDiv VALUES(3,1015,'Y');


INSERT INTO tblTeamDiv VALUES(4,1016,'Y');
INSERT INTO tblTeamDiv VALUES(4,1017,'Y');
INSERT INTO tblTeamDiv VALUES(4,1018,'Y');
INSERT INTO tblTeamDiv VALUES(4,1019,'Y');
INSERT INTO tblTeamDiv VALUES(4,1020,'Y');


INSERT INTO tblTeamDiv VALUES(5,1021,'Y');
INSERT INTO tblTeamDiv VALUES(5,1022,'Y');
INSERT INTO tblTeamDiv VALUES(5,1023,'Y');
INSERT INTO tblTeamDiv VALUES(5,1024,'Y');
INSERT INTO tblTeamDiv VALUES(5,1025,'Y');


INSERT INTO tblTeamDiv VALUES(6,1026,'Y');
INSERT INTO tblTeamDiv VALUES(6,1027,'Y');
INSERT INTO tblTeamDiv VALUES(6,1028,'Y');
INSERT INTO tblTeamDiv VALUES(6,1029,'Y');
INSERT INTO tblTeamDiv VALUES(6,1030,'Y');


commit;