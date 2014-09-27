DROP VIEW IF EXISTS v_messages;

CREATE VIEW v_messages AS
SELECT messages.id,
       messages.event_id,
       messages.from_id,
       f.name AS from_name,
       messages.to_id,
       t.name AS to_name,
       messages.subject,
       messages.message,
       messages.created_at,
       messages.read_at
FROM messages
JOIN accounts f ON f.id = messages.from_id
JOIN accounts t on t.id = messages.to_id
ORDER by messages.created_at DESC;
