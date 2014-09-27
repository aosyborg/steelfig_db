DROP PROCEDURE IF EXISTS set_wishlist_item;

DELIMITER $$
CREATE PROCEDURE set_wishlist_item(
    IN i_wishlist_item_id INT UNSIGNED,
    IN i_account_id INT UNSIGNED,
    IN i_event_id INT UNSIGNED,
    IN i_name VARCHAR(255),
    IN i_barcode VARCHAR(255),
    IN i_url VARCHAR(255),
    IN i_price INT UNSIGNED,
    IN i_is_purchased BOOLEAN,
    IN i_sort INT UNSIGNED,
    IN i_comments TEXT
)
BEGIN
    DECLARE v_wishlist_id INT UNSIGNED;

    -- Exit handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Start procedure
    START TRANSACTION;

    -- Insert
    IF i_wishlist_item_id IS NULL THEN
        -- Attempt to create wishlist
        INSERT INTO wishlists SET
            attendee_id = (SELECT id
                           FROM attendees
                           WHERE event_id = i_event_id
                           AND account_id = i_account_id)
        ON DUPLICATE KEY UPDATE attendee_id=attendee_id;

        -- Grab wishlist id
        SELECT wishlists.id INTO v_wishlist_id
        FROM wishlists
        JOIN attendees ON wishlists.attendee_id = attendees.id
        WHERE event_id = i_event_id
        AND account_id = i_account_id;

        -- Add wishlist item
        INSERT INTO wishlist_items SET
            wishlist_id = v_wishlist_id,
            name = i_name,
            barcode = i_barcode,
            url = i_url,
            price = i_price,
            is_purchased = i_is_purchased,
            sort = sort,
            comments = i_comments;
        SELECT * FROM wishlist_items WHERE id = LAST_INSERT_ID();

    -- Update
    ELSE
        -- Grab wishlist id
        SELECT wishlist_id INTO v_wishlist_id
        FROM wishlist_items
        WHERE id = i_wishlist_item_id;

        UPDATE wishlist_items SET
            name = COALESCE(i_name, name),
            barcode = COALESCE(i_barcode, barcode),
            url = COALESCE(i_url, url),
            price = COALESCE(i_price, price),
            is_purchased = COALESCE(i_is_purchased, is_purchased),
            sort = COALESCE(i_sort, sort),
            comments = COALESCE(i_comments, comments)
        WHERE id = i_wishlist_item_id;
        SELECT * FROM wishlist_items WHERE id = i_wishlist_item_id;
    END IF;

    -- Return

    COMMIT;
END $$
DELIMITER ;
