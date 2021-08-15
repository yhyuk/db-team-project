--시험 tblExam
--시험번호, 개설과목번호, 시험등록날짜, 필기시험날짜, 실기시험날짜, exist

CREATE sequence examSeq;
--DROP sequence examSeq;
--delete tblExam;
--select * from tblExam;

--=====================================================================
--개설과정1의 개설과목 7개
INSERT INTO tblExam VALUES (examSeq.nextval, 1, '2021-02-08', '2021-02-15', '2021-02-19', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 2, '2021-02-22', '2021-02-24', '2021-02-26', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 3, '2021-03-02', '2021-03-19', '2021-03-31', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 4, '2021-04-05', '2021-04-23', '2021-04-30', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 5, '2021-05-07', '2021-05-21', '2021-05-28', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 6, '2021-06-04', '2021-06-25', '2021-07-02', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 7, '2021-07-05', '2021-07-09', '2021-07-15', default);

--개설과정2의 개설과목 8개
INSERT INTO tblExam VALUES (examSeq.nextval, 8, '2021-03-05', '2021-03-11', '2021-03-18', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 9, '2021-03-20', '2021-03-27', '2021-04-01', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 10, '2021-04-07', '2021-04-21', '2021-05-01', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 11, '2021-05-09', '2021-05-17', '2021-05-31', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 12, '2021-06-04', '2021-07-19', '2021-08-02', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 13, '2021-08-12', '2021-08-15', '2021-08-20', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 14, '2021-08-24', '2021-09-16', '2021-09-23', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 15, '2021-10-01', '2021-10-15', '2021-10-20', default);

--개설과정3의 개설과목 8개
INSERT INTO tblExam VALUES (examSeq.nextval, 16, '2021-04-30', '2021-05-11', '2021-05-17', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 17, '2021-05-21', '2021-05-27', '2021-06-01', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 18, '2021-06-08', '2021-06-21', '2021-06-28', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 19, '2021-07-14', '2021-07-21', '2021-07-28', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 20, '2021-08-01', '2021-08-12', '2021-08-19', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 21, '2021-08-24', '2021-09-07', '2021-09-12', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 22, '2021-09-15', '2021-09-22', '2021-09-30', default);
INSERT INTO tblExam VALUES (examSeq.nextval, 23, '2021-10-10', '2021-10-18', '2021-10-25', default);

commit;
