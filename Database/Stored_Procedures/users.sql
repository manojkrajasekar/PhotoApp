USE photoapp;

/* This is executed, when a new user is added. User details are stored in the USER table */
DROP PROCEDURE IF EXISTS register_user;
DELIMITER
    //
CREATE PROCEDURE register_user
(
    IN _mail_id VARCHAR(254),
    IN _first_name VARCHAR(50),
    IN _last_name VARCHAR(50),
    OUT _user_id INTEGER
)
BEGIN
    INSERT INTO users
    (
        mail_id,
        first_name,
        last_name
    )
    VALUES
    (
        _mail_id,
        _first_name,
        _last_name
    ) ;
    SELECT last_insert_id() INTO _user_id;

END ; //
DELIMITER ;

/* ------------------------------------------------------------------------------------------ */

/* This stored procedure when executed, displays the user's details based on the passed USER_ID */
DROP PROCEDURE IF EXISTS get_user_details;
DELIMITER //
CREATE PROCEDURE get_user_details
(
	IN _user_id INTEGER
)
BEGIN
	SELECT
		u.mail_id,
		u.first_name, 
		u.last_name,
		u.no_of_posts
        FROM users u
        WHERE u.user_id = _user_id;
END;
//
DELIMITER ;


/* ------------------------------------------------------------------------------------------ */

/* Updates the user's firstname or lastname, or both */
DROP PROCEDURE IF EXISTS update_user_details;
DELIMITER
    //
CREATE PROCEDURE update_user_details
(
    IN _user_id VARCHAR(254),
    IN _first_name VARCHAR(50),
    IN _last_name VARCHAR(50)
)
BEGIN
    UPDATE users u
    SET
        u.first_name = _first_name,
        u.last_name = _last_name
    WHERE u.user_id = _user_id ;
END ; //
DELIMITER ;

/* ------------------------------------------------------------------------------------------ */


/* This when executed, toggles the IS_ACTIVE value of the user based on it's current value */
DROP PROCEDURE IF EXISTS toggle_user;
DELIMITER //
CREATE PROCEDURE toggle_user
(
	IN _user_id INTEGER
)
BEGIN
	UPDATE users u
		SET
			u.is_active = NOT u.is_active
		WHERE u.user_id = _user_id;
END;
//
DELIMITER ;
