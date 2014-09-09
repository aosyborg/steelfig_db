START TRANSACTION;

INSERT INTO attendees SET
    event_id = 1,
    account_id = 1,
    status = 1,
    notify_on_event_update = 0,
    notify_on_list_update = 0,
    notify_on_recipient_list_update = 0;

COMMIT;
