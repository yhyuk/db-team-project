-- 교육생DML
set serveroutput on;  

/*===================================================================
                            인덱스
===================================================================*/  
create index idx_projcet on tblTeamProject(projectseq);
create index idx_attend on tblAttend(studentSeq, exist);
create index idx_process on tblProcess(exist);


/*===================================================================
                            함수
===================================================================*/
--성적 처리 함수
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


--프로젝트 progress 처리 함수
create or replace function fnProgress(
    fcnt number
)return number
is
begin
    return case
           when fcnt = 1 then '1단계'
           when fcnt = 2 then '2단계'
           when fcnt = 3 then '3단계'
           when fcnt = 4 then '4단계'
           when fcnt = 5 then '5단계'
        end;
end fnProgress;



/*===================================================================
                            트리거
===================================================================*/
create or replace trigger trg_LogTeamProject
    after
    update or delete
    on tblTeamProject
declare
    vmessage varchar2(1000);
begin

    -- 로그 내용
    if updating then
        vmessage := '프로젝트 진행상황이 변경되었습니다.';

  
    end if;
    
    insert into tblLogTeamProject(seq, message, regdate)
        values (seqLogTeamProject.nextVal, vmessage, default);

end trg_LogTeamProject;


/*======================================================================================

         [C-001]교육생 수강 정보 출력
         교육생 수강정보 출력에 관한 모든 기능을 포함한다.

========================================================================================*/

create or replace view vw_C_001
as
select 
    s.seq as seq,
    s.name as name,
    r.studentseq as studentseq,
    p.name as processname,
    '강의실' || o.classroomseq as classroom,
    o.startdate || ' ~ ' || o.enddate as processdate 
from tblProcess p
    inner join tblopenprocess o
        on p.seq = o.processseq
    inner join tblregstudent r
        on o.seq = r.openprocessseq
    inner join tblstudent s
        on r.studentseq = s.seq
        
where 
    --s.seq = 1001 and 
    s.exist = 'Y' 
        and r.exist = 'Y' 
        and o.exist = 'Y' 
        and p.exist = 'Y';
    

--프로시저
create or replace procedure proc_C_001 (
    pseq number,                 -- 과목 번호
    pcursor out sys_refcursor    --커서
)
is
begin
    open pcursor for
        select * from vw_C_001 where seq = pseq;
end proc_C_001;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_C_001%rowtype;
begin
    proc_C_001(1001, vcursor);   --특정교육생
    
    dbms_output.put_line('[이름]' || ' [교육생번호]' || ' [과정명]' || ' [강의실]' || ' [과정기간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name               || ', ' || 
                             vrow.studentseq         || ', ' || 
                             vrow.processname        || ', ' || 
                             vrow.classroom          || ', ' || 
                             vrow.processdate );
    
    end loop;
end;


select * from vw_C_001;
        
        
        

/*======================================================================================

         [C-002]교육생 과목별 성적 정보 출력

========================================================================================*/
-- 프로시저
create or replace procedure proc_C_002 (
    pstudentseq number         -- 교육생 번호
)
is
    cursor vcursor is 
        select 
            o.seq as SubjeectNum,  
            s.name as name,
            t.name as Tname,  
            j.name as Subname,
            o.startdate ||' ~ '||o.enddate as processdate,
            b.name as book,
            c.attend as att,
            c.write as wri,
            c.perform as per,
            c.task as tas,
            (
                select 
                    fnavgscore(c.attend, p.attend,c.write, p.write, c.perform, p.perform, c.task, p.task)
                from tblScore 
                where 
                    studentseq = pstudentseq 
                    and
                    opensubjectseq = 1
            ) as avgg
        from tblStudent s
            left outer join tblScore c
                on s.seq = c.studentseq
            left outer join tblOpenSubject o
                on c.opensubjectseq = o.seq
            left outer join tblSubject j
                on o.subjectseq = j.seq
            left outer join tblBook b
                on o.bookseq = b.seq
            left outer join tblteacher t
                on o.teacherseq = t.seq
            left outer join tblPoint p
                on o.seq = p.opensubjectseq
        where s.seq = pstudentseq and 
            o.exist = 'Y' 
                and s.exist = 'Y' 
                and c.exist = 'Y' 
                and j.exist = 'Y' 
                and b.exist = 'Y'
                and t.exist = 'Y' 
                and p.exist = 'Y' 
        order by o.seq asc ;

   vrow vcursor%rowtype;
   
begin

    for vrow in vcursor loop
    dbms_output.put_line(vrow.SubjeectNum   || ', ' || 
                         vrow.name          || ', ' || 
                         vrow.Tname         || ', ' ||
                         vrow.Subname       || ', ' || 
                         vrow.processdate   || ', ' || 
                         vrow.book          || ', ' || 
                         vrow.att           || ', ' || 
                         vrow.wri           || ', ' || 
                         vrow.per           || ', ' || 
                         vrow.tas           || ', ' || 
                         vrow.avgg);
                                            
    end loop;
end proc_C_002;


   
--호출     
call proc_C_002(1001);      --특정교육생 번호



/*======================================================================================

         [C-003] 출결 입력

         1.[교육생 > 출결 관리 및 출결 조회 > 출결 입력]

========================================================================================*/


--프로시저 (출결입력)
create or replace procedure proc_Attend_insert(
    pseq tblAttend.seq%type,
    popenprocessseq tblAttend.openprocessseq%type,
    pstudentseq tblAttend.studentseq%type,
    pintime tblAttend.intime%type,
    pouttime tblAttend.outtime%type,
    pexist tblAttend.exist%type
)
is  
begin
    
    insert into tblAttend (seq, openprocessseq, studentseq, intime, outtime, exist)
        values (pseq, popenprocessseq, pstudentseq, pintime, pouttime, pexist);
        
        commit;
        dbms_output.put_line('출결 성공');
    
exception
    when others then
        rollback;
        dbms_output.put_line('출결 실패');
    
end proc_Attend_insert;


--호출
call proc_Attend_insert(attendSeq.nextVal, 1, 1001, to_date('2021-02-13 08:35', 'yyyy-mm-dd hh24:mi'), 
                        to_date('2021-02-13 00:00', 'yyyy-mm-dd hh24:mi'), 'Y');

-- 출결 확인 뷰
select * from vw_C_003;





--프로시저 (퇴실체크)
create or replace procedure proc_Attend_update(
  pnum in tblAttend.seq%type,   -- 출결 Seq
  psel in varchar2,             -- outtime선택       
  pintime in varchar2           -- 퇴실 시간  
)
is
begin
     -- outtime에 퇴실 시간을 넣어줌
      if psel = 'outtime' then update tblAttend set outTime = pintime where seq = pnum;               
      
      commit;
      end if;
      
      dbms_output.put_line('퇴실체크 완료');
    
exception

      when others then
      rollback;
      dbms_output.put_line('퇴실체크 실패');
    
end proc_Attend_update;   


--프로시저 호출
call proc_Attend_update(845,'outTime', to_date('18:00', 'hh24:mi'));



-- 퇴실 확인 뷰
select * from vw_C_003;



-- 1001번 교육생 출결 상태 뷰 생성
create view vw_C_003
as
select * from tblAttend where studentseq = 1001;







--프로시저(외출시 사유 입력)
create or replace procedure proc_Attendstate_insert(
    pseq tblAttendState.seq%type,
    pattendSeq tblAttendState.attendSeq%type,
    pstate tblAttendState.state%type,
    pcause tblAttendState.cause%type,
    pexist tblAttendState.exist%type
)
is  
begin

    insert into tblAttendState (seq, attendSeq, state, cause, exist)
        values (pseq, pattendSeq, pstate, pcause, pexist);
        
    commit;
    
        dbms_output.put_line('등록 성공');
    
exception
    when others then
        rollback;
        dbms_output.put_line('등록 실패');
    
end proc_Attendstate_insert;



--호출
call proc_Attendstate_insert(stateSeq.nextVal,31,'외출','은행업무','Y');

select * from tblAttendstate;


-- 확인
select * from tblAttend where studentseq = 1001;


/*======================================================================================

        [C-004]출결 조회

        1. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 전체조회]
        2. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 일별조회]
        3. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 월별 조회]

========================================================================================*/

--1. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 전체조회]
-- 프로시저
create or replace procedure proc_C_004 (
    pStudnetseq number         -- 학생 번호
)
is
cursor vcursor is 

    select
        to_char(wd.weekDayDate, 'yyyy-mm-dd') as weekDate,
        to_char(a.inTime, 'hh24:mi:ss') as intime,
        to_char(a.outTime, 'hh24:mi:ss') as outTime,
        case
            when at.state is not null then at.state
            when a.inTime is null then '결석'
            when a.inTime > to_date(to_char(inTime, 'yyyy-mm-dd')   || ' ' || '09:00:00', 'yyyy-mm-dd hh24:mi:ss') then '지각'
            when a.outTime < to_date(to_char(outTime, 'yyyy-mm-dd') || ' ' || '18:00:00', 'yyyy-mm-dd hh24:mi:ss') then '조퇴'
            else '출석'        
        end as attendstate,
        at.cause as cause
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
                        where seq = 1
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
                    where seq = 1       --특정 개설과정 선택
                ) - (
                    select
                        startDate
                    from tblOpenProcess
                    where seq = 1       --특정 개설과정 선택
                ) + 1
            )
        where to_char(weekDayDate, 'd') between 2 and 6
        ) wd, tblAttend a
        where a.openProcessSeq = 1
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
    where wd.studentSeq = pStudnetseq      --특정 교육생 선택
        and wd.openProcessSeq = 1          --특정 개설과정 선택
    order by wd.openProcessSeq asc, wd.weekDayDate asc;

    vrow vcursor%rowtype;
begin

    dbms_output.put_line(' [날짜]' || ' [입실시간]' || ' [퇴실시간]' || ' [출결상태]' || ' [사유]' );
    
    for vrow in vcursor loop
        
        dbms_output.put_line(vrow.weekDate       || ', ' || 
                             vrow.intime         || ', ' || 
                             vrow.outTime        || ', ' || 
                             vrow.attendstate    || ', ' || 
                             vrow.cause);
  
    end loop;
    
end proc_C_004;
        

-- 호출
call proc_C_004(1001);



--2. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 일별조회]
   
-- 프로시저
create or replace procedure proc_C_004_1 (
    pStudnetseq number         -- 학생 번호
)
is
    cursor vcursor is
    select
        count(decode(attendState, '출석', 1)) as attend,
        count(decode(attendState, '결석', 1)) as notAttend,
        count(decode(attendState, '지각', 1)) as rate,
        count(decode(attendState, '조퇴', 1)) as leaveEarly,
        count(decode(attendState, '외출', 1)) as out,
        count(decode(attendState, '병가', 1)) as pain,
        count(decode(attendState, '기타', 1)) as other
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
                            where seq = 1 and exist = 'Y'
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
                        where seq = 1       --특정 개설과정 선택
                    ) - (
                        select
                            startDate
                        from tblOpenProcess
                        where seq = 1 and exist = 'Y'    --특정 개설과정 선택
                    ) + 1
                )
            where to_char(weekDayDate, 'd') between 2 and 6
            ) wd, tblAttend a
            where a.openProcessSeq = 1 and a.exist = 'Y'
        ) wd
            left outer join (
                select
                    seq,
                    openProcessSeq,
                    studentSeq,
                    to_char(inTime, 'yy/mm/dd') as DT,
                    inTime,
                    outTime
                from tblAttend  where inTime between to_date('2021-02-03','YYYY-MM-DD') 
                                             and to_date('2021-02-05','YYYY-MM-DD')             -- 해당 기간만 조회
            ) a
                on wd.weekDayDate = a.DT
                    and wd.openProcessSeq = a.openProcessSeq
                    and wd.studentSeq = a.studentSeq
            left outer join tblAttendState at
                on a.seq = at.attendSeq    
    )
    where openProcessSeq = 1 and studentSeq = pStudnetseq
    group by studentSeq
    order by studentSeq;


    vrow vcursor%rowtype;
begin

    dbms_output.put_line(' [출석]' || ' [결석]' || ' [지각]' || ' [조퇴]' || ' [외출]' || ' [병가]'  || ' [기타]' );
    for vrow in vcursor loop
        
        dbms_output.put_line(vrow.attend       || ', ' || 
                             vrow.notAttend    || ', ' || 
                             vrow.rate         || ', ' || 
                             vrow.leaveEarly   || ', ' || 
                             vrow.out          || ', ' || 
                             vrow.pain         || ', ' || 
                             vrow.other);
   
        
    end loop;
    
end proc_C_004_1;
        

-- 호출
call proc_C_004_1(1001);



-- 3. [교육생 > 출결 관리 및 출결 조회 > 출결조회 > 월별 조회]
-- 프로시저
create or replace procedure proc_C_004_2 (
    pStudnetseq number         -- 학생 번호
)
is
    cursor vcursor is     
    select
        count(decode(attendState, '출석', 1)) as attend,
        count(decode(attendState, '결석', 1)) as notAttend,
        count(decode(attendState, '지각', 1)) as rate,
        count(decode(attendState, '조퇴', 1)) as leaveEarly,
        count(decode(attendState, '외출', 1)) as out,
        count(decode(attendState, '병가', 1)) as pain,
        count(decode(attendState, '기타', 1)) as other
    from (
        select
            wd.weekDayDate,
            wd.openProcessSeq,
            wd.studentSeq,
            case
                when at.state is not null then at.state
                when a.inTime is null then '결석'
                when a.inTime > to_date(to_char(inTime, 'yyyy-mm-dd')   || ' ' || '09:00:00', 'yyyy-mm-dd hh24:mi:ss') then '지각'
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
                            where seq = 1 and exist = 'Y'
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
                        where seq = 1       --특정 개설과정 선택
                    ) - (
                        select
                            startDate
                        from tblOpenProcess
                        where seq = 1 and exist = 'Y'    --특정 개설과정 선택
                    ) + 1
                )
            where to_char(weekDayDate, 'd') between 2 and 6
            ) wd, tblAttend a
            where a.openProcessSeq = 1 and a.exist = 'Y'
        ) wd
            left outer join (
                select
                    seq,
                    openProcessSeq,
                    studentSeq,
                    to_char(inTime, 'yy/mm/dd') as DT,
                    inTime,
                    outTime
                from tblAttend  where substr(intime, 5, 1 ) = 2   -- 해당 월만 조회
            ) a
                on wd.weekDayDate = a.DT
                    and wd.openProcessSeq = a.openProcessSeq
                    and wd.studentSeq = a.studentSeq
            left outer join tblAttendState at
                on a.seq = at.attendSeq    
    )
    where openProcessSeq = 1 and studentSeq = 1001
    group by studentSeq
    order by studentSeq;

    vrow vcursor%rowtype;
    
begin

    dbms_output.put_line(' [출석]' || ' [결석]' || ' [지각]' || ' [조퇴]' || ' [외출]' || ' [병가]'  || ' [기타]' );
    
    for vrow in vcursor loop
        
        dbms_output.put_line(vrow.attend       || ', ' || 
                             vrow.notAttend    || ', ' || 
                             vrow.rate         || ', ' || 
                             vrow.leaveEarly   || ', ' || 
                             vrow.out          || ', ' || 
                             vrow.pain         || ', ' || 
                             vrow.other);
 
    end loop;
    
end proc_C_004_2;
        

-- 호출
call proc_C_004_2(1001);

/*======================================================================================

        [C-005] 프로젝트 관리

========================================================================================*/
-- 뷰 (전체과목 프로젝트 조회)
create or replace view vw_C_005
as
select
   studentseq,
   j.seq as projectnum,
   u.name as name,
   j.title as title,
   j.startdate || ' ~ ' || j.enddate as projectdate

from tblRegStudent r
    inner join tblOpenProcess o
        on r.openprocessseq = o.seq
    inner join tblOpenSubject s
        on o.seq = s.openprocessseq
    inner join tblSubject u
        on s.subjectseq = u.seq
    inner join tblProcess p
        on o.processseq = p.seq
    inner join tblProject j
        on u.seq = j.opensubjectseq  

order by j.seq asc;



--프로시저
create or replace procedure proc_C_005 (
    pseq number,                 -- 과목 번호
    pcursor out sys_refcursor    --커서
)
is
begin
    open pcursor for
        select * from vw_C_005 where studentseq = pseq;
end proc_C_005;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_C_005%rowtype;
begin
    proc_C_005(1001, vcursor);   --특정과목 > 프로그래밍 기초
    
    dbms_output.put_line('[프로젝트 번호]' || ' [과목명]' || ' [프로젝트 명]' || ' [프로젝트 기간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.projectnum || ', ' || 
                             vrow.name       || ', ' || 
                             vrow.title      || ', ' || 
                             vrow.projectdate);
    
    end loop;
end;




/*======================================================================================

        [C-006]프로젝트 진행상황
        프로젝트 관리에 관한 모든 기능을 포함한다.

        1. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 수정]
        2. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 출력]
        3. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 삭제]

========================================================================================*/

-- 1. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 수정]
-- 프로젝트 진행상황 수정 프로시저
create or replace procedure proc_teamproject_update(
  pnum in tblTeamProject.seq%type,  --지정하는 과정 번호
  psel in varchar2,                 --수정할컬럼명
  pinput in varchar2                --수정 내용
)
is
begin
     --1. 학생의 프로젝트 진행상황 변경
      if psel = 'name' then update tblTeamProject set name = pinput where seq = pnum;               --프로젝트 제출명 수정
      elsif psel = 'content' then update tblTeamProject set content = pinput where seq = pnum;      --프로젝트 내용 수정
      elsif psel = 'progress' then update tblTeamProject set progress = pinput where seq = pnum;    --진행상황 수정
      elsif psel = 'issubmit' then update tblTeamProject set issubmit = pinput where seq = pnum;    --제출여부 수정
      
      commit;
      end if;
      
      dbms_output.put_line('프로젝트 진행상황 수정 완료');
    
exception

      when others then
      rollback;
      dbms_output.put_line('프로젝트 진행상황 수정 실패');
    
end proc_teamproject_update;   


--프로시저 호출
call proc_teamproject_update(1,'name','1조제일잘해');
call proc_teamproject_update(1,'content','첫번째 자바 프로젝트입니다');
call proc_teamproject_update(1,'progress',5);
call proc_teamproject_update(1,'issubmit','Yes');

--진행상황 확인
call proc_C_006(1001);


-- 2. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 출력

-- 프로시저
create or replace procedure proc_C_006 (
    pstudentseq number  
)
is
    cursor vcursor is 
    select
        seq as sseq,
        projectseq as examNum,
        name as examName,
        content as examdate,
--        case
--            when progress = 1 then '1단계'
--            when progress = 2 then '2단계'
--            when progress = 3 then '3단계'
--            when progress = 4 then '4단계'
--            when progress = 5 then '5단계'
--        end as examwrite,
        fnProgress(progress) as examwrite,
        issubmit as examper
    from tblTeamProject 
    where projectSeq in (
            select
                p.seq 
            from tblRegStudent rs
                inner join tblOpenProcess op
                    on rs.openProcessSeq = op.seq
                inner join tblOpenSubject os
                    on op.seq = os.openProcessSeq
                inner join tblProject p
                    on os.seq = p.openSubjectSeq
                where rs.studentSeq = pstudentseq
        )
        and teamSeq in (
            select
                teamSeq 
            from tblTeamDiv
            where
            studentSeq = pstudentseq and 
            exist = 'Y'
        );
        vrow vcursor%rowtype;
        
begin
     dbms_output.put_line('[프로젝트번호]' || ' [팀명]' || ' [내용]' || ' [진행상황]' || ' [제출여부]' );
    for vrow in vcursor loop
       dbms_output.put_line(vrow.sseq       || ', ' || 
                            vrow.examName   || ', ' || 
                            vrow.examdate   || ', ' || 
                            vrow.examwrite  || ', ' || 
                            vrow.examper);
        
    end loop;
    
end proc_C_006; 
    

--호출
call proc_C_006(1001);



-- 3. [교육생 > 프로젝트 관리 > 프로젝트 진행상황 삭제]

-- 교육생이 제출한 프로젝트를 default값으로 되돌리는 프로시저
-- 프로시저
create or replace procedure proc_teamproject_update_del(
  pnum in tblTeamProject.seq%type,  --지정하는 과정 번호
  psel in varchar2                --수정할컬럼명
)
is
begin
     --1. 학생의 프로젝트 진행상황 변경
      if  psel = 'progress' then update tblTeamProject set progress = default where seq = pnum;      --진행상황
      elsif psel = 'issubmit' then update tblTeamProject set issubmit = default where seq = pnum;    --제출여부
      
      commit;
      end if;
      
      dbms_output.put_line('프로젝트 진행상황 수정 완료');
    
exception

      when others then
      rollback;
      dbms_output.put_line('프로젝트 진행상황 수정 실패');

end proc_teamproject_update_del;   



call proc_teamproject_update_del(1,'progress');
call proc_teamproject_update_del(1,'issubmit');


select * from tblTeamProject;



-- 트리거 (프로젝트 진행상황 수정/삭제 시)
drop trigger trg_LogTeamProject;


create table tblLogTeamProject(
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);
    
create sequence seqLogTeamProject;
drop sequence seqLogTeamProject;


--로그 확인
select * from tblLogTeamProject;


/*======================================================================================

        [C-007]시험목록조회

========================================================================================*/

--프로시저
create or replace procedure proc_C_007 (
    pstudentseq number         
)
is
    cursor vcursor is 
    select 
        exam.seq as examNum,
        s.name as examName,
        exam.regdate as examdate,
        exam.writedate as examwrite,
        exam.performdate as examper
    from (
        select 
            * 
        from tblexam e
        
    where e.opensubjectseq 
        in(
            select seq 
            from tblopensubject 
            where openprocessseq 
            
            in(
                select openProcessSeq
                from tblregstudent
               where studentseq = pstudentseq --특정수강생 번호
            )
        )
    ) exam
        left outer join tblOpenSubject o
            on exam.openSubjectSeq = o.seq
        left outer join tblSubject s
            on o.subjectseq = s.seq
    order by  exam.seq asc;
    
    vrow vcursor%rowtype;
    
begin
    dbms_output.put_line('[시험번호]' || ' [과목명]' || ' [시험등록날짜]' || ' [필기시험일]' || ' [실기시험일]');
    
    for vrow in vcursor loop
        dbms_output.put_line(vrow.examNum    || ', ' || 
                             vrow.examName   || ', ' || 
                             vrow.examdate   || ', ' || 
                             vrow.examwrite  || ', ' || 
                             vrow.examper);
    end loop;
end proc_C_007; 
    

--호출
call proc_C_007(1001);


/*======================================================================================

        [C-008] 특정 과목 시험목록조회

========================================================================================*/
--뷰
create or replace view vw_C_008
as
select 
distinct
    o.subjectseq as subjectseq, 
    q.seq as seq,
    s.name as name,
    q.question as question

from tblOpenSubject o
    inner join tblExam e
        on o.seq = e.opensubjectseq
    inner join tblquestion q
        on e.seq = q.examseq
    inner join tblSubject s
        on o.subjectSeq = s.seq
    inner join tblAttend a
        on o.seq = a.openprocessseq
    where 
        o.exist = 'Y' 
        and e.exist = 'Y' 
        and q.exist = 'Y' 
        and s.exist = 'Y'     
order by q.seq asc;        
  


--프로시저
create or replace procedure proc_C_008 (
    pseq number,                 -- 과목 번호
    pcursor out sys_refcursor    --커서
)
is
begin
    open pcursor for
        select * from vw_C_008 where subjectseq = pseq;
end proc_C_008;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_C_008%rowtype;
begin
    proc_C_008(1, vcursor);   --특정과목 > 프로그래밍 기초
    
    dbms_output.put_line('[문제번호]' || ' [과목명]' || ' [문제]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
    dbms_output.put_line(vrow.seq        || ', ' || 
                         vrow.name       || ', ' || 
                         vrow.question);
    
    end loop;
end;
