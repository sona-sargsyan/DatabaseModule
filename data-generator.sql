-- a. 100K of users

-- b. 1K of subjects

-- c. 1 million of marks

CREATE OR REPLACE FUNCTION randomText ()
RETURNS varchar AS $text$
declare
	text varchar;
BEGIN
   SELECT substring(md5(random()::text) from 0 for 10) into text;
   RETURN text;
END;
$text$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION randomMark (number_range integer)
RETURNS integer AS $user$
declare
	user integer;
BEGIN
   SELECT   num
FROM     GENERATE_SERIES (1, number_range) AS s(num)
ORDER BY RANDOM() INTO user;
   RETURN user;
END;
$user$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION phone_number ()
RETURNS varchar AS $phone_number$
declare
	phone_number varchar;
BEGIN
   SELECT format('(%s%s%s) %s%s%s-%s%s%s%s'
     , a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10])
FROM  (
   SELECT ARRAY (
      SELECT trunc(random() * 10)::int
      FROM   generate_series(1, 10)
      ) AS a
   ) sub into phone_number;
   RETURN phone_number;
END;
$phone_number$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random_date ()
RETURNS timestamp AS $random_date$
declare
	random_date varchar;
BEGIN
   select timestamp '1990-01-10 20:00:00' +
       random() * (timestamp '2002-01-20 20:00:00' -
                   timestamp '1990-01-10 10:00:00') into random_date;
   RETURN random_date;
END;
$random_date$ LANGUAGE plpgsql;

INSERT INTO student VALUES (generate_series(1,100000), randomText (), randomText (),  random_date(), phone_number(), randomText (), random_date(), random_date());
INSERT INTO subject VALUES (generate_series(1,1000), randomText (), randomText ());

do $$
begin
   for counter in 1..10000 loop
   for subject_index in 1..1000 loop
	INSERT INTO exam_result VALUES (subject_index, counter, randomMark(5));
	end loop;
   end loop;
end; $$

CREATE INDEX stud_name_index ON student USING BTREE(name);
CREATE INDEX stud_surname_index ON student USING BTREE(surname);
CREATE INDEX stud_phone_index ON student USING BTREE(phone);