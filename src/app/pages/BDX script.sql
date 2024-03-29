USE [bdx]
GO
/****** Object:  Table [dbo].[Batch1$]    Script Date: 28-07-2021 08:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch1$](
	[customer] [nvarchar](255) NULL,
	[user] [nvarchar](255) NULL,
	[phonenumber] [float] NULL,
	[key] [float] NULL,
	[Location] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bdx_customerdetail]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdx_customerdetail](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[pkey] [nvarchar](200) NOT NULL,
	[customer] [nvarchar](200) NULL,
	[user] [nvarchar](200) NULL,
	[phoneNumber] [nvarchar](50) NOT NULL,
	[key] [nvarchar](50) NULL,
	[operationSite] [nvarchar](100) NULL,
	[createdGMTDate] [datetime] NULL,
	[createdby] [nvarchar](200) NULL,
	[modifiedGMTDate] [datetime] NULL,
	[modifiedby] [nvarchar](200) NULL,
 CONSTRAINT [PK_bdx_customerdetail] PRIMARY KEY CLUSTERED 
(
	[pkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bdx_portalTransactions]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdx_portalTransactions](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user] [nvarchar](200) NULL,
	[userOperation] [nvarchar](200) NULL,
	[operationDetails] [nvarchar](max) NULL,
	[operationStatus] [nvarchar](50) NULL,
	[operationSite] [nvarchar](50) NULL,
	[operationDate] [datetime] NULL,
 CONSTRAINT [PK_portalLogs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].['data']    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['data'](
	[id] [nvarchar](255) NULL,
	[pkey] [nvarchar](255) NULL,
	[customer] [nvarchar](255) NULL,
	[user] [nvarchar](255) NULL,
	[phonenumber] [float] NULL,
	[key] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loginMaster]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loginMaster](
	[pkey] [nvarchar](100) NOT NULL,
	[userName] [nvarchar](200) NULL,
	[userPassword] [nvarchar](200) NULL,
	[operationSite] [nvarchar](50) NULL,
	[createdGMTDate] [datetime] NULL,
	[createdby] [nvarchar](200) NULL,
	[modifiedGMTDate] [datetime] NULL,
	[modifiedby] [nvarchar](200) NULL,
 CONSTRAINT [PK_loginMaster] PRIMARY KEY CLUSTERED 
(
	[pkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bdx_customerdetail] ADD  DEFAULT (concat(left(CONVERT([int],rand()*(1000000000)+(999999)),(6)),datediff(second,'19700101',getutcdate()))) FOR [pkey]
GO
ALTER TABLE [dbo].[loginMaster] ADD  DEFAULT (concat(left(CONVERT([int],rand()*(1000000000)+(999999)),(6)),datediff(second,'19700101',getutcdate()))) FOR [pkey]
GO
/****** Object:  StoredProcedure [dbo].[phoneNumberkey]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[phoneNumberkey]
	@phonenumber nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	
	
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail') 
		BEGIN
			SELECT top 1 [pkey],[customer],[user],[phonenumber],[key],[modifiedby] FROM [dbo].[bdx_customerdetail] WITH (NOLOCK) WHERE [phonenumber] like '%' + @phonenumber;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[userCreate]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[userCreate]
	@initiatedUser nvarchar(200),
	@customer nvarchar(200),
	@user nvarchar(200),
	@phonenumber nvarchar(50),
	@key nvarchar(100),
	@operationSite nvarchar(50),
	@spOut nvarchar(50) output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	DECLARE @PTABLE bit;
	DECLARE @TTABLE bit;

	SET	@spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
	SET @userOperation = 'USER CREATION';
	SET @operationDetails  = 'INPUT : ' + @customer+'|'+@user+'|'+@phonenumber+'|'+@key;
	SET @operationStatus = 'FAIL';
	SET @operationSite = @operationSite;
	SET @operationDate = GETUTCDATE();
	SET @PTABLE = 0;
	SET @TTABLE = 0;
	
	BEGIN TRY
		
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail')
		BEGIN
			SET @PTABLE = 1;
		END
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_portalTransactions')
		BEGIN
			SET @TTABLE = 1;
		END

		IF (@PTABLE = 1) 
		BEGIN
			IF NOT EXISTS (SELECT 'TRUE' FROM [dbo].[bdx_customerdetail] WITH (NOLOCK) WHERE [phonenumber] = @phonenumber and [customer] = @customer)
			BEGIN
				SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
				BEGIN TRAN
				INSERT INTO [dbo].[bdx_customerdetail] ([customer],[user],[phonenumber],[key],[operationSite],[createdGMTDate],[createdby],[modifiedGMTDate],[modifiedby]) VALUES (@customer,@user,@phonenumber,@key,@operationSite,@operationDate,@initiatedUser,@operationDate,@initiatedUser)
				SET @spOut = 'FAIL|OPERATION|OK|LOG|NOK';
				SET @operationStatus = 'PASS';
				IF (@TTABLE = 1) 
				BEGIN
					INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
					COMMIT TRAN
					SET @spOut = 'PASS|OPERATION|OK|LOG|OK';
				END
				ELSE
				BEGIN
					ROLLBACK TRAN
					SET @spOut = 'FAIL|OPERATION|RB|LOG|NOTEXIST';
				END
			END
			ELSE
			BEGIN 
				SET @spOut = 'FAIL|OPERATION|RECORDEXISTS|LOG|NOK';
				SET @operationStatus = 'FAIL';
				IF (@TTABLE = 1)
				BEGIN
					BEGIN TRANSACTION
					INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
					COMMIT TRANSACTION
					SET @spOut = 'FAIL|OPERATION|RECORDEXISTS|LOG|OK';
				END
				ELSE
				BEGIN
					SET @spOut = 'FAIL|OPERATION|RB|LOG|NOTEXIST';
				END
			END
		END
		ELSE
		BEGIN
			SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOK';
			SET @operationStatus = 'FAIL';
			IF (@TTABLE = 1) 
			BEGIN
				BEGIN TRAN
				INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
				COMMIT TRAN
				SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|OK';
			END
			ELSE
			BEGIN
				SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOTEXIST';
			END
		END
	END TRY
	BEGIN CATCH
		SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
		IF (@TTABLE = 1) 
		BEGIN
			BEGIN TRAN
			INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
			COMMIT TRAN
			SET @spOut = 'FAIL|OPERATION|NOK|LOG|OK';
		END
		ELSE
		BEGIN
			SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOTEXIST';
		END
	END CATCH	
END
GO
/****** Object:  StoredProcedure [dbo].[userDelete]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[userDelete]
	@initiatedUser nvarchar(200),
	@pkey varchar(100),
	@operationSite nvarchar(50),
	@spOut nvarchar(50) output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	DECLARE @PTABLE bit;
	DECLARE @TTABLE bit;
	
	SET	@spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
	SET @userOperation = 'USER DELETE';
	SET @operationDetails  = 'INPUT DELETE ID: '+ +CAST(@pkey AS nvarchar)
	SET @operationStatus = 'FAIL';
	SET @operationSite = @operationSite;
	SET @operationDate = GETUTCDATE();
	SET @operationDate = GETUTCDATE();
	SET @PTABLE = 0;
	SET @TTABLE = 0;

	
	BEGIN TRY
		
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail')
		BEGIN
			SET @PTABLE = 1;
		END
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_portalTransactions')
		BEGIN
			SET @TTABLE = 1;
		END

		IF (@PTABLE = 1) 
		BEGIN
			BEGIN TRAN
			DELETE FROM [dbo].[bdx_customerdetail] WHERE [pkey] = @pkey;
			SET	@spOut = 'PASS|OPERATION|OK|LOG|NOK';
			SET @operationStatus = 'PASS';
			IF (@TTABLE = 1) 
			BEGIN
				INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
				COMMIT TRAN
				SET @spOut = 'PASS|OPERATION|OK|LOG|OK';
			END
			ELSE
			BEGIN
				ROLLBACK TRAN
				SET @spOut = 'FAIL|OPERATION|RB|LOG|NOTEXIST';
			END
		END
		ELSE
		BEGIN 
			SELECT 1;
			SET @operationStatus = 'FAIL';	
			SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOK';
			IF (@TTABLE = 1) 
			BEGIN
				INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
				SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|OK';
			END
			ELSE
			BEGIN
				SET @spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOTEXIST';
			END	
		END
	END TRY
	BEGIN CATCH
		SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
		IF (@TTABLE = 1) 
		BEGIN
			INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
			SET @spOut = 'FAIL|OPERATION|NOK|LOG|OK';
		END
		ELSE
		BEGIN
			SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOTEXIST';
		END
	END CATCH	
END
GO
/****** Object:  StoredProcedure [dbo].[userLogin]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[userLogin]
	@userName nvarchar(200),
	@userPassword nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='loginMaster') 
	BEGIN
		SELECT pkey,userName FROM [dbo].[loginMaster] WITH (NOLOCK) WHERE [userName]=@userName and [userPassword]=@userPassword;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[userModify]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[userModify]
	@initiatedUser nvarchar(200),
	@pkey nvarchar(200),
	@customer nvarchar(200),
	@user nvarchar(200),
	@phonenumber nvarchar(50),
	@key nvarchar(100),
	@operationSite nvarchar(50),
	@spOut nvarchar(50) output

AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	DECLARE @PTABLE bit;
	DECLARE @TTABLE bit;
	
	SET	@spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
	SET @userOperation = 'USER MODIFY';
	SET @operationDetails  = 'INPUT : '+ CAST(@pkey AS nvarchar) + '|' + @customer +'|'+ @user+'|'+ @phonenumber+'|'+@key;
	SET @operationStatus = 'FAIL';
	SET @operationSite = @operationSite;
	SET @operationDate = GETUTCDATE();
	SET @PTABLE = 0;
	SET @TTABLE = 0;

	BEGIN TRY
		
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail')
		BEGIN
			SET @PTABLE = 1;
		END
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_portalTransactions')
		BEGIN
			SET @TTABLE = 1;
		END

		IF (@PTABLE = 1) 
		BEGIN
			IF EXISTS (SELECT 'TRUE' FROM [dbo].[bdx_customerdetail] WITH (NOLOCK) WHERE [customer] = @customer AND [phonenumber]=@phonenumber and [pkey]<> @pkey)
			BEGIN
				SET	@spOut = 'FAIL|OPERATION|RECORDEXISTS|LOG|NOK';
				SET @operationStatus = 'FAIL';	
				IF (@TTABLE = 1) 
				BEGIN
					INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
					SET	@spOut = 'FAIL|OPERATION|RECORDEXISTS|LOG|OK';
				END
				ELSE
				BEGIN
					SET	@spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOTEXIST';
				END
			END
			ELSE
			BEGIN
				BEGIN TRAN
				UPDATE [dbo].[bdx_customerdetail] SET [customer] = @customer,[user] = @user,[phonenumber] = @phonenumber,[key]=@key,[modifiedby]=@initiatedUser,[operationSite]= @operationSite,[modifiedGMTDate]=@operationDate WHERE [pkey] = @pkey;
				SET	@spOut = 'FAIL|OPERATION|OK|LOG|NOK';
				SET @operationStatus = 'PASS';
				IF (@TTABLE=1) 
				BEGIN
					INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
					COMMIT TRAN
					SET	@spOut = 'PASS|OPERATION|OK|LOG|OK';
				END
				ELSE
				BEGIN
					ROLLBACK TRAN
					SET	@spOut = 'FAIL|OPERATION|RB|LOG|NOK';
				END
			END
		END
		ELSE
		BEGIN
			SET @operationStatus = 'FAIL';	
			SET	@spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOK';
			IF (@TTABLE = 1) 
			BEGIN
				INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
				SET	@spOut = 'FAIL|OPERATION|NOTEXIST|LOG|OK';
			END
			ELSE
			BEGIN
				SET	@spOut = 'FAIL|OPERATION|NOTEXIST|LOG|NOTEXIST';
			END
		END
	END TRY
	BEGIN CATCH
		SET	@spOut = 'FAIL|OPERATION|NOK|LOG|NOK';
		IF (@TTABLE = 1) 
		BEGIN
			SET @operationStatus = 'FAIL';
			INSERT INTO [dbo].[bdx_portalTransactions] ([user],[userOperation],[operationDetails],[operationStatus],[operationSite],[operationDate]) VALUES (@initiatedUser,@userOperation,@operationDetails,@operationStatus,@operationSite,@operationDate);
			SET @spOut = 'Fail|Operation|NOK|Log|OK';
		END
		ELSE
		BEGIN
			SET @spOut = 'FAIL|OPERATION|NOK|LOG|NOTEXIST';
		END
	END CATCH	
END
GO
/****** Object:  StoredProcedure [dbo].[userRecordByPkey]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[userRecordByPkey]
	@pkey nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	
	
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail') 
		BEGIN
			SELECT [pkey],[customer],[user],[phonenumber],[key],[modifiedby] FROM [dbo].[bdx_customerdetail] WITH (NOLOCK) WHERE [pkey]=@pkey;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[userRecords]    Script Date: 28-07-2021 08:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[userRecords]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @userOperation nvarchar(50);
    DECLARE @operationDetails nvarchar(max);
    DECLARE @operationStatus nvarchar(50);
    DECLARE @operationDate datetime;
	
	
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WITH (NOLOCK)  WHERE TABLE_TYPE='BASE TABLE'  AND TABLE_NAME='bdx_customerdetail') 
		BEGIN
			SELECT [pkey],[customer],[user],[phonenumber],[key],[modifiedby] FROM [dbo].[bdx_customerdetail] WITH (NOLOCK);
		END
END
GO
