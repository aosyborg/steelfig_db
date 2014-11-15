DROP PROCEDURE IF EXISTS set_event_schedule;

DELIMITER $$
CREATE PROCEDURE set_event_schedule(
    IN i_event_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED,
    IN i_time INT UNSIGNED
)
BEGIN
    DECLARE v_attendee_id INT UNSIGNED;
    DECLARE v_schedule_id INT UNSIGNED;

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Grab attendee id
    SELECT id INTO v_attendee_id
    FROM attendees
    WHERE event_id = i_event_id
    AND account_id = i_account_id
    LIMIT 1;

    IF v_attendee_id IS NULL THEN
        ROLLBACK;
    ELSE
        SELECT id INTO v_schedule_id
        FROM schedules
        WHERE attendee_id = v_attendee_id
        AND YEAR(FROM_UNIXTIME(time)) = YEAR(FROM_UNIXTIME(i_time))
        AND MONTH(FROM_UNIXTIME(time)) = MONTH(FROM_UNIXTIME(i_time))
        AND DAY(FROM_UNIXTIME(time)) = DAY(FROM_UNIXTIME(i_time))
        AND HOUR(FROM_UNIXTIME(time)) = HOUR(FROM_UNIXTIME(i_time))
        LIMIT 1;

        -- Insert
        IF v_schedule_id IS NULL THEN
            INSERT INTO schedules SET
                attendee_id = v_attendee_id,
                time = i_time;

            -- Return
            SELECT * FROM schedules WHERE id = LAST_INSERT_ID();

        -- Delete
        ELSE
            DELETE FROM schedules WHERE id = v_schedule_id;
        END IF;

        COMMIT;
    END IF;

END $$
DELIMITER ;
