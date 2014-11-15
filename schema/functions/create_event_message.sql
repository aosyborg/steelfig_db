DROP PROCEDURE IF EXISTS create_event_message;

DELIMITER $$
CREATE PROCEDURE create_event_message(
    IN i_event_id INT UNSIGNED,
    IN i_from_id INT UNSIGNED,
    IN i_to_id INT UNSIGNED,
    IN i_subject VARCHAR(255),
    IN i_message TEXT
)
BEGIN

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Insert
    INSERT INTO messages SET
        event_id = i_event_id,
        from_id = i_from_id,
        to_id = i_to_id,
        subject = i_subject,
        message = i_message
    ;

    -- Return
    SELECT LAST_INSERT_ID() AS id;

    COMMIT;
END $$
DELIMITER ;
