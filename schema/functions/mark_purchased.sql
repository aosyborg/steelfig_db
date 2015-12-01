DROP PROCEDURE IF EXISTS mark_purchased;

DELIMITER $$
CREATE PROCEDURE mark_purchased(
    IN i_wishlist_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED
)
BEGIN
    DECLARE v_is_valid BOOLEAN;

    SELECT true INTO v_is_valid
    FROM wishlists w
    JOIN attendees a1 ON w.attendee_id = a1.id
    JOIN attendees a2 ON a1.event_id = a2.event_id
    WHERE w.id = i_wishlist_id
    AND a2.account_id = i_account_id;

    IF COALESCE(v_is_valid, false) THEN
        UPDATE wishlists SET is_purchased = 1 WHERE id = i_wishlist_id;
    END IF;

    SELECT * FROM wishlists WHERE id = i_wishlist_id;

END $$
DELIMITER ;
