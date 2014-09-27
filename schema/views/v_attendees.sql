CREATE VIEW `v_attendees` AS
SELECT attendees.id,
       accounts.id AS account_id,
       attendees.event_id,
       accounts.name,
       accounts.avatar,
       attendees.status,
       attendees.message
FROM accounts
JOIN attendees ON accounts.id = attendees.account_id
ORDER by attendees.status DESC;
