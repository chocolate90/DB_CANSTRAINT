--제약조건

--PRIMARY KEY (테이블의 고유 키, 중복X, NULL 허용 X)
--UNIQUE KEY (중복 X)
--NOT NULL (NULL 허용 X)
--FOREIGN KEY (참조하는 테이블의 PK를 저장하는 컬럼, 참조테이블의 PK가 없다면 등록X, NULL 허용)
--CHECK (정의된 형식만 저장되도록 허용)

DROP TABLE DEPT2;

CREATE TABLE DEPT2 ( --열 레벨 제약조건
    DEPT_NO NUMBER(2)       CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          CONSTRAINT DEPT2_LOCA_LOCID_FK
                            REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE          DEFAULT SYSDATE, --아무것도 입력하지 않으면 자동으로 DEFAULT값이 저장
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1)     CONSTRAINT DEPT2_DEPT_GENDER_CK 
                            CHECK(DEPT_GENDER IN ('M','F'))
);

CREATE TABLE DEPT2 ( --열 레벨 제약조건 (열 레벨에서는 CONSTRAINT구문 생략 가능)
    DEPT_NO NUMBER(2)       PRIMARY KEY,
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE          DEFAULT SYSDATE, --아무것도 입력하지 않으면 자동으로 DEFAULT값이 저장
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL UNIQUE,
    DEPT_GENDER CHAR(1)     CHECK(DEPT_GENDER IN ('M','F'))
);


--테이블 레벨 제약조건

CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(15) NOT NULL,
    LOCA NUMBER(4),
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL,
    DEPT_GENDER CHAR(1),
    --테이블 레벨 제약조건은 아래쪽에 재약조건만 분리해서 작성 (슈퍼키 가능)
    CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY (DEPT_NO ,DEPT_NAME),
    CONSTRAINT DEPT2_DEPT_LOCA_LOCID_FK FOREIGN KEY (LOCA)
    REFERENCES LOCATIONS (LOCATION_ID),
    CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('M', 'F'))
);

DESC DEPT2;


--무결성 제약 조건

--개체 무결성 제약조건 - NULL과 중복을 허용하지 않는다.
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID)
VALUES (100, 'TEST', 'TEST', SYSDATE, 'TEST');


--참조 무결성 제약조건 - 참조 테이블의 PK에 존재해야 FK에 들어갈 수 있다.
INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID,
                       DEPARTMENT_ID)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', 5);


--도메인 무결성 제약조건 - 값이 컬럼의 정의에 속한 값이어야 한다. 
INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID,
                       SALARY)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', -10);

--제약조건 추가, 삭제
DROP TABLE DEPT2;

CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(15),
    LOCA NUMBER(4),
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20),
    DEPT_GENDER CHAR(1)
);

--PK추가

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY (DEPT_NO);

--FK추가

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_LOCA_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID);

--CHECK추가

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('M', 'F'));

--UNIQUE추가

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);

--NOT NULL추가 (MODIFY문으로 추가) - 일반적으로 열레벨로 정의한다.

ALTER TABLE DEPT2
MODIFY DEPT_PHONE VARCHAR(20) NOT NULL;

DESC DEPT2;


--제약조건의 확인

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT2';

--제약조건 삭제

ALTER TABLE DEPT2
DROP CONSTRAINT DEPT2_DEPT_NO_PK;

DROP TABLE DEPT2;

--문제 1.
--다음과 같은 테이블을 생성하고 데이터를 insert하세요 (커밋)
--조건) M_NAME 는 가변문자형, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형, 이름(mem_memnum_pk) primary key
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, 이름:(mem_regdate_uk) UNIQUE키
--조건) GENDER 가변문자형
--조건) LOCA 숫자형, 이름:(mem_loca_loc_locid_fk) foreign key ? 참조 locations테이블(location_id)

CREATE TABLE MEMBERS (
    M_NAME VARCHAR2(20)      NOT NULL,
    M_NUM NUMBER(3)         CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE           NOT NULL 
                            CONSTRAINT MEM_REGDATE_UK UNIQUE,
    GENDER CHAR(1)          CONSTRAINT MEMBERS_GENDER_CK
                            CHECK (GENDER IN ('M', 'F')),
    LOCA NUMBER(4)          CONSTRAINT MEM_LOCA_LOC_LOCID_FK
                            REFERENCES LOCATIONS (LOCATION_ID)
);

DESC MEMBERS;

INSERT INTO MEMBERS
VALUES ('AAA', 1, '2018-07-01', 'M', 1800);

INSERT INTO MEMBERS
VALUES ('BBB', 2, '2018-07-02', 'F', 1900);

INSERT INTO MEMBERS
VALUES ('CCC', 3, '2018-07-03', 'M', 2000);

INSERT INTO MEMBERS
VALUES ('DDD', 4, SYSDATE, 'M', 2000);

SELECT * FROM MEMBERS;

COMMIT;


--문제 2.
--MEMBERS테이블과 LOCATIONS테이블을 INNER JOIN 하고 m_name, m_mum, street_address, location_id
--컬럼만 조회
--m_num기준으로 오름차순 조회

SELECT M.M_NAME,
       M.M_NUM,
       L.STREET_ADDRESS,
       L.LOCATION_ID
FROM MEMBERS M
INNER JOIN LOCATIONS L ON M.LOCA = L.LOCATION_ID
ORDER BY M_NUM ASC;
