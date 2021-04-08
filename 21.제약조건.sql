--��������

--PRIMARY KEY (���̺��� ���� Ű, �ߺ�X, NULL ��� X)
--UNIQUE KEY (�ߺ� X)
--NOT NULL (NULL ��� X)
--FOREIGN KEY (�����ϴ� ���̺��� PK�� �����ϴ� �÷�, �������̺��� PK�� ���ٸ� ���X, NULL ���)
--CHECK (���ǵ� ���ĸ� ����ǵ��� ���)

DROP TABLE DEPT2;

CREATE TABLE DEPT2 ( --�� ���� ��������
    DEPT_NO NUMBER(2)       CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          CONSTRAINT DEPT2_LOCA_LOCID_FK
                            REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE          DEFAULT SYSDATE, --�ƹ��͵� �Է����� ������ �ڵ����� DEFAULT���� ����
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1)     CONSTRAINT DEPT2_DEPT_GENDER_CK 
                            CHECK(DEPT_GENDER IN ('M','F'))
);

CREATE TABLE DEPT2 ( --�� ���� �������� (�� ���������� CONSTRAINT���� ���� ����)
    DEPT_NO NUMBER(2)       PRIMARY KEY,
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE          DEFAULT SYSDATE, --�ƹ��͵� �Է����� ������ �ڵ����� DEFAULT���� ����
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL UNIQUE,
    DEPT_GENDER CHAR(1)     CHECK(DEPT_GENDER IN ('M','F'))
);


--���̺� ���� ��������

CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(15) NOT NULL,
    LOCA NUMBER(4),
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL,
    DEPT_GENDER CHAR(1),
    --���̺� ���� ���������� �Ʒ��ʿ� ������Ǹ� �и��ؼ� �ۼ� (����Ű ����)
    CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY (DEPT_NO ,DEPT_NAME),
    CONSTRAINT DEPT2_DEPT_LOCA_LOCID_FK FOREIGN KEY (LOCA)
    REFERENCES LOCATIONS (LOCATION_ID),
    CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('M', 'F'))
);

DESC DEPT2;


--���Ἲ ���� ����

--��ü ���Ἲ �������� - NULL�� �ߺ��� ������� �ʴ´�.
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID)
VALUES (100, 'TEST', 'TEST', SYSDATE, 'TEST');


--���� ���Ἲ �������� - ���� ���̺��� PK�� �����ؾ� FK�� �� �� �ִ�.
INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID,
                       DEPARTMENT_ID)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', 5);


--������ ���Ἲ �������� - ���� �÷��� ���ǿ� ���� ���̾�� �Ѵ�. 
INSERT INTO EMPLOYEES (EMPLOYEE_ID,
                       LAST_NAME,
                       EMAIL,
                       HIRE_DATE,
                       JOB_ID,
                       SALARY)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', -10);

--�������� �߰�, ����
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

--PK�߰�

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY (DEPT_NO);

--FK�߰�

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_LOCA_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID);

--CHECK�߰�

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('M', 'F'));

--UNIQUE�߰�

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);

--NOT NULL�߰� (MODIFY������ �߰�) - �Ϲ������� �������� �����Ѵ�.

ALTER TABLE DEPT2
MODIFY DEPT_PHONE VARCHAR(20) NOT NULL;

DESC DEPT2;


--���������� Ȯ��

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT2';

--�������� ����

ALTER TABLE DEPT2
DROP CONSTRAINT DEPT2_DEPT_NO_PK;

DROP TABLE DEPT2;

--���� 1.
--������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
--����) M_NAME �� ����������, �ΰ��� ������� ����
--����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
--����) GENDER ����������
--����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)

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


--���� 2.
--MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_mum, street_address, location_id
--�÷��� ��ȸ
--m_num�������� �������� ��ȸ

SELECT M.M_NAME,
       M.M_NUM,
       L.STREET_ADDRESS,
       L.LOCATION_ID
FROM MEMBERS M
INNER JOIN LOCATIONS L ON M.LOCA = L.LOCATION_ID
ORDER BY M_NUM ASC;
