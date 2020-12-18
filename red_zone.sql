-- 6. Create function that will return student at "red zone" (red zone means at least 2 marks <=3) (1 point)

CREATE OR REPLACE FUNCTION get_student_in_redzone() 
RETURNS record AS $$
	SELECT red.name, red.surname FROM (
		SELECT s.name, s.surname, m.result FROM exam_result m
			JOIN student s ON s.id = m.studentId WHERE m.result<=3) AS red 
			GROUP BY red.name, red.surname HAVING COUNT(*) >=2;
$$			
LANGUAGE sql;	

DROP FUNCTION get_student_in_redzone();

SELECT * from get_student_in_redzone() AS (name varchar, surname varchar);

SELECT red.name, red.surname FROM (
	SELECT s.name, s.surname, m.result FROM exam_result m
		JOIN student s ON s.id = m.studentId WHERE m.result<=3) AS red 
		GROUP BY red.name, red.surname HAVING COUNT(*) >=2;