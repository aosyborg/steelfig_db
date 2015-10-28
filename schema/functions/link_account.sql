DROP PROCEDURE IF EXISTS link_account;

DELIMITER $$
CREATE PROCEDURE link_account(
    IN i_event_id INT UNSIGNED,
    IN i_org_account_id INT UNSIGNED,
    IN i_new_account_id INT UNSIGNED
)
BEGIN

    DECLARE v_org_attendee_id INT UNSIGNED;
    DECLARE v_new_attendee_id INT UNSIGNED;

    -- Merge messages
    UPDATE messages
    SET to_id = i_new_account_id
    WHERE to_id = i_org_account_id;

    -- Merge wishlist
    SELECT id INTO v_org_attendee_id FROM attendees WHERE account_id = i_org_account_id;
    SELECT id INTO v_new_attendee_id FROM attendees WHERE account_id = i_new_account_id;
    UPDATE wishlists
    SET attendee_id = v_new_attendee_id
    WHERE attendee_id = v_org_attendee_id;

    -- Update user
    UPDATE users
    SET account_id = i_new_account_id
    WHERE account_id = i_org_account_id;

    -- Delete account
    DELETE FROM accounts WHERE id = i_org_account_id;

END $$
DELIMITER ;
