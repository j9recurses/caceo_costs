CREATE TRIGGER make_values_on_create
AFTER INSERT ON survey_responses
FOR EACH ROW CALL update_sr_values(NEW.id);

CREATE TRIGGER make_values_on_update
AFTER UPDATE ON survey_responses
FOR EACH ROW CALL update_sr_values(NEW.id);

CREATE TRIGGER set_sr_value_updated_at
BEFORE UPDATE ON questions
FOR EACH ROW BEGIN
  IF OLD.integer_value = NEW.integer_value AND
    OLD.decimal_value = NEW.decimal_value AND
    OLD.string_value = NEW.string_value AND
    OLD.text_value = NEW.text_value AND
    OLD.na_value = NEW.na_value
  THEN
    SET NEW.updated_at = OLD.updated_at
  END IF;
END;