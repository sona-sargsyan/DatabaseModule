CREATE TABLE student (
	id serial PRIMARY KEY NOT NULL,
	name VARCHAR ( 20 ) NOT NULL,
	surname VARCHAR ( 20 ) NOT NULL,
	date_of_birth Date NOT NULL,
	phone VARCHAR ( 15 ) NULL,
	primary_skill VARCHAR ( 100 ) NULL,
	created_datetime TIMESTAMP NOT NULL,
	updated_datetime TIMESTAMP NOT NULL
);

CREATE TABLE subject  (
	id serial PRIMARY KEY NOT NULL,
	name VARCHAR ( 50 ) NOT NULL,
	tutor VARCHAR ( 50 ) NULL
);

CREATE TABLE exam_result  (
	studentid PRIMARY KEY NOT NULL,
	subjectid PRIMARY KEY NOT NULL,
	result int NOT NULL,
    FOREIGN KEY studentid
		REFERENCES student(id)
	FOREIGN KEY subjectid
		REFERENCES subject(id)
);

INSERT INTO student(id,name,surname, date_of_birth, phone, primary_skill, created_datetime, updated_datetime) 
			VALUES (default, 'Jerry', 'Smit','2000-10-24','+57522900','speacking',current_timestamp,current_timestamp),
					(default, 'Tom', 'Cruise','1950-05-02','+57587700','acting',current_timestamp,current_timestamp),
					(default, 'Tom', 'Hardy','1980-12-02','+575849011','smoking',current_timestamp,current_timestamp);
			
SELECT * FROM student

INSERT INTO subject(id,name,tutor)
			VALUES (default, 'biography', 'Mr. Smit'),
					(default, 'mathematics', 'Nora Calderwood'),
					(default, 'applyed mathematics', 'Nora Calderwood'),
					(default, 'chemistry', 'Mr. Hardy');
			
SELECT * FROM subject

INSERT INTO exam_result(subjectId,studentId,result)
			VALUES (1, 1, 5),
					(1, 2, 4),
					(1, 3, 4),
					(1, 4, 3);
			
SELECT * FROM exam_result

-- Index B-Tree
CREATE INDEX ix_student_name ON student (name);

-- Index Hash
CREATE INDEX ix_example_result ON example_result USING HASH (result)

-- Index GIN
CREATE INDEX ix_subject_name ON subject USING GIN (name)

-- Index GIST
CREATE INDEX ix_primary_skill ON student USING GIST (primary_skill)


-- Test queries:
-- a. 
EXPLAIN ANALYZE SELECT * FROM student WHERE name='Tom';

-- b.
EXPLAIN ANALYZE SELECT * FROM student WHERE surname='Smit';

EXPLAIN ANALYZE SELECT * FROM exam_result

-- c.
EXPLAIN ANALYZE SELECT * FROM public.student WHERE phone~'00';

-- d.
EXPLAIN ANALYZE SELECT s.name,s.surname,m.result
	FROM exam_result m JOIN student s ON s.id = m.studentId 
	WHERE s.surname~'Smi';


SELECT
    pg_size_pretty (pg_indexes_size('student'));
	
SELECT
    pg_size_pretty (pg_indexes_size('subject'));
	
SELECT
    pg_size_pretty (pg_indexes_size('exam_result'));