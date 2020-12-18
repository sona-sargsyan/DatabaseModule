-- 2. Add validation on DB level that will check username on special characters (reject student name with next characters '@', '#', '$') (1 point)


ALTER TABLE
  student
ADD
  CONSTRAINT "name_@character_check" CHECK (name :: text ! ~ ~ '%@%' :: text) NOT VALID,
ADD
  CONSTRAINT "name_$character_check CHECK (name :: text ! ~ ~ '%$%' :: text) NOT VALID,
Add
  CONSTRAINT "name_#character_chack" CHECK (name :: text ! ~ ~ '%#%' :: text) NOT VALID
  
	   
ALTER TABLE student
    DROP CONSTRAINT ck_no_special_characters;
	    
	   
INSERT INTO student(id,name,surname, date_of_birth, phone, primary_skill, created_datetime, updated_datetime) 
	VALUES (default, 'Je55rry$', 'Smit','2000-10-24','+57522900','speacking',current_timestamp,current_timestamp);
			
UPDATE student SET name='Je#rh' where id = 5;

Select * from student 