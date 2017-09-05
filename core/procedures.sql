/**
* @author FABIO ELIA LOCATELLI
* @creationDate 08/12/2016
* @revisionDate 08/12/2016
* @purpose STORED PROCEDURES COLLECTION
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

USE eridanus;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS listRiverParameters;
DELIMITER //
/*
* PROCEDURE NAME   	: 	listRiverParameters
* INPUT PARAMETERS 	: 	COUNTRY NAME
* OUTPUT PARAMETERS	:	RIVER COLLECTION
*/
CREATE PROCEDURE listRiverParameters(IN paramCountryName VARCHAR(45), OUT resCollection LONGTEXT)
SQL SECURITY INVOKER
BEGIN
	DECLARE fetchedRiverName VARCHAR(45);
	DECLARE fetchedAverageDischarge INT;
	DECLARE fetchedCatchmentBasin INT;
	DECLARE fetchedLength INT;
    DECLARE fetchedCountryName VARCHAR(45);
    
    CASE paramCountryName 
    
    WHEN '*' THEN
    
		BEGIN

			/*CURSOR AND ITS HANDLER*/
			DECLARE cursorHasFinished INT DEFAULT FALSE;
			DECLARE riverRow CURSOR FOR SELECT localName, averageDischarge, catchmentBasin, length FROM riverParameters;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

			/*TEMPORARY TABLE USED TO STORE RESULTS*/
			DROP TABLE IF EXISTS cursorTable;
			CREATE TEMPORARY TABLE IF NOT EXISTS cursorTable(riverName VARCHAR(45), averageDischarge INT, catchmentBasin INT, length INT);

			/*CURSOR OPENING, RETRIEVAL LOOP AND CURSOR CLOSING*/    
			OPEN riverRow;

			TRIPLOOP: LOOP
				FETCH riverRow INTO fetchedRiverName, fetchedAverageDischarge, fetchedCatchmentBasin, fetchedLength;
				IF cursorHasFinished
				THEN
				  LEAVE TRIPLOOP;
				END IF;
				INSERT INTO cursorTable(riverName, averageDischarge, catchmentBasin, length) VALUES (fetchedRiverName, fetchedAverageDischarge, fetchedCatchmentBasin, fetchedLength);		
			  END LOOP;
			  
			CLOSE riverRow;
			
			/*MODIFY GROUP_CONCAT TO ACCOMMODATE 8kB AND CREATE COLLECTION*/
            SET SESSION group_concat_max_len := 8192;            
            SET resCollection := (SELECT GROUP_CONCAT( DISTINCT CONCAT(riverName, ', ', averageDischarge, ', ', catchmentBasin, ', ', length) SEPARATOR ' | ') FROM cursorTable);
            
		END;
        
	ELSE
    
		BEGIN

			/*CURSOR AND ITS HANDLER*/
			DECLARE cursorHasFinished INT DEFAULT FALSE;
			DECLARE riverRow CURSOR FOR SELECT localName, averageDischarge, catchmentBasin, length, countryName FROM riverParameters;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorHasFinished := TRUE;

			/*TEMPORARY TABLE USED TO STORE RESULTS*/
			DROP TABLE IF EXISTS cursorTable;
			CREATE TEMPORARY TABLE IF NOT EXISTS cursorTable(riverName VARCHAR(45), averageDischarge INT, catchmentBasin INT, length INT, country VARCHAR(45));

			/*CURSOR OPENING, RETRIEVAL LOOP AND CURSOR CLOSING*/    
			OPEN riverRow;

			TRIPLOOP: LOOP
				FETCH riverRow INTO fetchedRiverName, fetchedAverageDischarge, fetchedCatchmentBasin, fetchedLength, fetchedCountryName;
				IF cursorHasFinished
				THEN
				  LEAVE TRIPLOOP;
				END IF;
				INSERT INTO cursorTable(riverName, averageDischarge, catchmentBasin, length, country) VALUES (fetchedRiverName, fetchedAverageDischarge, fetchedCatchmentBasin, fetchedLength, fetchedCountryName);		
			  END LOOP;
			  
			CLOSE riverRow;
			
			/*MODIFY GROUP_CONCAT TO ACCOMMODATE 8kB AND CREATE COLLECTION*/
            SET SESSION group_concat_max_len := 8192;            
            SET resCollection := (SELECT GROUP_CONCAT( DISTINCT CONCAT(riverName, ', ', averageDischarge, ', ', catchmentBasin, ', ', length) SEPARATOR ' | ') FROM cursorTable WHERE country LIKE paramCountryName);
            
		END;
        
    END CASE;
    
END//
DELIMITER ;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
