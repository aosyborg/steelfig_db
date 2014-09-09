START TRANSACTION;

INSERT INTO accounts SET
 email = 'aosyborg@gmail.com',
 name = 'Dave Symons',
 oauth_token = 'something',
 avatar = 'yep';

COMMIT;
