IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[User]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[User] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Username] VARCHAR(200) NULL, 
	[Email] VARCHAR(200) NULL, 
	[Active] BIT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Username]), 
	UNIQUE ([Email])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Characteristics]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Characteristics] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[isCTPP] BIT NULL, 
	[Spreadsheet] IMAGE NULL, 
	PRIMARY KEY ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[TempCountry]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[TempCountry] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Name] NVARCHAR(255) NOT NULL, 
	[Abbreviation] NVARCHAR(255) NOT NULL, 
	PRIMARY KEY ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[TempDisease]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[TempDisease] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Name] NVARCHAR(255) NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Name])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[DataSpecification]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[DataSpecification] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[NumPops] INTEGER NOT NULL, 
	[PythonObj] IMAGE NOT NULL, 
	[Archived] DATETIME NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Name], [Archived])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[SocialAuthNonce]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[SocialAuthNonce] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[ServerUrl] VARCHAR(255) NULL, 
	[Timestamp] INTEGER NULL, 
	[Salt] VARCHAR(40) NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([ServerUrl], [Timestamp], [Salt])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[SocialAuthAssociation]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[SocialAuthAssociation] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[ServerUrl] VARCHAR(255) NULL, 
	[Handle] VARCHAR(255) NULL, 
	[Secret] VARCHAR(255) NULL, 
	[Issued] INTEGER NULL, 
	[Lifetime] INTEGER NULL, 
	[AssocType] VARCHAR(64) NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([ServerUrl], [Handle])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[SocialAuthCode]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[SocialAuthCode] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Email] VARCHAR(200) NULL, 
	[Code] VARCHAR(32) NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Code], [Email])
)
END
GO

CREATE INDEX [ix_gcat_SocialAuthCode_Code] ON gcat.[SocialAuthCode] ([Code])

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[SocialAuthPartial]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[SocialAuthPartial] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Token] VARCHAR(32) NULL, 
	[Data] TEXT NULL, 
	[NextStep] INTEGER NULL, 
	[Backend] VARCHAR(32) NULL, 
	PRIMARY KEY ([ID])
)
END
GO

CREATE INDEX [ix_gcat_SocialAuthPartial_Token] ON gcat.[SocialAuthPartial] ([Token])

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Analysis]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Analysis] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[UserID] INTEGER NOT NULL, 
	[Final] BIT NOT NULL, 
	[StartYear] FLOAT NOT NULL, 
	[EndYear] FLOAT NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([UserID], [Name]), 
	FOREIGN KEY([UserID]) REFERENCES gcat.[User] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Intervention]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Intervention] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Pathogen] NVARCHAR(255) NULL, 
	[Type] NVARCHAR(255) NULL, 
	[PST] NVARCHAR(255) NULL, 
	[Archived] DATETIME NULL, 
	[UpdatedBy] INTEGER NULL, 
	[CharacteristicsMin] INTEGER NULL, 
	[CharacteristicsOpt] INTEGER NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Name], [Archived]), 
	FOREIGN KEY([UpdatedBy]) REFERENCES gcat.[User] ([ID]), 
	FOREIGN KEY([CharacteristicsMin]) REFERENCES gcat.[Characteristics] ([ID]), 
	FOREIGN KEY([CharacteristicsOpt]) REFERENCES gcat.[Characteristics] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Framework]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Framework] (
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[DiseaseID] INTEGER NOT NULL, 
	[ModelType] NVARCHAR(255) NULL, 
	[Archived] DATETIME NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([DiseaseID], [Name], [Archived]), 
	FOREIGN KEY([DiseaseID]) REFERENCES gcat.[TempDisease] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[SocialAuthUser]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[SocialAuthUser] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[Provider] VARCHAR(32) NULL, 
	[ExtraData] TEXT NULL, 
	[UID] VARCHAR(255) NULL, 
	[UserID] INTEGER NOT NULL, 
	PRIMARY KEY ([ID]), 
	FOREIGN KEY([UserID]) REFERENCES gcat.[User] ([ID])
)
END
GO

CREATE INDEX [ix_gcat_SocialAuthUser_UserID] ON gcat.[SocialAuthUser] ([UserID])

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Scenario]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Scenario] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[AnalysisID] INTEGER NOT NULL, 
	[PythonObj] IMAGE NOT NULL, 
	[NumProducts] INTEGER NOT NULL, 
	[NumBranches] INTEGER NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([AnalysisID], [Name]), 
	FOREIGN KEY([AnalysisID]) REFERENCES gcat.[Analysis] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[InterventionDiseaseMap]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[InterventionDiseaseMap] (
	[InterventionID] INTEGER NULL, 
	[DiseaseID] INTEGER NULL, 
	FOREIGN KEY([InterventionID]) REFERENCES gcat.[Intervention] ([ID]), 
	FOREIGN KEY([DiseaseID]) REFERENCES gcat.[TempDisease] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Product]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Product] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[InterventionID] INTEGER NOT NULL, 
	[Archived] DATETIME NULL, 
	[SOC] BIT NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([Name], [Archived]), 
	FOREIGN KEY([InterventionID]) REFERENCES gcat.[Intervention] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[FrameworkFile]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[FrameworkFile] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Key] INTEGER NOT NULL IDENTITY(1,1), 
	[ID] INTEGER NOT NULL, 
	[Spreadsheet] IMAGE NOT NULL, 
	[Notes] TEXT NULL, 
	PRIMARY KEY ([Key]), 
	FOREIGN KEY([ID]) REFERENCES gcat.[Framework] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[ProductCharacteristicsMap]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[ProductCharacteristicsMap] (
	[ProductID] INTEGER NULL, 
	[CharacteristicsID] INTEGER NULL, 
	FOREIGN KEY([ProductID]) REFERENCES gcat.[Product] ([ID]), 
	FOREIGN KEY([CharacteristicsID]) REFERENCES gcat.[Characteristics] ([ID]) ON DELETE CASCADE
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[CountryData]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[CountryData] (
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[FrameworkKey] INTEGER NOT NULL, 
	[CountryID] INTEGER NOT NULL, 
	[SpecificationID] INTEGER NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([FrameworkKey], [CountryID], [SpecificationID]), 
	FOREIGN KEY([FrameworkKey]) REFERENCES gcat.[FrameworkFile] ([Key]), 
	FOREIGN KEY([CountryID]) REFERENCES gcat.[TempCountry] ([ID]), 
	FOREIGN KEY([SpecificationID]) REFERENCES gcat.[DataSpecification] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[CountryDataFile]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[CountryDataFile] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[Key] INTEGER NOT NULL IDENTITY(1,1), 
	[ID] INTEGER NOT NULL, 
	[Spreadsheet] IMAGE NOT NULL, 
	[Archived] DATETIME NULL, 
	[Valid] BIT NULL, 
	PRIMARY KEY ([Key]), 
	UNIQUE ([ID], [Name]), 
	FOREIGN KEY([ID]) REFERENCES gcat.[CountryData] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Calibration]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Calibration] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Name] NVARCHAR(255) NOT NULL, 
	[Description] NVARCHAR(255) NULL, 
	[Notes] TEXT NULL, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[DataKey] INTEGER NOT NULL, 
	[PythonObj] IMAGE NOT NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([DataKey], [Name]), 
	FOREIGN KEY([DataKey]) REFERENCES gcat.[CountryDataFile] ([Key])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Project]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Project] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[Modified] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[ScenarioID] INTEGER NOT NULL, 
	[DataKey] INTEGER NOT NULL, 
	[CalibrationID] INTEGER NOT NULL, 
	[Notes] TEXT NULL, 
	[PythonObj] IMAGE NOT NULL, 
	[DataStartYear] FLOAT NULL, 
	[CalibrationQuality] FLOAT NULL, 
	PRIMARY KEY ([ID]), 
	FOREIGN KEY([ScenarioID]) REFERENCES gcat.[Scenario] ([ID]), 
	FOREIGN KEY([DataKey]) REFERENCES gcat.[CountryDataFile] ([Key]), 
	FOREIGN KEY([CalibrationID]) REFERENCES gcat.[Calibration] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[Result]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[Result] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[ProjectID] INTEGER NOT NULL, 
	[PythonObj] IMAGE NOT NULL, 
	PRIMARY KEY ([ID]), 
	FOREIGN KEY([ProjectID]) REFERENCES gcat.[Project] ([ID]) ON DELETE CASCADE
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[CalibrationTask]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[CalibrationTask] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[StartTime] DATETIME NULL, 
	[EndTime] DATETIME NULL, 
	[TaskID] NVARCHAR(32) NULL, 
	[Completed] BIT NULL, 
	[Error] BIT NULL, 
	[Status] TEXT NULL, 
	[ProjectID] INTEGER NOT NULL, 
	[PythonObj] IMAGE NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([TaskID]), 
	UNIQUE ([ProjectID]), 
	FOREIGN KEY([ProjectID]) REFERENCES gcat.[Project] ([ID])
)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'gcat.[ScenarioTreeResult]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
CREATE TABLE gcat.[ScenarioTreeResult] (
	[Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	[ID] INTEGER NOT NULL IDENTITY(1,1), 
	[StartTime] DATETIME NULL, 
	[EndTime] DATETIME NULL, 
	[TaskID] NVARCHAR(32) NULL, 
	[Completed] BIT NULL, 
	[Error] BIT NULL, 
	[Status] TEXT NULL, 
	[ScenarioID] INTEGER NOT NULL, 
	[ProjectID] INTEGER NOT NULL, 
	[BranchUID] NVARCHAR(36) NOT NULL, 
	[ResultID] INTEGER NULL, 
	PRIMARY KEY ([ID]), 
	UNIQUE ([TaskID]), 
	FOREIGN KEY([ScenarioID]) REFERENCES gcat.[Scenario] ([ID]), 
	FOREIGN KEY([ProjectID]) REFERENCES gcat.[Project] ([ID]), 
	FOREIGN KEY([ResultID]) REFERENCES gcat.[Result] ([ID])
)
END
GO
