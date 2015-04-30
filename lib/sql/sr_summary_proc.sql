CREATE PROCEDURE create_sr_summaries(IN sr_select_query TEXT)
  BEGIN
  DECLARE stmt TEXT;

  DROP TEMPORARY TABLE IF EXISTS survey_response_summaries;
  CREATE TEMPORARY TABLE survey_response_summaries (
    total INT, 
    questions INT, 
    answered INT, 
    na INT,
    survey_id VARCHAR(20),
    table_name VARCHAR(20), 
    field VARCHAR(30), 
    na_field VARCHAR(30)
  );

  SET @stmt = sr_select_query;
  PREPARE sr_query FROM @stmt;

  INSERT INTO survey_response_summaries
  SELECT s.table_name, s.id AS survey_id, sr.*
  FROM surveys s
  INNER JOIN (EXECUTE sr_query) AS sr
  ON s.response_type = sr.response_type;

  DEALLOCATE PREPARE sr_query;
END

Survey.all.joins('INNER JOIN (SELECT * FROM survey_responses) AS sr ON surveys.response_type = sr.response_type')

 q.field, q.na_field
  INNER JOIN questions q
  ON sr.survey_id = q.survey_id
  WHERE


CREATE PROCEDURE create_sr_summaries(IN sr_id_list TEXT)
  BEGIN
  DECLARE stmt TEXT;

  DROP TEMPORARY TABLE IF EXISTS temp_survey_responses;
  CREATE TEMPORARY TABLE temp_survey_responses LIKE survey_responses;
  SET @stmt := CONCAT('INSERT INTO temp_survey_responses ',
    'SELECT * FROM survey_responses WHERE survey_responses.id IN (', 
    sr_id_list ,')'
  );
  PREPARE sr_query FROM @stmt;
  EXECUTE sr_query;
  DEALLOCATE PREPARE sr_query;

  DROP TEMPORARY TABLE IF EXISTS survey_response_summaries;
  CREATE TEMPORARY TABLE survey_response_summaries

  survey_response_id, response_id, election_id, response_type, county_id, updated_at, created_at


  INSERT INTO survey_response_summaries
  (survey_response_id, question_id, data_type)
  SELECT tsr.id AS survey_response_id, 
    tsr.response_type AS response_type, 
    tsr.response_type AS survey_id,
    tsr.election_id,
    tsr.county_id,
    tsr.created_at,
    tsr.updated_at,
    q.
  FROM temp_survey_responses tsr
  INNER JOIN questions q
  ON tsr.response_type = q.survey_id;

  -- take a survey_response, get its response, 
  -- then loop through the matching summary rows, joining each in turn with its question row

  DECLARE sr_cursor CURSOR FOR SELECT id FROM temp_survey_responses;
  DECLARE sr_no_more_rows BOOLEAN := FALSE;
  DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET sr_no_more_rows := TRUE;
  OPEN sr_cursor;
    SR_LOOP: LOOP
      FETCH sr_cursor

  SELECT * FROM survey_response_summaries;
END

  REPLACE survey_response_values
  (survey_response_id, question_id, data_type, integer_value, decimal_value, string_value, text_value, na_value)

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sr_values`(IN survey_response_id int)
BEGIN
    DECLARE sr_id, q_id, response_id, integer_value int;
    DECLARE data_type, field, na_field, table_name varchar(30);
    DECLARE na_able, na_value tinyint(1);
    DECLARE decimal_value decimal;
    DECLARE string_value, val_query varchar(255);
    DECLARE text_value text;
    DECLARE srq_no_more_rows tinyint(1) DEFAULT 0;

    DECLARE srq_cursor CURSOR FOR 
      SELECT 
        sr.id, sr.response_id, q.id, q.data_type, q.field, q.na_field, q.na_able, q.table_name
      FROM survey_responses sr
      INNER JOIN questions q
        ON q.survey_id = sr.response_type
      WHERE sr.id = survey_response_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET srq_no_more_rows := 1;

    OPEN srq_cursor;
    SRQ_LOOP: LOOP
      SET integer_value = NULL;
      SET decimal_value := NULL;
      SET string_value  := NULL;
      SET text_value    := NULL;
      SET na_value      := NULL;

      FETCH srq_cursor INTO 
        sr_id, response_id, q_id, data_type, field, na_field, na_able, table_name;
            
      IF srq_no_more_rows = 1 THEN
        CLOSE srq_cursor;
        LEAVE SRQ_LOOP;
      END IF;
      
      CASE na_able
        WHEN 0 THEN
          SET @val_query := CONCAT(
          'SELECT ', field, 
          ' INTO ', data_type, '_value', 
          ' FROM ', table_name, ' WHERE ', table_name, '.id = ', response_id, ';' );
        WHEN 1 THEN
          SET @val_query := CONCAT(
          'SELECT ', field, ', ', na_field,
          ' INTO ', data_type, '_value, na_value', 
          ' FROM ', table_name, ' WHERE ', table_name, '.id = ', response_id, ';' );
          ELSE BEGIN END;
      END CASE;

      PREPARE val_stmt FROM @val_query;
      EXECUTE val_stmt;
      DEALLOCATE PREPARE val_stmt;

      REPLACE INTO survey_response_values (
        survey_response_id, question_id, 
        data_type, integer_value, decimal_value, string_value, text_value, na_value 
        )
      SELECT 
        s_id, q_id, 
        data_type, integer_value, decimal_value, string_value, text_value, na_value
      ;
    END LOOP SRQ_LOOP;
  END;



  SELECT SUM(integer_value)
  FROM survey_response_values vals
  RIGHT JOIN survey_responses sr
    ON sr.id = vals.survey_response_id
  LEFT JOIN questions AS q
    ON vals.question_id = q.id
  WHERE 
    q.sum_able = TRUE 
    AND (na_value = FALSE OR q.na_able = FALSE) 
    AND vals.survey_response_id



    survey_response_id INT,
    response_id INT, 
    election_id INT, 
    response_type VARCHAR(20), 
    survey_id VARCHAR(20),
    county_id INT,
    updated_at DATETIME,
    created_at DATETIME,

    na_value BOOLEAN,
    data_type VARCHAR(30),
    int_value INT,
    dec_value DECIMAL,
    text_value TEXT,
    str_value VARCHAR(),
    survey_id VARCHAR(20),
    table_name VARCHAR(20), 
    field VARCHAR(30), 
    na_field VARCHAR(30)

  -- SET @stmt = CONCAT('INSERT INTO survey_response_summaries ',
  --   '(survey_response_id, response_id, election_id, response_type, county_id, updated_at, created_at) ', 
  --   sr_select_query);
  -- PREPARE sr_query FROM @stmt;
  -- EXECUTE sr_query;
  -- DEALLOCATE PREPARE sr_query;

-- i guess dup the temp table to insert into. that should take care of it
-- also could use this logic in a trigger on survey_response
-- with a proc that I can run on all existing records


-- i can make the new table from a select statement. or do something usable for a trigger.

  CREATE TEMPORARY TABLE survey_response_summaries
  SELECT temp_survey_responses.*, s.table_name, s.id AS survey_id
  FROM temp_survey_responses
  INNER JOIN surveys s
  ON temp_survey_responses.response_type = s.response_type;
  -- WHERE survey_responses.id IN



  -- INSERT INTO survey_response_summaries
  -- (survey_response_id, response_id, election_id, response_type, county_id, updated_at, created_at, table_name, survey_id)
  -- SELECT survey_response_summaries.*, s.table_name, s.id AS survey_id
  -- FROM survey_response_summaries
  -- INNER JOIN surveys s
  -- ON survey_response_summaries.response_type = s.response_type;



-- damn, remembered you can't do this... what's group_concat?
  -- SET @stmt = CONCAT('SELECT * FROM survey_responses WHERE survey_responses.id IN ', sr_id_list);
  -- PREPARE sr_query FROM @stmt;

  -- INSERT INTO survey_response_summaries
  -- (survey_response_id, response_id, election_id, response_type, county_id, updated_at, created_at, table_name, survey_id)
  -- SELECT sr.*, s.table_name, s.id AS survey_id
  -- FROM (EXECUTE sr_query) sr
  -- INNER JOIN surveys s
  -- ON sr.response_type = s.response_type;

  -- DEALLOCATE PREPARE sr_query;




END


    -- SET @stmt = 'DROP TEMPORARY TABLE IF EXISTS survey_response_summaries';
    -- PREPARE sr_query FROM @stmt;
    -- EXECUTE sr_query;
    -- DEALLOCATE PREPARE sr_query;

    -- SET @stmt = CONCAT( 'CREATE TEMPORARY TABLE survey_response_summaries', 
    --         '(total INT, questions INT, answered INT, na INT,',
    --         ' survey_id VARCHAR(20) table_name VARCHAR(20), field VARCHAR(30), na_field VARCHAR(30))',
    --         sr_select_query );

DROP PROCEDURE IF EXISTS calc_survey_responses $$

join table with each question, and a lookup of its values like CONCAT(survey.table_name '.', question.field, ' as value ', survey.table_name, '.', question.na_field, 'as na_value'

  or join on field value = column name value, is that possible?

// put all this in the first proc to create the temp table
-- can I just select the ones from temp_table here?

SELECT s.table_name, s.id AS survey_id, q.field, q.na_field
FROM temp_table tt
INNER JOIN surveys s
ON tt.response_type = s.response_type
INNER JOIN questions q
ON tt.survey_id = q.survey_id

// okay so do I change the foreign key in questions to response_type? can I just call it id then? yeah, I can. fack.


// then in the second part, loop through and give each a value.
// and THEN you can query it for totals, yeesh.
// so then can I just literally whery it with where statements and all that?
// or do i put it in instance methods, or both i guess.
// so survey_response.total checks if the table exists, then checks if it is in teh table?
// oooh I can feed the whole relation in, and use then as properties, like instance methods.
// assume for now that the temp table has been created.
// more smartly, union or insert results to a table as they re requested and then return that value?

SET @table_name := temp_table.table_name;
SET @value_column := temp_table.field;
SET @na_column := temp_table.na_field;

Prepare stmt FROM CONCAT('SELECT ', @value_column, ' AS value, ', @na_column, ' AS na_value FROM ', @table_name,);