--1. Add trigger that will update column updated_datetime to current date in case of updating any of student. (1 point)

CREATE or replace FUNCTION student_updated() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_datetime := LOCALTIMESTAMP;
  RETURN NEW;
END;
$$;

CREATE trigger trigger_student_updated
  BEFORE UPDATE ON student
  FOR EACH ROW
  EXECUTE PROCEDURE student_updated();
  
UPDATE student SET name='POGHOS' WHERE id=4  
  
SELECT * FROM student WHERE id = 4;
