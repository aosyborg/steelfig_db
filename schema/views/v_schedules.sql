DROP VIEW IF EXISTS v_schedules;

CREATE VIEW v_schedules AS
SELECT schedules.id,
       attendees.event_id,
       attendees.account_id,
       schedules.time,
       schedules.updated_at,
       schedules.created_at
FROM attendees
JOIN schedules ON attendees.id = schedules.attendee_id
