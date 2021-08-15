-- 관리자DML
set serveroutput on;


/*===================================================================
                            인덱스
===================================================================*/
create index idx_student on tblStudent(exist);
create index idx_attend on tblAttend(studentSeq, exist);


/*===================================================================
                            함수
===================================================================*/
-- 주민번호 뒷자리 제거 함수
create or replace function func_ssn (
    fssn varchar2
) return number
is
begin
    return substr(fssn, 1, 6);
end;

-- 두 날짜의 일 수 구하기 함수
create or replace function func_date (
    fstartDate date,
    fendDate date
) return number
is
begin
    return to_date(fendDate, 'yyyy-mm-dd') - to_date(fstartDate, 'yyyy-mm-dd');
end;

-- 전공자 / 비전공자 구분 함수
create or replace function func_B_003_2 (
    fcnt VARCHAR2
) return VARCHAR2
is
begin
    return  case
                when fcnt = 'Yes' then '전공자'
                when fcnt = 'No' then '비전공자'
            end;
end func_B_003_2;

-- 두 기간이 겹치는지 확인 (겹치는 경우 1, 아닌경우 0) 함수
create or replace function fn_check_termIsDup (
    pnewStartDate date,
    pnewEndDate date,
    poldStartDate date,
    poldEndDate date
) return number
is
begin
    if poldStartDate between pnewStartDate and pnewEndDate
        or poldEndDate between pnewStartDate and pnewEndDate
        or ((pnewStartDate between poldStartDate and poldEndDate) and (pnewEndDate between poldStartDate and poldEndDate)) then
        return 1;
    else
        return 0;
    end if;
end fn_check_termIsDup;

-- 시작날짜, 종료날짜 -> 기간(시작날짜 ~ 종료날짜) 함수
create or replace function fn_toTerm (
    pstartDate date,    -- 시작날짜
    pendDate date       -- 종료날짜
) return varchar2
is
begin
    return to_char(pstartDate, 'yyyy-mm-dd') || ' ~ ' || to_char(pendDate, 'yyyy-mm-dd');
end fn_toTerm;

-- 수강상태 계산 함수
create or replace function fn_toRegState (
    pcurrDate date,     -- 현재날짜
    pfinishDate date,   -- 수료날짜
    pdropDate date,     -- 중도탈락날짜
    pstartDate date,    -- 과정 시작날짜
    pendDate date       -- 과정 종료날짜
) return varchar2
is
    vresult varchar2(30);
begin
    if pfinishDate is not null then
        vresult := '수료';
    elsif pdropDate is not null then
        vresult := '중도탈락';
    elsif (pdropDate is null) and (pstartDate > pcurrDate) then
        vresult := '과정 시작전';
    elsif (pdropDate is null) and (pcurrDate between pstartDate and pendDate) then
        vresult := '수료예정';
    end if;
    return vresult;
end fn_toRegState;

-- 강의진행여부 함수
create or replace function fnteachering(
    fstartDate date,
    fendDate date
) return varchar2
is
begin
    return  
    case 
        when sysDate between fstartDate and fendDate then '강의중'
        when sysDate < fstartDate then '강의예정'
        when sysdate > fendDate then '강의종료'
    end ;
end fnteachering;

-- 평균 구하는 함수
create or replace function fnAvgScore(
    fattend varchar2,
    pattend varchar2,
    fwrite varchar2,
    pwrite varchar2,
    fperform varchar2,
    pperform varchar2,
    ftask varchar2,
    ptask varchar2
) return number
is
begin
    return  
    ((fattend * pattend) + (fwrite*pwrite) + (fperform*pperform) + (ftask*ptask))/100;
end fnAvgScore;


/*===================================================================
                            트리거
===================================================================*/
-- 개설 과정 수정 트리거 생성
create or replace trigger trg_openProcess
    after
    update on tblOpenProcess
    for each row
begin

    DBMS_OUTPUT.PUT_LINE('개설과정 수정 완료 시간: '  || TO_CHAR(SYSDATE, 'HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('수정되기 전 개설과정번호: '|| :old.seq             || ', 수정된 후 개설과정번호: '  || :new.seq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 과정번호: '    || :old.processSeq      || ', 수정된 후 과정번호: '      || :new.processseq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 강의실번호: '  || :old.classroomSeq    || ', 수정된 후 강의실번호: '    || :new.classRoomseq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 시작날짜: '    || :old.startDate       || ', 수정된 후 시작날짜: '      || :new.startDate);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 종료날짜: '    || :old.endDate         || ', 수정된 후 종료날짜: '      || :new.endDate);
    
end trg_openProcess;


 -- 개설 과목 수정 트리거 생성
 create or replace trigger trg_openSubject
    after
    update on tblOpenSubject
    for each row
begin

    DBMS_OUTPUT.PUT_LINE('개설과목 수정 완료 시간: '  || TO_CHAR(SYSDATE, 'HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('수정되기 전 개설과목번호: '|| :old.seq                 || ', 수정된 후 개설과목번호: ' || :new.seq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 과목번호: '    || :old.subjectSeq          || ', 수정된 후 과목번호: '     || :new.subjectSeq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 개설과정번호: '|| :old.openProcessSeq      || ', 수정된 후 개설과정번호: ' || :new.openProcessSeq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 교사번호: '    || :old.teacherSeq          || ', 수정된 후 교사번호: '     || :new.teacherSeq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 교재번호: '    || :old.bookSeq             || ', 수정된 후 교재번호: '     || :new.bookSeq);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 시작날짜: '    || :old.startDate           || ', 수정된 후 시작날짜: '     || :new.startDate);
    DBMS_OUTPUT.PUT_LINE('수정되기 전 종료날짜: '    || :old.endDate             || ', 수정된 후 종료날짜: '     || :new.endDate);
    
end trg_openSubject;

/*======================================================================================

        [A-001] 기초 정보 과정 입력

========================================================================================*/

--프로시저
create or replace procedure proc_process_insert (
    pname in tblprocess.name%type,
    pmonth in tblprocess.month%type,
    pcampus in tblprocess.campus%type,
    pdifficulty in tblprocess.difficulty%type,
    pprice in tblprocess.price%type,
    pgrade in tblprocess.grade%type,
    pjob in tblprocess.job%type,
    pcapacity in tblprocess.capacity%type,
    pemploymentrate in tblprocess.employmentrate%type,
    pdiv in tblprocess.div%type
)
is
    
begin

    insert into tblProcess values 
        (PROCESSSEQ.nextval, pname, pmonth, pcampus,pdifficulty,pprice, pgrade, pjob,pcapacity, pemploymentrate ,pdiv, default);
    exception
        when others then
        rollback;
        dbms_output.put_line('과정 정보 추가 실패');            
end proc_process_insert;

--호출
call proc_process_insert
    ('과목명', 5.5, '캠퍼스', null, 12000, null, '관련 직업', '관련자격증', null , '취업');
    
select * from tblProcess;


/*======================================================================================

        [A-002] 기초 정보 과정 입력

========================================================================================*/

--프로시저
create or replace procedure proc_subject_insert (
    pname in tblsubject.name%type,
    pcommon in tblsubject.common%type,
    pdifficulty in tblsubject.difficulty%type,
    pdiv in tblsubject.div%type,
    ppriorLearn in tblsubject.priorLearn%type,
    
    presult out number  --50 이상이다 아니다 
)
is
    vsubjectNum number := 0;         --과목의 갯수를 담을 변수
    vresult number := 0;
  
    cursor vcursor is select * from tblSubject;
    vrow vcursor%rowtype;
begin
    
    for vrow in vcursor loop
        vsubjectNum := vsubjectNum + 1;     --루프 돌면서 row의 갯수 더하기 
    end loop;
    
        if vsubjectNum < 50 then -- 과목 개수가 50개 이하일때만 추가 
            insert into tblSubject(seq, name, common, difficulty, div, priorLearn)
                values(SUBJECTSEQ.nextval, '과목명', 'No', '중', '과목분류', 'No');
            presult := 1;
        else 
            presult := 0;
            null;
        end if; 
end proc_subject_insert;               

--호출
declare
    presult number;
begin
    proc_subject_insert('과목명', 'No', '중', '과목분류', 'No',presult);
    if presult = 1 then
        dbms_output.put_line('과목 추가가 완료되었습니다.');
    else
        dbms_output.put_line('과목은 최대 50개까지만 추가 가능합니다.');
    end if;
end;

--확인
select * from tblSubject;


/*======================================================================================

        [A-003] 기초 정보 과정별 과목 입력(ProcessSub)

========================================================================================*/

--프로시저                
create or replace procedure proc_processSub_insert (
    pprocessSeq in tblprocessSub.processSeq%type,
    psubjectSeq in tblprocessSub.subjectSeq%type
)
is
begin
    insert into tblsubject values 
        (pprocessSeq, psubjectSeq,default); 
    exception
        when others then
        rollback;
        dbms_output.put_line('과정별 과목 정보 추가 실패');  
end proc_processSub_insert;     

--호출
call proc_processSub_insert(1,24);

        

/*======================================================================================

        [A-004] 기초 정보 강의실명 입력

========================================================================================*/

-- 프로시저              
create or replace procedure proc_classRoom_insert (
    pseq in tblclassRoom.seq%type,
    pname in tblclassRoom.name%type,
    pmax in tblclassRoom.max%type,
    pwifiName in tblclassRoom.wifiName%type,
    pwifiPw in tblclassRoom.wifiPw%type,
    pos in tblclassRoom.os%type
)
is
begin
    insert into tblClassRoom values(pseq, pname, pmax, pwifiName, pwifiPw, pos, default);
    commit;
    exception
        when others then
        rollback;
        dbms_output.put_line('강의실 정보 추가 실패');       
end proc_classRoom_insert;  

--호출
call proc_classRoom_insert(CLASSROOMSEQ.nextval, '강의실명', 30, '와이파이이름', '와이파이비번', 'Windows');

  
/*======================================================================================

        [A-005] 기초 정보 교재 입력

========================================================================================*/
 

insert into tblBook values (BOOKSEQ.nextval, '책이름', '저자', '출판사', 123, sysdate, 10000,default);

-- 프로시저 
create or replace procedure proc_book_insert (
    pseq in tblBook.seq%type,
    pname in tblBook.name%type,
    pauthor in tblBook.author%type,
    ppublisher in tblBook.publisher%type,
    ppage in tblBook.page%type,
    ppublishDate in tblBook.publishDate%type,
    pprice in tblBook.price%type
)
is
begin
    insert into tblBook values(pseq, pname, pauthor, ppublisher, ppage, ppublishDate, pprice);
    commit;
    exception
        when others then
        rollback;
        dbms_output.put_line('교재 정보 추가 실패');       
end proc_book_insert;  

--호출
call proc_book_insert(BOOKSEQ.nextval, '책이름', '저자', '출판사', 123, sysdate, 10000,default);





/*======================================================================================

        [A-006-1] 기초 정보 과정 수정

========================================================================================*/


--프로시저 
create or replace procedure proc_process_update (
  pnum in tblprocess.seq%type, --지정하는 과정 번호
  psel in varchar2, --수정할 번호
  pinput in varchar2 --수정 내용
)
is
begin
    if psel = 'name' then update tblprocess set name = pinput where seq = pnum;
    elsif psel = 'month' then update tblprocess set month = pinput where seq = pnum;
    elsif psel = 'campus' then update tblprocess set campus = pinput where seq = pnum;
    elsif psel = 'difficulty' then update tblprocess set difficulty = pinput where seq = pnum;
    elsif psel = 'price' then update tblprocess set price = pinput where seq = pnum;
    elsif psel = 'grade' then update tblprocess set grade = pinput where seq = pnum;
    elsif psel = 'job' then update tblprocess set job = pinput where seq = pnum;
    elsif psel = 'capacity' then update tblprocess set capacity = pinput where seq = pnum;
    elsif psel = 'employmentrate' then update tblprocess set employmentrate = pinput where seq = pnum;
    elsif psel = 'div' then update tblprocess set div = pinput where seq = pnum;
    commit;
    end if;
    
    exception
    when others then
    rollback;
    dbms_output.put_line('과정 정보 수정 실패');
end proc_process_update;

--호출
call proc_process_update(1, 'name', '이름~');

/*======================================================================================

        [A-006-2] 기초 정보 과목 수정

========================================================================================*/
                
-- 프로시저 
create or replace procedure proc_subject_update (
    pnum in tblsubject.seq%type, --지정하는 과목 번호
    psel in varchar2, --수정할 번호
    pinput in varchar2 --수정 내용
)
is
begin
    if psel = 'name' then update tblsubject set name = pinput where seq = pnum;
    elsif psel = 'common' then update tblsubject set common = pinput where seq = pnum;
    elsif psel = 'difficulty' then update tblsubject set difficulty = pinput where seq = pnum;
    elsif psel = 'div' then update tblsubject set div = pinput where seq = pnum;
    elsif psel = 'priorlearn' then update tblsubject set priorlearn = pinput where seq = pnum;
    commit;
    end if;
    exception
      when others then
      rollback;
      dbms_output.put_line('과목 정보 수정실패');
end proc_subject_update;   

--호출
call proc_subject_update(1,'name','바꿀이름');



/*======================================================================================

        [A-006-3] 기초 정보 강의실 수정

========================================================================================*/

-- 프로시저
create or replace procedure proc_classRoom_update (
    pnum in tblclassRoom.seq%type, --지정할 강의실 번호
    psel in varchar2, --수정할 컬럼번호
    pinput in varchar2 --수정 내용
)
is
begin
    if psel = 'name' then update tblClassRoom set name = pinput where seq = pnum;
    elsif psel = 'wifiName' then update tblClassRoom set wifiName = pinput where seq = pnum;
    elsif psel = 'wifiPw' then update tblClassRoom set wifiPw = pinput where seq = pnum;
    elsif psel = 'os' then update tblClassRoom set os = pinput where seq = pnum;
    commit;
    end if;
    
    
    exception
      when others then
      rollback;
      dbms_output.put_line('강의실 정보 수정실패');
end proc_classRoom_update;   

-- 호출
call proc_classRoom_update(1, 'os', 'Windows');

select * from tblClassRoom;


/*======================================================================================

        [A-006-4] 기초 정보 교재 수정 

========================================================================================*/



create or replace procedure proc_book_update (
    pnum in tblsubject.seq%type, --지정하는 과목 번호
    psel in varchar2, --수정할 번호
    pinput in varchar2 --수정 내용
)
is
begin
    if psel = 'name' then update tblBook set name = pinput where seq = pnum;
    elsif psel = 'author' then update tblBook set author = pinput where seq = pnum;
    elsif psel = 'publisher' then update tblBook set publisher = pinput where seq = pnum;
    elsif psel = 'page' then update tblBook set page = pinput where seq = pnum;
    elsif psel = 'publishDate' then update tblBook set publishDate = pinput where seq = pnum;
    elsif psel = 'price' then update tblBook set price = pinput where seq = pnum;
    commit;
    end if;
    exception
      when others then
      rollback;
      dbms_output.put_line('교재 정보 수정실패');
end proc_book_update;   

-- 호출 
call proc_book_update(3, name, '교재명');


/*======================================================================================

        [A-007-1] 기초 정보 과정 삭제

========================================================================================*/

-- 제약사항 *** 개설과정에 포함된 과정은 삭제가 불가능하다.
-- 제약사항 *** 과정별 과목에 포함된 과정은 삭제가 불가능하다. 
-- 삭제 프로시저 생성
create or replace procedure proc_process_delete (
    pseq in tblprocess.seq%type --지정할 과정 번호
)
is
    vcount1 number;         -- 개설과정에 속한 과정 개수
    vcount2 number;         -- 과정별과목에 속한 과정 개수
    
begin

    --개설과정에 속한 과정의 개수 알아내기
    select count(*) into vcount1 from tblOpenprocess where processseq = pseq;
    
    --과정별과목에 속한 과정의 개수 알아내기
    select count(*) into vcount2 from tblprocessSub where processseq = pseq;
    
    
    if vcount1 > 0 then
        dbms_output.put_line('이미 개설된 과정입니다. 삭제할 수 없습니다.');
        
    elsif vcount2 > 0 then
        dbms_output.put_line('과정별과목에 구성된 과정입니다. 삭제할 수 없습니다.');
    
    else 
        update tblProcess set exist = 'N' where seq = pseq;
        dbms_output.put_line('과정 정보 삭제 완료');
    end if;
  
    exception
    when others then
    rollback;
    dbms_output.put_line('4과정 정보 삭제실패');
end proc_process_delete;

-- 이미 만들어진 과정에 모든 과정들이 개설되어서 삭제할 데이터가 없음.
-- 호출
call proc_process_delete (12);

-- 삭제확인
select * from tblProcess where exist = 'Y';


/*======================================================================================

        [A-007-2] 기초 정보 과목 삭제

========================================================================================*/


-- 프로시저 
create or replace procedure proc_subject_delete (
    pseq in tblsubject.seq%type --지정할 과목 번호
)
is
  
    vsubjectNum number := 0;         --과목의 갯수를 담을 변수
    vcount1 number;                    --vcount 변수 선언 > 해당 과목으로 열린 개설과목 개수
    vcount2 number; 
    
    cursor vcursor is select * from tblSubject;
    vrow vcursor%rowtype;
    
begin
    
    -- 개설과정에 속한 과목 번호의 개수
    select count(*) into vcount1 from tblOpenSubject where subjectseq = pseq;
    
    -- 과정별 과목에 속한 과목 번호의 개수
    select count(*) into vcount2 from tblprocessSub where subjectseq = pseq;
    
    open vcursor;
    -- 현재 과목 목록의 개수 구하기
        loop
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            vsubjectNum := vsubjectNum + 1;
        end loop;
    close vcursor; 
    
    
    
        --1번 조건 현재 과목의 개수가 30~50개 사이가 아니라면 삭제 실패 
         if vsubjectNum  <= 30 then
            dbms_output.put_line('과목이 30개 이하입니다. (삭제실패)');
            null;
        --2번 조건 개설 과목에 속한 과목이면 삭제 실패
        elsif vcount1 > 0 then
            dbms_output.put_line('개설과목에 포함된 과목입니다.(삭제실패)');
            null;
            
        --3번 조건 과정별과목에 속한 과목이면 삭제 실패
        elsif vcount2 > 0 then
            dbms_output.put_line('과정별과목에 포함된 과목입니다.(삭제실패)');
            null;
            
        else 
            update tblsubject set exist = 'N' where seq = pseq;
            dbms_output.put_line('과목 정보 삭제 완료');
    end if;
    
    exception
        when others then
        rollback;
        dbms_output.put_line('4과목 정보 삭제실패');
end proc_subject_delete;


-- 호출
-- 9번 유일하게 삭제 가능함. 나머지는이미 2개의 테이블에 속해있어서 삭제불가능
call proc_subject_delete (2);

-- 삭제확인
select * from tblsubject where exist = 'Y';




/*======================================================================================

        [A-007-3] 기초 정보 과정별 과목 삭제(ProcessSub)

========================================================================================*/

----안쓰는걸 권장한다. 
-- 프로시저
create or replace procedure proc_processSub_delete (
    pnum1 in tblprocessSub.processSeq%type,
    pnum2 in tblprocessSub.subjectSeq%type
)
is
begin
     update tblprocessSub set exist = 'N' where processSeq = pnum1 and subjectSeq = pnum2;
    commit;
    exception
        when others then
        rollback;
        dbms_output.put_line('과정별 과목 정보 삭제실패');      
end proc_processSub_delete; 




--호출
call proc_processSub_delete(1,1);

-- 삭제확인
select * from tblprocessSub where exist = 'Y';





/*======================================================================================

        [A-007-4] 기초 정보 강의실 삭제

========================================================================================*/


--프로시저
create or replace procedure proc_classRoom_delete (
  pseq in tblclassRoom.seq%type --지정할 강의실 번호
)
is
begin
    update tblclassRoom set exist = 'N' where seq = pseq;
    commit;
    exception
        when others then
        rollback;
        dbms_output.put_line('강의실 정보 삭제실패');
end proc_classRoom_delete;

-- 호출
call proc_classRoom_delete(3);

-- 삭제확인
select * from tblclassRoom where exist = 'Y';




/*======================================================================================

        [A-007-5] 기초 정보 교재 삭제

========================================================================================*/
--프로시저
create or replace procedure proc_book_delete (
  pseq in tblBook.seq%type --지정할 강의실 번호
)
is
    vcount1 number;     --개설과목에 속한 교재의 개수
    
begin
    
    --개설과목에 등록된 해당교재의 개수 알아오기
    select count(*) into vcount1 from tblOpenSubject where bookseq = pseq;
    
    if vcount1 > 0 then
        dbms_output.put_line('해당 교재는 과목에 사용중입니다. 삭제할 수 없습니다.');
    else
        update tblBook set exist = 'N' where seq = pseq;
        dbms_output.put_line('교재 정보 삭제 완료');
    end if;
    
    exception
        when others then
        rollback;
        dbms_output.put_line('교재 정보 삭제실패');
end proc_book_delete;

-- 호출
call proc_book_delete(14);

-- 삭제확인
select * from tblBook where exist = 'Y';



/*======================================================================================

        [A-008] 기초 정보 출력
        1. 과정관련 기초정보를 출력한다.
        2. 과목관련 기초정보를 출력한다.
        3. 강의실관련 기초정보를 출력한다.
        4. 교재명관련 기초정보를 출력한다.

========================================================================================*/


-- 1. 과정관련 기초정보를 출력한다.
select * from tblProcess where exist = 'Y';
-- 2. 과목관련 기초정보를 출력한다.
select * from tblSubject where exist = 'Y';
-- 3. 강의실관련 기초정보를 출력한다.
select * from tblClassRoom where exist = 'Y';
-- 4. 교재명관련 기초정보를 출력한다.
select * from tblBook where exist = 'Y';


/*======================================================================================

        [A-009] 교사 정보 입력

========================================================================================*/

insert into tblTeacher 
    values(TEACHERSEQ.nextval, '강사명','주민번호', 'email', 'tel', 'address', 5, '학교명', '전공', '날짜', '강사분류', default);


--프로시저                
create or replace procedure proc_teacher_insert(
    pname in tblTeacher.name%type,
    pssn in tblteacher.ssn%type,
    pemail in tblteacher.email%type,
    ptel in tblteacher.tel%type,
    paddress in tblteacher.address%type,
    pcareer in tblteacher.career%type,
    pschool in tblteacher.school%type,
    pmajor in tblteacher.major%type,
    penterDate in tblteacher.enterDate%type,
    pdiv in tblteacher.div%type
)
is
    vteacherNum number := 0;          -- 교사 인원수
    cursor vcursor is select * from tblTeacher;
    vrow vcursor%rowtype;
begin

    --교사 인원수 파악하기
    for vrow in vcursor loop
        vteacherNum := vteacherNum + 1;
    end loop;
    
    if vteacherNum >= 10 then
        dbms_output.put_line('등록 가능한 교사 인원은 총 10명입니다. (등록실패)');
    else
        insert into tblteacher values 
            (teacherseq.nextVal,pname, pssn,pemail,ptel,paddress,pcareer,pschool,pmajor,penterDate,pdiv,default); 
        dbms_output.put_line('교사정보 등록 완료');    
    end if;
    
    exception
        when others then
        rollback;
        dbms_output.put_line('교사 정보 추가 실패');  
end proc_teacher_insert;     

--호출
-- call proc_teacher_insert('이름', '주민번호', 'email', 'tel', 'address', 5, '학교명', '전공', '날짜', '강사분류');


/*======================================================================================

        [A-010] 교사 정보 출력
        1. 전체 교사 목록을 출력한다.
        2. 특정 교사 목록을 출력한다.

========================================================================================*/

-- 1. 전체 교사 목록을 출력한다.
-- 뷰
create or replace view vw_A_010_1
as
select
    t.seq,
    t.name,
    t.tel,
    t.email
from tblTeacher t
    where t.exist = 'Y'
order by 
    t.seq asc;

--호출
select * from vw_A_010_1;

-- 2. 특정 교사 목록을 출력한다.
-- ANSI-SQL
select 
    t.name as "교사명",
    substr(t.ssn, 1, 6) as "생년월일",
    t.tel,
    s.name as "강의가능과목"
from tblTeacher t
    inner join tblTeacherSub t2
        on t.seq = t2.teacherseq
    inner join tblSubject s
        on s.seq = t2.subjectseq
where t.seq = 1 
        and t.exist = 'Y' 
        and t2.exist = 'Y' 
        and s.exist = 'Y'
order by s.name asc;
                        
--뷰
create or replace view vw_A_010_1
as 
select 
    t.seq as teacherSeq,
    t.name as teacherName,
    substr(t.ssn, 1, 6) as birthInfo,
    t.tel as tel,
    s.name as ableSubject
from tblTeacher t
    inner join tblTeacherSub t2
        on t.seq = t2.teacherseq
    inner join tblSubject s
        on s.seq = t2.subjectseq
where t.exist = 'Y' 
        and t2.exist = 'Y' 
        and s.exist = 'Y'
order by s.name asc;

--프로시저
create or replace procedure proc_A_010_1(
    pteacherSeq number, --교사번호
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_A_010_1 where teacherSeq = pteacherSeq;
end proc_A_010_1;

--호출
declare
    vcursor sys_refcursor;
    vrow vw_A_010_1%rowtype;
begin
    
    proc_A_010_1(10, vcursor);
    
    dbms_output.put_line('[교사번호]' || ' [교사명]' || ' [생년월일]' || ' [전화번호]' || '      [강의가능과목]');
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.teacherSeq ||'          '|| 
                            vrow.teacherName || '  '||
                            vrow.birthInfo || '   '||
                            vrow.tel ||  '   '||
                            vrow.ableSubject);
        
    end loop;
end;


/*======================================================================================

        [A-011] 교사 정보 수정

========================================================================================*/

-- 프로시저
create or replace procedure proc_teacher_update (
    pnum in tblteacher.seq%type, --지정할 강의실 번호
    psel in varchar2, --수정할 컬럼번호
    pinput in varchar2 --수정 내용
)
is
begin
    if psel = 'name' then update tblteacher set name = pinput where seq = pnum;
    elsif psel = 'ssn' then update tblteacher set ssn = pinput where seq = pnum;
    elsif psel = 'email' then update tblteacher set email = pinput where seq = pnum;
    elsif psel = 'tel' then update tblteacher set tel = pinput where seq = pnum;
    elsif psel = 'address' then update tblteacher set address = pinput where seq = pnum;
    elsif psel = 'career' then update tblteacher set career = pinput where seq = pnum;
    elsif psel = 'school' then update tblteacher set school = pinput where seq = pnum;
    elsif psel = 'major' then update tblteacher set major = pinput where seq = pnum;
    elsif psel = 'enterDate' then update tblteacher set enterDate = pinput where seq = pnum;
    elsif psel = 'div' then update tblteacher set div = pinput where seq = pnum;
    
    commit;
    end if;
    
    exception
      when others then
      rollback;
      dbms_output.put_line('교사 정보 수정실패');
end proc_teacher_update;   

-- 호출
-- call proc_teacher_update(1, major, '전공수정');

/*======================================================================================

        [A-012] 교사 정보 삭제

========================================================================================*/

-- 프로시저
create or replace procedure proc_teacher_delete (
  pseq in tblteacher.seq%type --지정할 교사 번호
)
is
    vteacherNum number := 0;        --교사인원
    vcount number;                  --개설과목에 속한 교사
    cursor vcursor is select * from tblTeacher;
    vrow vcursor%rowtype;
begin
    
    --개설과목에 속한 교사
    select count(*) into vcount from tblOpenSubject where teacherseq = pseq;
    
    -- 교사인원파악
    for vrow in vcursor loop
        vteacherNum := vteacherNum + 1;
    end loop;

    if vteacherNum <= 6 then
        dbms_output.put_line('최소 6명의 교사계정이 등록되어야 합니다. (삭제실패)');
    elsif vcount > 0 then
        dbms_output.put_line('개설과정에 속한 교사입니다. 삭제할 수 없습니다.');
    else   
        update tblteacher set exist = 'N' where seq = pseq;
        dbms_output.put_line('교사정보 삭제 완료');
    end if;
    
    exception
        when others then
        rollback;
        dbms_output.put_line('교사 정보 삭제실패');
end proc_teacher_delete;

-- 호출
-- call proc_teacher_delete(3);

-- 삭제확인
select * from tblteacher where exist = 'Y';


/*======================================================================================

        [A-013] 개설과목에 속한 특정 교사 정보 출력 
        1. 개설과목에 속한 전체 교사 목록을 출력한다.
        2. 개설과목에 속한 특정 교사를 선택한후 해당 교사의 정보를 출력한다.

========================================================================================*/

-- 1. 개설과목에 속한 전체 교사 목록을 출력한다.
-- 뷰 
create or replace view vw_A_013_1
as
select
    (select seq from tblTeacher where name = t.name)as "교사번호",
    t.name as "개설과목 교사",
    (select tel from tblTeacher where name = t.name)as "tel"
from tblTeacher t
    inner join tblopenSubject os
        on t.seq = os.teacherseq
where t.exist = 'Y' and 
        os.exist = 'Y'
group by t.name
order by 
    "교사번호" asc;

-- 호출
select * from vw_A_013_1;

-- 2. 개설과목에 속한 특정 교사를 선택한후 해당 교사의 정보를 출력한다.
-- 뷰
create or replace view vw_A_013_2
as
select
    os.teacherseq as teacherSeq,
    t.name as teacherName,
    s.name as subjectName,
    fnteachering(os.startDate, os.endDate)as subjectIng,
    os.startdate as osStart,
    p.name as processName,
    p.month || '개월' as opDuration,
    b.name as bookName,
    c.name as classRoomName
    
from tblTeacher t
    full outer join tblOpenSubject os
        on t.seq = os.teacherseq
    full outer join tblopenprocess op
        on os.openprocessseq = op.seq
    full outer join tblClassRoom c
        on c.seq = op.classroomseq
    full outer join tblprocess p
        on p.seq = op.processseq
    full outer join tblSubject s
        on s.seq = os.subjectseq
    full outer join tblBook b
        on b.seq = os.bookseq
where 
    t.exist = 'Y' 
    and os.exist = 'Y' 
    and op.exist = 'Y' 
    and c.exist = 'Y' 
    and p.exist = 'Y' 
    and s.exist = 'Y' 
    and b.exist = 'Y';

--프로시저
create or replace procedure proc_A_013_2 (
    pteacherSeq number,          -- 특정교사 번호
    pcursor out sys_refcursor   --커서
)
is
begin
    open pcursor for
        select * from vw_A_013_2 where teacherSeq = pteacherSeq;
        
end proc_A_013_2;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_A_013_2%rowtype;
begin
    proc_A_013_2(4, vcursor);   --4번 교사의 정보
    
    dbms_output.put_line
    ('[교사번호]' || ' [교사명]' || ' [개강날짜]' || ' [강의실명]' || '  [기간]' || '   [강의진행여부]' || ' [과목명]' || ' [과정명]'|| ' [교재명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line
        (vrow.teacherseq|| ',        ' || 
        vrow.teacherName|| ',  ' || 
        vrow.osStart|| ',   ' || 
        vrow.classRoomName || ',   ' || 
        vrow.opDuration|| ',   ' || 
        vrow.subjectIng|| ',   ' || 
        vrow.subjectName || ',   ' || 
        vrow.processName|| ',   ' || 
        vrow.bookName);
    end loop;
end;


/*======================================================================================

        [A-014] 개설 과정 등록

========================================================================================*/
-- 프로시저
create or replace procedure proc_openProcess_insert(
    popSeq          in number,
    pprocessSeq     in number,
    pclassRoomSeq   in number,
    pstartDate      date,
    pEndDate        date
)
is
    cursor vcursor
        is select startDate, endDate from tblOpenProcess where classRoomSeq = pclassRoomSeq;
    vrow tblOpenProcess%rowtype;
    vcnt number;
begin
     
       for vrow in vcursor loop
            
            if pstartDate between vrow.startDate and vrow.endDate then
                RAISE_APPLICATION_ERROR(-20000, '시작날짜가 잘못 입력되었습니다.');
        
            elsif pEndDate between vrow.startDate and vrow.endDate then
                RAISE_APPLICATION_ERROR(-20001, '종료날짜가 잘못 입력되었습니다.');
            
            elsif (pstartDate between vrow.startDate and vrow.endDate) and (pendDate between vrow.startDate and vrow.endDate) then
                RAISE_APPLICATION_ERROR(-20002, '시작 날짜, 종료날짜가 잘못 입력되었습니다. ');
                
            elsif round(months_between(pendDate, pstartDate)) > 7 then
                RAISE_APPLICATION_ERROR(-20003, '과정 기간이 7개월을 이상이므로 추가를 실패했습니다.');
                
            elsif round(months_between(pendDate, pstartDate)) < 5 then
                RAISE_APPLICATION_ERROR(-20004, '과정 기간이 5.5개월을 미만이므로 추가를 실패했습니다.');  

            else insert into tblOpenProcess (seq, processSeq, classRoomSeq, startDate, endDate) 
                values (openProcessSeq.nextVal, pprocessSeq , pclassRoomSeq, pstartDate, pEndDate); vcnt := 1;
                
            end if;
    
            exit when vcnt = 1;    

        end loop;
        
        commit;
        
exception
    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과정 등록이 실패했습니다.');
end proc_openProcess_insert;

-- 호출
-- call proc_openProcess_insert(openProcessSeq.nextVal, 1, 1, '2022-04-01', '2022-09-05');


/*======================================================================================

        [A-015] 개설 과정 조회

========================================================================================*/


-- 뷰
create or replace view vw_openProcess
as
select
    op.seq as "개설과정번호",
    p.name as "과정명",
    op.startDate || '~' || op.endDate as "과정기간",
    func_date(op.startDate, op.endDate) || '일' as "과정기간 일 수",
    cr.name as "강의실명",
    studentCnt.cnt as "수강인원",
    case
        when subjectCnt.cnt - openSubjectCnt.cnt > 0 then '미등록'
        else '등록'
    end as "과목 등록여부"
from tblOpenProcess op
    inner join tblProcess p
        on op.processSeq = p.seq
    inner join tblClassRoom cr
        on op.classRoomSeq = cr.seq
    inner join (
                    select
                        op.seq as openProcessSeq,
                        count(*) as cnt
                    from tblOpenProcess op
                        left outer join tblRegStudent rs
                            on op.seq = rs.openProcessSeq
                    where 
                        op.exist = 'Y' 
                        and rs.exist = 'Y'
                    group by op.seq
                ) studentCnt
        on op.seq = studentCnt.openProcessSeq
    inner join (
                    select  --개설과정별 필요과목 수
                        op.seq as openProcessSeq,   --개설과정번호
                        count(*) as cnt   --개설과정 총 과목 수
                    from tblOpenProcess op
                        inner join tblProcess p
                            on op.processSeq = p.seq
                        inner join tblProcessSub ps
                            on p.seq = ps.processSeq
                    where 
                        op.exist = 'Y' 
                        and p.exist = 'Y' 
                        and ps.exist = 'Y'
                    group by op.seq
                ) subjectCnt
        on op.seq = subjectCnt.openProcessSeq
    inner join (
                    select  --개설과정별 개설과목 수
                        op.seq as openProcessSeq,    --개설과정번호
                        count(*) as cnt  --개설과정 총 개설과목 수
                    from tblOpenProcess op
                        left outer join tblOpenSubject os
                            on op.seq = os.openProcessSeq
                    where 
                        op.exist = 'Y' 
                        and os.exist = 'Y'
                    group by op.seq
                ) openSubjectCnt
        on op.seq = openSubjectCnt.openProcessSeq
where 
    op.exist = 'Y' 
    and p.exist = 'Y' 
    and cr.exist = 'Y';

-- 호출
 select * from vw_openProcess;

/*======================================================================================

        [A-016] 개설 과정 수정

========================================================================================*/
-- 프로시저
create or replace procedure proc_openProcess_update (
    pnum    in number,      -- 수정할 개설과정 번호
    psel    in varchar2,    -- 수정할 컬럼명
    pinput  in varchar2     -- 수정할 내용
)
is
begin
    
    if    psel = 'processSeq'   then update tblOpenProcess set processSeq   = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'classRoomSeq' then update tblOpenProcess set classRoomSeq = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'startDate'    then update tblOpenProcess set startDate    = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'endDate'      then update tblOpenProcess set endDate      = pinput where seq = pnum and exist = 'Y';    

    commit;
    end if;
    
exception

    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과정 정보 수정 실패');
    
end proc_openProcess_update;

-- 호출
-- call proc_openProcess_update (?, ?, ?);


/*======================================================================================

        [A-017] 개설 과정 삭제
        - 관리자(개발자) 입장에서는 데이터가 실제 삭제(delete)가 된것은 아니다.
        - 사용자(교사, 교육생) 입장에서는 데이터가 눈에 보이지 않는다.

========================================================================================*/

-- 프로시저
create or replace procedure proc_openProcess_delete (
    pseq in number -- 삭제할 개설과정 번호
)
is
begin

    update tblOpenProcess set exist = 'N' where seq = pseq;
    commit;

exception

    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과정 정보 삭제 실패');

end proc_openProcess_delete;


-- 호출
-- call proc_openProcess_delete (?);

/*======================================================================================

        [A-018] 특정 개설 과정의 과목 조회

========================================================================================*/

-- 뷰
create or replace view vw_A_021
as
select
    op.seq as opSeq,
    s.name as sbName, 
    os.startDate || ' ~ ' || os.endDate as sbPriod,
    func_date(os.startDate, os.endDate) || '일' as osDate,
    b.name as bkName,
    t.name as thName
from tblOpenProcess op, tblOpenSubject os, tblSubject s, tblteacher t, tblBook b, tblClassRoom c
where
    op.seq = os.openProcessSeq 
    and os.subjectSeq = s.seq 
    and os.teacherSeq = t.seq 
    and os.bookSeq = b.seq
    and op.classRoomSeq = c.seq
    and op.exist = 'Y'
    and os.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and b.exist = 'Y';
    
-- 프로시저
create or replace procedure proc_A_021 (
    pseq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_A_021 where opSeq = pseq;
end proc_A_021;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_A_021%rowtype;
begin
    proc_A_021(2, vcursor); --특정 개설 과정 번호
    DBMS_OUTPUT.PUT_LINE('[과목명]' || ', ' || '[과목기간]' || ', ' || '[과목 일수]' || ', ' || '[교재명]' || ', ' || '[교사명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(vrow.sbName || ', ' || vrow.sbPriod || ', ' || vrow.osDate || ', ' || vrow.bkName || ', ' || vrow.thName );
    end loop;

end;

/*======================================================================================

        [A-019] 특정 개설 과정의 교육생 조회

========================================================================================*/

-- 뷰
create or replace view vw_A_019
as
select
    op.seq as osSeq,
    s.name as sName,
    func_ssn(ssn) as sSsn,
    s.tel as sTel,
    rs.finishDate as sFinishDate,
    rs.dropDate as sDropDate,
    case
        when rs.isMajor = 'Yes' then '전공'
        when rs.isMajor = 'No' then '비전공'
    end as sMajor
from tblStudent s, tblRegStudent rs, tblOpenProcess op
where 
    s.seq = rs.studentSeq
    and op.seq = rs.openprocessseq
    and s.exist = 'Y'
    and rs.exist = 'Y'
    and op.exist = 'Y'
order by s.seq ASC;

-- 프로시저
create or replace procedure proc_A_019(
    pseq  in number,            -- 조회할 개설과정 과목번호
    pcursor out sys_refcursor   -- 반환값
)
is
begin
    open pcursor for
        select * from vw_A_019 where osSeq = pseq;
end proc_A_019;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_A_019%rowtype;
begin

    proc_A_019(2, vcursor); -- 특정 과정 번호
    DBMS_OUTPUT.PUT_LINE('[교육생 이름]' || '[교육생 주민번호]' || '[교육생 전화번호]' || '[수료/중도탈락 날짜]' || '[전공/비전공]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(vrow.sName || ', ' || vrow.sSsn || ', ' || vrow.sTel || ', ' || vrow.sFinishDate || ', ' || vrow.sDropDate || ', ' || vrow.sMajor);
    end loop;
    
end;

/*======================================================================================

        [A-020] 특정 개설 과정에 들어갈 개설 과목 정보 입력

========================================================================================*/

-- 프로시저
create or replace procedure proc_openSubject_insert(
    posSeq              in number,
    psubejctSeq         in number,
    popenProcessSeq     in number,
    pteacherSeq         in number,
    pbookSeq            in number,
    pstartDate          date,
    pEndDate            date
)
is
    cursor vcursor
        is select startDate, endDate from tblOpenSubject where teacherSeq = pteacherSeq;
    vrow tblOpenSubject%rowtype;
    vcnt number;
begin
     
       for vrow in vcursor loop
            
            if pstartDate between vrow.startDate and vrow.endDate then
                RAISE_APPLICATION_ERROR(-20000, '시작날짜가 잘못 입력되었습니다.');
        
            elsif pEndDate between vrow.startDate and vrow.endDate then
                RAISE_APPLICATION_ERROR(-20001, '종료날짜가 잘못 입력되었습니다.');
            
            elsif (pstartDate between vrow.startDate and vrow.endDate) and (pendDate between vrow.startDate and vrow.endDate) then
                RAISE_APPLICATION_ERROR(-20002, '시작 날짜, 종료날짜가 잘못 입력되었습니다. ');

            else insert into tblOpenSubject (seq, subjectSeq, openProcessSeq, teacherSeq, bookSeq, startDate, endDate) 
                values (openSubjectSeq.nextVal, psubjectSeq , popenProcessSeq, pteacherSeq, pbookSeq, pstartDate, pEndDate); vcnt := 1;
                
            end if;
    
            exit when vcnt = 1;    

        end loop;
        
        commit;
        
exception
    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과목 등록이 실패했습니다.');
end proc_openSubject_insert;

-- 호출
-- call proc_openSubject_insert(openSubjectSeq.nextVal, 12, 1, 2, 15, '2022-04-01', '2022-09-05');

/*======================================================================================

        [A-021] 특정 개설 과정에 속한 개설 과목 전체 목록 출력

========================================================================================*/

-- 뷰
create or replace view vw_A_021
as
select
    op.seq as opSeq,
    s.name as sbName, 
    os.startDate || ' ~ ' || os.endDate as sbPriod,
    func_date(os.startDate, os.endDate) || '일' as osDate,
    b.name as bkName,
    t.name as thName
from tblOpenProcess op, tblOpenSubject os, tblSubject s, tblteacher t, tblBook b, tblClassRoom c
where
    op.seq = os.openProcessSeq 
    and os.subjectSeq = s.seq 
    and os.teacherSeq = t.seq 
    and os.bookSeq = b.seq
    and op.classRoomSeq = c.seq
    and op.exist = 'Y'
    and os.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and b.exist = 'Y';
    
-- 프로시저
create or replace procedure proc_A_021 (
    pseq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_A_021 where opSeq = pseq;
end proc_A_021;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_A_021%rowtype;
begin
    proc_A_021(2, vcursor); --특정 개설 과정 번호
    DBMS_OUTPUT.PUT_LINE('[과목명]' || ', ' || '[과목기간]' || ', ' || '[과목일 수]' || ', ' || '[교재명]' || ', ' || '[교사명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(vrow.sbName || ', ' || vrow.sbPriod || ', ' || vrow.osDate || ',' || vrow.bkName || ', ' || vrow.thName);
    end loop;

end;

/*======================================================================================

        [A-022] 개설 과목 삭제
        - 관리자(개발자) 입장에서는 데이터가 실제 삭제(delete)가 된것은 아니다.
        - 사용자(교사, 교육생) 입장에서는 데이터가 눈에 보이지 않는다.

========================================================================================*/

select * from tblOpenSubject;

-- 프로시저
create or replace procedure proc_openSubject_delete (
    pseq in number -- 삭제할 개설과목 번호
)
is
begin

    update tblOpenSubject set exist = 'N' where seq = pseq;
    commit;

exception

    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과정 정보 삭제 실패');

end proc_openSubject_delete;


-- 호출
-- call proc_openSubject_delete (?);

/*======================================================================================

        [A-023] 개설 과목 수정

========================================================================================*/

 -- 프로시저
 create or replace procedure proc_openSubject_update (
    pnum    in number,      -- 수정할 개설과정 번호
    psel    in varchar2,    -- 수정할 컬럼명
    pinput  in varchar2     -- 수정할 내용
)
is
begin
    
    if    psel = 'subjectSeq'       then update tblOpenSubject set subjectSeq       = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'openProcessSeq'   then update tblOpenSubject set openProcessSeq   = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'teacherSeq'       then update tblOpenSubject set teacherSeq       = pinput where seq = pnum and exist = 'Y';
    elsif psel = 'BookSeq'          then update tblOpenSubject set BookSeq          = pinput where seq = pnum and exist = 'Y';    
    elsif psel = 'startDate'        then update tblOpenSubject set startDate        = pinput where seq = pnum and exist = 'Y';    
    elsif psel = 'endDate'          then update tblOpenSubject set endDate          = pinput where seq = pnum and exist = 'Y';    
    commit;
    end if;
    
exception

    when others then
    rollback;
    DBMS_OUTPUT.PUT_LINE('개설 과목 정보 수정 실패');
    
end proc_openSubject_update;

-- 호출
-- call proc_openSubject_update (?, ?, ?);


/*======================================================================================

        [A-024] 교육생 등록

========================================================================================*/

--프로시저
create or replace procedure proc_student_insert (
    pname tblStudent.name%type,          -- 이름
    pssn tblStudent.ssn%type,            -- 주민번호
    pemail tblStudent.email%type,        -- 이메일
    ptel tblStudent.tel%type,            -- 전화번호
    paddress tblStudent.address%type,    -- 주소
    pschool tblStudent.school%type,      -- 대학교
    pmajor tblStudent.major%type         -- 전공
)
is
begin
    insert into tblStudent (seq, name, ssn, email, tel, address, school, major, exist)
        values (studentSeq.nextVal+1000, pname, pssn, pemail, ptel, paddress, pschool, pmajor, default);
    commit;
    dbms_output.put_line('교육생 추가 성공');
exception
    when others then
        rollback;
        dbms_output.put_line('교육생 추가 실패');
end proc_student_insert;

--호출
--call proc_student_insert('이름', '000000-0000000', 'abcd@abc.com', '010-0000-0000', '주소', '대학교', '전공');

/*======================================================================================

        [A-025] 교육생 정보에 대한 수정

========================================================================================*/

--프로시저
create or replace procedure proc_student_update (
    pstudentSeq number,         -- 교육생 번호
    psel varchar2,              -- 수정할 컬럼명
    pinput varchar2             -- 수정 내용
)
is
begin
    -- 이름 수정
    if psel = 'name' then
        update tblStudent set name = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
    
    -- 주민번호 수정
    elsif psel = 'ssn' then
        update tblStudent set ssn = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
            
     -- 이메일 수정
    elsif psel = 'email' then
        update tblStudent set email = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
            
     -- 전화번호 수정
    elsif psel = 'tel' then
        update tblStudent set tel = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
            
     -- 주소 수정
    elsif psel = 'address' then
        update tblStudent set address = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
            
     -- 출신학교 수정
    elsif psel = 'school' then
        update tblStudent set school = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
            
     -- 전공 수정
    elsif psel = 'major' then
        update tblStudent set major = pinput where seq = pstudentSeq;
            commit;
            dbms_output.put_line('교육생 수정 성공');
    
    else
        dbms_output.put_line('교육생 수정 실패');
    
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('교육생 수정 실패');
end proc_student_update;

--호출
--call proc_student_update(1001, 'name', '홍길동');




/*======================================================================================

        [A-026] 교육생 정보 삭제

========================================================================================*/

--프로세스
create or replace procedure proc_student_delete (
    pseq number
)
is
    vcnt number;    -- 수강횟수
begin
    select count(*) into vcnt
        from tblRegStudent
        where studentSeq = pseq;
    
    -- 수강내역이 있는 교육생 정보는 삭제할 수 없다.
    if vcnt > 0 then
        dbms_output.put_line('교육생 삭제 실패');

    else
        update tblStudent set exist = 'N' where seq = pseq;
        commit;
        dbms_output.put_line('교육생 삭제 성공');
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('교육생 삭제 실패');
end proc_student_delete;

--호출
--call proc_student_delete(1001);

/*======================================================================================

        [A-027] 교육생 수강정보 등록

========================================================================================*/

--프로시저
create or replace procedure proc_regStudent_insert (
    pstudentSeq number,                     -- 교육생 번호
    popenProcessSeq number,                 -- 개설과정 번호
    pisMajor tblRegStudent.isMajor%type     -- 전공여부
)
is
    vstudentExist tblStudent.exist%type;                    -- 교육생 존재여부
    vopenProcessExist tblOpenProcess.exist%type;            -- 개설과정 존재여부
    vcurrDate date;                                         -- 현재 날짜
    vnewStartDate date;                                     -- 개설과정 시작 날짜
    vnewEndDate date;                                       -- 개설과정 시작 날짜    
    cursor vcursor is select openProcessSeq                 
        from tblRegStudent 
        where studentSeq = pstudentSeq
            and exist = 'Y';                                -- 커서: 이미 등록된 수강과정 번호 리스트
    vopenProcessSeq number;                                 -- 이미 등록된 수강과정 번호
    voldStartDate date;                                     -- 이미 등록된 개설과정의 시작 날짜    
    voldEndDate date;                                       -- 이미 등록된 개설과정의 종료 날짜
    visDup number := 0;                                     -- 기간 중복여부 (0: 중복아님, 1: 중복)
    vclassRoomMax number;                                   -- 해당 개설과정의 강의실 최대 인원
    vstudentCnt number;                                     -- 해당 과정을 수강하는 총 학생 수
    vresult number := 0;                                    -- 성공 유무(0: 성공, 1: 실패)
begin
    -- 삭제된 교육생 번호는 입력할 수 없다.
    select exist into vstudentExist
        from tblStudent
        where seq = pstudentSeq;
        
    if vstudentExist = 'N' then
        vresult := 1; -- 실패
    end if;
        
    -- 삭제된 개설과정 번호는 입력할 수 없다.
    select exist into vopenProcessExist
        from tblOpenProcess
        where seq = popenProcessSeq;
        
    if vopenProcessExist = 'N' then
        vresult := 1; -- 실패
    end if;
    
    -- 이미 시작한 개설과정에는 교육생을 추가할 수 없다.
    select sysdate into vcurrDate 
        from dual;
        
    select startDate, endDate into vnewStartDate, vnewEndDate 
        from tblOpenProcess 
        where seq = popenProcessSeq;
            
    if vcurrDate > vnewStartDate then
        vresult := 1; -- 실패
    end if;
    
    -- 교육생이 이미 수강중인 개설과정과 추가하려는 개설과정의 기간이 겹치면 안된다.
    open vcursor;
    loop
        fetch vcursor into vopenProcessSeq;
        exit when vcursor%notfound;

        select startDate, endDate into voldStartDate, voldEndDate
            from tblOpenProcess
            where seq = vopenProcessSeq;
        
        visDup := visDup + fn_check_termIsDup(vnewStartDate, vnewEndDate, voldStartDate, voldEndDate);

    end loop;
    close vcursor;

    if visDup > 0 then
        vresult := 1; -- 실패
    end if;
    
    -- 교육생 수가 해당 개설과정의 강의실 최대 인원을 초과하면 안된다.
    select max into vclassRoomMax
        from tblClassRoom
        where seq = (
            select classRoomSeq
            from tblOpenProcess
            where seq = popenProcessSeq
        );
        
    select count(*) into vstudentCnt
        from tblRegStudent
        where openProcessSeq = popenProcessSeq
            and exist = 'Y';
        
    if vstudentCnt >= vclassRoomMax then
        vresult := 1; -- 실패
    end if;
    
    -- 결과 처리
    if vresult = 0 then
        insert into tblRegStudent (studentSeq, openProcessSeq, finishDate, dropDate, isMajor, exist)
            values (pstudentSeq, popenProcessSeq, null, null, pisMajor, default);
        commit;
        dbms_output.put_line('수강정보 추가 성공');
    else
        dbms_output.put_line('수강정보 추가 실패');
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('수강정보 추가 실패');
end proc_regStudent_insert;

--호출
--call proc_regStudent_insert(1001, 1, 'Yes');

/*======================================================================================

        [A-028] 교육생 수강정보 수정

========================================================================================*/

--프로시저
create or replace procedure proc_regStudent_update (
    pstudentSeq number,         -- 교육생 번호
    popenProcessSeq number,     -- 개설과정 번호
    psel varchar2,              -- 수정할 컬럼명
    pinput varchar2             -- 수정 내용
)
is
    vcurrDate date;             -- 현재 날짜
    vfinishDate date;           -- 수료 날짜
    vdropDate date;             -- 중도포기 날짜
    vendDate date;              -- 개설과정 종료 날짜
begin
    select sysdate into vcurrDate
        from dual;
        
    select finishDate into vfinishDate
        from tblRegStudent
        where studentSeq = pstudentSeq 
            and openProcessSeq = popenProcessSeq;
    
    select dropDate into vdropDate
        from tblRegStudent
        where studentSeq = pstudentSeq 
            and openProcessSeq = popenProcessSeq;
            
    select endDate into vendDate
        from tblOpenProcess
        where seq = popenProcessSeq;
    
    -- 수료 날짜 수정
    if psel = 'finishDate' then
    
        -- 중도탈락한 경우 수료 날짜가 입력되어서는 안된다.
        if vdropDate is not null then
            dbms_output.put_line('수강정보 수정 실패');
            
        -- 과정 종료 날짜가 지나지 않은 상태에서는 수료 날짜를 입력할 수 없다. 
        elsif vcurrDate < vendDate then
            dbms_output.put_line('수강정보 수정 실패');
        
        -- 수료 날짜는 과정 종료 날짜와 일치해야 한다.
        elsif to_date(pinput, 'yyyy-mm-dd') <> vendDate then
            dbms_output.put_line('수강정보 수정 실패');
        
        -- 수정 성공
        else
            update tblRegStudent set finishDate = pinput where studentSeq = pstudentSeq and openProcessSeq = popenProcessSeq;
            commit;
            dbms_output.put_line('수강정보 수정 성공');
            
        end if;
    
    -- 중도포기 날짜 수정
    elsif psel = 'dropDate' then
    
        -- 수료한 경우 중도포기 날짜가 입력되어서는 안된다.
        if vfinishDate is not null then
            dbms_output.put_line('수강정보 수정 실패');
        
        -- 현재 날짜 이후의 날짜를 중도포기 날짜로 입력할 수 없다.
        elsif to_date(pinput, 'yyyy-mm-dd') > vcurrDate then
            dbms_output.put_line('수강정보 수정 실패');
        
        -- 수정 성공
        else
            update tblRegStudent set finishDate = pinput where studentSeq = pstudentSeq and openProcessSeq = popenProcessSeq;
            commit;
            dbms_output.put_line('수강정보 수정 성공');
        
        end if;
        
    -- 전공여부 수정
    elsif psel = 'isMajor' then
        update tblRegStudent set isMajor = pinput where studentSeq = pstudentSeq and openProcessSeq = popenProcessSeq;
        commit;
        dbms_output.put_line('수강정보 수정 성공');
        
    else
        dbms_output.put_line('수강정보 수정 실패');
        
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('수강정보 수정 실패');
end proc_regStudent_update;

--호출
--call proc_regStudent_update(1001, 1, 'finishDate', '2021-11-11');

/*======================================================================================

        [A-029] 교육생 수강정보 삭제

========================================================================================*/

--프로시저
create or replace procedure proc_regStudent_delete (
    pstudentSeq number,         -- 교육생 번호
    popenProcessSeq number      -- 개설과정 번호
)
is
    vcurrDate date;             -- 현재 날짜
    vstartDate date;            -- 개설과정 시작 날짜
begin
    select sysdate into vcurrDate 
        from dual;
    select startDate into vstartDate 
        from tblOpenProcess 
        where seq = popenProcessSeq;

    -- 개설과정이 시작전인 경우에만 삭제가 가능하다.
    if vcurrDate < vstartDate then
        update tblRegStudent set exist = 'N' where studentSeq = pstudentSeq and openProcessSeq = popenProcessSeq;
        commit;
        dbms_output.put_line('수강정보 삭제 성공');
    else
        dbms_output.put_line('수강정보 삭제 실패');
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('수강정보 삭제 실패');
end proc_regStudent_delete;

--호출
--call proc_regStudent_delete(1001, 1);



/*======================================================================================

        [A-030] 교육생 목록 조회
        
        1. 교육생 전체 정보를 출력한다.
        2. 특정 교육생 정보를 출력한다.
        3. 교육생 수강정보 목록을 출력한다.

========================================================================================*/

-- 1. 교육생 전체 정보를 출력한다.
--뷰
create or replace view vw_A_030_1 --교육생 목록 조회
as
select
    s.seq as "교육생 번호",
    s.name as "이름",
    substr(s.ssn, 1, 6) as "주민번호 앞자리",
    s.email as "이메일", 
    s.tel as "전화번호",
    case
        when r.cnt is null then 0
        else r.cnt
    end as "수강 횟수"
from tblStudent s
	left outer join (
        select studentSeq,
            count(*) as cnt
        from tblRegStudent
        where exist = 'Y'
		group by studentSeq) r
            on s.seq = r.studentSeq
where s.exist = 'Y'
order by s.seq;
--호출
select * from vw_A_030_1;

-- 2. 특정 교육생 정보를 출력한다.
--뷰
create or replace view vw_A_030_2 -- 교육생 정보 조회
as
select
    s.seq as studentSeq,
    s.name as studentName, 
    s.ssn as ssn, 
    s.email as email, 
    s.tel as tel,
    t.processName as processName, 
    t.processTerm as processTerm, 
    t.isFinish as isFinish
from tblStudent s
    left outer join (
        select
            rs.studentSeq as studentSeq,
            p.name as processName,
            fn_toTerm(op.startDate, op.endDate) as processTerm,
            fn_toRegState(sysdate, rs.finishDate, rs.dropDate, op.startDate, op.endDate) as isFinish
        from tblRegStudent rs
            inner join tblOpenProcess op
                on rs.openProcessSeq = op.seq
            inner join tblProcess p
                on op.processSeq = p.seq
        where rs.exist = 'Y'
            and op.exist = 'Y'
            and p.exist = 'Y'
    ) t
        on s.seq = t.studentSeq
where s.exist = 'Y'
order by s.seq;

--프로시저
create or replace procedure proc_A_030_2 (    --특정 교육생 정보 조회
    pstudentSeq number,          -- 교사 번호
    pcursor out sys_refcursor   --커서
)
is
begin
    open pcursor for
        select * from vw_A_030_2 where studentSeq = pstudentSeq;
end proc_A_030_2;

--호출

declare
    vcursor sys_refcursor;
    vrow vw_A_030_2%rowtype;
begin
    proc_A_030_2(1001, vcursor);   --특정 교육생 > 1001
    
    dbms_output.put_line('[교육생 번호]' || ' [이름]' || ' [주민번호]' || ' [이메일]' || 
        ' [전화번호]' || ' [과정명]' || ' [과정기간]' || ' [수료여부]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.studentSeq || ', ' || vrow.studentName || ', ' || 
            vrow.ssn || ', ' || vrow.email || ', ' || vrow.tel || ', ' || vrow.processName 
            || ', ' || vrow.processTerm || ', ' || vrow.isFinish);
    end loop;
end;

-- 3. 교육생 수강정보 목록을 출력한다.
-- 뷰
create or replace view vw_A_030_3 --교육생 수강정보 조회
as
select
    s.name as "이름",
    p.name as "과정명",
    r.finishDate as "수료날짜",
    r.dropDate as "중도탈락날짜",
    r.isMajor as "전공여부"
from tblRegStudent r
    inner join tblStudent s
        on r.studentSeq = s.seq
    inner join tblOpenProcess op
        on r.openProcessSeq = op.seq
    inner join tblProcess p
        on op.processSeq = p.seq
where r.exist = 'Y'
    and s.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y'
order by s.name asc, p.name asc;

-- 호출
select * from vw_A_030_3;



/*======================================================================================

        [A-032] 과목별 성적조회
        1. 출력된 특정 개설의 과목들 중 특정 과목을 선택하는 경우 해당 과목의 모든 교육생들의 성적정보를 출력한다.
        2. 특정 과목 성적 조회(전체 교육생)

========================================================================================*/
--ANSI-SQL
select
    os.seq as "개설과목번호",
    case
        when s.name is null then '(개설과목 미정)'
        when s.name is not null then s.name
    end  as "과목명",
    p.name as "개설과정명",
    op.seq as "개설과정번호"
from tblOpenProcess op
    right outer join tblProcess p
        on p.seq = op.processseq
    left outer join tblOpenSubject os
        on os.openprocessseq = op.seq
    left outer join tblSubject s
        on s.seq = os.subjectseq
    
    -- 원하는 개설과정 번호를 입력
where op.seq = 2 
        and op.exist = 'Y'
        and p.exist = 'Y'
        and os.exist = 'Y'
        and s.exist = 'Y'        
order by os.startdate asc;

--뷰
create or replace view vw_A_032 
as
select
    os.seq as osSeq,
    case
        when s.name is null then '(개설과목 미정)'
        when s.name is not null then s.name
    end  as subjectName,
    p.name as processName,
    op.seq as opSeq
from tblOpenProcess op
    right outer join tblProcess p
        on p.seq = op.processseq
    left outer join tblOpenSubject os
        on os.openprocessseq = op.seq
    left outer join tblSubject s
        on s.seq = os.subjectseq
where  op.exist = 'Y'
        and p.exist = 'Y'
        and os.exist = 'Y'
        and s.exist = 'Y'        
order by os.startdate asc;

--프로시저
create or replace procedure proc_A_032 (
    popSeq number, --특정과정 선택
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_A_032  where opSeq = popSeq;
end proc_A_032;

--호출
declare
    vcursor sys_refcursor;
    vrow vw_A_032%rowtype;
begin
    proc_A_032(2,vcursor); --특정과정선택

    dbms_output.put_line('[개설과정번호]'||'[개설과목번호]'||'[과목명]'||'[개설과정명]');
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;

        dbms_output.put_line('   '||vrow.opSeq||',             '||
                                vrow.osSeq||',      '||
                                vrow.subjectName||',     '||
                                vrow.processName||','); 
    end loop;
end;

-- 2. 특정 과목 성적 조회(전체 교육생)

--ANSI-SQL
select
    st.seq as "교육생 번호",
    st.name as "교육생명",
    sc.attend as "출결",
    sc.write as "필기",
    sc.perform  as "실기",
    sc.task as "과제",
    fnAvgScore(sc.attend , p.attend, sc.write, p.write, sc.perform, p.perform, sc.task, p.task) as "총점"
    
from tblOpenSubject os
    inner join tblScore sc
        on os.seq = sc.opensubjectseq
    inner join tblStudent st
        on st.seq = sc.studentseq
    inner join tblPoint p
        on p.opensubjectseq = os.seq
    inner join tblOpenProcess op
        on op.seq = os.openprocessseq    
        -- 원하는 특정 개설과목 번호를 입력   
where 
    os.seq = 21
    and os.exist = 'Y'
    and sc.exist = 'Y'
    and st.exist = 'Y'
    and p.exist = 'Y'
    and op.exist = 'Y'
order by 
    st.name asc;
    
-- 뷰  
create or replace view vw_A_032_2
as
select
    os.seq as subjectSeq,
    st.seq as studentSeq,
    st.name as studentName,
    sc.attend as attend,
    sc.write as write,
    sc.perform  as perform,
    sc.task as task,
    fnAvgScore(sc.attend , p.attend, sc.write, p.write, sc.perform, p.perform, sc.task, p.task) as total
from tblOpenSubject os
    inner join tblScore sc
        on os.seq = sc.opensubjectseq
    inner join tblStudent st
        on st.seq = sc.studentseq
    inner join tblPoint p
        on p.opensubjectseq = os.seq
    inner join tblOpenProcess op
        on op.seq = os.openprocessseq    
where
    os.exist = 'Y'
    and sc.exist = 'Y'
    and st.exist = 'Y'
    and p.exist = 'Y'
    and op.exist = 'Y'
order by 
    st.name asc;
 
--프로시저
create or replace procedure proc_A_032_2 (
    psubjectSeq number,     --과목번호 
    pcursor out sys_refcursor   --커서
)
is
begin
    open pcursor for
        select*from vw_A_032_2 where subjectSeq = psubjectSeq;
        
end proc_A_032_2;
    
--호출
declare
    vcursor sys_refcursor;
    vrow vw_A_032_2%rowtype;
begin
    proc_A_032_2(21, vcursor);  -- 특정과목 선택
    dbms_output.put_line('[과목번호]'||'[교육생번호]'||'[교육생명]'||'[출결]'||'[필기]'||'[실기]'||'[과제]'||'[총점]');
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line(vrow.subjectSeq||',       '||
                                vrow.studentSeq||',       '||
                                vrow.studentName||',    '||
                                vrow.attend||',  '||
                                vrow.write||',   '||
                                vrow.perform||',  '||
                                vrow.task||',   '||
                                vrow.total||',  ');
    end loop;    
end;


/*======================================================================================

        [A-033] 개설과정에 수강중인 전체 교육생 조회

========================================================================================*/

create or replace view vw_A_033
as
select
    st.seq as "교육생 번호",
    st.name as "교육생 이름",
    st.tel as "교육생 전화번호",
    p.name as "과정명"
from tblRegStudent rs
    inner join tblopenprocess op
        on rs.openprocessseq = op.seq
    inner join tblStudent st
        on st.seq = rs.studentseq
    inner join tblProcess p
        on p.seq = op.processseq
order by st.name asc;

-- 
select * from vw_a_033;


/*======================================================================================

        [A-034] 개설과정에 수강중인 (개인별) 특정 교육생 성적조회

========================================================================================*/

select 
    sc.Studentseq as "교육생번호",
    s.name as "과목명",
    sc.attend as "출결",
    sc.write as "필기",
    sc.perform as "실기",
    sc.task as "과제",
    ((sc.attend * po.attend) + (sc.write*po.write) + (sc.perform*po.perform) + (sc.task*po.task))/100 as "총점",
    p.name as "과정명"
from tblScore sc
    inner join tblopensubject os
        on sc.opensubjectseq = os.seq
    inner join tblopenprocess op
        on op.seq = os.openprocessseq
    inner join tblProcess p
        on p.seq = op.processseq
    inner join tblSubject s
        on s.seq = os.subjectseq
    inner join tblPoint po
        on po.opensubjectseq = os.seq
where sc.exist = 'Y'
        and os.exist = 'Y'
        and op.exist = 'Y'
        and p.exist = 'Y'
        and s.exist = 'Y'
        and po.exist = 'Y'
        and sc.Studentseq = 1070;


--뷰
create or replace view vw_A_034_1
as 
select 
    sc.Studentseq as studentSeq,
    s.name as subjectName,
    sc.attend as attend,
    sc.write as write,
    sc.perform as perform,
    sc.task as task,
    ((sc.attend * po.attend) + (sc.write*po.write) + (sc.perform*po.perform) + (sc.task*po.task))/100 as total,
    p.name as processName 
from tblScore sc
    inner join tblopensubject os
        on sc.opensubjectseq = os.seq
    inner join tblopenprocess op
        on op.seq = os.openprocessseq
    inner join tblProcess p
        on p.seq = op.processseq
    inner join tblSubject s
        on s.seq = os.subjectseq
    inner join tblPoint po
        on po.opensubjectseq = os.seq
where sc.exist = 'Y'
        and os.exist = 'Y'
        and op.exist = 'Y'
        and p.exist = 'Y'
        and s.exist = 'Y'
        and po.exist = 'Y';

    
--프로시저
create or replace procedure proc_A_034_1 (
    pstudentSeq number,          -- 교사 번호
    pcursor out sys_refcursor   --커서
)
is
begin
    open pcursor for
        select * from vw_A_034_1 where studentSeq = pstudentSeq;
end proc_A_034_1;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_A_034_1%rowtype;
begin

    proc_A_034_1(1070, vcursor);   --특정 교육생 > 1070
    dbms_output.put_line('[교육생번호]' || ' [과목명]' || ' [출결]' || ' [필기]' || ' [실기]' || ' [과제]'|| ' [총점]'|| ' [과정명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;       

        dbms_output.put_line(vrow.studentSeq || ', ' ||
                                vrow.subjectName || ', ' ||
                                vrow.attend || ', ' ||
                                vrow.write || ', ' ||
                                vrow.perform || ', ' ||
                                vrow.task || ', ' ||
                                vrow.total || ', ' ||
                                vrow.processName);
    end loop;
end;


/*======================================================================================

        [A-036] 특정 과정별 교육생 출결 조회

========================================================================================*/

create or replace procedure proc_A_036 (
    popenProcessSeq number --특정 개설과정 번호
)
is
    cursor vcursor is
        select
            studentSeq as sSeq,
            count(decode(attendState, '출석', 1)) as attend,
            count(decode(attendState, '결석', 1)) as unattend,
            count(decode(attendState, '지각', 1)) as late,
            count(decode(attendState, '조퇴', 1)) as early,
            count(decode(attendState, '외출', 1)) as outing,
            count(decode(attendState, '병가', 1)) as sick,
            count(decode(attendState, '기타', 1)) as etc
        from (
            select
                wd.weekDayDate,
                wd.openProcessSeq,
                wd.studentSeq,
                case
                    when at.state is not null then at.state
                    when a.inTime is null then '결석'
                    when a.inTime > to_date(to_char(inTime, 'yyyy-mm-dd') || ' ' || '09:00:00', 'yyyy-mm-dd hh24:mi:ss') then '지각'
                    when a.outTime < to_date(to_char(outTime, 'yyyy-mm-dd') || ' ' || '18:00:00', 'yyyy-mm-dd hh24:mi:ss') then '조퇴'
                    else '출석'        
                end as attendState
            from (
                select
                    distinct
                    wd.weekDayDate,
                    a.openProcessSeq,
                    a.studentSeq
                from (
                    select
                        weekDayDate
                    from (
                        select
                            (
                                select 
                                    startDate
                                from tblOpenProcess
                                where seq = popenProcessSeq
                            )+ (LEVEL - 1) as weekDayDate
                        from
                            dual
                        connect by level <= (
                            select
                                case
                                    when endDate < sysdate then endDate
                                    else sysdate
                                end
                            from tblOpenProcess
                            where seq = popenProcessSeq       --특정 개설과정 선택
                        ) - (
                            select
                                startDate
                            from tblOpenProcess
                            where seq = popenProcessSeq       --특정 개설과정 선택
                        ) + 1
                    )
                where to_char(weekDayDate, 'd') between 2 and 6
                ) wd, tblAttend a
                where a.openProcessSeq = popenProcessSeq
            ) wd
                left outer join (
                    select
                        seq,
                        openProcessSeq,
                        studentSeq,
                        to_char(inTime, 'yy/mm/dd') as DT,
                        inTime,
                        outTime
                    from tblAttend
                ) a
                    on wd.weekDayDate = a.DT
                        and wd.openProcessSeq = a.openProcessSeq
                        and wd.studentSeq = a.studentSeq
                left outer join tblAttendState at
                    on a.seq = at.attendSeq    
        )
        where openProcessSeq = popenProcessSeq        --특정 개설과정 선택
        group by studentSeq
        order by studentSeq;
   
    vrow vcursor%rowtype;
begin
    dbms_output.put_line('[교육생번호]'||'[출석]'||'[결석]'||'[지각]'||'[조퇴]'||'[외출]'||'[병가]'||'[기타]');
    
    for vrow in vcursor loop
        dbms_output.put_line('  '||vrow.sSeq||',       '||
                            vrow.attend||',    '||
                            vrow.unattend||',   '||
                            vrow.late||',   '||
                            vrow.early||',   '||
                            vrow.outing||',   '||
                            vrow.sick||',   '||
                            vrow.etc);
        
    end loop;
end proc_A_036;

--호출
call proc_A_036(1);

/*======================================================================================

        [A-037] 특정 교육생별 출결 조회

========================================================================================*/

--프로시저
create or replace procedure proc_A_037 (
    popenProcessSeq number,      -- 특정 개설 과정 번호
    pstudentSeq number           -- 특정 교육생 번호
)
is
    cursor vcursor is
        select
            wd.openProcessSeq as opSeq,
            wd.studentSeq as sSeq,
            to_char(wd.weekDayDate, 'yyyy-mm-dd') as sDate,
            case
                when a.inTime is not null then to_char(a.intime, 'hh24:mi:ss')
                when a.inTime is null then 'NUll'
            end as sInTime,
            case
                when a.outTime is not null then to_char(a.outtime, 'hh24:mi:ss')
                when a.outTime is null then 'NUll'
            end as sOutTime,
            case
                when at.state is not null then at.state
                when a.inTime is null then '결석'
                when a.inTime > to_date(to_char(inTime, 'yyyy-mm-dd') || ' ' || '09:00:00', 'yyyy-mm-dd hh24:mi:ss') then '지각'
                when a.outTime < to_date(to_char(outTime, 'yyyy-mm-dd') || ' ' || '18:00:00', 'yyyy-mm-dd hh24:mi:ss') then '조퇴'
                else '출석'        
            end as sState,
            case
                when at.cause is not null then at.cause
                when at.cause is null then 'NULL'
            end as sCause
        from (
            select
                distinct
                wd.weekDayDate,
                a.openProcessSeq,
                a.studentSeq
            from (
                select
                    weekDayDate
                from (
                    select
                        (
                            select 
                                startDate
                            from tblOpenProcess
                            where seq = popenProcessSeq
                        )+ (LEVEL - 1) as weekDayDate
                    from
                        dual
                    connect by level <= (
                        select
                            case
                                when endDate < sysdate then endDate
                                else sysdate
                            end
                        from tblOpenProcess
                        where seq = popenProcessSeq       --특정 개설과정 선택
                    ) - (
                        select
                            startDate
                        from tblOpenProcess
                        where seq = popenProcessSeq       --특정 개설과정 선택
                    ) + 1
                )
            where to_char(weekDayDate, 'd') between 2 and 6
            ) wd, tblAttend a
            where a.openProcessSeq = popenProcessSeq       --특정 개설과정 선택
        ) wd
            left outer join (
                select
                    seq,
                    openProcessSeq,
                    studentSeq,
                    to_char(inTime, 'yy/mm/dd') as DT,
                    inTime,
                    outTime
                from tblAttend
            ) a
                on wd.weekDayDate = a.DT
                    and wd.openProcessSeq = a.openProcessSeq
                    and wd.studentSeq = a.studentSeq
            left outer join tblAttendState at
                on a.seq = at.attendSeq
        where wd.studentSeq = pstudentSeq                  --특정 교육생 선택
            and wd.openProcessSeq = popenProcessSeq   --특정 개설과정 선택
        order by wd.openProcessSeq asc, wd.weekDayDate asc;

    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[개설과정번호]' || ', ' || '[교육생번호]' || ', ' ||  '[날짜]' || ',   ' || '[입실시간]' || ',   ' || '[퇴실시간]' || ',   ' || '[상태]'|| ', ' || '[사유]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE( '      ' ||  vrow.opSeq           || ',          ' ||
                                vrow.sSeq           || ',    ' || 
                                vrow.sDate          || ', ' || 
                                vrow.sInTime        || ',   ' || 
                                vrow.sOutTime       || ',    ' ||
                                vrow.sState         || ',  ' ||
                                vrow.sCause);
    end loop;
    
end proc_A_037;

-- 호출
 call proc_A_037(1, 1001);



/*======================================================================================

        [A-038] 강의실별 PC 등록

========================================================================================*/

--프로시저
create or replace procedure proc_pc_insert (
    pclassRoomSeq number    -- 강의실 번호
)
is
    vclassRoomExist tblClassRoom.exist%type;    -- 강의실 존재여부
    vmax number;                                -- 강의실 최대인원
    vpcCnt number;                              -- 해당 강의실에 등록된 총 PC 수
    vresult number := 0;                        -- 성공 유무(0: 성공, 1: 실패)
begin
    -- 삭제된 강의실 번호는 입력할 수 없다.
    select exist into vclassRoomExist
        from tblClassRoom
        where seq = pclassRoomSeq;
        
    if vclassRoomExist = 'N' then
        vresult := 1; -- 실패
    end if;

    -- 해당 강의실에 이미 등록된 PC의 개수가 해당 강의실의 최대 인원수를 넘어갈 수 없다.
    select max into vmax
        from tblClassRoom
        where seq = pclassRoomSeq;

    select count(*) into vpcCnt
        from tblPC
        where classRoomSeq = pclassRoomSeq
            and exist = 'Y';
            
    if vpcCnt >= vmax then
        vresult := 1; -- 실패
    end if;        

    -- 결과 처리
    if vresult = 0 then -- 성공
        insert into tblPC (seq, classRoomSeq, pcTrouble, cause, exist)
            values (pcSeq.nextVal, pclassRoomSeq, default, null, default);
        commit;
        dbms_output.put_line('PC 추가 성공');
    else                -- 실패
        dbms_output.put_line('PC 추가 실패');
    end if;    
exception
    when others then
        rollback;
        dbms_output.put_line('PC 추가 실패');
end proc_pc_insert;

--호출
--call proc_pc_insert(1);


/*======================================================================================

        [A-039] PC 정보 수정

========================================================================================*/

--프로시저
create or replace procedure proc_pc_update (
    pseq number,        -- PC 번호
    psel varchar2,      -- 수정할 컬럼명
    pinput varchar2     -- 수정 내용
)
is
    vclassRoomExist tblClassRoom.exist%type;    -- 강의실 존재여부
    vmax number;                                -- 강의실 최대인원
    vpcCnt number;                              -- 해당 강의실에 등록된 총 PC 수
    vpcTrouble tblPC.pcTrouble%type;            -- 해당 PC 고장여부
begin
    -- 강의실 번호 수정
    if psel = 'classRoomSeq' then
        
        select exist into vclassRoomExist
            from tblClassRoom
            where seq = pinput;
        
        select max into vmax
            from tblClassRoom
            where seq = pinput;
    
        select count(*) into vpcCnt
            from tblPC
            where classRoomSeq = pinput
                and exist = 'Y';
        
        -- 강의실 번호를 삭제된 강의실 번호로 수정할 수 없다.
        if vclassRoomExist = 'N' then
            dbms_output.put_line('PC 정보 수정 실패');
        
        -- 이미 PC 수가 강의실 최대 인원수만큼 등록된 강의실 번호로 수정할 수 없다.
        elsif vpcCnt >= vmax then
            dbms_output.put_line('PC 정보 수정 실패');
        
        else
            update tblPC set classRoomSeq = pinput where seq = pseq;
            commit;
            dbms_output.put_line('PC 정보 수정 성공');
        end if;         
    
    -- 고장여부 수정
    elsif psel = 'pcTrouble' then
        update tblPC set pcTrouble = pinput where seq = pseq;
        commit;
        dbms_output.put_line('PC 정보 수정 성공');
    
    -- 고장원인 수정
    elsif psel = 'cause' then
        select pcTrouble into vpcTrouble
            from tblPC
            where seq = pseq;
        
        -- 고장여부가 'No'인 경우 고장원인을 null이 아닌 값으로 수정할 수 없다.
        if vpcTrouble = 'No' and pinput is not null then
            dbms_output.put_line('PC 정보 수정 실패');
            
        -- 고장여부가 'Yes'인 경우 고장원인을 null로 수정할 수 없다.
        elsif vpcTrouble = 'Yes' and pinput is null then
            dbms_output.put_line('PC 정보 수정 실패');

        else
            update tblPC set cause = pinput where seq = pseq;
            commit;
            dbms_output.put_line('PC 정보 수정 성공');
        end if;   
        
    else
        dbms_output.put_line('PC 정보 수정 실패');
    end if;
exception
    when others then
        rollback;
        dbms_output.put_line('PC 정보 수정 실패');
end proc_pc_update;

--호출
--call proc_pc_update(1, 'pcTrouble', 'No');



/*======================================================================================

        [A-040] PC 정보 삭제
        
========================================================================================*/

--프로시저
create or replace procedure proc_pc_delete (
    pseq number        -- PC 번호
)
is
begin
    update tblPC set exist = 'N' where seq = pseq;
    commit;
    dbms_output.put_line('PC 정보 삭제 성공');
exception
    when others then
        rollback;
        dbms_output.put_line('PC 정보 삭제 실패');
end proc_pc_delete;

--호출
--call proc_pc_delete(1);


/*======================================================================================

        [A-041] 강의실 정보 + 고장PC개수 조회
        
========================================================================================*/

--뷰
create or replace view vw_A_041
as
select
    cr.seq as "강의실번호",
    cr.name as "강의실명", 
    cr.max as "최대인원수",
    cr.os as "PC운영체제",
    pc.totalCnt as "PC 수",
    pc.troubleCnt as "고장PC 수"
from tblClassRoom cr
    inner join (
        select 
            classRoomSeq,
            count(*) as totalCnt,
            count(
                case 
                    when pcTrouble = 'Yes' then 1 
                end
            ) as troubleCnt
        from tblPC
        where exist = 'Y'
        group by classRoomSeq
    ) pc
        on cr.seq = pc.classRoomSeq
where cr.exist = 'Y'
order by cr.seq;

--호출
--select * from vw_A_041;



/*======================================================================================

        [A-042] 특정 강의실 PC 정보 조회
        
========================================================================================*/

--뷰
create or replace view vw_A_042 -- 전체 PC정보 조회
as
select
    pc.seq as pcSeq,
    cr.seq as classRoomSeq,
    pc.pcTrouble,
    case
        when pc.pcTrouble = 'No' then '정상'
        else pc.cause
    end as cause
from tblPC pc
    inner join tblClassRoom cr
        on pc.classRoomSeq = cr.seq
where cr.exist = 'Y'
    and pc.exist = 'Y'
order by pcSeq;

--프로시저
create or replace procedure proc_A_042 (    --특정 강의실 PC 정보 조회
    pclassRoomSeq number,       -- 강의실번호
    pcursor out sys_refcursor   -- 커서
)
is
begin
    open pcursor for
        select * from vw_A_042 where classRoomSeq = pclassRoomSeq;
end proc_A_042;

--호출

declare
    vcursor sys_refcursor;
    vrow vw_A_042%rowtype;
begin
    proc_A_042(1, vcursor);   --특정 강의실 > 1
    
    dbms_output.put_line('[강의실번호]' || ' [PC번호]' || ' [고장여부]' || ' [고장원인]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.classRoomSeq || ', ' || vrow.pcSeq || ', ' || vrow.pcTrouble || ', ' || vrow.cause);
    end loop;
end;



/*======================================================================================

        [A-043] 전체 고장PC 목록 조회
        
========================================================================================*/

-- 뷰
create or replace view vw_A_043
as
select
    pc.seq as "PC번호",
    cr.seq as "강의실번호",
    pc.cause as "고장원인"
from tblPC pc
    inner join tblClassRoom cr
        on pc.classRoomSeq = cr.seq
where cr.exist = 'Y'
    and pc.exist = 'Y'
    and pc.pcTrouble = 'Yes';

-- 호출
-- select * from vw_A_043;