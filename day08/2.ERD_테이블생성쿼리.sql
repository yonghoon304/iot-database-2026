CREATE TABLE `Lecture` (
	`lec_cd`	CHAR(4)	NOT NULL,
	`lec_name`	VARCHAR(20)	NOT NULL,
	`ims_no`	INT	NOT NULL
);

CREATE TABLE `Student` (
	`std_no`	INT	NOT NULL,
	`std_name`	VARCHAR(10)	NOT NULL,
	`std_tel`	VARCHAR(13)	NOT NULL
);

CREATE TABLE `Enrollment` (
	`std_no`	INT	NOT NULL,
	`lec_cd`	CHAR(4)	NOT NULL,
	`enr_dt`	DATETIME	NULL	DEFAULT now(),
	`grade`	VARCHAR(2)	NULL
);

CREATE TABLE `Instructor` (
	`ims_no`	INT	NOT NULL,
	`ims_name`	VARCHAR(10)	NOT NULL,
	`ims_tel`	VARCHAR(13)	NULL
);

ALTER TABLE `Lecture` ADD CONSTRAINT `PK_LECTURE` PRIMARY KEY (
	`lec_cd`
);

ALTER TABLE `Student` ADD CONSTRAINT `PK_STUDENT` PRIMARY KEY (
	`std_no`
);

ALTER TABLE `Enrollment` ADD CONSTRAINT `PK_ENROLLMENT` PRIMARY KEY (
	`std_no`,
	`lec_cd`
);

ALTER TABLE `Instructor` ADD CONSTRAINT `PK_INSTRUCTOR` PRIMARY KEY (
	`ims_no`
);

ALTER TABLE `Lecture` ADD CONSTRAINT `FK_Instructor_TO_Lecture_1` FOREIGN KEY (
	`ims_no`
)
REFERENCES `Instructor` (
	`ims_no`
);

ALTER TABLE `Enrollment` ADD CONSTRAINT `FK_Student_TO_Enrollment_1` FOREIGN KEY (
	`std_no`
)
REFERENCES `Student` (
	`std_no`
);

ALTER TABLE `Enrollment` ADD CONSTRAINT `FK_Lecture_TO_Enrollment_1` FOREIGN KEY (
	`lec_cd`
)
REFERENCES `Lecture` (
	`lec_cd`
);

