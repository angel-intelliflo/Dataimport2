--PIVOTAL COMMISSION EXPECTATION EXTRACT - ALM - V1.0

If Object_Id('ANGEL_Jon_Charcol_Pivotal_Test..iO_Commission_Expectation_Extract') IS NOT NULL  
 DROP TABLE ANGEL_Jon_Charcol_Pivotal_Test..iO_Commission_Expectation_Extract  


	CREATE TABLE ANGEL_Jon_Charcol_Pivotal_Test..[iO_Commission_Expectation_Extract]
	(
		[CommissionMigrationRef] BINARY(8),
		[PlanMigrationRef] BINARY(8),
		[InitialFG] [BIT],
		[RecurringFG] [BIT],
		[CommissionType] [VARCHAR] (30),
		[Amount] [VARCHAR] (10),
		[Due] [VARCHAR] (20),
		[DueDate] DATE,
		[Frequency] [VARCHAR] (30),
		[ChargingPeriod] [VARCHAR] (4),
		[Control] [BIT]
	) 
	INSERT INTO [iO_Commission_Expectation_Extract]
	(
		[CommissionMigrationRef],
		[PlanMigrationRef],
		[InitialFG],
		[RecurringFG],
		[CommissionType],
		[Amount],
		[Due],
		[DueDate],
		[Frequency],
		[ChargingPeriod],
		[Control]
	)
	SELECT
		B.BANKING_ID AS [CommissionMigrationRef],
		B.CASE_ID AS [PlanMigrationRef],
		1 AS [InitialFG],
		0 AS [RecurringFG],
		'Single Premium' AS [CommissionType],
		B.OTHER AS [Amount],
		NULL AS [Due],
		NULL AS [DueDate],
		NULL AS [Frequency],
		NULL AS [ChargingPeriod],
		NULL AS [Control]
	FROM [ANGEL_Jon_Charcol_Pivotal_Test].[dbo].[Banking] B
	

	SELECT * FROM [iO_Commission_Expectation_Extract]
	
	SELECT BANKED_AMOUNT, OTHER, * FROM BANKING where RECEIVED_DATE IS NULL