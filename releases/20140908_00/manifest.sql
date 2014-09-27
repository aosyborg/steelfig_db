BEGIN;

-- tables
\. ../schema/tables/accounts.sql
\. ../schema/tables/events.sql
\. ../schema/tables/attendees.sql
\. ../schema/tables/messages.sql
\. ../schema/tables/wishlists.sql
\. ../schema/tables/wishlist_items.sql

\. ../schema/tables/api_tokens.sql
\. ../schema/tables/api_requests.sql

\. ../schema/tables/versions.sql

-- views
\. ../schema/views/v_attendees.sql
\. ../schema/views/v_messages.sql
\. ../schema/views/v_events.sql

-- functions
\. ../schema/functions/set_event_attendee.sql
\. ../schema/functions/set_event_attendee_status.sql

COMMIT;
