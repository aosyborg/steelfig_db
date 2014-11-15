DROP VIEW IF EXISTS v_events;

CREATE VIEW v_events AS
SELECT events.id,
       events.name,
       events.start_at,
       events.end_at,
       events.location,
       events.account_id AS organizer_id,
       accounts.id AS account_id,
       accounts.name AS organizer_name,
       accounts.avatar AS organizer_avatar,
       events.is_active,
       events.updated_at,
       events.created_at
FROM events
JOIN accounts ON events.account_id = accounts.id;
