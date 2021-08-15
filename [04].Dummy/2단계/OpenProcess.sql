-- 개설과정
-- 개설과정번호   과정번호   강의실번호   시작날짜   종료날짜  

create sequence openProcessSeq;
select * from tblOpenProcess;

--==========테스트용 데이터==============================================

--개설과정1 -> 30명 
-- 1번 과정 5.5개월, 1번강의실(30명)
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 1, 1, '2021-02-01', '2021-07-15', default , default);

--개설과정2 -> 30명 
-- 7번 과정 7개월, 2번강의실(30명)
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 7, 2, '2021-03-01', '2021-10-20', default , default);


--개설과정3 -> 30명 
-- 6번 과정 6개월, 3번강의실(30명)
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 6, 3, '2021-04-26', '2021-10-26', default , default);


--=================무작위 dummy====================================
-- 개설과정4 -> 26명/ 4번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 5, 4, '2021-05-01', '2021-10-20', default , default);

-- 개설과정5 -> 26명/ 5번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 8, 5, '2021-09-01', '2022-03-01', default , default);

-- 개설과정6 -> 26명/ 6번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 4, 6, '2021-06-20', '2021-12-29', default , default);

-- 개설과정7 -> 30명/ 1번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 1, 1, '2021-09-01', '2022-03-01', default , default);

-- 개설과정8 -> 30명/ 2번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 2, 2, '2021-10-25', '2022-05-01', default , default);

-- 개설과정9 -> 30명/ 3번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 9, 3, '2021-11-01', '2022-05-01', default , default);

-- 개설과정10 -> 26명/ 4번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 3, 4, '2021-11-01', '2022-05-01', default , default);

-- 개설과정11 -> 26명/ 5번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 12, 5, '2021-01-04', '2021-08-04', default , default);

-- 개설과정12 -> 26명/ 6번 강의실
INSERT INTO tblOpenProcess values(OPENPROCESSSEQ.nextval, 11, 6, '2021-01-04', '2021-06-04', default , default);

commit;




