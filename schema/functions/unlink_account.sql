DROP PROCEDURE IF EXISTS unlink_account;

DELIMITER $$
CREATE PROCEDURE unlink_account(
    IN i_event_id INT UNSIGNED,
    IN i_user_id INT UNSIGNED
)
BEGIN

    DECLARE v_has_mulitple_users INT UNSIGNED;

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    SELECT id INTO v_has_mulitple_users
    FROM users
    GROUP BY account_id
    HAVING count(*) > 1
    AND account_id = (SELECT account_id FROM users WHERE id = i_user_id);

    IF v_has_mulitple_users IS NOT NULL THEN
        INSERT INTO accounts SET
            name = (SELECT name FROM users WHERE id = i_user_id);
        UPDATE users SET account_id = LAST_INSERT_ID() WHERE id = i_user_id;
        INSERT INTO attendees SET
            event_id = i_event_id,
            account_id = LAST_INSERT_ID();
    END IF;

    COMMIT;

END $$
DELIMITER ;
