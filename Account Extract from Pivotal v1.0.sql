--PIVOTAL ACCOUNT EXTRACT - ALM - V1.0

USE ANGEL_Jon_Charcol_Pivotal_Test
GO

IF OBJECT_ID('ANGEL_Jon_Charcol_Pivotal_Test..iO_Solicitor_ProfContact_Extract') IS NOT NULL
DROP TABLE ANGEL_Jon_Charcol_Pivotal_Test..iO_Solicitor_ProfContact_Extract

CREATE TABLE [dbo].[iO_Solicitor_ProfContact_Extract]
	(
		[MigrationRef] BINARY(8),
		[AccountNature] VARCHAR(10),
		[AccountType] VARCHAR(50),
		[Title] VARCHAR(50),
		[FirstName] VARCHAR(255),
		[MiddleName] VARCHAR(255),
		[LastName] VARCHAR(255),
		[JobTitle] VARCHAR(255),
		[Gender] VARCHAR(11),
		[Employer] VARCHAR(255),
		[AdviserUser] VARCHAR(50),
		[AdviserUserMigrationRef] BINARY(8),
		[CorporateName] VARCHAR(255),
		[Type] VARCHAR(50),
		[BusinessType] VARCHAR(50),
		[CompanyRegNumber] VARCHAR(50),
		[AddressType] VARCHAR(50),
		[OtherAddressType] VARCHAR(50),
		[ResidencyStatus] VARCHAR(50),
		[AddressLine1] VARCHAR(50),
		[AddressLine2] VARCHAR(50),
		[AddressLine3] VARCHAR(50),
		[AddressLine4] VARCHAR(50),
		[CityTown] VARCHAR(50),
		[County] VARCHAR(50),
		[PostCode] VARCHAR(10),
		[Country] VARCHAR(50),
		[DateFrom] DATE,
		[AddressStatus] VARCHAR(50),
		[Telephone] VARCHAR(50),
		[Mobile] VARCHAR(50),
		[Fax] VARCHAR(50),
		[Email] VARCHAR(50),
		[Website] VARCHAR(50),
		[SocialMedia] VARCHAR(50),
		[CampaignType] VARCHAR(50),
		[CampaignSource] VARCHAR(50),
		[CampaignDescription] VARCHAR(50),
		[Cost] VARCHAR(50),
		[Notes] VARCHAR(500),
		[Control] BIT
	)
	GO
 
	 INSERT INTO iO_Solicitor_ProfContact_Extract
	 (
		[MigrationRef],
		[AccountNature],
		[AccountType],
		[Title],
		[FirstName],
		[MiddleName],
		[LastName],
		[JobTitle],
		[Gender],
		[Employer],
		[AdviserUser],
		[AdviserUserMigrationRef],
		[CorporateName],
		[Type],
		[BusinessType],
		[CompanyRegNumber],
		[AddressType],
		[OtherAddressType],
		[ResidencyStatus],
		[AddressLine1],
		[AddressLine2],
		[AddressLine3],
		[AddressLine4],
		[CityTown],
		[County],
		[PostCode],
		[Country],
		[DateFrom],
		[AddressStatus],
		[Telephone],
		[Mobile],
		[Fax],
		[Email],
		[Website],
		[SocialMedia],
		[CampaignType],
		[CampaignSource],
		[CampaignDescription],
		[Cost],
		[Notes],
		[Control]
	 )
	 SELECT
		NULL AS [MigrationRef],
		NULL AS [AccountNature],
		NULL AS [AccountType],
		NULL AS [Title],
		NULL AS [FirstName],
		NULL AS [MiddleName],
		NULL AS [LastName],
		NULL AS [JobTitle],
		NULL AS [Gender],
		NULL AS [Employer],
		NULL AS [AdviserUser],
		NULL AS [AdviserUserMigrationRef],
		NULL AS [CorporateName],
		NULL AS [Type],
		NULL AS [BusinessType],
		NULL AS [CompanyRegNumber],
		NULL AS [AddressType],
		NULL AS [OtherAddressType],
		NULL AS [ResidencyStatus],
		NULL AS [AddressLine1],
		NULL AS [AddressLine2],
		NULL AS [AddressLine3],
		NULL AS [AddressLine4],
		NULL AS [CityTown],
		NULL AS [County],
		NULL AS [PostCode],
		NULL AS [Country],
		NULL AS [DateFrom],
		NULL AS [AddressStatus],
		NULL AS [Telephone],
		NULL AS [Mobile],
		NULL AS [Fax],
		NULL AS [Email],
		NULL AS [Website],
		NULL AS [SocialMedia],
		NULL AS [CampaignType],
		NULL AS [CampaignSource],
		NULL AS [CampaignDescription],
		NULL AS [Cost],
		NULL AS [Notes],
		1 AS [Control]
		
	 FROM Contact C
	 LEFT JOIN Company CO
		ON C.COMPANY_ID = CO.COMPANY_ID
	 LEFT JOIN Case_ CA
		ON CA.CONTACT_ID = C.CONTACT_ID
	 WHERE CO.TYPE = 'Solicitor'
	
	SELECT * FROM iO_Solicitor_ProfContact_Extract
	/*
	select * from iO_Solicitor_Extract
	select top 10 TYPE,* from Contact
	select top 10 TYPE,* from Company
	select distinct TYPE from Company
	

	--SELECT TOP 10 * FROM Alt_Phone

*/


SELECT * FROM Contact WHERE CONTACT_ID = 0x0000000000014745


0x0000000000000EA2	Solicitor	Karen Newman	Barnes and Partners	0x0000000000014745	NULL	The Business & Technology Centre	Bessemer Drive	NULL	NULL	Stevenage	Herts	SG1 2DX	Stevenage	NULL	NULL	NULL	1