CREATE TABLE students
(
  id serial4 primary key,
  first varchar(20),
  last varchar(20),
  dob date
);

CREATE TABLE courses
(
  id serial4 primary key,
  name varchar(50) unique not null
);

CREATE TABLE schedules
(
  id serial4 primary key,
  student_id int4 references students(id),
  course_id int4 references courses(id)
);  

INSERT INTO students (first, last, dob) VALUES ('bill', 'jones', '1/1/1990');
INSERT INTO students (first, last, dob) VALUES ('sally', 'jones', '1/1/1950');
INSERT INTO students (first, last, dob) VALUES ('sue', 'smith', '1/1/2013');
INSERT INTO courses (name) VALUES ('Biology');
INSERT INTO courses (name) VALUES ('Chemistry');
INSERT INTO courses (name) VALUES ('Physics');
INSERT INTO schedules (student_id, course_id) VALUES (2, 3);
INSERT INTO schedules (student_id, course_id) VALUES (2, 1);
INSERT INTO schedules (student_id, course_id) VALUES (2, 2);