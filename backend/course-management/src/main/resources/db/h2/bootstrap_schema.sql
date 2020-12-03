-- MODELS A UNIVERSITY COURSE FOR A GIVEN SEMESTER
CREATE TABLE COURSE (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    CODE VARCHAR(63) NOT NULL,
    LEVEL INT NOT NULL,
    TERM VARCHAR(63) NOT NULL,
    ACADEMIC_YEAR INT NOT NULL,
    CONSTRAINT U_COURSE_CODE_LEVEL_CODE_ACADEMIC_YEAR UNIQUE (CODE, LEVEL, TERM, ACADEMIC_YEAR)
);
-- MODELS A KEY-VALUE ATTRIBUTE PAIR FOR A COURSE
CREATE TABLE COURSE_ATTR (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    COURSE_ID INT NOT NULL,
    ATTR_NAME VARCHAR(250) NOT NULL,
    ATTR_VALUE VARCHAR(MAX) DEFAULT NULL,
    CONSTRAINT U_COURSE_ATTR_COURSE_ID_ATTR_NAME_UNIQUE UNIQUE (COURSE_ID, ATTR_NAME),
    CONSTRAINT FK_COURSE_ATTR_COURSE_ID_COURSE_ID FOREIGN KEY (COURSE_ID) REFERENCES COURSE(ID)
);
-- MODELS THE ENROLLMENT OF A USER IN A COURSE
CREATE TABLE COURSE_ENROLLMENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    COURSE_ID INT NOT NULL,
    USER_ID VARCHAR(40) NOT NULL,
    PINNED BOOLEAN DEFAULT FALSE,
    CONSTRAINT U_COURSE_ID_USER_ID UNIQUE (COURSE_ID, USER_ID),
    CONSTRAINT FK_COURSE_ENROLLMENT_COURSE_ID_COURSE_ID FOREIGN KEY (COURSE_ID) REFERENCES COURSE(ID)
);
-- MODELS AN ASSIGNMENT FOR A COURSE
CREATE TABLE ASSIGNMENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    COURSE_ID INT NOT NULL,
    NAME VARCHAR(250) NOT NULL,
    DUE_DATE DATE,
    CONSTRAINT U_ASSIGNMENT_COURSE_ID_NAME UNIQUE (COURSE_ID, NAME),
    CONSTRAINT FK_ASSIGNMENT_COURSE_ID_COURSE_ID FOREIGN KEY (COURSE_ID) REFERENCES COURSE(ID)
);
-- MODELS A KEY-VALUE ATTRIBUTE PAIR FOR AN ASSIGNMENT
CREATE TABLE ASSIGNMENT_ATTR (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ASSIGNMENT_ID INT NOT NULL,
    ATTR_NAME VARCHAR(250) NOT NULL,
    ATTR_VALUE VARCHAR(MAX) DEFAULT NULL,
    CONSTRAINT U_ASSIGNMENT_ATTR_ASSIGNMENT_ID_NAME UNIQUE (ASSIGNMENT_ID, ATTR_NAME),
    CONSTRAINT FK_ASSIGNMENT_ATTR_ASSIGNMENT_ID_ASSIGNMENT_ID FOREIGN KEY (ASSIGNMENT_ID) REFERENCES ASSIGNMENT(ID)
);
-- MODELS THE ENROLLMENT OF A USER FOR AN ASSIGNMENT
CREATE TABLE ASSIGNMENT_ENROLLMENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ASSIGNMENT_ID INT NOT NULL,
    USER_ID VARCHAR(40) NOT NULL,
    PINNED BOOLEAN DEFAULT FALSE,
    CONSTRAINT U_ASSIGNMENT_ID_USER_ID UNIQUE (ASSIGNMENT_ID, USER_ID),
    CONSTRAINT FK_ASSIGNMENT_ENROLLMENT_ASSIGNMENT_ID_ASSIGNMENT_ID FOREIGN KEY (ASSIGNMENT_ID) REFERENCES ASSIGNMENT(ID)
);
-- MODELS A SOURCE
CREATE TABLE SOURCE (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(63) NOT NULL,              -- NAME OF SOURCE
    CONSTRAINT U_SOURCE_NAME UNIQUE (NAME)
);
-- MODELS A COMMENT ON A SOURCE
CREATE TABLE COMMENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    SOURCE INT NOT NULL,            -- TYPE OF SOURCE BEING COMMENTED ON
    AUTHOR_ID VARCHAR(40) NOT NULL, -- ID OF USER WHO COMMENTED
    SOURCE_ID INT NOT NULL,         -- ID OF SOURCE BEING COMMENTED ON
    CONTENT VARCHAR(MAX) DEFAULT NULL,
    VOTE_SCORE INT NOT NULL DEFAULT 0,
    CONSTRAINT FK_COMMENT_SOURCE_SOURCE_ID FOREIGN KEY (SOURCE) REFERENCES SOURCE(ID)
);
-- MODELS A VOTE ON A SOURCE
CREATE TABLE VOTE (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    SOURCE INT NOT NULL,            -- TYPE OF SOURCE BEING VOTED ON
    AUTHOR_ID VARCHAR(40) NOT NULL, -- ID OF USER WHO VOTED
    SOURCE_ID INT NOT NULL,         -- ID OF SOURCE BEING VOTED ON
    ACTION VARCHAR(63) NOT NULL,    -- EITHER UPVOTE OR DOWNVOTE
    CONSTRAINT U_VOTE_AUTHOR_ID_SOURCE_ID_SOURCE UNIQUE (AUTHOR_ID, SOURCE_ID, SOURCE),
    CONSTRAINT FK_VOTE_SOURCE_SOURCE_ID FOREIGN KEY (SOURCE) REFERENCES SOURCE(ID)
);