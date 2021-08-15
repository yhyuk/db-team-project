
-- Drop문


/*===================================================================
                            1단계
===================================================================*/


/* 출결 상태 */
DROP TABLE tblAttendState 
	CASCADE CONSTRAINTS;

/* 시험 문제 */
DROP TABLE tblQuestion 
	CASCADE CONSTRAINTS;
    
/* 팀원 */
DROP TABLE tblTeamDiv 
	CASCADE CONSTRAINTS;
    

/* 팀별 프로젝트 */
DROP TABLE tblTeamProject 
	CASCADE CONSTRAINTS;
    
    
/*===================================================================
                            2단계
===================================================================*/    

/* 출결 */
DROP TABLE tblAttend 
	CASCADE CONSTRAINTS;

/* 시험 */
DROP TABLE tblExam 
	CASCADE CONSTRAINTS;
    
/* 개설과목 배점 */
DROP TABLE tblPoint 
	CASCADE CONSTRAINTS;

/* 프로젝트 */
DROP TABLE tblProject 
	CASCADE CONSTRAINTS;

/* 수강정보 */
DROP TABLE tblRegStudent 
	CASCADE CONSTRAINTS;

/* 시험 점수 */
DROP TABLE tblScore 
	CASCADE CONSTRAINTS;
    
/* 팀 */
DROP TABLE tblTeam 
	CASCADE CONSTRAINTS;
    
    
    
    
/*===================================================================
                            3단계
===================================================================*/


/* 개설 과정 */
DROP TABLE tblOpenProcess 
	CASCADE CONSTRAINTS;

/* 개설 과목 */
DROP TABLE tblOpenSubject 
	CASCADE CONSTRAINTS;
    
/* 과정별 과목 */
DROP TABLE tblProcessSub 
	CASCADE CONSTRAINTS;
    
/* 교사 강의 가능 과목 */
DROP TABLE tblTeacherSub 
	CASCADE CONSTRAINTS;

/* 강의실별 PC */
DROP TABLE tblPC 
	CASCADE CONSTRAINTS;




/*===================================================================
                            4단계
===================================================================*/

/* 교재 */
DROP TABLE tblBook 
	CASCADE CONSTRAINTS;

/* 강의실 */
DROP TABLE tblClassRoom 
	CASCADE CONSTRAINTS;
    
/* 과정 */
DROP TABLE tblProcess 
	CASCADE CONSTRAINTS;

/* 과목 */
DROP TABLE tblSubject 
	CASCADE CONSTRAINTS;


/* 교육생 */
DROP TABLE tblStudent 
	CASCADE CONSTRAINTS;


/* 교사 */
DROP TABLE tblTeacher 
	CASCADE CONSTRAINTS;


















