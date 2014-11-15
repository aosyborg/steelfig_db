BEGIN;

-- tables
\. ../schema/tables/accounts.sql
\. ../schema/tables/events.sql
\. ../schema/tables/attendees.sql
\. ../schema/tables/messages.sql
\. ../schema/tables/schedules.sql
\. ../schema/tables/wishlists.sql
\. ../schema/tables/wishlist_items.sql

\. ../schema/tables/api_tokens.sql
\. ../schema/tables/api_requests.sql

\. ../schema/tables/versions.sql

-- views
\. ../schema/views/v_attendees.sql
\. ../schema/views/v_messages.sql
\. ../schema/views/v_events.sql
\. ../schema/views/v_schedules.sql

-- functions
\. ../schema/functions/create_event_message.sql
\. ../schema/functions/create_reply_message.sql
\. ../schema/functions/set_event_attendee.sql
\. ../schema/functions/set_event_attendee_status.sql
\. ../schema/functions/set_event_schedule.sql
\. ../schema/functions/set_wishlist_item.sql

COMMIT;
