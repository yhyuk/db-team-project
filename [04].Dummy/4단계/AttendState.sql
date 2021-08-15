/********************************
-- 출결 상태 데이터
**********************************/

create sequence stateSeq;
DROP SEQUENCE STATESEQ;
select * from tblAttendState;


/*********************************************************************
         실제 데이터
**********************************************************************/
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 10, '외출', '치과');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 23, '기타', '집안사정');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 29, '기타', '코로나 검진');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 65, '외출', '안과');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 79, '병가', '코로나 확진');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 85, '기타', '취업관련');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 89, '기타', '취업관련');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 102, '기타', '집안사정');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 123, '외출', '치과');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 128, '기타', '집안사정');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 345, '기타', '코로나 검진');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 76, '외출', '안과');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 27, '병가', '코로나 확진');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 75, '기타', '취업관련');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 234, '기타', '취업관련');
INSERT INTO tblAttendState VALUES (stateSeq.nextVal, 341, '기타', '집안사정');

COMMIT;