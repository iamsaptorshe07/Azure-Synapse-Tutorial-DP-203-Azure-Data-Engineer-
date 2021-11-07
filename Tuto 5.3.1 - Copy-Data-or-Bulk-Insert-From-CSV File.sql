


-- Creatng the Table
CREATE TABLE [logdata]
(
    [Id] [int] NULL,
	[Correlationid] [varchar](200) NULL,
	[Operationname] [varchar](200) NULL,
	[Status] [varchar](100) NULL,
	[Eventcategory] [varchar](100) NULL,
	[Level] [varchar](100) NULL,
	[Time] [datetime] NULL,
	[Subscription] [varchar](200) NULL,
	[Eventinitiatedby] [varchar](1000) NULL,
	[Resourcetype] [varchar](1000) NULL,
	[Resourcegroup] [varchar](1000) NULL
)

-- This needs to be run on master db after creation of the table if the privileges are need to given on table level 
/*
GRANT INSERT ON logdata TO user_load;
GRANT SELECT ON logdata TO user_load;
*/

-- Checking if there is any data
SELECT * FROM [dbo].[logdata];

-- Here there is no authentication/authorization, so you need to allow public access for the container
COPY INTO logdata FROM 'https://dp203preparation.blob.core.windows.net/data/raw/Log.csv'
WITH
(
    FIRSTROW = 2,
    CREDENTIAL = (IDENTITY= 'Shared Access Signature', SECRET='?sv=2020-08-04&ss=b&srt=sco&sp=rl&se=2021-12-05T18:18:04Z&st=2021-11-05T10:18:04Z&spr=https,http&sig=RAe5lM2ra85eF6oe6dcmiF0kHdnysy67VPTrPEzXdVk%3D')
)


-- Checking if there is any data
SELECT * FROM [dbo].[logdata];

SELECT COUNT(*) AS count FROM [dbo].[logdata];

DROP TABLE [dbo].[logdata];