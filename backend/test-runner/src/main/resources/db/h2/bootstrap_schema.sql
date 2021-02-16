-- SEQUENCES
CREATE SEQUENCE TEST_SUITE_SEQUENCE START 1000;
CREATE SEQUENCE TEST_CASE_SEQUENCE START 1000;
CREATE SEQUENCE SOURCE_FILE_SEQUENCE START 1000;
CREATE SEQUENCE SOURCE_FILE_SUBMISSION_SEQUENCE START 100;

-- MODELS A SUITE OF TEST CASES
CREATE TABLE TEST_SUITE (
    ID INT DEFAULT TEST_SUITE_SEQUENCE.NEXTVAL PRIMARY KEY,
    ASSIGNMENT_ID INT NOT NULL,
    NAME VARCHAR(255),
    LANG VARCHAR(255) NOT NULL
    -- FOR UNIFIED DB
    --CONSTRAINT FK_TEST_SUITE_ASSIGNMENT_ID_ASSIGNMENT_ID FOREIGN KEY (ASSIGNMENT_ID) REFERENCES ASSIGNMENT(ID) ON DELETE CASCADE
);

-- MODELS A TEST CASE
CREATE TABLE TEST_CASE (
    ID INT DEFAULT TEST_CASE_SEQUENCE.NEXTVAL PRIMARY KEY,
    SUITE_ID INT NOT NULL,
    AUTHOR_ID VARCHAR(40) NOT NULL,
    DESCRIPTION VARCHAR(255) DEFAULT NULL,
    RUN_COUNT INT DEFAULT 0,
    PASS_COUNT INT DEFAULT 0,
    LANG VARCHAR(255) NOT NULL,
    CODE NVARCHAR(MAX) DEFAULT NULL,
    CONSTRAINT FK_TEST_CASE_SUITE_ID_TEST_SUITE_ID FOREIGN KEY (SUITE_ID) REFERENCES TEST_SUITE(ID)
);

-- MODELS AN UPLOADED SOURCE FILE
CREATE TABLE SOURCE_FILE (
    ID INT DEFAULT SOURCE_FILE_SEQUENCE.NEXTVAL PRIMARY KEY,
    SUBMISSION_ID INT NOT NULL,
    ASSIGNMENT_ID INT NOT NULL,
    FILE_NAME VARCHAR(255) NOT NULL,
    -- FOR UNIFIED DB
    --CONSTRAINT FK_SOURCE_FILE_ASSIGNMENT_ID_ASSIGNMENT_ID FOREIGN KEY (ASSIGNMENT_ID) REFERENCES ASSIGNMENT(ID) ON DELETE CASCADE
    SUBMISSION_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    AUTHOR_ID VARCHAR(40) NOT NULL,
    CONTENT VARBINARY(MAX) NOT NULL
);