--4. Create function that will return average mark for input user (1 point)

CREATE OR REPLACE FUNCTION get_marks()
RETURNS SETOF record
AS $$
    SELECT studentid, AVG(result)::numeric(10,2) AS avg FROM exam_result GROUP BY studentid;
$$ LANGUAGE SQL;

SELECT get_marks();

CREATE OR REPLACE FUNCTION get_student_avgmark(student_name VARCHAR, student_surname VARCHAR)
RETURNS numeric
AS $$
    SELECT m.avg FROM get_marks() m(studentid integer, avg numeric) JOIN student s ON s.id = m.studentId 
		WHERE s.name~student_name AND s.surname~student_surname;
$$ LANGUAGE SQL;

SELECT get_student_avgmark('POGHOS', 'Hardy') 


SELECT m.avg FROM (SELECT studentid, AVG(result)::numeric(10,2) AS avg FROM exam_result GROUP BY studentid) m
JOIN student s ON s.id = m.studentId WHERE s.name~'POGHOS' AND s.surname='Hardy'


