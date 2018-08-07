--PIVOTAL ADDRESS EXTRACT - ALM - V1.0
USE Jon_Charcol_Pivotal
GO

IF Object_Id('Jon_Charcol_Pivotal..iO_Address_Extract') IS NOT NULL  
 DROP TABLE Jon_Charcol_Pivotal..iO_Address_Extract  

	CREATE TABLE iO_Address_Extract
	(
		MigrationRef BINARY(8),
		Owner1MigrationRef BINARY(8),
		LEGACY_Owner VARCHAR (100),
		AddressLine1 VARCHAR (100),
		AddressLine2 VARCHAR (100),
		AddressLine3 VARCHAR (100),
		AddressLine4 VARCHAR (100),
		City VARCHAR (50),
		LegacyCounty VARCHAR (50),
		County VARCHAR (50),
		PostCode VARCHAR (50),
		LegacyCountry VARCHAR (50),
		Country VARCHAR (50),
		AddressType VARCHAR (50),
		IsDefault VARCHAR (3),
		Control VARCHAR (1)
	)

--SELECT ALL (Progress Check)
--	SELECT * FROM iO_Address_Extract


-- ADDRESS IMPORT
 -- Tables expected: entity (E), entity_prev_address (EP)
 -- And previous CLIENT import completed (Iress_iO_Client_Extract)

INSERT INTO	Jon_Charcol_Pivotal..iO_Address_Extract
	(
		MigrationRef,
		Owner1MigrationRef,
		LEGACY_Owner,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		AddressLine4,
		City,
		LegacyCounty,
		County,
		PostCode,
		LegacyCountry,
		Country,
		AddressType,
		IsDefault,
		[Control]
	)
	SELECT
		CA.CASE_ID AS MigrationRef,
		CA.CONTACT_ID AS Owner1MigrationRef,
		C.FIRST_NAME + ' ' + c.LAST_NAME AS LEGACY_Owner,
		PROPERTY_ADDRESS_1 AS [AddressLine1],
		PROPERTY_ADDRESS_2 AS [AddressLine2],
		PROPERTY_ADDRESS_3 AS [AddressLine3],
		NULL AS [AddressLine4],
		PROPERTY_TOWN AS [City],
		PROPERTY_COUNTY AS [LegacyCounty],
		NULL AS [County],
		PROPERTY_POSTCODE AS [PostCode],
		PROPERTY_COUNTRY AS [LegacyCountry],
		NULL AS [Country],
		PROPERTY_TYPE AS [AddressType], -- Other types of address?
		'No' AS IsDefault,
-- start_date and end_date - iO doesn't need to capture (only start_date but doesn't show to user)
-- In iO, for Current Address only, Yrs at Address. Could use End_Date minus Start_Date calculation.
-- Also Current Address, Previous Address, Unknown data in iO.
		'1' AS Control
	FROM Case_ CA
	LEFT JOIN Contact C 
		ON C.CONTACT_ID = CA.CONTACT_ID
	

--SELECT ALL (Progress Check)
	SELECT * FROM iO_Address_Extract


--HIGHLIGHT DISTINCT VALUES
	SELECT DISTINCT * FROM iO_Address_Extract

-- If Distinct Values vary from All then can highlight and remove them with the following two scripts.

--HIGHLIGHT DUPLICATES (For reference purposes)
	SELECT
		MigrationRef,
		Owner1MigrationRef,
		LEGACY_Owner,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		AddressLine4,
		City,
		LegacyCounty,
		County,
		PostCode,
		LegacyCountry,
		Country,
		AddressType,
		IsDefault,
		Control,
		COUNT(*)
	FROM iO_Address_Extract
	GROUP BY
		MigrationRef,
		Owner1MigrationRef,
		LEGACY_Owner,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		AddressLine4,
		City,
		LegacyCounty,
		County,
		PostCode,
		LegacyCountry,
		Country,
		AddressType,
		IsDefault,
		Control
	HAVING COUNT(*) > 1

	
--REMOVE DUPLICATES
	;WITH DuplicatedData AS
	(
		SELECT 
			MigrationRef,
			Owner1MigrationRef,
			LEGACY_Owner,
			AddressLine1,
			AddressLine2,
			AddressLine3,
			AddressLine4,
			City,
			LegacyCounty,
			County,
			PostCode,
			LegacyCountry,
			Country,
			AddressType,
			IsDefault,
			Control, 
		ROW_NUMBER() OVER(PARTITION BY 
			MigrationRef,
			Owner1MigrationRef,
			LEGACY_Owner,
			AddressLine1,
			AddressLine2,
			AddressLine3,
			AddressLine4,
			City,
			LegacyCounty,
			County,
			PostCode,
			LegacyCountry,
			Country,
			AddressType,
			IsDefault,
			Control
		ORDER BY MigrationRef DESC) AS 'RowNum'
		FROM iO_Address_Extract
	)
	DELETE FROM DuplicatedData
	WHERE RowNum > 1


--INSERT UNIQUE CASE REF - *** Insert the Case Ref you are working on in the CASEREF value below. ***
	DECLARE @CASEREF varchar(10)
	
	SET @CASEREF = 123456 -- <-- To change this to the Case Ref that is currently being worked on.

	UPDATE iO_Address_Extract
	SET MigrationRef = MigrationRef + ' [CASE ' + @CASEREF + ']',
	Owner1MigrationRef = ISNULL(Owner1MigrationRef + ' [CASE ' + @CASEREF + ']','')
	GO


	--SELECT ALL (Final Result)
	SELECT * FROM iO_Address_Extract