DROP PROCEDURE IF EXISTS invite;

DELIMITER $$
CREATE PROCEDURE invite(
    IN i_name VARCHAR(255),
    IN i_email VARCHAR(255),
    IN i_event_id INT UNSIGNED
)
BEGIN

    DECLARE v_user_id INT UNSIGNED;
    DECLARE v_attendee_id INT UNSIGNED;

    -- Start procedure
    START TRANSACTION;

    SELECT id INTO v_user_id
    FROM users
    WHERE email = i_email;

    IF v_user_id IS NULL THEN
        INSERT INTO accounts SET
            name = i_name;

        INSERT INTO users SET
            account_id = LAST_INSERT_ID(),
            email = i_email,
            name = i_name;

        SELECT LAST_INSERT_ID() INTO v_user_id;
    END IF;

    SELECT attendees.id INTO v_attendee_id
    FROM attendees
    JOIN users USING(account_id)
    WHERE users.id = v_user_id;

    IF v_attendee_id IS NULL THEN
        INSERT INTO attendees SET
            event_id = i_event_id,
            account_id = (SELECT account_id FROM users where id = v_user_id);
    END IF;

    COMMIT;

END $$
DELIMITER ;
