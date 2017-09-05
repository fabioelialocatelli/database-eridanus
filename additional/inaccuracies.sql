USE eridanus;
DROP VIEW IF EXISTS riverInaccuracies;
CREATE VIEW riverInaccuracies AS
    SELECT 
        river.localName, river.sourceLocation, river.mouthLocation
    FROM
        river
    WHERE
        localName IN ('Ganges' , 'Léna',
            'Mekong',
            'Niger',
            'Nile',
            'Ob',
            'Orinoco',
            'Volga',
            'Yangtze',
            'Yukon',
            'Zambezi')
    ORDER BY localName;
