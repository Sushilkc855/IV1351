CREATE TABLE administrative_staff (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 availabel_instructor VARCHAR(200),
 availabel_time_and_date TIMESTAMP(5)
);

ALTER TABLE administrative_staff ADD CONSTRAINT PK_administrative_staff PRIMARY KEY (id);


CREATE TABLE adress (
 street VARCHAR(500),
 zip_code VARCHAR(500),
 city VARCHAR(500)
);


CREATE TABLE email_adress (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email_adress_UNIQUE VARCHAR(300) NOT NULL
);

ALTER TABLE email_adress ADD CONSTRAINT PK_email_adress PRIMARY KEY (id);


CREATE TABLE person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(200),
 last_name VARCHAR(200),
 person_number_UNIQUE VARCHAR(13),
 street VARCHAR(500),
 zip_code VARCHAR(500),
 city VARCHAR(500)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE person_email (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email_adress_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (person_id,email_adress_id);


CREATE TABLE phone_number (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_no_UNIQUE VARCHAR(50) NOT NULL
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (id);


CREATE TABLE prices (
 price_biginner_intermediate FLOAT(10) NOT NULL,
 price_advanced FLOAT(10) NOT NULL,
 price_individual FLOAT(10) NOT NULL,
 price_group_lessons FLOAT(10) NOT NULL
);


CREATE TABLE scheduled_time_slot (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time_slots TIMESTAMP(5),
 time_and_date TIMESTAMP(5)
);

ALTER TABLE scheduled_time_slot ADD CONSTRAINT PK_scheduled_time_slot PRIMARY KEY (id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(100) NOT NULL,
 student_identification_UNIQUE VARCHAR(100) NOT NULL,
 number_of_lesson_taken INT,
 instrument VARCHAR(200)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE discount (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 discount_percentage FLOAT(10)
);

ALTER TABLE discount ADD CONSTRAINT PK_discount PRIMARY KEY (student_id);


CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id_UNIQUE VARCHAR(200),
 number_of_group_lessions INT,
 number_of_individual_lessions INT,
 instrument VARCHAR(200)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(200) NOT NULL,
 time_and_date TIMESTAMP(5),
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE person_phone (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_number_id);


CREATE TABLE renting_instrument (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_type VARCHAR(10),
 stock INT,
 price_of_instrument FLOAT(10),
 renting_period VARCHAR(100)
);

ALTER TABLE renting_instrument ADD CONSTRAINT PK_renting_instrument PRIMARY KEY (student_id);


CREATE TABLE siblings (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id_UNIQUE VARCHAR(100),
 relation VARCHAR(100),
 number_of_siblings INT
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (student_id);


CREATE TABLE ensembles (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 genre VARCHAR(200) NOT NULL,
 min_number_of_students INT NOT NULL,
 max_number_of_students INT NOT NULL
);

ALTER TABLE ensembles ADD CONSTRAINT PK_ensembles PRIMARY KEY (lesson_id);


CREATE TABLE group_lessons (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(200) NOT NULL,
 max_number_of_students INT NOT NULL,
 min_number_of_students INT NOT NULL
);

ALTER TABLE group_lessons ADD CONSTRAINT PK_group_lessons PRIMARY KEY (lesson_id);


CREATE TABLE individual_lessons (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 administrative_staff_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(200) NOT NULL
);

ALTER TABLE individual_lessons ADD CONSTRAINT PK_individual_lessons PRIMARY KEY (lesson_id,administrative_staff_id);


CREATE TABLE lesson_time (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 scheduled_time_slot INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE lesson_time ADD CONSTRAINT PK_lesson_time PRIMARY KEY (lesson_id,scheduled_time_slot);


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (email_adress_id) REFERENCES email_adress (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE discount ADD CONSTRAINT FK_discount_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_number_id) REFERENCES phone_number (id);


ALTER TABLE renting_instrument ADD CONSTRAINT FK_renting_instrument_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE ensembles ADD CONSTRAINT FK_ensembles_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE group_lessons ADD CONSTRAINT FK_group_lessons_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE individual_lessons ADD CONSTRAINT FK_individual_lessons_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE individual_lessons ADD CONSTRAINT FK_individual_lessons_1 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id);


ALTER TABLE lesson_time ADD CONSTRAINT FK_lesson_time_0 FOREIGN KEY (lesson_id) REFERENCES ensembles (lesson_id);
ALTER TABLE lesson_time ADD CONSTRAINT FK_lesson_time_1 FOREIGN KEY (scheduled_time_slot) REFERENCES scheduled_time_slot (id);
ALTER TABLE lesson_time ADD CONSTRAINT FK_lesson_time_2 FOREIGN KEY (lesson_id) REFERENCES group_lessons (lesson_id);


