START TRANSACTION;

INSERT INTO events SET
    account_id = 1,
    name = 'Sample Event',
    is_active = 1,
    start_at = '2014-08-24 17:25:00',
    end_at = '2014-12-24 00:00:00';

COMMIT;
