DROP PROCEDURE IF EXISTS set_wishlist;

DELIMITER $$
CREATE PROCEDURE set_wishlist(
    IN i_wishlist_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED,
    IN i_event_id INT UNSIGNED,
    IN i_name VARCHAR(255),
    IN i_url VARCHAR(255),
    IN i_price INT UNSIGNED,
    IN i_is_purchased BOOLEAN,
    IN i_sort INT UNSIGNED,
    IN i_comments TEXT
)
BEGIN
    DECLARE v_attendee_id INT UNSIGNED;

    SELECT id INTO v_attendee_id
    FROM attendees
    WHERE event_id = i_event_id
    AND account_id = i_account_id;

    IF v_attendee_id IS NULL THEN
        CALL raise_error;
    END IF;

    -- Insert
    IF i_wishlist_id IS NULL THEN
        INSERT INTO wishlists SET
            attendee_id = v_attendee_id,
            name = i_name,
            url = i_url,
            price = i_price,
            is_purchased = i_is_purchased,
            sort = 10000,
            comments = i_comments;

    -- Update
    ELSE
        -- Update sort values
        IF i_sort IS NOT NULL THEN
            IF i_sort < (SELECT sort FROM wishlists where id = i_wishlist_id) THEN
                UPDATE wishlists SET
                    sort = sort + 1
                    WHERE attendee_id = v_attendee_id
                    AND sort >= i_sort;
            ELSE
                UPDATE wishlists SET
                    sort = sort - 1
                    WHERE attendee_id = v_attendee_id
                    AND sort <= i_sort;
            END IF;
        END IF;

        UPDATE wishlists SET
            attendee_id = v_attendee_id,
            name = COALESCE(i_name, name),
            url = COALESCE(i_url, url),
            price = COALESCE(i_price, price),
            sort = COALESCE(i_sort, sort),
            comments = COALESCE(i_comments, comments)
        WHERE id = i_wishlist_id;
    END IF;

    -- Fix sort id
    SET @n = -1;
    UPDATE wishlists SET
        sort = (@n:=@n+1)
    WHERE attendee_id = v_attendee_id
    ORDER BY sort;

    -- Return
    SELECT * FROM wishlists WHERE id = COALESCE(i_wishlist_id, LAST_INSERT_ID());

    COMMIT;
END $$
DELIMITER ;
