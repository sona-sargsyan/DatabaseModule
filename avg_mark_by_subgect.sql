-- 5. Create function that will return avarage mark for input subject name (1 point)

CREATE OR REPLACE FUNCTION get_subject_avgmark(subgect_name varchar) 
RETURNS numeric AS $$
	SELECT m.avg FROM (SELECT subjectid, AVG(result)::numeric(10,2) AS avg FROM exam_result GROUP BY subjectid) m
	JOIN subject s ON s.id = m.subjectid WHERE s.name~subgect_name;
$$
LANGUAGE sql;	
	
SELECT get_subject_avgmark('biography');

SELECT m.avg FROM (SELECT subjectid, AVG(result)::numeric(10,2) AS avg FROM exam_result GROUP BY subjectid) m
JOIN subject s ON s.id = m.subjectid WHERE s.name~'biography'
