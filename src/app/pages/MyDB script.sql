USE [myDB]
GO
/****** Object:  Table [dbo].[tbl_EmergencyStatus]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_EmergencyStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[Ledited] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[LoginName] [nvarchar](255) NOT NULL,
	[LoginPassword] [nvarchar](50) NULL,
	[LoginType] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[LoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[CheckInTable]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CheckInTable] 
    -- Add the parameters for the stored procedure here
    @param1 nvarchar(50),
	@param2 nvarchar(50),
	@param3 nvarchar(50)
    AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    Declare @rcount nvarchar(50);
	IF (@param1=1)
	BEGIN 
		SET @rcount = (Select case when Status is null then 'FALSE' when Status =1 then 'TRUE' when Status =0 then 'FALSE' End as Status from tbl_EmergencyStatus WITH(NOLOCK) where Country=@param2);
		IF(@rcount is null) 
		BEGIN
			SET @rcount = 'FALSE';
			select @rcount as ID;
		END
		ELSE
		BEGIN
			Select @rcount as ID 
		END
	END
	
	IF (@param1>1)
	BEGIN 
		SET @rcount = 'FALSE';
		select @rcount as ID;
	END	
END













GO
/****** Object:  StoredProcedure [dbo].[GetStatusMaersk]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[GetStatusMaersk] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  Select * from [dbo].[tbl_EmergencyStatus] with(nolock)

END

GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [dbo].[GetUser]  
@uname nvarchar(50),
@pwd nvarchar(50)
as  
begin  
   SELECT Count(*) as Cnt from [User] WITH (NOLOCK) WHERE LoginName=@uname and LoginPassword=@pwd;
End

GO
/****** Object:  StoredProcedure [dbo].[UpdateStatusMaersk]    Script Date: 28-07-2021 08:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateStatusMaersk] 
	@country nvarchar(50),
	@status bit,
	@user nvarchar(50),
	 @rc int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
   BEGIN TRY
    UPDATE [dbo].[tbl_EmergencyStatus] SET Status=@status, Ledited = @user, UpdateTime=GetDate()  where Country = @country;
    Set @rc =  1;
   
   END TRY
   BEGIN CATCH
    Set @rc =  0;
   
   END CATCH
END



GO
