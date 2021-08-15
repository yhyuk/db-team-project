-- 교사DML
set serveroutput on;


/*===================================================================
                            인덱스
===================================================================*/
create index idx_student on tblStudent(exist);                  -- 교육생 데이터 유무
create index idx_attend on tblAttend(studentSeq, exist);        -- 출결테이블의 교육생 번호, 데이터 유무
create index tblOpenSubject on tblOpenSubject(teacherSeq);      -- 교사가 수업하는 과목
create index idx_tblTeamProject_fk on tblTeamProject(teamSeq);  -- 프로젝트 PK(부모) = FK(자식)


/*===================================================================
                            함수
===================================================================*/
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

-- 전공 비전공 표현하기 함수
create or replace function fn_B_021_2 (
    pismajor varchar2
) return varchar2
is
begin
    return case
        when pismajor = 'Yes' then '전공'
        when pismajor = 'No' then '비전공'
    end;
end;

-- 프로젝트 진행단계 표시하기 함수
create or replace function fn_project (
    pprogress number
) return varchar2
is
begin
    return case
        when pprogress = 1 then '0%'
        when pprogress = 2 then '25%'
        when pprogress = 3 then '50%'
        when pprogress = 4 then '75%'
        when pprogress = 5 then '100%'
    end;
    
end;


/*===================================================================
                            트리거
===================================================================*/
create or replace trigger trgProject_update
    after
    update 
    on tblProject
declare
begin
    dbms_output.put_line('프로젝트 정보가 변경/삭제되었습니다.');
end;

create or replace trigger trgTeam_insert
    before
    insert
    on tblTeam 
declare
begin
        dbms_output.put_line('팀이 등록 되었습니다.');
end;

create or replace trigger trgTeam_update
    before -- 사건 전(before)/후(after) -> 언제 트리거가 개입할지 정함
    update -- 감시 사건
    on tblTeam -- 감시 대상
    for each row
declare
begin
    dbms_output.put_line(:old.openSubjectSeq|| '번 과목의 ' || :old.seq ||'팀 정보가 수정되었습니다.');
end;


/*======================================================================================

        [B-001] 강의스케줄 조회
        1. 교사 자신의 강의스케줄 정보 조회 기능이 있다
        2. 교사 자신의 가르키는 과목의 수강생 정보 조회가 있다.

========================================================================================*/

-- 1. 교사 자신의 강의스케줄 정보 조회 기능이 있다
-- 뷰
create or replace view vw_B_001_1
as
select 
    t.seq as tSeq,
    p.name as pName,
    s.name as sName,
    s.common as sCommon,
    s.difficulty as sDifficulty,
    op.startDate || ' ~ ' || op.endDate as pPriod,
    os.startDate || ' ~ ' || os.endDate as sPriod
from tblOpenSubject os
    inner join tblSubject s
        on os.subjectseq = s.seq
    inner join tblTeacher t
        on os.teacherseq = t.seq
    inner join tblOpenProcess op
        on os.openprocessseq = op.seq
    inner join tblProcess p
        on op.processseq = p.seq
where 
    os.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y'
order by op.startDate ASC, os.startDate ASC;
    
-- 프로시저
create or replace procedure proc_B_001_1 (
    pteacherSeq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_001_1 where tSeq = pteacherSeq;
end proc_B_001_1;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_001_1%rowtype;
begin
    proc_B_001_1(2, vcursor); --교사 자신의 번호
    DBMS_OUTPUT.PUT_LINE('[과정명]' || ', ' || '[과목명]' || ', ' || '[공통과목여부]' || ', ' || '[난이도]' || ', ' || '[과정기간]' || ', ' || '[과목기간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.pName          || ', ' || 
                                vrow.sName          || ', ' || 
                                vrow.sCommon        || ', ' || 
                                vrow.sDifficulty    || ', ' || 
                                vrow.pPriod         || ', ' || 
                                vrow.sPriod     );
    end loop;
end;

-- 뷰 --> 교사 자신이 교육하고 있는 과목명
create or replace view vw_B_001_2_list
as
select
    os.seq as "개설과목번호",
    s.name as "개설과목명",
    p.name as "개설과정명"
from tblOpenSubject os
    inner join tblSubject s
        on os.subjectseq = s.seq
    inner join tblTeacher t
        on os.teacherseq = t.seq
    inner join tblOpenProcess op
        on os.openprocessseq = op.seq
    inner join tblProcess p
        on op.processseq = p.seq
where 
    os.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y'
    and t.seq = 2
order by os.seq ASC;

-- 출력 --> 교사 자신이 교육하고 있는 과목명
select * from vw_B_001_2_list;


select * from tblopensubject;


-- 2. 교사 자신의 가르키는 과목의 수강생 정보 조회가 있다.
-- 뷰
create or replace view vw_B_001_2
as
select
    t.seq as tSeq,
    os.seq as osSeq,
    st.seq as stSeq,
    st.name as stName,
    st.email as stEmail,
    st.tel as stTel,
    st.school as stSchool,
    st.major as stMajor,
    s.name as sName
from tblOpenSubject os
    inner join tblSubject s
        on os.subjectSeq = s.seq
    inner join tblOpenProcess op
        on os.openprocessSeq = op.seq
    inner join tblTeacher t
        on os.teacherseq = t.seq
    inner join tblregstudent r
        on r.openProcessSeq = op.seq
    inner join tblStudent st
        on st.seq = r.studentseq
where 
    os.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and op.exist = 'Y'
    and r.exist = 'Y'
    and st.exist = 'Y'
order by st.seq ASC;    
   
-- 프로시저
create or replace procedure proc_B_001_2 (
    pteacherSeq number,
    popenProcessSeq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_001_2 where tSeq = pteacherSeq and osSeq = popenProcessSeq;
end proc_B_001_2;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_001_2%rowtype;
begin
    proc_B_001_2(1, 1, vcursor); -- 교사 자신의 번호, 교사 자신이 가르키는 과목 번호
    DBMS_OUTPUT.PUT_LINE('[번호]' || ', ' || '[이름]' || ', ' || '[이메일]' || ', ' || '[전화번호]' || ', ' || '[졸업학교]' || ', ' || '[전공]' || ', ' || '[과목명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.stSeq      || ', ' || 
                                vrow.stName     || ', ' || 
                                vrow.stEmail    || ', ' || 
                                vrow.stTel      || ', ' || 
                                vrow.stSchool   || ', ' || 
                                vrow.stMajor    || ', ' || 
                                vrow.sName  );
    end loop;
    
end;


/*======================================================================================

        [B-002] 강의스케줄 조회
        1. 교사는 자신이 교육중인 과목과 해당 과목이 속한 과정에 대한 정보를 확인할 수 있다.
        2. 교사는 자신이 교육중인 과목에 속하는 과정에 대한 각 과정의 수강 인원수를 확인 할 수 있다.

========================================================================================*/

-- 1. 교사는 자신이 교육중인 과목과 해당 과목이 속한 과정에 대한 정보를 확인할 수 있다.
-- 뷰
create or replace view vw_B_002_1
as
select
    t.seq as tSeq,
    t.name as tName,
    p.name as pName,
    s.name as sName,
    c.name as cName,
    p.month || '개월' as pMonth,
    op.startDate || ' ~ ' || op.endDate as opPriod,
    op.seq as opNum
from tblOpenSubject os
    inner join tblTeacher t
        on os.teacherSeq = t.seq
    inner join tblOpenProcess op
        on os.openprocessSeq = op.seq
    inner join tblProcess p
        on op.processSeq = p.seq
    inner join tblSubject s
        on os.subjectseq = s.seq
    inner join tblClassRoom c
        on op.classRoomSeq = c.seq
where 
    os.exist = 'Y'
    and t.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y'
    and s.exist = 'Y'
    and c.exist = 'Y'
order by op.startDate ASC;
    
-- 프로시저
create or replace procedure proc_B_002_1 (
    pteacherSeq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_002_1 where tSeq = pteacherSeq;
end proc_B_002_1;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_002_1%rowtype;
begin
    proc_B_002_1(2, vcursor); --교사 자신의 번호
    DBMS_OUTPUT.PUT_LINE('[교사명]' || ', ' || '[과정명]' || ', ' || '[과목명]' || ', ' || '[강의실명]' || ', ' || '[과정 개월수]' || ', ' || '[과정기간]' || ', ' || '[과정번호]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.tName      || ', ' || 
                                vrow.pName      || ', ' || 
                                vrow.sName      || ', ' || 
                                vrow.cName      || ', ' || 
                                vrow.pMonth     || ', ' || 
                                vrow.opPriod    || ', ' ||    
                                vrow.opNum  );
    end loop;
    
end;


-- 2. 교사는 자신이 교육중인 과목에 속하는 과정에 대한 각 과정의 수강 인원수를 확인 할 수 있다.
-- 프로시저
create or replace procedure proc_B_002_2 (
    pteacherSeq number         -- 교사 번호
)
is
    cursor vcursor is 
        select 
            op.seq as opSeq,
            p.name as pName,
            c.name as cName,
            rs.cnt as stCount,
            op.startDate || ' ~ ' || op.endDate as opPriod
        from tblOpenProcess op
            inner join tblProcess p
                on op.processSeq = p.seq
            inner join (
                            select
                                openProcessSeq,
                                count(*) as cnt
                            from tblRegStudent
                            where tblRegStudent.exist = 'Y'
                            group by openProcessSeq
                        ) rs
                on op.seq = rs.openProcessSeq
            inner join tblClassRoom c
                on op.classRoomSeq = c.seq
        where
            op.seq in (
                            select
                                distinct openProcessSeq
                            from tblOpenSubject os
                            where 
                                os.teacherSeq = pteacherSeq
                                and os.exist = 'Y'
        
                      )
            and op.exist = 'Y'
            and p.exist = 'Y'
            and c.exist = 'Y'
        order by op.startDate ASC;
        
    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[과정명]' || ', ' || '[강의실명]' || ', ' || '[수강 총 인원 수]' || ', ' || '[과정기간]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE(   vrow.opSeq      || ', ' || 
                                vrow.pName      || ', ' || 
                                vrow.cName      || ', ' || 
                                vrow.stCount    || ', ' || 
                                vrow.opPriod    );
    end loop;
    
end proc_B_002_2;

-- 호출
-- call proc_B_002_2(2);

/*======================================================================================

        [B-003] 강의스케줄 조회
        1. 교사는 과정별 수강생 정보를 보기 위해 자신이 속한 개설 과정을 조회한다. 
        2. 특정 과정 선택 시 해당 과정을 수강중인 교육생들의 정보를 조회할 수 있다.

========================================================================================*/

-- 1. 교사는 과정별 수강생 정보를 보기 위해 자신이 속한 개설 과정을 조회한다. 
-- 프로시저
create or replace procedure proc_B_003_1 (
    pteacherSeq number         -- 교사 번호
)
is
    cursor vcursor is 
        select 
            p.name as pName,
            op.seq as opSeq
        from tblOpenProcess op
            inner join tblProcess p
                on op.processSeq = p.seq
            inner join (
                            select
                                openProcessSeq,
                                count(*) as cnt
                            from tblRegStudent
                            where tblRegStudent.exist = 'Y'
                            group by openProcessSeq
                        ) rs
                on op.seq = rs.openProcessSeq
        where
            op.seq in (
                            select
                                distinct openProcessSeq
                            from tblOpenSubject
                            where
                                tblOpenSubject.exist = 'Y'
                                and teacherSeq = pteacherSeq
                                
                      )
            and op.exist = 'Y'
            and p.exist = 'Y'
        order by op.startDate ASC;
        
    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[개설과정명]' || ', ' || '[개설과정번호]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE( vrow.pName || ', ' || vrow.opSeq );
    end loop;
    
end proc_B_003_1;

-- 호출
-- call proc_B_003_1(2);



-- 2. 특정 과정 선택 시 해당 과정을 수강중인 교육생들의 정보를 조회할 수 있다.
-- 프로시저
create or replace procedure proc_B_003_2 (
    pteacherSeq number,         -- 교사 번호
    popenProcessSeq number      -- 개설 과정 번호
)
is
    cursor vcursor is
        select
            st.seq as stSeq,
            st.name as stName,
            st.email as stEmail,
            st.tel as stTel,
            st.school as stSchool,
            st.major as stMajor,
            func_B_003_2(r.isMajor) as isMajor
        from tblOpenProcess op
            inner join tblRegStudent r
                on r.openProcessSeq = op.seq
            inner join tblStudent st
                on st.seq = r.studentseq
            inner join (
                            select 
                                distinct r.openProcessSeq
                            from tblRegStudent r
                            where r.exist = 'Y'
                        ) rp
                on op.seq = rp.openProcessSeq
        where 
            op.seq in (
                            select
                                distinct openProcessSeq
                            from tblOpenSubject os
                            where
                                os.exist = 'Y'
                                and teacherSeq = pteacherSeq  -- 교사 번호
                      )
            and op.exist = 'Y'
            and r.exist = 'Y'
            and st.exist = 'Y'
            and op.seq = popenProcessSeq  -- 개설과정번호
        order by st.seq ASC;
        
    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[번호]' || ', ' || '[이름]' || ', ' || '[이메일]' || ', ' || '[전화번호]' || ', ' || '[졸업학교]' || ', ' || '[전공]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE(   vrow.stSeq      || ', ' || 
                                vrow.stName     || ', ' || 
                                vrow.stEmail    || ', ' || 
                                vrow.stTel      || ', ' || 
                                vrow.stSchool   || ', ' || 
                                vrow.stMajor    || ', ' ||
                                vrow.isMajor);
    end loop;
    
end proc_B_003_2;

-- 호출
-- call proc_B_003_2(2, 1);


















/*======================================================================================

        [B-012] 출결 관리 및 출결 조회
        1. 특정 과정을 듣는 모든 교육생들의 출결 현황을 조회할 수 있다.
        2. 특정 과정을 듣는 특정 교육생의 출결 현황을 조회할 수 있다.

========================================================================================*/

-- 1. 특정 과정을 듣는 모든 교육생들의 출결 현황을 조회할 수 있다.
--프로시저
create or replace procedure proc_B_012_1 (
    popenProcessSeq number      -- 개설 과정 번호
)
is
    cursor vcursor is
        select
            studentSeq as sSeq,
            count(decode(attendState, '출석', 1)) as sAttend,
            count(decode(attendState, '결석', 1)) as sAbsent,
            count(decode(attendState, '지각', 1)) as sLate,
            count(decode(attendState, '조퇴', 1)) as sLeave,
            count(decode(attendState, '외출', 1)) as sGoing,
            count(decode(attendState, '병가', 1)) as sSick,
            count(decode(attendState, '기타', 1)) as sExcep
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
                                                from tblOpenProcess op
                                                where seq = popenProcessSeq and op.exist = 'Y'
                                        ) - (
                                                select
                                                    startDate
                                                from tblOpenProcess op
                                                where seq = popenProcessSeq and op.exist = 'Y'     
                                        ) + 1
                                    )
                                where to_char(weekDayDate, 'd') between 2 and 6
                            ) wd, tblAttend a
                    where a.openProcessSeq = popenProcessSeq and a.exist = 'Y'       
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
        where openProcessSeq = popenProcessSeq and a.exist = 'Y' and at.exist = 'Y'        --특정 개설과정 선택
        group by studentSeq
        order by studentSeq;

    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[교육생 번호]' || ', ' || '[출석]' || ', ' || '[결석]' || ', ' || '[지각]' || ', ' || '[조퇴]' || ', ' || '[외출]' || ', ' || '[병가]' || ', ' || '[기타]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE(   vrow.sSeq       || ', ' || 
                                vrow.sAttend    || ', ' || 
                                vrow.sAbsent    || ', ' || 
                                vrow.sLate      || ', ' || 
                                vrow.sLeave     || ', ' ||
                                vrow.sGoing     || ', ' ||
                                vrow.sSick      || ', ' ||
                                vrow.sExcep);
    end loop;
    
end proc_B_012_1;

-- 호출
-- call proc_B_012_1(2);


-- 2. 특정 과정을 듣는 특정 교육생의 출결 현황을 조회할 수 있다.
-- 프로시저
create or replace procedure proc_B_012_2 (
    popenProcessSeq number,      -- 특정 개설 과정 번호
    pstudentSeq number           -- 특정 교육생 번호
)
is
    cursor vcursor is
        select
            wd.studentSeq as sSeq,
            wd.openProcessSeq as osSeq,
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
                        where seq = popenProcessSeq       
                    ) - (
                        select
                            startDate
                        from tblOpenProcess
                        where seq = popenProcessSeq     
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
        where wd.studentSeq = pstudentSeq                 
            and wd.openProcessSeq = popenProcessSeq   
        order by wd.openProcessSeq asc, wd.weekDayDate asc;

    vrow vcursor%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('[교육생 번호]' || ', ' || '[개설과목번호]' || ', ' || '[날짜]' || ', ' || '[입실시간]' || ', ' || '[퇴실시간]' || ', ' || '[출결상태]' || ', ' || '[사유]');
    
    for vrow in vcursor loop
        DBMS_OUTPUT.PUT_LINE(   vrow.sSeq           || ', ' || 
                                vrow.osSeq          || ', ' || 
                                vrow.sDate          || ', ' || 
                                vrow.sInTime        || ', ' || 
                                vrow.sOutTime       || ', ' ||
                                vrow.sState         || ', ' ||
                                vrow.sCause);
    end loop;
    
end proc_B_012_2;

-- 호출
 call proc_B_012_2(1, 1010);


/*======================================================================================

        B-013 출결 관리 및 출결 조회
        1. 전체 교육생의 특정 날짜 출결 조회하기
        2. 특정 교육생의 전체 날짜 출결 조회하기
        3. 특정 교육생의 특정 날짜 출결 조회하기

========================================================================================*/

-- 1. 전체 교육생의 특정 날짜 출결 조회하기
-- 뷰
create or replace view vw_B_013_1
as
select
    a.inTime as sInTime,
    s.name as sName,
    p.name as pName,
    a.inTime || ' ~ ' || a.outTime as inOutTime
from tblStudent s, tblAttend a, tblOpenProcess op, tblProcess p
where
    s.seq = a.studentSeq
    and op.seq = a.openProcessSeq
    and op.processSeq = p.seq
    and s.exist = 'Y'
    and a.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y';

-- 프로시저
create or replace procedure proc_B_013_1 (
    pinTime date,
    poutTime date,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_013_1 where sInTime between pinTime and poutTime;
end proc_B_013_1;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_013_1%rowtype;
begin
    proc_B_013_1('2021-02-02', '2021-02-03', vcursor); -- 시작 날짜, 종료 날짜
    DBMS_OUTPUT.PUT_LINE('[학생명]' || ', ' || '[과정명]' || ', ' || '[입실/퇴실 시간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.sName      || ', ' || 
                                vrow.pName      || ', ' || 
                                vrow.inOutTime  );
    end loop;
    
end;


-- 2. 특정 교육생의 전체 날짜 출결 조회하기
-- 뷰
create or replace view vw_B_013_2
as
select
    s.seq as sSeq,
    s.name as sName,
    p.name as pName,
    a.inTime || ' ~ ' || a.outTime as inOutTime
from tblStudent s
    inner join tblAttend a
        on s.seq = a.studentSeq
    inner join tblOpenProcess op
        on op.seq = a.openProcessSeq
    inner join tblProcess p
        on op.processSeq = p.seq
where 
    s.exist = 'Y'
    and a.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y';

-- 프로시저
create or replace procedure proc_B_013_2 (
    pstudentSeq NUMBER,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_013_2 where sSeq = pstudentSeq;
end proc_B_013_2;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_013_2%rowtype;
begin
    proc_B_013_2(1010, vcursor); --교육생 번호
    DBMS_OUTPUT.PUT_LINE('[학생명]' || ', ' || '[과정명]' || ', ' || '[입실/퇴실 시간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.sName      || ', ' || 
                                vrow.pName      || ', ' || 
                                vrow.inOutTime    );
    end loop;
    
end;


-- 3. 특정 교육생의 특정 날짜 출결 조회하기
-- 뷰
create or replace view vw_B_013_3
as
select
    a.intime as sInTime,
    s.seq as sSeq,
    s.name as sName,
    p.name as pName,
    a.inTime || ' ~ ' || a.outTime as inOutTime
from tblStudent s
    inner join tblAttend a
        on s.seq = a.studentSeq
    inner join tblOpenProcess op
        on op.seq = a.openProcessSeq
    inner join tblProcess p
        on op.processSeq = p.seq
where 
    s.exist = 'Y'
    and a.exist = 'Y'
    and op.exist = 'Y'
    and p.exist = 'Y';

-- 프로시저
create or replace procedure proc_B_013_3 (
    pstudentSeq NUMBER,
    pinTime date,
    poutTime date,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_013_3 where sSeq = pstudentSeq and (sInTime between pinTime and poutTime);
end proc_B_013_3;

-- 호출
declare
    vcursor sys_refcursor;
    vrow vw_B_013_3%rowtype;
begin
    proc_B_013_3(1010, '2021-02-02', '2021-02-03', vcursor); -- 교육생 번호, 시작날짜, 종료날짜
    DBMS_OUTPUT.PUT_LINE('[학생명]' || ', ' || '[과정명]' || ', ' || '[입실/퇴실 시간]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE(   vrow.sName      || ', ' || 
                                vrow.pName      || ', ' || 
                                vrow.inOutTime    );
    end loop;
    
end;



/*======================================================================================

        [B-014] 프로젝트 관리
        1. 교사는 자신이 강의하는 과목에서 프로젝트 정보를 입력할 과목을 선택한다.
        2. 교사는 자신이 강의하는 과목의 프로젝트를 등록할 수 있다.

========================================================================================*/

-- 1. 교사는 자신이 강의하는 과목에서 프로젝트 정보를 입력할 과목을 선택한다.
--뷰
create or replace view vw_B_014
as
select
    os.teacherSeq as teacherSeq,
    os.openProcessSeq as openProcessSeq, 
    os.seq as openSubjectSeq,
    s.name as subjectName
from tblsubject s
    inner join tblOpenSubject os
        on s.seq = os.subjectseq
where s.exist = 'Y'
    and os.exist = 'Y';


--프로시저
create or replace procedure proc_B_014 (
    pteacherSeq number,          -- 교사 번호
    pcursor out sys_refcursor     --커서
)
is
begin
    open pcursor for
        select * from vw_B_014 where teacherseq = pteacherSeq;
end proc_B_014;


--호출
declare
    vcursor sys_refcursor;
    vrow vw_B_014%rowtype;
begin
    proc_B_014(2, vcursor);   -- 특정 교사 > 2
    
    dbms_output.put_line('[개설과정 번호]' || ' [개설과목 번호]' || ' [과목명]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.openProcessSeq || ', ' || vrow.openSubjectSeq || ', ' || vrow.subjectName);
    end loop;
end;



-- 2. 교사는 자신이 강의하는 과목의 프로젝트를 등록할 수 있다.
insert into tblProject values
    (
        projectSeq.nextval,                                                                         -- 프로젝트 번호
        24,                                                                                         -- 개설과목번호
        '할 일 리스트 목록 만들기',                                                                 -- 프로젝트주제
        '파일입출력을 이용하여 수정, 삭제, 저장하는 기능을 넣어 체크 리스트를 만들어보기 바랍니다.', -- 프로젝트설명
        '하',                                                                                       -- 난이도
        '업로드',                                                                                   -- 제출방법
        '2021-03-12',                                                                               -- 시작날짜 
        '2021-03-17',                                                                               -- 종료날짜
        default
    );


commit;
rollback;


-- 프로시저
-- 호출
create or replace procedure proc_project_insert (

    popenSubjectSeq in tblproject.openSubjectSeq%type,
    ptitle in tblproject.title%type,
    psummary in tblproject.summary%type,
    pdifficulty in tblproject.difficulty%type,
    psubmit in tblproject.submit%type,
    pstartDate in tblproject.startDate%type,
    pendDate in tblproject.endDate%type
)
is
begin
    insert into tblProject (seq, openSubjectSeq, title, summary, difficulty, submit, startDate, endDate, exist) values
        (projectSeq.nextVal, popenSubjectSeq, ptitle, psummary, pdifficulty, psubmit, pstartDate, pendDate, default);
        commit;
exception
    when others then
   rollback;
end proc_project_insert;




begin
    proc_project_insert(24, '할 일 리스트 목록 만들기', '파일입출력을 이용하여 수정, 삭제, 저장하는 기능을 넣어 체크 리스트를 만들어보기 바랍니다.', '하', '업로드', '2021-03-12', '2021-03-17');
end;


select * from tblproject;


/*======================================================================================

        [B-015] 프로젝트 관리
        1. 전체 개설 과목의 프로젝트 정보를 출력한다.

========================================================================================*/

-- 전체 개설 과목의 프로젝트 정보를 출력한다.
-- 뷰
create or replace view vw_B_015_1
as
select
    '과정' || os.openprocessseq as "개설과정",
    s.name as "과목명",
    case
        when p.title is null then '미정'
        else p.title
    end as "프로젝트명",
    case
        when p.summary is null then '미정'
        else p.summary 
    end as "프로젝트 설명",
    case
        when p.startDate is null then '미정'
        else to_char(p.startDate)
    end as "프로젝트시작",
    case
        when p.endDate is null then '미정'
        else to_char(p.endDate)
    end as "프로젝트종료"
from tblsubject s
    inner join tblOpenSubject os
        on s.seq = os.subjectSeq
    left outer join tblProject p
        on os.seq = p.openSubjectSeq
order by os.seq asc, s.seq asc;


-- 호출
select * from vw_B_015_1;




/*======================================================================================

        [B-016] 프로젝트 관리
        1. 교사가 자신이 강의하는 개설 과목 목록을 보여준다. > 과목하나를 선택한다.
        2. 해당 과목의 팀별 프로젝트 진행 상황을 출력한다.

========================================================================================*/

-- 1. 교사가 자신이 강의하는 개설 과목 목록을 보여준다.
call proc_subject_select(2); 


-- 뷰 : 과정명, 팀명, 프로젝트 진행상황
create or replace view vw_B_016
as
select 
    p.name as openProcessName,
    pj.title as projectTitle,
    tp.name as teamName,
    tp.progress as projectProgress,
    os.teacherSeq as teacherSeq
from tblProcess p
    inner join tblOpenProcess op
        on p.seq = op.processSeq
    inner join tblopenSubject os
        on op.seq = os.openProcessSeq
    inner join tblproject pj
        on os.seq = pj.openSubjectSeq
    inner join tblTeamProject tp
        on pj.seq = tp.projectSeq
where p.exist = 'Y'
    and op.exist = 'Y'
    and os.exist = 'Y'
    and pj.exist = 'Y'
    and tp.exist = 'Y';


-- 확인
select * from vw_B_016;



-- 프로시저
create or replace procedure proc_project (
    pteacherSeq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_016 where teacherSeq = pteacherSeq;
end proc_project;


-- 2. 해당 과목의 팀별 프로젝트 진행 상황을 출력한다.
-- 확인
declare
    vcursor sys_refcursor;
    vrow vw_B_016%rowtype;
begin
    proc_project(2, vcursor);
    dbms_output.put_line('[과정명]' || ' [팀명]' || ' [진행상황]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line(vrow.openProcessName || ', '  || vrow.projectTitle || ', ' || vrow.teamName || ', ' || fn_project(vrow.projectProgress));
    end loop;
end;



/*======================================================================================

        [B-017] 프로젝트 관리
        1. 교사는 자신이 강의하는 과목들 중 하나를 선택하여 해당 과목의 프로젝트 정보를 수정한다.

========================================================================================*/

-- 과목을 선택 > 해당 과목 프로젝트를 보여줌
select
    os.openProcessSeq as "개설과정번호", 
    os.seq as "개설과목번호",
    s.name as "과목명",
    p.seq as "프로젝트번호",
    p.title as "프로젝트제목",
    p.summary as "프로젝트설명",
    p.difficulty as "난이도",
    p.submit as "제출방법",
    p.startDate as "시작날짜",
    p.endDate as "종료날짜"
from tblsubject s
    inner join tblOpenSubject os
        on s.seq = os.subjectseq
    inner join tblProject p
        on os.seq = p.openSubjectSeq 
where os.teacherseq = 3
    and os.seq = 8; -- 과목 선택
    and to_date(p.enddate,'yyyy-mm-dd') > to_date(sysdate,'yyyy-mm-dd');  -- 완료되거나 진행 중인 프로젝트는 수정할 수 없다.



-- 뷰
create or replace view vw_B_017
as
select
    os.openProcessSeq as processSeq, 
    os.seq as subjectSeq,
    s.name as subjectName,
    p.seq as projectSeq,
    p.title as projectTitle,
    p.summary as projectSummary,
    p.difficulty as difficulty,
    p.submit as submit,
    p.startDate as startDate,
    p.endDate as endDate,
    os.teacherseq as teacherSeq
from tblsubject s
    inner join tblOpenSubject os
        on s.seq = os.subjectseq
    inner join tblProject p
        on os.seq = p.openSubjectSeq
where os.exist = 'Y'
    and p.exist = 'Y'
order by processSeq asc;
    

-- 프로시저
-- 과목을 선택 > 해당 과목 프로젝트를 보여줌
create or replace procedure proc_B_017 (
    pteacherseq number,     -- 선생님번호
    pOpenSubject number,    -- 개정과목번호
    pdate date,             -- 기준 날짜
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_017 
    where teacherSeq = pteacherSeq 
        and subjectSeq = pOpenSubject 
        and to_date(pdate,'yyyy-mm-dd') < to_date(endDate,'yyyy-mm-dd')
        and to_date(pdate,'yyyy-mm-dd') < to_date(startDate,'yyyy-mm-dd');  -- 완료되거나 진행 중인 프로젝트는 수정할 수 없다.
end proc_B_017;


-- 확인
declare
    vcursor sys_refcursor;
    vrow vw_B_017%rowtype;
begin
    proc_B_017(3, 19, sysdate, vcursor);   -- 특정 교사 > 2
    
    dbms_output.put_line('[개설과정 번호]' || ' [개설과목 번호]' || ' [과목명]'|| ' [프로젝트번호]' || ' [프로젝트제목]' || ' [프로젝트설명]' || ' [난이도]' || ' [제출방법]' || ' [시작날짜]' || ' [종료날짜]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.processSeq || ', ' || vrow.subjectSeq || ', ' || vrow.subjectName || ', ' || vrow.projectSeq || ', ' || vrow.projectTitle || ', ' || vrow.projectSummary || ', ' || vrow.difficulty || ', ' || vrow.submit || ', ' || vrow.startDate || ', ' || vrow.endDate);
    end loop;
end;

set serverout on;


-- 프로젝트 제출방법 수정
update tblproject set submit = '메일' where seq = 8; -- 수정할 프로젝트번호




/*======================================================================================

        [B-018] 프로젝트 관리
        1. 교사는 자신이 강의하는 과목들 중 하나를 선택하여 해당 과목의 프로젝트 정보를 삭제한다.

========================================================================================*/

-- 교사가 강의하는 과목 & 과정
call proc_subject_select(2); 

-- 해당 과목 삭제
update tblProject set exist = 'N' where openSubjectSeq = 8;


/*======================================================================================

        [B-019] 프로젝트 관리
        1. 교사가 자신이 강의한 과목에 팀과 팀장을 등록할 수 있다. 

========================================================================================*/

-- 팀번호  개설과목번호  팀장번호

-- 6개의 팀으로 구성한다고 가정
insert into tblTeam values(teamSeq.nextval,16,1200);



-- 프로시저
create or replace procedure proc_tblTeam_insert(
    popenSubjectSeq number,
    pleaderSeq number
)
is
    vteamCount number;
begin
    select count(*) into vteamCount from tblTeam where openSubjectSeq = popenSubjectSeq;
    
    if vteamCount < 6 then
        insert into tblTeam (seq,openSubjectSeq,leaderSeq) values(teamSeq.nextval, popenSubjectSeq, pleaderSeq);
    else
        null; -- 팀이 6개가 넘으면 팀을 만들 수 없음
    end if;    
    commit;
exception
    when others then
    rollback;
end proc_tblTeam_insert;


-- 호출
begin  
    proc_tblTeam_insert(16,1200);
end;



/*======================================================================================

        [B-020] 프로젝트 관리
        1. 교사가 자신이 강의한 과목을 수강하는 교육생들의 id, 조id를 입력하여 팀을 분배한다.

========================================================================================*/

-- 프로시저
-- 팀에 넣을 학생이 다른 팀에 속해 있으면 넣을 수 없음.

set serveroutput on;

create or replace procedure proc_teamDiv_insert(
    pteamSeq number,
    pstudentSeq number,
    presult out number -- 학생이 있으면 1 없으면 0
)
is
    vopenSubjectSeq number; -- 개설과목번호를 저장할 변수
    vresult number; -- 학생의 유무를 저장하는 변수
begin
    -- 1. 개설과목 번호 알아내기
    select openSubjectSeq into vopenSubjectSeq from tblTeam where pteamSeq = seq;
    
    -- 2. 개설과목을 듣는 팀번호들 알아내기 > 학생이 있으면 1 없으면 0
    select count(*) into vresult from (select studentSeq as "학생번호" from tblTeamDiv where teamSeq in (select seq from tblTeam where openSubjectSeq = vopenSubjectSeq)) where 학생번호 = pstudentSeq;
    
    if vresult = 0 then
        -- 학생이 없으면 팀에 학생 넣기
        insert into tblTeamDiv (teamSeq, studentSeq) values (pteamSeq, pstudentSeq);
        presult := 1;
    else 
        presult := 0;
        null;
    end if;
    
    commit;
exception
    when others then
    rollback;
end proc_teamDiv_insert;


-- 호출(확인)
declare
    presult number;
begin  
    proc_teamDiv_insert(1,1300,presult);
    if presult = 1 then
        dbms_output.put_line('팀에 학생 없음');
    else
        dbms_output.put_line('팀에 학생 있음');
    end if;
end;



/*======================================================================================

        [B-021] 프로젝트 관리
        1. 교사가 강의하는 개설 과목을 목록으로 보여준다. > 과목을 선택한다.
        2. 특정 과목의 팀 현황을 출력한다.

========================================================================================*/

-- 1. 교사가 강의하는 개설 과목을 목록으로 보여준다. > 과목을 선택한다.
-- 뷰
create or replace view vw_B_021_1
as
select
    os.openprocessseq as processSeq, 
    os.seq as subjectSeq,
    s.name as subjectName,
    os.teacherseq as teacherSeq
from tblsubject s
    inner join tblOpenSubject os
        on s.seq = os.subjectseq
where os.exist = 'Y'
    and s.exist = 'Y';


-- 확인
select * from vw_B_021_1;


-- 2. 특정 과목의 팀 현황을 출력한다.
-- 뷰
create or replace view vw_B_021_2
as
select
    tb.teamSeq as "팀 번호",
    s.seq as "교육생 번호",
    s.name as "교육생 이름",
    os.seq as "과목번호",
    rs.ismajor as "전공여부"
from tblTeamDiv tb
    inner join tblStudent s
        on tb.studentseq = s.seq
    inner join tblTeam t
        on tb.teamseq = t.seq
    inner join tblOpenSubject os
        on t.opensubjectseq = os.seq
    inner join tblTeacher te
        on os.teacherSeq = te.seq
    inner join tblRegStudent rs
        on s.seq = rs.studentSeq
where tb.exist = 'Y'
    and s.exist = 'Y'
    and t.exist = 'Y'
    and os.exist = 'Y'
    and te.exist = 'Y'
    and rs.exist = 'Y'
order by tb.teamseq asc;

-- 호출
select * from vw_B_021_2;


-- 프로시저
create or replace procedure proc_B_021_2 (
    pteacherSeq number,
    popenSubjectSeq number,
    pcursor out sys_refcursor
)
is
begin
    open pcursor for
        select * from vw_B_021_2 where teacherSeq = pteacherSeq and opensubjectSeq = popenSubjectSeq;
end proc_B_021_2;


-- 확인
declare
    vcursor sys_refcursor;
    vrow vw_B_021_2%rowtype;
begin
    proc_B_021_2(2,1,vcursor);
    dbms_output.put_line('[팀번호]' || ' [학생번호]' || ' [학생이름]' || '[전공여부]');
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line(vrow.teamNum || ', '  || vrow.studentSeq || ', ' || vrow.studentName || ', ' || fn_B_021_2(vrow.major));
    end loop;
end;



/*======================================================================================

        [B-022] 프로젝트 관리
        1. 교사가 자신이 강의한 과목을 수강하는 교육생들의 id, 팀 id를 입력하여 팀 정보를 수정한다.

========================================================================================*/

--- 1조 학생을 2조로 옮기고 2조 학생을 1조로 옮기기
update tblTeamDiv set teamseq = 2 where studentseq = 1091;
update tblTeamDiv set teamseq = 1 where studentseq = 1095;



-- 프로시저
create or replace procedure proc_teamdiv_update (
    pteamSeq in number,              -- 이동할 학생 팀번호
    pstudentSeq in number,           -- 이동할 학생번호
    pshiftTeamSeq in number,         -- 옮길 팀번호
    presult out number
)
is
    cursor vcursor is 
        select seq from tblTeam 
        where openSubjectSeq = (select openSubjectSeq from tblTeam where seq = pteamSeq);
    vteamSeq number; -- 결과값을 저장할 변수
    vresult number :=0;
begin
    open vcursor;
    loop
        fetch vcursor into vteamSeq;
        exit when vcursor%notfound;
        
        if vteamSeq = pshiftTeamSeq then
            vresult := 1;
        end if;
        
    end loop;
    close vcursor;
    
    
    -- 학생이 이동할 팀이 듣고 있는 과목에 속해있는지 알아내기   
    if vresult = 1 then
        update tblTeamDiv set teamseq = pshiftTeamSeq where studentseq = pstudentSeq; 
        presult := 1;
    
    else 
        presult := 0;
        null;
        
    end if;
    commit;
exception
    when others then
    rollback;
end proc_teamdiv_update;  



-- 호출
declare
    presult number;
begin  
    proc_teamdiv_update(1,1001,2,presult);
    if presult = 1 then
        dbms_output.put_line('학생이 이동 되었습니다.');
    else
        dbms_output.put_line('학생이 듣는 과목이 아닙니다.');
    end if;
end;


ROLLBACK;
commit;


/*======================================================================================

        [B-023] 프로젝트 관리
        1. 특정 과목의 팀 정보를 삭제한다

========================================================================================*/

-- 특정 과목의 팀 정보를 보여준다.
select 
    t.seq as "팀번호",
    td.studentseq as "팀원",
    t.leaderseq as "팀장",
    s.name as "이름"
from tblTeam t
    inner join tblTeamDiv td
        on t.seq = td.teamseq
    inner join tblStudent s
        on td.studentSeq = s.seq
where t.opensubjectseq = 1   -- 특정 과목 선택    
order by t.seq asc;
        

select * from tblTeam where openSubjectSeq = 1;


-- 특정 과목의 팀 정보를 삭제한다
update tblTeam set exist = 'Y' where openSubjectSeq = 1;