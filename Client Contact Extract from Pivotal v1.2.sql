--PIVOTAL ADDITIONAL CONTACT EXTRACT - ALM - V1.0

USE ANGEL_Jon_Charcol_Pivotal_Test
GO

IF OBJECT_ID('ANGEL_Jon_Charcol_Pivotal_Test..iO_Client_Contacts_Extract') IS NOT NULL
DROP TABLE ANGEL_Jon_Charcol_Pivotal_Test..iO_Client_Contacts_Extract

CREATE TABLE [dbo].[iO_Client_Contacts_Extract]
	(
		[MigrationRef] BINARY(8),
		[ClientMigrationRef] BINARY(8),
		[Type] TEXT,
		[Value] VARCHAR(255),
		[Note] TEXT,
		[Default] VARCHAR(3),
		[Control] BIT,
	)
	GO
 
	 INSERT INTO iO_Client_Contacts_Extract
	 (
		[MigrationRef],
		[ClientMigrationRef],
		[Type],
		[Value],
		[Note],
		[Default],
		[Control]
	 )
	 SELECT
		AP.ALT_PHONE_ID AS [MigrationRef],
		AP.CONTACT_ID AS [ClientMigrationRef],
		'Telephone' AS [Type],
		AP.PHONE AS [Value],
		CAST(AP.RN_DESCRIPTOR AS NVARCHAR) + ': Comments: ' + CAST(AP.COMMENTS AS NVARCHAR) AS [Note],
		NULL AS [Default],
		NULL AS [Control]
	 FROM Alt_Phone AP
	 LEFT JOIN Contact C
		ON C.CONTACT_ID = AP.CONTACT_ID
	
	SELECT * FROM iO_Client_Contacts_Extract

	--SELECT TOP 10 * FROM Alt_Phone

