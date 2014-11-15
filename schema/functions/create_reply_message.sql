DROP PROCEDURE IF EXISTS create_reply_message;

DELIMITER $$
CREATE PROCEDURE create_reply_message(
    IN i_message_id INT UNSIGNED,
    IN i_from_id INT UNSIGNED,
    IN i_subject VARCHAR(255),
    IN i_message TEXT
)
BEGIN
    DECLARE v_event_id INT UNSIGNED;
    DECLARE v_to_id INT UNSIGNED;

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Who are we sending this message to
    SELECT event_id, from_id  INTO v_event_id, v_to_id
    FROM messages
    WHERE id = i_message_id
    AND to_id = i_from_id
    LIMIT 1;

    -- Sanity check
    IF v_to_id IS NULL THEN
        SELECT False;

    ELSE
        INSERT INTO messages SET
            event_id = v_event_id,
            from_id = i_from_id,
            to_id = v_to_id,
            subject = i_subject,
            message = i_message
        ;
        SELECT LAST_INSERT_ID() AS id;
    END IF;

    COMMIT;
END $$
DELIMITER ;
