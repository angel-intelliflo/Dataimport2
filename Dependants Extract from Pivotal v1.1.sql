--PIVOTAL DEPENDANT EXTRACT - ALM - V1.0
USE Jon_Charcol_Pivotal
GO

CREATE TABLE [dbo].[t_DI_dependant](
	[MigrationRef] [varchar](50) NOT NULL,
	[Owner1Ref] [varchar](50) NOT NULL,
	[Owner2Ref] [varchar](50) NULL,
	[FullName] [varchar](50) NOT NULL,
	[DOB] [datetime] NULL,
	[Relationship] [varchar](50) NOT NULL,
	[DependantOf] [varchar](50) NOT NULL,
	[FinancialyDependent] [varchar](3) NULL,
	[ControlNumber] [varchar](1) NOT NULL
) ON [PRIMARY]

--DEPENDANT EXTRACT FROM [Correspondence]

--SELECT TOP 100 * FROM Correspondence 

