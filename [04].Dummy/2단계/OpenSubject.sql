--개설과목
-- 개설과목번호   과목번호  개설과정번호  교사번호  교재번호   시작날짜  종료날짜 
--delete tblOpenSubject;
--drop sequence openSubjectSeq;

create sequence openSubjectSeq;
select * from tblOpenSubject;

--============테스트용 데이터===========================================
-- 과정1 과목개설 : 7개
--'2021-02-01' ~ '2021-08-20'
-- 개설과목번호   과목번호  개설과정번호  교사번호  교재번호   시작날짜  종료날짜 
--**********공통과목**********
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 1, 2, 5, '2021-02-01','2021-02-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 1, 5, 8, '2021-02-19','2021-03-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 2, 1, 4, 14, '2021-03-02','2021-04-01', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 3, 1, 4, 9, '2021-04-02','2021-05-03', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 10, 1, 3, 22, '2021-05-04','2021-05-31', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 11, 1, 6, 16, '2021-06-01','2021-07-02', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 8, 1, 1, 11, '2021-07-03','2021-07-15', default);

-- 과정2 과목개설 : 8개
--'2021-03-01'~'2021-10-20'
-- 개설과목번호   과목번호  개설과정번호  교사번호  교재번호   시작날짜  종료날짜 
--**********공통과목**********
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 2, 2, 5, '2021-03-01','2021-03-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 2, 5, 8, '2021-03-19','2021-04-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 17, 2, 1, 34, '2021-04-02','2021-05-03', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 19, 2, 1, 39, '2021-05-04','2021-05-31', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 20, 2, 4, 40, '2021-06-01','2021-08-05', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 21, 2, 3, 31, '2021-08-06','2021-08-20', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 22, 2, 4, 32, '2021-08-21','2021-09-25', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 23, 2, 6, 33, '2021-09-26','2021-10-20', default);


-- 과정3 과목개설 : 8개
--'2021-04-26' ~ '2021-10-26'
-- 개설과목번호   과목번호  개설과정번호  교사번호  교재번호   시작날짜  종료날짜 
--**********공통과목**********
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 3, 2, 5, '2021-04-26','2021-05-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 3, 5, 8, '2021-05-19','2021-06-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 33, 3, 1, 42, '2021-06-02','2021-06-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 34, 3, 3, 44, '2021-07-01','2021-07-28', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 35, 3, 4, 45, '2021-07-29','2021-08-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 36, 3, 3, 33, '2021-08-20','2021-09-12', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 37, 3, 5, 50, '2021-09-13','2021-09-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 38, 3, 5, 48, '2021-10-01','2021-10-26', default);


--============더미 데이터===========================================
--과정4
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 4, 2, 5, '2021-05-01','2021-05-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 4, 5, 8, '2021-05-19','2021-06-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 12, 4, 1, 6, '2021-06-02','2021-06-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 19, 4, 1, 9, '2021-07-01','2021-07-28', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 20, 4, 2, 7, '2021-07-29','2021-08-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 22, 4, 3, 20, '2021-08-20','2021-09-12', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 23, 4, 4, 21, '2021-09-13','2021-09-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 24, 4, 4, 22, '2021-10-01','2021-10-20', default);


--과정5
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 5, 2, 5, '2021-09-01','2021-10-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 5, 5, 8, '2021-10-19','2021-11-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 2, 5, 1, 6, '2021-11-02','2021-12-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 3, 5, 1, 9, '2021-12-01','2022-01-28', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 4, 5, 2, 7, '2022-01-29','2022-02-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 7, 5, 4, 22, '2021-02-19','2022-03-01', default);


--과정6
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 1, 6, 2, 5, '2021-06-20','2021-07-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 32, 6, 5, 8, '2021-07-19','2021-08-01', default);
--******************************
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 24, 6, 1, 29, '2021-08-02','2021-08-30', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 25, 6, 1, 30, '2021-09-01','2021-09-28', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 27, 6, 2, 31, '2021-09-29','2021-11-19', default);
INSERT INTO tblopensubject values (OPENSUBJECTSEQ.nextval, 30, 6, 4, 32, '2021-11-19','2021-12-29', default);

commit;



