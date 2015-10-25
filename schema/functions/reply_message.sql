DROP PROCEDURE IF EXISTS reply_message;

DELIMITER $$
CREATE PROCEDURE reply_message(
    IN i_event_id INT UNSIGNED,
    IN i_message_id INT UNSIGNED,
    IN i_from_id INT UNSIGNED,
    IN i_subject VARCHAR(255),
    IN i_message TEXT
)
BEGIN
    DECLARE v_to_id INT UNSIGNED;

    SELECT from_id INTO v_to_id
    FROM messages
    WHERE id = i_message_id;

    INSERT INTO messages SET
        event_id = i_event_id,
        from_id = i_from_id,
        to_id = v_to_id,
        subject = i_subject,
        message = i_message;

    -- Return
    SELECT * FROM messages WHERE id = LAST_INSERT_ID();

    COMMIT;
END $$
DELIMITER ;
