USE `#{Rails.configuration.database_configuration["production"]["database"]}`;
DROP procedure IF EXISTS `update_sr_values`;

DELIMITER $$
USE `#{Rails.configuration.database_configuration["production"]["database"]}`$$
CREATE DEFINER=`#{Rails.configuration.database_configuration["production"]["username"]}`@`localhost` 
PROCEDURE `update_sr_values`(IN survey_response_id int)
BEGIN
    DECLARE sr_id, q_id, response_id, integer_value int;
    DECLARE data_type, field, na_field, table_name varchar(30);
    DECLARE na_able, na_value, answered tinyint(1);
    DECLARE decimal_value decimal;
    DECLARE string_value, val_query varchar(255);
    DECLARE text_value text;
    DECLARE srq_no_more_rows tinyint(1) DEFAULT 0;
    DECLARE created_at, updated_at datetime;
 
    DECLARE srq_cursor CURSOR FOR 
      SELECT 
        sr.response_id,
        sr.id, sr.created_at, sr.updated_at, q.id, q.data_type, 
        q.field, q.na_field, q.na_able, q.table_name
      FROM survey_responses sr
      INNER JOIN questions q
        ON q.survey_id = sr.response_type
      WHERE sr.id = survey_response_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET srq_no_more_rows := 1;

    OPEN srq_cursor;
    SRQ_LOOP: LOOP
      FETCH srq_cursor INTO 
        response_id,
        sr_id, created_at, updated_at, q_id, data_type, 
        field, na_field, na_able, table_name;

      IF srq_no_more_rows = 1 THEN
        CLOSE srq_cursor;
        LEAVE SRQ_LOOP;
      END IF;
      
      SET @integer_value := NULL;
      SET @decimal_value := NULL;
      SET @string_value  := NULL;
      SET @text_value    := NULL;
      SET @na_value      := NULL;

      SET @sr_id      := sr_id;
      SET @q_id       := q_id;
      SET @data_type  := data_type;
      SET @updated_at := updated_at;
      SET @created_at := created_at;

      SET @stmt     := NULL;
      SET @answered := NULL;


      CASE na_able
        WHEN 0 THEN
          SET @stmt := CONCAT(
          'SELECT ', field, 
          ' INTO @', data_type, '_value', 
          ' FROM ', table_name, ' WHERE ', table_name, '.id = ', response_id, ';' );
        WHEN 1 THEN
          SET @stmt := CONCAT(
          'SELECT ', field, ', ', na_field,
          ' INTO @', data_type, '_value, @na_value', 
          ' FROM ', table_name, ' WHERE ', table_name, '.id = ', response_id, ';' );
          ELSE BEGIN END;
      END CASE;

      PREPARE val_stmt FROM @stmt;
      EXECUTE val_stmt;
      DEALLOCATE PREPARE val_stmt;

      SET @stmt := CONCAT('SELECT IF( @', data_type, '_value IS NULL, ',
        '@answered := 0, ',
        '@answered := 1);');
      PREPARE answer_stmt FROM @stmt;
      EXECUTE answer_stmt;
      DEALLOCATE PREPARE answer_stmt;

      REPLACE INTO survey_response_values (
        survey_response_id, created_at, updated_at, question_id, data_type, 
        integer_value, decimal_value, string_value, text_value, na_value,
        answered
        )
      SELECT 
        @sr_id, @created_at, @updated_at, @q_id, @data_type, 
        @integer_value, @decimal_value, @string_value, @text_value, @na_value,
        @answered
      ;

    END LOOP SRQ_LOOP;
  END$$

DELIMITER ;

