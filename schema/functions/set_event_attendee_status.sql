DROP PROCEDURE IF EXISTS set_event_attendee_status;

DELIMITER $$
CREATE PROCEDURE set_event_attendee_status(
    IN i_event_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED,
    IN i_status VARCHAR(255),
    IN i_message VARCHAR(255)
)
BEGIN

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Update attendee
    UPDATE attendees SET
        status = i_status,
        message = i_message
    WHERE event_id = i_event_id
    AND account_id = i_account_id;

    -- Return
    SELECT v_events.*,
        attendees.status AS attendee_status,
        attendees.message AS attendee_message
    FROM v_events
    JOIN attendees ON v_events.id = attendees.event_id
    JOIN accounts ON attendees.account_id = accounts.id
    WHERE v_events.id = i_event_id
    AND attendees.account_id = i_account_id;

    COMMIT;
END $$
DELIMITER ;
