/**
* @author FABIO ELIA LOCATELLI
* @creationDate 08/12/2016
* @revisionDate 20/02/2018
* @purpose VIEWS LIBRARY
*------------------------------------------------------------------------------------------------------------------------------------------------------*/

USE eridanus;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/

DROP VIEW IF EXISTS riverNumbers;
CREATE VIEW riverNumbers AS
    SELECT 
        COUNT(DISTINCT riverTable.localName) AS riverTable,
        COUNT(DISTINCT countryTable.localName) AS countryTable
    FROM
        eridanus.river riverTable
            LEFT JOIN
        eridanus.country countryTable ON countryTable.localName = riverTable.localName;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/

DROP VIEW IF EXISTS riverParameters;
CREATE VIEW riverParameters AS
    SELECT 
        riverTable.localName AS localName,
        riverTable.averageDischarge AS averageDischarge,
        riverTable.catchmentBasin AS catchmentBasin,
        riverTable.length AS length,
        countryTable.countryName AS countryName
    FROM
        eridanus.river riverTable
            LEFT JOIN
        eridanus.country countryTable ON countryTable.localName = riverTable.localName;
        
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/

DROP VIEW IF EXISTS riverCoordinates;
CREATE VIEW riverCoordinates AS
    SELECT 
        riverTable.sourceLocation AS sourceLocation,
        riverTable.mouthLocation AS mouthLocation
    FROM
        eridanus.river riverTable;
        
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/

DROP VIEW IF EXISTS riverCharacteristics;
CREATE VIEW riverCharacteristics AS
    SELECT 
        riverTable.isNavigable AS isNavigable,
        riverTable.isPolluted AS isPolluted,
        riverTable.isRegional AS isRegional,
        riverTable.isTributary AS isTributary
    FROM
        eridanus.river riverTable;
        
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/