USE photoapp;

DROP PROCEDURE IF EXISTS REGISTER_USER;
/* This is executed, when a new user is added.User details are added to into the user table */
DELIMITER //
CREATE PROCEDURE REGISTER_USER
(
	 IN _MAIL_ID VARCHAR(254),
	 IN _FIRST_NAME VARCHAR(20), 
	 IN _LAST_NAME VARCHAR(20),
	 OUT  _USER_ID INTEGER
)
BEGIN
	INSERT INTO USER(MAIL_ID, FIRST_NAME, LAST_NAME) VALUES(_MAIL_ID, _FIRST_NAME, _LAST_NAME);
	
	SELECT U.USER_ID FROM USER U 
		WHERE U.MAIL_ID = _MAIL_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS GET_USER_DETAILS;
/* This stored procedure when executed, displays the user details */
DELIMITER //
CREATE PROCEDURE GET_USER_DETAILS
(
	IN _USER_ID INTEGER
)
BEGIN
	SELECT U.MAIL_ID, U.FIRST_NAME, U.LAST_NAME, U.NO_OF_POSTS FROM USER U
		WHERE U.USER_ID = _USER_ID;
END;
//
DELIMITER ;



DROP PROCEDURE IF EXISTS UPDATE_USER_DETAILS; 
/* This is executed, to display the user's lastname */
DELIMITER //
CREATE PROCEDURE UPDATE_USER_DETAILS
(
	IN _USER_ID VARCHAR(254),
	IN _FIRST_NAME VARCHAR(20), 
	IN _LAST_NAME VARCHAR(20)
)
BEGIN
	UPDATE USER U
		SET U.FIRST_NAME = _FIRST_NAME, U.LAST_NAME = _LAST_NAME
			WHERE U.USER_ID = _USER_ID;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS DEACTIVATE_USER;
/* This is executed, to display the user's lastname */
DELIMITER //
CREATE PROCEDURE DEACTIVATE_USER
(
	IN _USER_ID INTEGER
)
BEGIN
	UPDATE USER U
		SET U.IS_ACTIVE = 0
			WHERE U.USER_ID = _USER_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS ADD_TOPIC;
/* This stored procedure is executed, whenever a topic is posted */
DELIMITER //
CREATE PROCEDURE ADD_TOPIC 
(
	IN _TOPIC_TITLE VARCHAR(100),
	OUT _TOPIC_ID INTEGER
)
BEGIN
	DECLARE EXIT HANDLER FOR 1452
	SELECT 'MySQL error 1452: Cannot add or update a child row: a foreign key constraint fails';
	
	INSERT INTO TOPIC(TOPIC_TITLE) VALUES(_TOPIC_TITLE);
	
	SELECT T.TOPIC_ID FROM TOPIC T WHERE T.USER_ID = USER_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS GET_TOPICS;
/* This stored procedure when executed, displays all the topics */
DELIMITER //
CREATE PROCEDURE GET_TOPICS
(
	IN _IS_ACTIVE BOOLEAN
)
BEGIN
	DECLARE EXIT HANDLER FOR 1452
	SELECT 'MySQL error 1452: Cannot add or update a child row: a foreign key constraint fails';
	
	SELECT T.TOPIC_ID, T.TOPIC_TITLE, T.USER_ID, T.UPLOADTIME FROM TOPIC T WHERE T.IS_ACTIVE = _IS_ACTIVE ;
END;
//
DELIMITER ;



DROP PROCEDURE IF EXISTS ADD_POST;
/* This stored procedure is executed, when a photo is posted and the details are stored in the database */
DELIMITER //
CREATE PROCEDURE ADD_POST
(
	IN _USER_ID INTEGER,
	IN _TOPIC_ID INTEGER,
	IN _URL VARCHAR(254),
	IN _DESCRIPTION VARCHAR(100),
	IN _NEXT_TOPIC VARCHAR(100),
	OUT _POST_ID INTEGER
)
BEGIN
	DECLARE EXIT HANDLER FOR 1452
	SELECT 'MySQL error 1452: Cannot add or update a child row: a foreign key constraint fails';
	
	DECLARE EXIT HANDLER FOR 1062
	SELECT 'MySQL error 1062: Duplicate ket entry for primary key';
	
	INSERT INTO POST(USER_ID, TOPIC_ID, URL, DESCRIPTION, NEXT_TOPIC) VALUES(_USER_ID, _TOPIC_ID, _URL, _DESCRIPTION, _NEXT_TOPIC);
	
	SELECT P.POST_ID FROM POST P;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS UPDATE_POST;
/* This stored procedure when executed, the description for the post is updated */
DELIMITER //
CREATE PROCEDURE UPDATE_POST
(
	IN _POST_ID INTEGER,
	IN _USER_ID INTEGER, 
	IN _DESCRIPTION VARCHAR(100)
)
BEGIN
	DECLARE EXIT HANDLER FOR 1452
	SELECT 'MySQL error 1452: Cannot add or update a child row: a foreign key constraint fails';
	UPDATE POST P
		SET DESCRIPTION = _DESCRIPTION
			WHERE P.POST_ID = _POST_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS DELETE_POST;
/* This stored procedure when executed, deactivates the post */
DELIMITER //
CREATE PROCEDURE DELETE_POST
(
	IN _POST_ID INTEGER,
	IN _USER_ID INTEGER
)
BEGIN
	DECLARE EXIT HANDLER FOR 1452
	SELECT 'MySQL error 1452: Cannot add or update a child row: a foreign key constraint fails';
	UPDATE POST P
		SET IS_ACTIVE = 0
			WHERE P.POST_ID = _POST_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS ADD_VOTE;
/* This stored procedure when executed, adds a vote for a particular post */
DELIMITER //
CREATE PROCEDURE ADD_VOTE
(
	IN _POST_ID INTEGER,
	IN _USER_ID INTEGER,
	OUT _VOTE_ID INTEGER
)
BEGIN
	INSERT INTO VOTES(POST_ID, USER_ID) VALUES(_POST_ID, _USER_ID);
	
	SELECT V.VOTE_ID FROM VOTES V WHERE V.USER_ID = _USER_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS UPDATE_VOTE;
/* This stored procedure when executed, Displays the recently casted votes for a particular post */
DELIMITER //
CREATE PROCEDURE UPDATE_VOTE
(
	IN _VOTE_ID INTEGER,
	IN _POST_ID INTEGER, 
	IN _USER_ID INTEGER
)
BEGIN
	SELECT V.IS_ACTIVE FROM VOTES V WHERE V.VOTE_ID = VOTE_ID; 
	IF V.IS_ACTIVE = 0 THEN
		UPDATE VOTES V
			SET V.IS_ACTIVE = 1
				WHERE V.VOTE_ID = _VOTE_ID;
	ELSE
		UPDATE VOTES V
			SET V.IS_ACTIVE = 0
				WHERE V.VOTE_ID = _VOTE_ID;
	END IF;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS ADD_COMMENT;
/* This stored procedure when executed, saves the added comment in the comments table */
DELIMITER //
CREATE PROCEDURE ADD_COMMENT
(
	IN _USER_ID INTEGER,
	IN _POST_ID INTEGER, 
	IN _COMMENT_CONTENT VARCHAR(100),
	OUT _COMMENT_ID INTEGER
)
BEGIN
	INSERT INTO COMMENTS(USER_ID, POST_ID, COMMENT_CONTENT) VALUES(_USER_ID, _POST_ID, _COMMENT_CONTENT);
	
	SELECT C.COMMENT_ID FROM COMMENTS C 
		WHERE C.POST_ID = _POST_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS GET_COMMENTS;
/* This stored procedure when executed, displays all the comments for a particular post */
DELIMITER //
CREATE PROCEDURE GET_COMMENTS
(
	IN _USER_ID INTEGER, 
	IN _POST_ID INTEGER
)
BEGIN
	SELECT  U.FIRST_NAME, C.COMMENT_CONTENT FROM USER U JOIN COMMENTS C ON C.USER_ID = U.USER_ID 
		WHERE C.POST_ID = POST_ID AND C.IS_ACTIVE = 1 ; 
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS UPDATE_COMMENT;
/* This stored procedure when executed, updates the comment */
DELIMITER //
CREATE PROCEDURE UPDATE_COMMENT
(
	IN _COMMENT_CONTENT VARCHAR(100), 
	IN _COMMENT_ID INTEGER, 
	IN _USER_ID INTEGER
)
BEGIN
	UPDATE COMMENTS C
		SET COMMENT_CONTENT = _COMMENT_CONTENT
			WHERE C.COMMENT_ID = _COMMENT_ID;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS DELETE_COMMENT;
/* This stored procedure when executed, Deactivates the comment */
DELIMITER //
CREATE PROCEDURE DELETE_COMMENT
(
	IN _COMMENT_ID INTEGER, 
	IN _USER_ID INTEGER
)
BEGIN
	UPDATE COMMENTS C
		SET C.IS_ACTIVE = 0
			WHERE C.COMMENT_ID = _COMMENT_ID;
END;
//
DELIMITER ;




