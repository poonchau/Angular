USE [WebAPI]
GO
/****** Object:  Table [dbo].[StudentsRecord]    Script Date: 28-07-2021 08:46:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsRecord](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Gender] [int] NULL,
	[Stream] [varchar](50) NULL,
	[EmailId] [varchar](100) NULL,
	[Address] [varchar](500) NULL,
 CONSTRAINT [PK_StudentsRecord] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
