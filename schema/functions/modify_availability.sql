DROP PROCEDURE IF EXISTS modify_availability;

DELIMITER $$
CREATE PROCEDURE modify_availability(
    IN i_event_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED,
    IN i_available_at DATETIME
)
BEGIN
    DECLARE v_attendee_id INT UNSIGNED;
    DECLARE v_schedule_id INT UNSIGNED;

    SELECT id INTO v_attendee_id
    FROM attendees
    WHERE event_id = i_event_id
    AND account_id = i_account_id;

    IF v_attendee_id IS NOT NULL THEN
        SELECT id INTO v_schedule_id
        FROM schedules
        WHERE attendee_id = v_attendee_id
        AND available_at = i_available_at;

        -- INSERT
        IF v_schedule_id IS NULL THEN
            INSERT INTO schedules SET
            attendee_id = v_attendee_id,
            available_at = i_available_at;

        -- DELETE
        ELSE
            DELETE FROM schedules WHERE id = v_schedule_id;

        END IF;

    END IF;

END $$
DELIMITER ;
