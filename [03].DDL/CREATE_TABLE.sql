

/******************* 1조 DDL *******************************
***********************************************************/


--===================== create문 (PK포함) =====================

/* 과정 */
CREATE TABLE tblProcess (
	seq NUMBER NOT NULL,                /* 과정번호 */
	name VARCHAR2(100) NOT NULL,        /* 과정명 */
	month NUMBER NOT NULL,              /* 개월수 */
	campus VARCHAR2(20) NOT NULL,       /* 캠퍼스 */
	difficulty VARCHAR2(20),            /* 난이도 */
	price NUMBER NOT NULL,              /* 수강비 */
	grade VARCHAR2(20),                 /* 기관평가등급 */
	job VARCHAR2(100) NOT NULL,         /* 관련직종 */
	capacity VARCHAR2(30) NOT NULL,     /* 관련자격증 */
	employmentrate NUMBER,              /* 취업률 */
	div VARCHAR2(20) NOT NULL,          /* 분류(재직/취업) */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblProcess
	ADD
		CONSTRAINT PK_tblProcess
		PRIMARY KEY (
			seq
		);

/* 과목 */
CREATE TABLE tblSubject (
	seq NUMBER NOT NULL,                        /* 과목번호 */
	name VARCHAR2(100) NOT NULL,                /* 과목명 */
	common VARCHAR2(20) DEFAULT 'No' NOT NULL,    /* 공통과목여부 */
	difficulty VARCHAR2(20) NOT NULL,           /* 난이도 */
	div VARCHAR2(20) NOT NULL,                  /* 분류 */
	priorLearn VARCHAR2(20) NOT NULL,           /* 선행학습필요여부 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblSubject
	ADD
		CONSTRAINT PK_tblSubject
		PRIMARY KEY (
			seq
		);

/* 과정별 과목 */
CREATE TABLE tblProcessSub (
	processSeq NUMBER NOT NULL,             /* 과정번호 */
	subjectSeq NUMBER NOT NULL,             /* 과목번호 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL      /* exist */
);

ALTER TABLE tblProcessSub
	ADD
		CONSTRAINT PK_tblProcessSub
		PRIMARY KEY (
			processSeq,
			subjectSeq
		);

/* 강의실 */
CREATE TABLE tblClassRoom (
	seq NUMBER NOT NULL,                    /* 강의실번호 */
	name VARCHAR2(20) NOT NULL,             /* 강의실명 */
	max NUMBER NOT NULL,                    /* 최대인원 */
	wifiName VARCHAR2(100) NOT NULL,        /* WiFi 이름 */
	wifiPW VARCHAR2(20) NOT NULL,           /* WiFi 비밀번호 */
	os VARCHAR2(20) NOT NULL,               /* PC 운영체제 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL      /* exist */
);

ALTER TABLE tblClassRoom
	ADD
		CONSTRAINT PK_tblClassRoom
		PRIMARY KEY (
			seq
		);

/* 강의실별 PC */
CREATE TABLE tblPC (
	seq NUMBER NOT NULL,                            /* PC번호 */
	classRoomSeq NUMBER NOT NULL,                   /* 강의실번호 */
	pcTrouble VARCHAR2(20) DEFAULT 'No' NOT NULL,   /* 고장여부 */
	cause varchar2(100),                            /* 고장원인 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL              /* exist */
);

ALTER TABLE tblPC
	ADD
		CONSTRAINT PK_tblPC
		PRIMARY KEY (
			seq
		);


/* 교재 */
CREATE TABLE tblBook (
	seq NUMBER NOT NULL,                /* 교재번호 */
	name VARCHAR2(100) NOT NULL,        /* 교재명 */
	author VARCHAR2(20) NOT NULL,       /* 저자 */
	publisher VARCHAR2(20) NOT NULL,    /* 출판사 */
	page NUMBER NOT NULL,               /* 페이지수 */
	publishDate DATE NOT NULL,                 /* 발행일 */
	price NUMBER NOT NULL,              /* 가격 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblBook
	ADD
		CONSTRAINT PK_tblBook
		PRIMARY KEY (
			seq
		);

/* 교사 */
CREATE TABLE tblTeacher (
	seq NUMBER NOT NULL,                        /* 교사번호 */
	name VARCHAR2(20) NOT NULL,                 /* 교사명 */
	ssn VARCHAR2(20) NOT NULL,                  /* 주민번호 */
	email VARCHAR2(100) NOT NULL,               /* 이메일 */
	tel VARCHAR2(20) NOT NULL,                  /* 전화번호 */
	address VARCHAR2(100) NOT NULL,             /* 주소 */
	career NUMBER DEFAULT 0 NOT NULL,           /* 경력 */
	school VARCHAR2(100),                       /* 출신학교 */
	major VARCHAR2(20),                         /* 전공 */
	enterDate DATE NOT NULL,                    /* 입사날짜 */
	div VARCHAR2(20) DEFAULT '강사' NOT NULL,   /* 강사분류 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblTeacher
	ADD
		CONSTRAINT PK_tblTeacher
		PRIMARY KEY (
			seq
		);

/* 교사 강의 가능 과목 */
CREATE TABLE tblTeacherSub (
	teacherSeq NUMBER NOT NULL,                 /* 교사번호 */
	subjectSeq NUMBER NOT NULL,                 /* 과목번호 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblTeacherSub
	ADD
		CONSTRAINT PK_tblTeacherSub
		PRIMARY KEY (
			teacherSeq,
			subjectSeq
		);

/* 개설 과정 */
CREATE TABLE tblOpenProcess (
	seq NUMBER NOT NULL,                /* 개설과정번호 */
	processSeq NUMBER NOT NULL,         /* 과정번호 */
	classRoomSeq NUMBER NOT NULL,       /* 강의실번호 */
	startDate DATE NOT NULL,            /* 시작날짜 */
	endDate DATE NOT NULL,              /* 종료날짜 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblOpenProcess
	ADD
		CONSTRAINT PK_tblOpenProcess
		PRIMARY KEY (
			seq
		);

/* 개설 과목 */
CREATE TABLE tblOpenSubject (
	seq NUMBER NOT NULL,                        /* 개설과목번호 */
	subjectSeq NUMBER NOT NULL,                 /* 과목번호 */
	openProcessSeq NUMBER NOT NULL,             /* 개설과정번호 */
	teacherSeq NUMBER NOT NULL,                 /* 교사번호 */
	bookSeq NUMBER NOT NULL,                    /* 교재번호 */
	startDate DATE NOT NULL,                    /* 시작날짜 */
	endDate DATE NOT NULL,                      /* 종료날짜 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT PK_tblOpenSubject
		PRIMARY KEY (
			seq
		);

/* 교육생 */
CREATE TABLE tblStudent (
	seq NUMBER NOT NULL,                /* 교육생번호 */
	name VARCHAR2(20) NOT NULL,         /* 이름 */
	ssn VARCHAR2(20) NOT NULL,          /* 주민번호 */
	email VARCHAR2(100) NOT NULL,       /* 이메일 */
	tel VARCHAR2(20) NOT NULL,          /* 전화번호 */
	address VARCHAR2(100) NOT NULL,     /* 주소 */
	school VARCHAR2(100),               /* 출신학교 */
	major VARCHAR2(100),                /* 전공 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblStudent
	ADD
		CONSTRAINT PK_tblStudent
		PRIMARY KEY (
			seq
		);

/* 수강정보 */
CREATE TABLE tblRegStudent (
	studentSeq NUMBER NOT NULL,                     /* 교육생번호 */
	openProcessSeq NUMBER NOT NULL,                 /* 개설과정번호 */
	finishDate DATE,                                /* 수료날짜 */
	dropDate DATE,                                  /* 중도탈락날짜 */
	isMajor VARCHAR2(20) DEFAULT 'No' NOT NULL,     /* 전공여부 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL              /* exist */
);

ALTER TABLE tblRegStudent
	ADD
		CONSTRAINT PK_tblRegStudent
		PRIMARY KEY (
			studentSeq,
			openProcessSeq
		);

/* 개설과목 배점 */
CREATE TABLE tblPoint (
	seq NUMBER NOT NULL,                /* 배점번호 */
	openSubjectSeq NUMBER NOT NULL,     /* 개설과목번호 */
	attend NUMBER NOT NULL,             /* 출결 */
	write NUMBER NOT NULL,              /* 필기 */
	perform NUMBER NOT NULL,            /* 실기 */
	task NUMBER NOT NULL,               /* 과제 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblPoint
	ADD
		CONSTRAINT PK_tblPoint
		PRIMARY KEY (
			seq
		);

/* 시험 점수 */
CREATE TABLE tblScore (
	studentSeq NUMBER NOT NULL,                 /* 교육생번호 */
	openSubjectSeq NUMBER NOT NULL,             /* 개설과목번호 */
	attend NUMBER,                              /* 출결 */
	write NUMBER,                               /* 필기 */
	perform NUMBER,                             /* 실기 */
	task NUMBER,                                /* 과제 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblScore
	ADD
		CONSTRAINT PK_tblScore
		PRIMARY KEY (
			studentSeq,
			openSubjectSeq
		);

/* 프로젝트 */
CREATE TABLE tblProject (
	seq NUMBER NOT NULL,                        /* 프로젝트번호 */
	openSubjectSeq NUMBER NOT NULL,             /* 개설과목번호 */
	title VARCHAR2(100) NOT NULL,               /* 프로젝트 주제 */
	summary VARCHAR2(200) NOT NULL,             /* 프로젝트 설명 */
	difficulty VARCHAR2(20) NOT NULL,           /* 난이도 */
	submit VARCHAR2(20) NOT NULL,               /* 제출방법 */
	startDate DATE NOT NULL,                    /* 시작날짜 */
	endDate DATE NOT NULL,                      /* 종료날짜 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);

ALTER TABLE tblProject
	ADD
		CONSTRAINT PK_tblProject
		PRIMARY KEY (
			seq
		);

/* 팀 */
CREATE TABLE tblTeam (
	seq NUMBER NOT NULL,                        /* 팀번호 */
	openSubjectSeq NUMBER NOT NULL,             /* 개설과목번호 */
	leaderSeq NUMBER NOT NULL,                  /* 팀장번호 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL          /* exist */
);  

ALTER TABLE tblTeam
	ADD
		CONSTRAINT PK_tblTeam
		PRIMARY KEY (
			seq
		);

/* 팀원 */
CREATE TABLE tblTeamDiv (
	teamSeq NUMBER NOT NULL,                /* 팀번호 */
	studentSeq NUMBER NOT NULL,             /* 교육생번호 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL      /* exist */
);

ALTER TABLE tblTeamDiv
	ADD
		CONSTRAINT PK_tblTeamDiv
		PRIMARY KEY (
			teamSeq,
			studentSeq
		);

/* 출결 */
CREATE TABLE tblAttend (
	seq NUMBER NOT NULL,                    /* 출결번호 */
	openProcessSeq NUMBER NOT NULL,         /* 개설과정번호 */
	studentSeq NUMBER NOT NULL,             /* 교육생번호 */
	inTime DATE,                            /* 입실시간 */
	outTime DATE,                           /* 퇴실시간 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL      /* exist */
);

ALTER TABLE tblAttend
	ADD
		CONSTRAINT PK_tblAttend
		PRIMARY KEY (
			seq
		);

/* 출결 상태 */
CREATE TABLE tblAttendState (
	seq NUMBER NOT NULL,                /* 출결상태번호 */
	attendSeq NUMBER NOT NULL,          /* 출결번호 */
	state VARCHAR2(20) NOT NULL,        /* 상태종류 */
	cause VARCHAR2(100) NOT NULL,       /* 사유 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblAttendState
	ADD
		CONSTRAINT PK_tblAttendState
		PRIMARY KEY (
			seq
		);

/* 팀별 프로젝트 */
CREATE TABLE tblTeamProject (
	seq NUMBER NOT NULL,                            /* 팀프로젝트번호 */
	projectSeq NUMBER NOT NULL,                     /* 프로젝트번호 */
	teamSeq NUMBER NOT NULL,                        /* 팀번호 */
	name VARCHAR2(100) NOT NULL,                    /* 프로젝트제출명 */
	content VARCHAR2(200) NOT NULL,                 /* 프로젝트 내용 */
	progress NUMBER DEFAULT 1 NOT NULL,             /* 진행상황 */
	isSubmit VARCHAR2(20) DEFAULT 'No' NOT NULL,    /* 제출여부 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL              /* exist */
);

ALTER TABLE tblTeamProject
	ADD
		CONSTRAINT PK_tblTeamProject
		PRIMARY KEY (
			seq
		);

/* 시험 */
CREATE TABLE tblExam (
	seq NUMBER NOT NULL,                /* 시험번호 */
	openSubjectSeq NUMBER NOT NULL,     /* 개설과목번호 */
	regDate DATE NOT NULL,              /* 시험 등록날짜 */
	writeDate DATE NOT NULL,            /* 필기시험날짜 */
	performDate DATE NOT NULL,          /* 실기시험날짜 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblExam
	ADD
		CONSTRAINT PK_tblExam
		PRIMARY KEY (
			seq
		);

/* 시험 문제 */
CREATE TABLE tblQuestion (
	seq NUMBER NOT NULL,                /* 문제번호 */
	examSeq NUMBER NOT NULL,            /* 시험번호 */
	question VARCHAR2(200) NOT NULL,    /* 문제 */
	answer VARCHAR2(200) NOT NULL,      /* 답 */
	score NUMBER NOT NULL,              /* 점수 */
	type VARCHAR2(20) NOT NULL,         /* 유형 */
	exist CHAR(1) DEFAULT 'Y' NOT NULL  /* exist */
);

ALTER TABLE tblQuestion
	ADD
		CONSTRAINT PK_tblQuestion
		PRIMARY KEY (
			seq
		);


--===================== FK 제약조건 =====================

ALTER TABLE tblProcessSub
	ADD
		CONSTRAINT FK_Process_ProcessSub
		FOREIGN KEY (
			processSeq
		)
		REFERENCES tblProcess (
			seq
		);

ALTER TABLE tblProcessSub
	ADD
		CONSTRAINT FK_Subject_ProcessSub
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES tblSubject (
			seq
		);

ALTER TABLE tblPC
	ADD
		CONSTRAINT FK_ClassRoom_PC
		FOREIGN KEY (
			classRoomSeq
		)
		REFERENCES tblClassRoom (
			seq
		);


ALTER TABLE tblTeacherSub
	ADD
		CONSTRAINT FK_Teacher_TeacherSub
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES tblTeacher (
			seq
		);

ALTER TABLE tblTeacherSub
	ADD
		CONSTRAINT FK_Subject_TeacherSub
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES tblSubject (
			seq
		);

ALTER TABLE tblOpenProcess
	ADD
		CONSTRAINT FK_Process_OpenProcess
		FOREIGN KEY (
			processSeq
		)
		REFERENCES tblProcess (
			seq
		);

ALTER TABLE tblOpenProcess
	ADD
		CONSTRAINT FK_ClassRoom_OpenProcess
		FOREIGN KEY (
			classRoomSeq
		)
		REFERENCES tblClassRoom (
			seq
		);

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT FK_Subject_OpenSubject
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES tblSubject (
			seq
		);

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT FK_OpenProcess_OpenSubject
		FOREIGN KEY (
			openProcessSeq
		)
		REFERENCES tblOpenProcess (
			seq
		);

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT FK_Teacher_OpenSubject
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES tblTeacher (
			seq
		);

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT FK_Book_OpenSubject
		FOREIGN KEY (
			bookSeq
		)
		REFERENCES tblBook (
			seq
		);

ALTER TABLE tblRegStudent
	ADD
		CONSTRAINT FK_Student_RegStudent
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES tblStudent (
			seq
		);

ALTER TABLE tblRegStudent
	ADD
		CONSTRAINT FK_OpenProcess_RegStudent
		FOREIGN KEY (
			openProcessSeq
		)
		REFERENCES tblOpenProcess (
			seq
		);

ALTER TABLE tblPoint
	ADD
		CONSTRAINT FK_OpenSubject_Point
		FOREIGN KEY (
			openSubjectSeq
		)
		REFERENCES tblOpenSubject (
			seq
		);

ALTER TABLE tblScore
	ADD
		CONSTRAINT FK_Student_Score
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES tblStudent (
			seq
		);

ALTER TABLE tblScore
	ADD
		CONSTRAINT FK_OpenSubject_Score
		FOREIGN KEY (
			openSubjectSeq
		)
		REFERENCES tblOpenSubject (
			seq
		);

ALTER TABLE tblProject
	ADD
		CONSTRAINT FK_OpenSubject_Project
		FOREIGN KEY (
			openSubjectSeq
		)
		REFERENCES tblOpenSubject (
			seq
		);

ALTER TABLE tblTeam
	ADD
		CONSTRAINT FK_OpenSubject_Team
		FOREIGN KEY (
			openSubjectSeq
		)
		REFERENCES tblOpenSubject (
			seq
		);

ALTER TABLE tblTeam
	ADD
		CONSTRAINT FK_Student_Team
		FOREIGN KEY (
			leaderSeq
		)
		REFERENCES tblStudent (
			seq
		);

ALTER TABLE tblTeamDiv
	ADD
		CONSTRAINT FK_Team_TeamDiv
		FOREIGN KEY (
			teamSeq
		)
		REFERENCES tblTeam (
			seq
		);

ALTER TABLE tblTeamDiv
	ADD
		CONSTRAINT FK_Student_TeamDiv
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES tblStudent (
			seq
		);

ALTER TABLE tblAttend
	ADD
		CONSTRAINT FK_OpenProcess_Attend
		FOREIGN KEY (
			openProcessSeq
		)
		REFERENCES tblOpenProcess (
			seq
		);

ALTER TABLE tblAttend
	ADD
		CONSTRAINT FK_Student_Attend
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES tblStudent (
			seq
		);

ALTER TABLE tblAttendState
	ADD
		CONSTRAINT FK_Attend_AttendState
		FOREIGN KEY (
			attendSeq
		)
		REFERENCES tblAttend (
			seq
		);

ALTER TABLE tblTeamProject
	ADD
		CONSTRAINT FK_Project_TeamProject
		FOREIGN KEY (
			projectSeq
		)
		REFERENCES tblProject (
			seq
		);

ALTER TABLE tblTeamProject
	ADD
		CONSTRAINT FK_Team_TeamProject
		FOREIGN KEY (
			teamSeq
		)
		REFERENCES tblTeam (
			seq
		);

ALTER TABLE tblExam
	ADD
		CONSTRAINT FK_OpenSubject_Exam
		FOREIGN KEY (
			openSubjectSeq
		)
		REFERENCES tblOpenSubject (
			seq
		);

ALTER TABLE tblQuestion
	ADD
		CONSTRAINT FK_Exam_Question
		FOREIGN KEY (
			examSeq
		)
		REFERENCES tblExam (
			seq
		);
        
--===================== CHECK 제약조건 =====================        

/*
ALTER TABLE 테이블명
	ADD
		CONSTRAINT 제약조건명
		CHECK;
*/


ALTER TABLE tblProcess
	ADD
		CONSTRAINT CH_Process_Value
		CHECK (
            month in (5.5, 6, 7)
            and
            difficulty in ('상', '중', '하')
            and
            grade in ('A', 'B', 'C')
            and
            div in ('재직', '취업')
            and
            employmentRate between 0 and 100
            and
            exist in ('Y','N')
        );

ALTER TABLE tblSubject
	ADD
		CONSTRAINT CH_Subject_Value
		CHECK (
            common in ('Yes', 'No')
            and
            difficulty in ('상', '중', '하')
            and
            priorLearn in ('Yes', 'No')
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblProcessSub
	ADD
		CONSTRAINT CH_ProcessSub_Value
		CHECK (        
            exist in ('Y','N')
        );
        
        
ALTER TABLE tblClassRoom
	ADD
		CONSTRAINT CH_ClassRoom_Value
		CHECK (
            max in (26, 30)
            and
            os in ('Windows', 'Mac', 'Linux')
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblPC
	ADD
		CONSTRAINT CH_PC_Value
		CHECK (
            pcTrouble in ('Yes', 'No')
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblBook
	ADD
		CONSTRAINT CH_Book_Value
		CHECK (
            price >= 0
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblTeacher
	ADD
		CONSTRAINT CH_Teacher_Value
		CHECK (
            length(name) between 2 and 5
            and
            REGEXP_LIKE(ssn,'[0-9]{6}-[0-9]{7}')
            and
            email like '%@%'
            and
            REGEXP_LIKE(tel,'[0-9]{3}-[0-9]{4}-[0-9]{4}')
            and
            div in ('강사', '전임강사')
            and
            exist in ('Y','N')
        );

ALTER TABLE tblTeacherSub
	ADD
		CONSTRAINT CH_TeacherSub_Value
		CHECK (
            exist in ('Y','N')
        );


ALTER TABLE tblOpenProcess
	ADD
		CONSTRAINT CH_OpenProcess_Value
		CHECK (
            exist in ('Y','N')
        );

ALTER TABLE tblOpenSubject
	ADD
		CONSTRAINT CH_OpenSubject_Value
		CHECK (
            exist in ('Y','N')
        );

        
ALTER TABLE tblStudent
	ADD
		CONSTRAINT CH_Student_Value
		CHECK (
            length(name) between 2 and 5
            and
            REGEXP_LIKE(ssn,'[0-9]{6}-[0-9]{7}')
            and
            email like '%@%'
            and
            REGEXP_LIKE(tel,'[0-9]{3}-[0-9]{4}-[0-9]{4}')
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblRegStudent
	ADD
		CONSTRAINT CH_RegStudent_Value
		CHECK (
            isMajor in ('Yes', 'No')
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblPoint
	ADD
		CONSTRAINT CH_Point_Value
		CHECK (
            attend >= 20
            and
            attend + write + perform + task = 100
            and
            exist in ('Y','N')
        );


        
ALTER TABLE tblScore
	ADD
		CONSTRAINT CH_Score_Value
		CHECK (
            attend between 0 and 100
            and
            write between 0 and 100
            and
            perform between 0 and 100
            and
            task between 0 and 100
            and
            exist in ('Y','N')
        );
        
ALTER TABLE tblProject
	ADD
		CONSTRAINT CH_Project_Value
		CHECK (
            difficulty in ('상', '중', '하')
            and
            submit in ('발표', '업로드', '메일')
            and
            exist in ('Y','N')
        );
        
        
ALTER TABLE tblTeam
	ADD
		CONSTRAINT CH_Team_Value
		CHECK (
            exist in ('Y','N')
        );
        
ALTER TABLE tblTeamDiv
	ADD
		CONSTRAINT CH_TeamDiv_Value
		CHECK (
            exist in ('Y','N')
        );

ALTER TABLE tblAttend
	ADD
		CONSTRAINT CH_Attend_Value
		CHECK (
            exist in ('Y','N')
        );


ALTER TABLE tblAttendState
	ADD
		CONSTRAINT CH_AttendState_Value
		CHECK (
            state in ('외출', '병가', '기타')
            and
            exist in ('Y','N')
        );

ALTER TABLE tblTeamProject
	ADD
		CONSTRAINT CH_TeamProject_Value
		CHECK (
            progress between 1 and 5
            and
            isSubmit in ('Yes', 'No')
            and
            exist in ('Y','N')
        );
        

ALTER TABLE tblExam
	ADD
		CONSTRAINT CH_Exam_Value
		CHECK (
            exist in ('Y','N')
        );


ALTER TABLE tblQuestion
	ADD
		CONSTRAINT CH_Question_Value
		CHECK (
            score between 0 and 100
            and
            type in ('필기', '실기')
            and
            exist in ('Y','N')
        );

















        