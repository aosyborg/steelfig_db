DROP PROCEDURE IF EXISTS set_event_attendee;

DELIMITER $$
CREATE PROCEDURE set_event_attendee(
    IN i_name VARCHAR(255),
    IN i_email VARCHAR(255),
    IN i_event_id INT UNSIGNED
)
BEGIN

    DECLARE v_account_id INT UNSIGNED;

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Grab account id (create if not exists)
    SELECT id INTO v_account_id FROM accounts WHERE email = i_email;
    IF v_account_id IS NULL THEN
        INSERT INTO accounts SET email = i_email, name = i_name;
        SELECT LAST_INSERT_ID() INTO v_account_id;
    END IF;

    -- Add event attendee
    INSERT IGNORE INTO attendees SET
        event_id = i_event_id,
        account_id = v_account_id;

    -- Return
    SELECT * FROM v_attendees WHERE account_id = v_account_id;

    COMMIT;
END $$
DELIMITER ;
