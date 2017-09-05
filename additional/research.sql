/**
* @author FABIO ELIA LOCATELLI
* @studentID 2143701
* @revisionDate 22/02/2017
* @purpose EXPERIMENTAL CODE COLLECTION
*------------------------------------------------------------*/

SELECT 
    *
FROM
    eridanus.riverparameters;
    
SELECT 
    *
FROM
    eridanus.riverparameters
WHERE
    countryName LIKE 'Italy'
ORDER BY averageDischarge ASC;

SELECT 
    GROUP_CONCAT(localName
        ORDER BY averageDischarge ASC
        SEPARATOR ',')
FROM
    eridanus.riverparameters
WHERE
    countryName LIKE 'Italy';
    
SELECT 
    GROUP_CONCAT(averageDischarge
        ORDER BY averageDischarge ASC
        SEPARATOR ',')
FROM
    eridanus.riverparameters
WHERE
    countryName LIKE 'Italy';
    
SELECT 
    GROUP_CONCAT(catchmentBasin
        ORDER BY averageDischarge ASC
        SEPARATOR ',')
FROM
    eridanus.riverparameters
WHERE
    countryName LIKE 'Italy';
    
SELECT 
    GROUP_CONCAT(length
        ORDER BY averageDischarge ASC
        SEPARATOR ',')
FROM
    eridanus.riverparameters
WHERE
    countryName LIKE 'Italy';
    
SELECT 
    GROUP_CONCAT(localName
        ORDER BY averageDischarge ASC
        SEPARATOR ',')
FROM
    eridanus.riverparameters;
    
SELECT 
    GROUP_CONCAT(localName
        ORDER BY 'averageDischarge' DESC
        SEPARATOR ',')
FROM
    eridanus.riverparameters;
    
SELECT AES_ENCRYPT('Ganges', 'SadalmelikSuhail@#$');

SELECT 
    CAST(AES_DECRYPT(AES_ENCRYPT('Ganges', 'SadalmelikSuhail@#$'),
                'SadalmelikSuhail@#$')
        AS CHAR (1024) CHARACTER SET UTF8);
    
SHOW VARIABLES LIKE 'group_concat%';

SELECT 
    COUNT(localName)
FROM
    eridanus.river;

SELECT 
    COUNT(DISTINCT localName)
FROM
    eridanus.country;
    
SELECT 
    localName,
    GROUP_CONCAT(CONCAT(localName,
                ', ',
                averageDischarge,
                ', ',
                catchmentBasin,
                ', ',
                length)
        SEPARATOR ',')
FROM
    eridanus.river
GROUP BY localName;

SELECT 
    CONCAT(averageDischarge,
            '|',
            catchmentBasin,
            '|',
            length)
FROM
    eridanus.river
WHERE
    localName LIKE 'Xingu';

SELECT 
    GROUP_CONCAT(CONCAT(localName,
                ', ',
                averageDischarge,
                ', ',
                catchmentBasin,
                ', ',
                length)
        SEPARATOR ' | ')
FROM
    eridanus.river;
