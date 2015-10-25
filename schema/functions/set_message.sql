DROP PROCEDURE IF EXISTS set_message;

DELIMITER $$
CREATE PROCEDURE set_message(
    IN i_event_id INT UNSIGNED,
    IN i_from_id INT UNSIGNED,
    IN i_to_id INT UNSIGNED,
    IN i_subject VARCHAR(255),
    IN i_message TEXT
)
BEGIN
    DECLARE v_message_id INT UNSIGNED;

    INSERT INTO messages SET
        event_id = i_event_id,
        from_id = i_from_id,
        to_id = i_to_id,
        subject = i_subject,
        message = i_message;

    -- Return
    SELECT * FROM messages WHERE id = LAST_INSERT_ID();

    COMMIT;
END $$
DELIMITER ;
