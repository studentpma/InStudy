/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     5/20/2017 12:41:10 PM                        */
/*==============================================================*/


alter table FAQS
   drop constraint FK_FAQS_STUDENT_Q_STUDENT;

alter table FAQS
   drop constraint FK_FAQS_TASK_FAQS_TASK;

alter table FAQS
   drop constraint FK_FAQS_TEACHER_A_TEACHER;

alter table SCHEDULE
   drop constraint FK_SCHEDULE_SCHEDULE__DISCIPLI;

alter table SCHEDULE
   drop constraint FK_SCHEDULE_SCHEDULE__GROUP;

alter table SCHEDULE
   drop constraint FK_SCHEDULE_SCHEDULE__TEACHER;

alter table STUDENT
   drop constraint FK_STUDENT_STUDENT_I_GROUP;

alter table STUDENT
   drop constraint FK_STUDENT_USER_STUD_USER;

alter table STUDENTWORK
   drop constraint FK_STUDENTW_STUDENT_W_STUDENT;

alter table STUDENTWORK
   drop constraint FK_STUDENTW_TASK_WORK_TASK;

alter table TASK
   drop constraint FK_TASK_DISCIPLIN_DISCIPLI;

alter table TASK
   drop constraint FK_TASK_SUB_TASK_TASK;

alter table TASK
   drop constraint FK_TASK_TASK_TYPE_TASKTYPE;

alter table TEACHER
   drop constraint FK_TEACHER_USER_TEAC_USER;

drop table DISCIPLINE cascade constraints;

drop index TEACHER_ANSWER_FK;

drop index STUDENT_QUESTION_FK;

drop index TASK_FAQS_FK;

drop table FAQS cascade constraints;

drop table "GROUP" cascade constraints;

drop index SCHEDULE_GROUP_FK;

drop index SCHEDULE_TEACHER_FK;

drop index SCHEDULE_DISCIPLINE_FK;

drop table SCHEDULE cascade constraints;

drop index STUDENT_IN_GROUP_FK;

drop index USER_STUDENT_FK;

drop table STUDENT cascade constraints;

drop index STUDENT_WORK_FK;

drop index TASK_WORK_FK;

drop table STUDENTWORK cascade constraints;

drop index TASK_TYPE_FK;

drop index SUB_TASK_FK;

drop index DISCIPLINE_TASK_FK;

drop table TASK cascade constraints;

drop table TASKTYPES cascade constraints;

drop index USER_TEACHER_FK;

drop table TEACHER cascade constraints;

drop table "USER" cascade constraints;

/*==============================================================*/
/* Table: DISCIPLINE                                            */
/*==============================================================*/
create table DISCIPLINE 
(
   DISCIPLINE_CODE      INTEGER              not null,
   DISCIPLINE_NAME      VARCHAR2(50)         not null,
   constraint PK_DISCIPLINE primary key (DISCIPLINE_CODE)
);

/*==============================================================*/
/* Table: FAQS                                                  */
/*==============================================================*/
create table FAQS 
(
   STUDENT_ID           NUMBER               not null,
   TASK_ID              NUMBER               not null,
   FAQS_QUESTION_TIME   DATE                 not null,
   FAQS_QUESTION        VARCHAR2(500)        not null,
   TEACHER_ID           NUMBER,
   FAQS_ANSWER_TIME     DATE,
   FAQS_ANSWER          VARCHAR2(500),
   constraint PK_FAQS primary key (STUDENT_ID, TASK_ID, FAQS_QUESTION_TIME)
);

/*==============================================================*/
/* Index: TASK_FAQS_FK                                          */
/*==============================================================*/
create index TASK_FAQS_FK on FAQS (
   TASK_ID ASC
);

/*==============================================================*/
/* Index: STUDENT_QUESTION_FK                                   */
/*==============================================================*/
create index STUDENT_QUESTION_FK on FAQS (
   STUDENT_ID ASC
);

/*==============================================================*/
/* Index: TEACHER_ANSWER_FK                                     */
/*==============================================================*/
create index TEACHER_ANSWER_FK on FAQS (
   TEACHER_ID ASC
);

/*==============================================================*/
/* Table: "GROUP"                                               */
/*==============================================================*/
create table "GROUP" 
(
   GROUP_CODE           VARCHAR2(10)         not null,
   constraint PK_GROUP primary key (GROUP_CODE)
);

/*==============================================================*/
/* Table: SCHEDULE                                              */
/*==============================================================*/
create table SCHEDULE 
(
   TEACHER_ID           NUMBER               not null,
   GROUP_CODE           VARCHAR2(10)         not null,
   DISCIPLINE_CODE      INTEGER              not null,
   SCHEDULE_DATE        DATE                 not null,
   SCHEDULE_ROOM        NUMBER               not null,
   constraint PK_SCHEDULE primary key (TEACHER_ID, GROUP_CODE, DISCIPLINE_CODE, SCHEDULE_DATE)
);

/*==============================================================*/
/* Index: SCHEDULE_DISCIPLINE_FK                                */
/*==============================================================*/
create index SCHEDULE_DISCIPLINE_FK on SCHEDULE (
   DISCIPLINE_CODE ASC
);

/*==============================================================*/
/* Index: SCHEDULE_TEACHER_FK                                   */
/*==============================================================*/
create index SCHEDULE_TEACHER_FK on SCHEDULE (
   TEACHER_ID ASC
);

/*==============================================================*/
/* Index: SCHEDULE_GROUP_FK                                     */
/*==============================================================*/
create index SCHEDULE_GROUP_FK on SCHEDULE (
   GROUP_CODE ASC
);

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT 
(
   STUDENT_ID           NUMBER               not null,
   GROUP_CODE           VARCHAR2(10)         not null,
   STUDENT_START        DATE                 not null,
   USER_PHONE           VARCHAR2(20),
   STUDENT_END          DATE,
   constraint PK_STUDENT primary key (STUDENT_ID)
);

/*==============================================================*/
/* Index: USER_STUDENT_FK                                       */
/*==============================================================*/
create index USER_STUDENT_FK on STUDENT (
   USER_PHONE ASC
);

/*==============================================================*/
/* Index: STUDENT_IN_GROUP_FK                                   */
/*==============================================================*/
create index STUDENT_IN_GROUP_FK on STUDENT (
   GROUP_CODE ASC
);

/*==============================================================*/
/* Table: STUDENTWORK                                           */
/*==============================================================*/
create table STUDENTWORK 
(
   STUDENT_ID           NUMBER               not null,
   TASK_ID              NUMBER               not null,
   STUDENT_WORK_FILE    BLOB,
   STUDENT_WORK_TEXT    VARCHAR2(500)        not null,
   STUDENT_WORK_MARK    INTEGER,
   STUDENT_WORK_DATE    DATE                 not null,
   constraint PK_STUDENTWORK primary key (STUDENT_ID, TASK_ID)
);

/*==============================================================*/
/* Index: TASK_WORK_FK                                          */
/*==============================================================*/
create index TASK_WORK_FK on STUDENTWORK (
   TASK_ID ASC
);

/*==============================================================*/
/* Index: STUDENT_WORK_FK                                       */
/*==============================================================*/
create index STUDENT_WORK_FK on STUDENTWORK (
   STUDENT_ID ASC
);

/*==============================================================*/
/* Table: TASK                                                  */
/*==============================================================*/
create table TASK 
(
   TASK_ID              NUMBER               not null,
   PARENT_TASK_ID       NUMBER,
   DISCIPLINE_CODE      INTEGER              not null,
   TASK_DATE            DATE                 not null,
   TASK_TYPE_CODE       INTEGER              not null,
   TASK_DESCRIPTION     VARCHAR2(500),
   constraint PK_TASK primary key (TASK_ID)
);

/*==============================================================*/
/* Index: DISCIPLINE_TASK_FK                                    */
/*==============================================================*/
create index DISCIPLINE_TASK_FK on TASK (
   DISCIPLINE_CODE ASC
);

/*==============================================================*/
/* Index: SUB_TASK_FK                                           */
/*==============================================================*/
create index SUB_TASK_FK on TASK (
   PARENT_TASK_ID ASC
);

/*==============================================================*/
/* Index: TASK_TYPE_FK                                          */
/*==============================================================*/
create index TASK_TYPE_FK on TASK (
   TASK_TYPE_CODE ASC
);

/*==============================================================*/
/* Table: TASKTYPES                                             */
/*==============================================================*/
create table TASKTYPES 
(
   TASK_TYPE_CODE       INTEGER              not null,
   TASK_TYPE_NAME       VARCHAR2(200)        not null,
   constraint PK_TASKTYPES primary key (TASK_TYPE_CODE)
);

/*==============================================================*/
/* Table: TEACHER                                               */
/*==============================================================*/
create table TEACHER 
(
   TEACHER_ID           NUMBER               not null,
   USER_PHONE           VARCHAR2(20)         not null,
   TEACHER_START        DATE                 not null,
   TEACHER_END          DATE,
   constraint PK_TEACHER primary key (TEACHER_ID)
);

/*==============================================================*/
/* Index: USER_TEACHER_FK                                       */
/*==============================================================*/
create index USER_TEACHER_FK on TEACHER (
   USER_PHONE ASC
);

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" 
(
   USER_PHONE           VARCHAR2(20)         not null,
   USER_PASSWORD        VARCHAR2(10)         not null,
   USER_EMAIL           VARCHAR2(50)         not null,
   USER_FIRSTNAME       VARCHAR2(20)         not null,
   USER_LASTNAME        VARCHAR2(20)         not null,
   USER_BIRTHDAY        DATE                 not null,
   USER_AVATAR          BLOB,
   constraint PK_USER primary key (USER_PHONE)
);

alter table FAQS
   add constraint FK_FAQS_STUDENT_Q_STUDENT foreign key (STUDENT_ID)
      references STUDENT (STUDENT_ID);

alter table FAQS
   add constraint FK_FAQS_TASK_FAQS_TASK foreign key (TASK_ID)
      references TASK (TASK_ID);

alter table FAQS
   add constraint FK_FAQS_TEACHER_A_TEACHER foreign key (TEACHER_ID)
      references TEACHER (TEACHER_ID);

alter table SCHEDULE
   add constraint FK_SCHEDULE_SCHEDULE__DISCIPLI foreign key (DISCIPLINE_CODE)
      references DISCIPLINE (DISCIPLINE_CODE);

alter table SCHEDULE
   add constraint FK_SCHEDULE_SCHEDULE__GROUP foreign key (GROUP_CODE)
      references "GROUP" (GROUP_CODE);

alter table SCHEDULE
   add constraint FK_SCHEDULE_SCHEDULE__TEACHER foreign key (TEACHER_ID)
      references TEACHER (TEACHER_ID);

alter table STUDENT
   add constraint FK_STUDENT_STUDENT_I_GROUP foreign key (GROUP_CODE)
      references "GROUP" (GROUP_CODE);

alter table STUDENT
   add constraint FK_STUDENT_USER_STUD_USER foreign key (USER_PHONE)
      references "USER" (USER_PHONE);

alter table STUDENTWORK
   add constraint FK_STUDENTW_STUDENT_W_STUDENT foreign key (STUDENT_ID)
      references STUDENT (STUDENT_ID);

alter table STUDENTWORK
   add constraint FK_STUDENTW_TASK_WORK_TASK foreign key (TASK_ID)
      references TASK (TASK_ID);

alter table TASK
   add constraint FK_TASK_DISCIPLIN_DISCIPLI foreign key (DISCIPLINE_CODE)
      references DISCIPLINE (DISCIPLINE_CODE);

alter table TASK
   add constraint FK_TASK_SUB_TASK_TASK foreign key (PARENT_TASK_ID)
      references TASK (TASK_ID)
      on delete cascade;

alter table TASK
   add constraint FK_TASK_TASK_TYPE_TASKTYPE foreign key (TASK_TYPE_CODE)
      references TASKTYPES (TASK_TYPE_CODE);

alter table TEACHER
   add constraint FK_TEACHER_USER_TEAC_USER foreign key (USER_PHONE)
      references "USER" (USER_PHONE);

