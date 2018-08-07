--PIVOTAL DOCUMENT EXTRACT - ALM - V1.1
--PIVOTAL DOCUMENT EXTRACT - Sue Updates - V1.2

USE ANGEL_Jon_Charcol_Pivotal_Test
GO

IF Object_Id('ANGEL_Jon_Charcol_Pivotal_Test..iO_Document_Extract') IS NOT NULL  
 DROP TABLE ANGEL_Jon_Charcol_Pivotal_Test..iO_Document_Extract

CREATE TABLE [dbo].[iO_Document_Extract]
(
	[DocumentMigrationRef] BINARY(8),
	[FileLocation] [varchar](255) NULL,
	[Identifier] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
	[CodedFileName] [varchar](255) NULL,
	[ClientName] [varchar](100) NULL,
	[LegacyFullPathName] [varchar](255) NULL,
	[FYI_SendMethod] [varchar] (50) NULL,
	[DocumentCategory] [varchar](255) NULL,
	[DocumentSubCategory] [varchar](255) NULL,
	[OriginalFileName] [varchar](255) NULL,
	[ClientMigrationRef] BINARY(8),
	[CRMContactID] [int] NULL,
	[PlanMigrationRef] BINARY(8),
	[PolicyBusinessId] [int] NULL,
	[AdviceCaseMigrationRef] [varchar](50) NULL,
	[AdviceCaseID] [int] NULL,
	[IsFactFind] [bit] NULL,
	[TaskMigrationRef] BINARY(8),
	[LastUpdatedDate] [datetime] NULL,
	[FilePath] [varchar](255) NULL,
	[LinkedDoc] [bit] NULL,
	[FileSize] [int] NULL,
	[SourceFileHash] [varchar](1000) NULL,
	[DestinationFileHash] [varchar](1000) NULL,
	[FileSuccessfullyCopiedToDocStore] [bit] NULL,
	[ErrorMessage] [varchar](1000) NULL,
	[Control] [tinyint] NULL
)


--DOCUMENT LINK EXTRACT FROM [Correspondence]
--WHERE SENT METHOD != NOT SENT

--SELECT TOP 100 * FROM Correspondence 

INSERT INTO [dbo].[iO_Document_Extract]
(
	[DocumentMigrationRef],
	[FileLocation],
	[Identifier],
	[Description],
	[CodedFileName],
	[ClientName],
	[LegacyFullPathName],
	[FYI_SendMethod],
	[DocumentCategory],
	[DocumentSubCategory],
	[OriginalFileName],
	[ClientMigrationRef],
	[CRMContactID],
	[PlanMigrationRef],
	[PolicyBusinessId],
	[AdviceCaseMigrationRef],
	[AdviceCaseID],
	[IsFactFind],
	[TaskMigrationRef],
	[LastUpdatedDate],
	[FilePath],
	[LinkedDoc],
	[FileSize],
	[SourceFileHash],
	[DestinationFileHash],
	[FileSuccessfullyCopiedToDocStore],
	[ErrorMessage],
	[Control]
)
SELECT 
		--CO.CORRESPONDENCE_ID AS [DocumentMigrationRef],
	CA.CORRESPONDENCE_ATTACHMENTS_ID AS [DocumentMigrationRef],																	--SUE'S MAPPING
		--SUBSTRING(DOCUMENT_FILEPATH,1,LEN(DOCUMENT_FILEPATH)-CHARINDEX('\',REVERSE(DOCUMENT_FILEPATH))+1) AS [FileLocation],
	SUBSTRING(CA.ATTACHMENT,1,LEN(CA.ATTACHMENT)-CHARINDEX('\',REVERSE(CA.ATTACHMENT))+1) AS [FileLocation],					--SUE'S MAPPING
		--CO.DESCRIPTION AS [Identifier],
	CA.DESCRIPTION_ AS [Identifier],																							--SUE'S MAPPING
		--CO.[DESCRIPTION] AS [Description],
	CA.DESCRIPTION_ AS [Identifier],																							--SUE'S MAPPING
	NULL AS [CodedFileName],
	C.FIRST_NAME + ' ' + C.LAST_NAME AS [ClientName],
		--CO.DOCUMENT_FILEPATH AS [LegacyFullPathName],
	CA.ATTACHMENT AS [LegacyFullPathName],																						--SUE'S MAPPING
	CO.SEND_METHOD AS [FYI_SendMethod],
	NULL AS [DocumentCategory],
	NULL AS [DocumentSubCategory],
		--RIGHT(DOCUMENT_FILEPATH, (CHARINDEX('\',REVERSE(DOCUMENT_FILEPATH),0))-1) AS [OriginalFileName],
	RIGHT(CA.ATTACHMENT,(NULLIF(CHARINDEX('\',REVERSE(CA.ATTACHMENT)),0))-1) AS [OriginalFileName],									--SUE'S MAPPING
	CO.CONTACT_ID AS [ClientMigrationRef],
	NULL AS [CRMContactID],
	CO.CASE_ID AS [PlanMigrationRef],
	NULL AS [PolicyBusinessId],
	NULL AS [AdviceCaseMigrationRef],
	NULL AS [AdviceCaseID],
	NULL AS [IsFactFind],
	CO.CORRESPONDENCE_ID AS [TaskMigrationRef],
	CONVERT(VARCHAR(11),CONVERT(DATE,CO.DATE_SENT,106),113) AS [LastUpdatedDate],
	SUBSTRING(DOCUMENT_FILEPATH,1,LEN(DOCUMENT_FILEPATH)-CHARINDEX('\',REVERSE(DOCUMENT_FILEPATH))+1) AS [FilePath],
	NULL AS [LinkedDoc],
	NULL AS [FileSize],
	NULL AS [SourceFileHash],
	NULL AS [DestinationFileHash],
	NULL AS [FileSuccessfullyCopiedToDocStore],
	NULL AS [ErrorMessage],
	1 AS [Control]
FROM Correspondence_Attachments CA
LEFT JOIN Correspondence CO
	ON CO.CORRESPONDENCE_ID = CA.CORRESPONDENCE_ID
LEFT JOIN Contact C
	ON C.CONTACT_ID = CO.CONTACT_ID

SELECT * FROM iO_Document_Extract

/*
SELECT TOP 10 * FROM Correspondence_Attachments
select top 10 * from Case_
select top 10 * from Correspondence
*/