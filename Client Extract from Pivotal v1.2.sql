--PIVOTAL CLIENT EXTRACT - ALM - V1.2

USE ANGEL_Jon_Charcol_Pivotal_Test
GO

IF OBJECT_ID('ANGEL_Jon_Charcol_Pivotal_Test..iO_Client_Extract') IS NOT NULL
DROP TABLE ANGEL_Jon_Charcol_Pivotal_Test..iO_Client_Extract

CREATE TABLE [dbo].[iO_Client_Extract]
	(
		[MigrationRef] BINARY(8),
		[LegacyContactType] [varchar](255),
		[ContactType] [varchar](9),
		[FirstName] [varchar](255),
		[LastName] [varchar](255),
		[MiddleName] [varchar](255),
		[LegacyTitle] [varchar](255),
		[Title] [varchar](50),
		[DOB] [varchar](11),
		[Gender] [varchar](10),
		[NINumber] [varchar](25),
		[IsSmoker] [varchar](10),
		[CorporateName] [varchar](255),
		[Adviser] [varchar](50),
		[AdviserMigrationRef] [varchar](50),
		[Notes] [TEXT],
		[AddressLine1] [varchar](50),
		[AddressLine2] [varchar](50),
		[AddressLine3] [varchar](50),
		[AddressLine4] [varchar](50),
		[City] [varchar](50),
		[LegacyCounty] [varchar](50),
		[County] [varchar](50),
		[PostCode] [varchar](50),
		[LegacyCountry] [varchar](255),
		[Country] [varchar](50),
		[TelephoneNumber] [varchar](50),
		[WorkNumber] [varchar](50),
		[FaxNumber] [varchar](50),
		[Email] [varchar](100),
		[Mobile] [varchar](50),
		[Web] [varchar](50),
		[DPAMail] [varchar](50),
		[DPATelephone] [varchar](50),
		[DPAEmail] [varchar](50),
		[SecondaryMigrationRef] [varchar](50),
		[ClientServiceStatus] [varchar](50),
		[RelatedtoMigrationRef] BINARY(8),
		[LegacyRelationshipType] [varchar](50),
		[RelationshipType] [varchar](50),
		[DeceasedDate] [varchar](50),
		[CampaignType] [varchar](50),
		[CampaignSource] [varchar](50),
		[CampaignDescription] [varchar](50),
		[LegacyMaritalStatus] [varchar](255),
		[MaritalStatus] [varchar](50),
		[Occupation] [varchar](50),
		[Employer] [varchar](50),
		[LegacyEmploymentStatus] [varchar](255),
		[EmploymentStatus] [varchar](50),
		[PSalutation] [varchar](50),
		[Control] [varchar](1)
	)
	GO

	--SELECT ALL (Progress Check)
	/*
	SELECT * FROM iO_Client_Extract
	select distinct [TYPE] from Contact
	*/
-- CLIENT IMPORT from CONTACT (C)
 
 INSERT INTO iO_Client_Extract
 (
	[MigrationRef],
	[LegacyContactType],
	[ContactType],
	[FirstName],
	[LastName],
	[MiddleName],
	[LegacyTitle],
	[Title],
	[DOB],
	[Gender],
	[NINumber],
	[IsSmoker],
	[CorporateName],
	[Adviser],
	[AdviserMigrationRef],
	[Notes],
	[AddressLine1],
	[AddressLine2],
	[AddressLine3],
	[AddressLine4],
	[City],
	[LegacyCounty],
	[County],
	[PostCode],
	[LegacyCountry],
	[Country],
	[TelephoneNumber],
	[WorkNumber],
	[FaxNumber],
	[Email],
	[Mobile],
	[Web],
	[DPAMail],
	[DPATelephone],
	[DPAEmail],
	[SecondaryMigrationRef],
	[ClientServiceStatus],
	[RelatedtoMigrationRef],
	[LegacyRelationshipType],
	[RelationshipType],
	[DeceasedDate],
	[CampaignType],
	[CampaignSource],
	[CampaignDescription],
	[LegacyMaritalStatus],
	[MaritalStatus],
	[Occupation],
	[Employer],
	[LegacyEmploymentStatus],
	[EmploymentStatus],
	[PSalutation],
	[Control]
 )
 SELECT
	C.CONTACT_ID AS [MigrationRef],
	C.TYPE AS [LegacyContactType],
	CASE C.TYPE
		WHEN 'Cleint' THEN 'Person'
		WHEN 'Client' THEN 'Person'
		WHEN 'cliient' THEN 'Person' 
		WHEN 'C' THEN 'Person'
		WHEN 'Business' THEN 'Corporate' 
		WHEN 'Bus' THEN 'Corporate' 
	ELSE NULL END AS [ContactType],
	C.FIRST_NAME AS [FirstName],
    C.LAST_NAME AS [LastName],
  	NULL AS [MiddleName],
  	C.TITLE AS [LegacyTitle],
    NULL AS [Title], -- To improve mapping with CASE?
	REPLACE(CONVERT(varchar,C.BIRTHDAY,106),' ','-') AS [DOB],
    C.GENDER AS [Gender],
    C.NI_NUMBER AS [NINumber],
	C.SMOKES AS [IsSmoker],
	C.COMPANY_NAME AS [CorporateName],
	E.RN_DESCRIPTOR AS [Adviser],
	E.EMPLOYEE_ID AS [AdviserMigrationRef],
	NULL AS [Notes],
	C.HOME_ADDRESS_1 AS [AddressLine1],
	C.HOME_ADDRESS_2 AS [AddressLine2],
	C.HOME_ADDRESS_3 AS [AddressLine3],
	NULL AS [AddressLine4],
	C.HOME_TOWN AS [City],
	C.HOME_COUNTY AS [LegacyCounty],
	NULL AS [County],
	C.HOME_POSTCODE AS [PostCode],
	C.COUNTRY AS [LegacyCountry],
	NULL AS [Country],
	-- A.type AS [Legacy_AddressType],
	--CASE a.type WHEN 'Residential' THEN 'Home' WHEN 'Business' THEN 'Work' WHEN 'Postal' THEN 'Home' END AS [AddressType], -- Other types of address?
	C.PHONE AS [TelephoneNumber],
	C.DAYTIME_PHONE AS [WorkNumber],
 	C.FAX AS [FaxNumber],
	C.EMAIL AS [Email],
	C.CELL AS [Mobile],
    NULL AS [Web],
    --IF "NO CONTACT" FIELD IS SET TO "NO" THEN THE FOLLOWING 3 DPA FIELDS NEED TO BE SET TO NO
	CASE C.CONSENT_TO_MARKETING 
		WHEN 'Yes' THEN '1' 
		ELSE '0' END AS [DPAMail],
	CASE C.CONSENT_TO_MARKETING
		WHEN 'Yes' THEN '1' 
		ELSE '0' END AS [DPATelephone],
	CASE C.CONSENT_TO_MARKETING
		WHEN 'Yes' THEN '1' 
		ELSE '0' END AS [DPAEmail],
	C.CUSTOMER_REF_NO AS [SecondaryMigrationRef],
	NULL AS [ClientServiceStatus],		--USE CONSENT TO RATE ROLL OFF FIELD TO POPULATE THIS FIELD TO "JC SERVICE" UNLESS CLIENT IS "DECEASED"
	NULLIF(C.SIGNIFICANT_OTHER,'') AS [RelatedtoMigrationRef],	--CHANGED FROM 'NULLIF(C.PARTNER_CONTACT_ID,'') AS [RelatedtoMigrationRef],'
	NULL AS [LegacyRelationshipType],
	NULL AS [RelationshipType],
	NULL AS [DeceasedDate],
	NULL AS [CampaignType],
	C.ORIGINAL_LEAD_SOURCE AS [CampaignSource],
	NULL AS [CampaignDescription],
	NULL AS [LegacyMaritalStatus],
	CASE C.MARITAL_STATUS 
		WHEN 'Co-Habitee' THEN 'Living Together'
		WHEN 'Cohabiting' THEN 'Living Together'
		WHEN 'Divorced/ Ex-Civil Partner' THEN 'Divorced' 
		WHEN 'Married/ Civil Partnership' THEN 'Married' 
		WHEN 'Same Sex Partner' THEN 'Civil Partner' 
		WHEN 'Widowed/ Surviving Civil Partner' THEN 'Widowed'
		ELSE C.MARITAL_STATUS END AS [MaritalStatus],
	C.OCCUPATION AS [Occupation],
	C.COMPANY_NAME AS [Employer],
	C.EMPLOYMENT_STATUS AS [LegacyEmploymentStatus],
	CASE C.EMPLOYMENT_STATUS 
		WHEN 'Housewife/husband' THEN 'Houseperson' 
		WHEN 'Self Employed' THEN 'Self-Employed' 
		WHEN 'Contractor' THEN 'Self-Employed' 
		WHEN 'Employed' THEN 'Employed'
		ELSE C.EMPLOYMENT_STATUS END AS [EmploymentStatus],
	C.ENVELOPE_ADDRESS AS [PSalutation],
	1 AS [Control]
  FROM CONTACT C
  LEFT JOIN Employee E
	ON E.EMPLOYEE_ID = C.ACCOUNT_MANAGER_ID
  LEFT JOIN Company CO
	ON CO.COMPANY_ID = C.COMPANY_ID	
  
SELECT * FROM iO_Client_Extract



/*

--INSERT UNIQUE CASE REF - *** Insert the Case Ref you are working on in the CASEREF value below. ***
	DECLARE @CASEREF varchar(10)
	
	SET @CASEREF = 123456 -- <-- To change this to the Case Ref that is currently being worked on.

	UPDATE iO_Client_Extract
	SET MigrationRef = MigrationRef + ' (CASE-' + @CASEREF + ')',
	RelatedtoMigrationRef = ISNULL(RelatedtoMigrationRef + ' CASE-' + @CASEREF + ')','')
	GO


--UPDATE COUNTIES
		UPDATE CE
			SET CE.County = C.[County Name]
		FROM [iO_Client_Extract] CE
		LEFT JOIN [iO_RefData].[DBO].[Alt Counties] AC
			ON AC.[Alt County Name] = CE.County
		LEFT JOIN [iO_RefData].[DBO].[IO Counties] C
			ON C.ID = AC.[IO County ID]
	GO


--UPDATE COUNTRIES
		UPDATE CE
			SET CE.Country = C.[Country Name]
		FROM [iO_Client_Extract] CE
		LEFT JOIN [iO_RefData].[DBO].[Alt Countries] AC
			ON AC.[Alt Country Name] = CE.Country
		LEFT JOIN [iO_RefData].[DBO].[IO Countries] C
			ON C.ID = AC.[IO Country ID]
	GO


	--SELECT ALL (Final Result)
	SELECT * FROM iO_Client_Extract
	*/
	
	
