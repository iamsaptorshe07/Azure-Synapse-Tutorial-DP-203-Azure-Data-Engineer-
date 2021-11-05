/*
------------------------------------------------------ Skipping this part --------------------------------------------------------------
-- Lab - SQL Pool - External tables - Parquet

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd@123';

-- Here we are using the Storage account key for authorization

CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
  IDENTITY = 'appdatalake7000',
  SECRET = 'VqJnhlUibasTfhSuAxkgIgY97GjRzHL9VNOPkjD8y+KYzl1LSDCflF6LXlrezAYKL3Mf1buLdZoJXa/38BXLYA==';

-- In the SQL pool, we can use Hadoop drivers to mention the source

CREATE EXTERNAL DATA SOURCE main_log_data
WITH (    LOCATION   = 'abfss://data@appdatalake7000.dfs.core.windows.net',
          CREDENTIAL = AzureStorageCredential,
          TYPE = HADOOP
)
-------------------------------------------Already have authorised syanapse to connect with our adls gen 2 -------------------------------
*/ 

-- Drop the table if it already exists
DROP EXTERNAL TABLE [logdata]

-- Check if table is there or not
SELECT * FROM [logdata];

-- Here we are mentioning the file format as Parquet
CREATE EXTERNAL FILE FORMAT parquetfile  
WITH (  
    FORMAT_TYPE = PARQUET,  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'  
);

-- Notice that the column names don't contain spaces
-- When Azure Data Factory was used to generate these files, the column names could not have spaces


CREATE EXTERNAL TABLE [logdata]
(
    [Id] [int],
	[Correlationid] [varchar](200),
	[Operationname] [varchar](200),
	[Status] [varchar](100),
	[Eventcategory] [varchar](100),
	[Level] [varchar](100),
	[Time] [datetime],
	[Subscription] [varchar](200),
	[Eventinitiatedby] [varchar](1000),
	[Resourcetype] [varchar](1000),
	[Resourcegroup] [varchar](1000)
)
WITH (
 LOCATION = '/parquet/',
    DATA_SOURCE = main_log_data,  
    FILE_FORMAT = parquetfile
);


SELECT * FROM [logdata];