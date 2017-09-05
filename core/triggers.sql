/**
* @author FABIO ELIA LOCATELLI
* @studentID 2143701
* @revisionDate 11/10/2016
* @purpose UTILITY FUNCTIONS COLLECTION
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
DROP TRIGGER IF EXISTS eridanus.riverInsertion$$
USE `eridanus`$$
CREATE DEFINER = CURRENT_USER TRIGGER eridanus.riverInsertion AFTER INSERT ON river FOR EACH ROW
BEGIN
	DECLARE operationID VARCHAR(45);
    DECLARE operationSummary VARCHAR(45);
    DECLARE operationTime TIMESTAMP;
    DECLARE formattedTime VARCHAR(45);
    DECLARE formattingPattern VARCHAR(15);
    DECLARE operationType VARCHAR(15);
    DECLARE riverName VARCHAR(45);    
    
    SET operationTime := CURRENT_TIMESTAMP();    
	SET formattingPattern := '%X%V%H%I%S';
	SET formattedTime := DATE_FORMAT(operationTime, formattingPattern);
	SET formattedTime := RIGHT(formattedTime, 10);
    
    SET operationType := 'Insertion';
    SET riverName := NEW.localName;    
    SET operationID := CONCAT(riverName, '_inserted@', formattedTime);
    SET operationID := UPPER(operationID);
    
    INSERT INTO eridanus.history(operationID, operationTime, operationType, localName) VALUES (operationID, operationTime, operationType, riverName);  
END$$
DELIMITER ;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
DROP TRIGGER IF EXISTS eridanus.riverModification$$
USE `eridanus`$$
CREATE DEFINER = CURRENT_USER TRIGGER `eridanus`.`riverModification` AFTER UPDATE ON `river` FOR EACH ROW
BEGIN
	DECLARE operationID VARCHAR(45);
    DECLARE operationSummary VARCHAR(45);
    DECLARE operationTime TIMESTAMP;
    DECLARE formattedTime VARCHAR(45);
    DECLARE formattingPattern VARCHAR(15);
    DECLARE operationType VARCHAR(15);
    DECLARE riverName VARCHAR(45);    
    
    SET operationTime := CURRENT_TIMESTAMP();    
	SET formattingPattern := '%X%V%H%I%S';
	SET formattedTime := DATE_FORMAT(operationTime, formattingPattern);
	SET formattedTime := RIGHT(formattedTime, 10);
    
    SET operationType := 'Modification';
    SET riverName := OLD.localName;    
    SET operationID := CONCAT(riverName, '_modified@', formattedTime);
    SET operationID := UPPER(operationID);
    
    INSERT INTO eridanus.history(operationID, operationTime, operationType, localName) VALUES (operationID, operationTime, operationType, riverName);
END$$
DELIMITER ;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
DROP TRIGGER IF EXISTS eridanus.riverInsertValidation$$
USE `eridanus`$$
CREATE DEFINER=`root`@`suhail` TRIGGER `eridanus`.`riverInsertValidation` BEFORE INSERT ON `river` FOR EACH ROW
BEGIN
	DECLARE riverName VARCHAR(45);
	DECLARE exceptionMessage VARCHAR(90);
		IF EXISTS(SELECT localName FROM river WHERE localName LIKE NEW.localName)
		THEN
			SET riverName := NEW.localName;
			SET exceptionMessage := CONCAT(riverName, ' already exists in database...');
			SIGNAL SQLSTATE '23000'
				SET MESSAGE_TEXT = exceptionMessage;
		END IF;
END$$
DELIMITER ;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
DROP TRIGGER IF EXISTS eridanus.countryInsertValidation$$
USE `eridanus`$$
CREATE DEFINER=`root`@`suhail` TRIGGER `eridanus`.`countryInsertValidation` BEFORE INSERT ON `country` FOR EACH ROW
BEGIN
	DECLARE riverName VARCHAR(45);
	DECLARE exceptionMessage VARCHAR(90);
		IF NOT EXISTS(SELECT localName FROM river WHERE localName LIKE NEW.localName)
		THEN
			SET riverName := NEW.localName;
			SET exceptionMessage := CONCAT(riverName, ' not existing in main table...');
			SIGNAL SQLSTATE '23000'
				SET MESSAGE_TEXT = exceptionMessage;
		END IF;
END$$
DELIMITER ;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
