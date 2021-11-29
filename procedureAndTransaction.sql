use cloudcomputingDB;
DROP PROCEDURE IF EXISTS generateIDForTable;
DELIMITER $$
CREATE PROCEDURE generateIDForTable(
IN tableName varchar(20),
OUT uid varchar(20)
)
BEGIN
    DECLARE prefix varchar(20);
    DECLARE pk varchar(20);
    CASE tableName
		WHEN  'authorization' THEN
		   SET prefix = 'AUT_';
           SET pk = 'authID';
		WHEN 'billing' THEN
		   SET prefix = 'BILL_';
           SET pk = 'billID';
		WHEN 'computing' THEN
		   SET prefix = 'COM_';
           SET pk = 'computeID';
		WHEN 'instance' THEN
		   SET prefix = 'INS_';
           SET pk = 'instanceID';
		WHEN 'logs' THEN
		   SET prefix = 'LOG_';
           SET pk = 'logID';
		WHEN 'paymentInformation' THEN
		   SET prefix = 'PAY_';
           SET pk = 'payID';
		WHEN 'storage' THEN
		   SET prefix = 'STO_';
           SET pk = 'storageID';
		WHEN 'subscription' THEN
		   SET prefix = 'SUB_';
           SET pk = 'subscriptionID';
		WHEN 'user' THEN
		   SET prefix = 'USR_';
           SET pk = 'userID';
	END CASE;
    SELECT CONCAT(prefix,FLOOR(RAND()*(1000000))) INTO uid;
END$$
DELIMITER ;

USE cloudcomputingDB;
DROP PROCEDURE IF EXISTS generateUserAccount;
DELIMITER //
CREATE PROCEDURE generateUserAccount(username varchar(20), pass varchar(20), emailid varchar(40), fullname varchar(20), contact varchar(20), paymethod varchar(20))
BEGIN
    /*DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;*/
    /*START TRANSACTION;*/
        CALL generateIDForTable('authorization',@authid);
        CALL generateIDForTable('paymentInformation',@payid);
        CALL generateIDForTable('user',@userid);
        SET @authkey = 0;
        WHILE @authkey!=1 DO
			IF EXISTS(SELECT * FROM authorization WHERE authID=@authid) = 0 THEN
				SET @authkey = 1;
			ELSE
				CALL generateIDForTable('authorization',@authid);
			END IF;
		END WHILE;
        
        SET @paykey = 0;
        WHILE @paykey!=1 DO
			IF EXISTS(SELECT * FROM paymentInformation WHERE payID=@payid) = 0 THEN
				SET @paykey = 1;
			ELSE
				CALL generateIDForTable('paymentInformation',@payid);
			END IF;
		END WHILE;
        
        SET @userkey = 0;
        WHILE @userkey!=1 DO
			IF EXISTS(SELECT * FROM user WHERE userID=@userid) = 0 THEN
				SET @userkey = 1;
			ELSE
				CALL generateIDForTable('user',@userid);
			END IF;
		END WHILE;
        
        INSERT INTO authorization (authID, userName, password) values (@authid, username, pass);
        INSERT INTO paymentInformation (payID, methodType) values (@payid, paymethod);
        INSERT INTO user (userID, name, email, payID, authID, contactNumber) values (@userid, fullname, emailid, @payid, @authid, contact);
        SELECT @authid, @payid, @userid, 'Congrates!, Transaction Successful.';
    /*COMMIT;*/
END; //
DELIMITER ;