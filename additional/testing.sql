/**
* @author FABIO ELIA LOCATELLI
* @studentID 2143701
* @revisionDate 11/10/2016
* @purpose MANUAL PROCEDURE TEST CASES COLLECTION
*-------------------------------------------------------*/

/*RETRIEVE RIVERS BY COUNTRY*/
CALL listRiverParameters('*', @collection);
CALL listRiverParameters('Italy', @collection);
CALL listRiverParameters('Russia', @collection);
CALL listRiverParameters('China', @collection);
SELECT @collection;

/*-------------------------------------------------------*/
