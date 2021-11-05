-- Here we are creating a database master key. This key will be used to protect the Shared Access Signature which is specified in the next step
-- Ensure to switch the context to the new database first

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd@123';

CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
  IDENTITY = 'dp203preparation',
  SECRET = 'KEwOwYEDupyWkMxrYA9NjrNbRnIpwt7BeAvh5pZzqXoPEEDboBiMM4/fZHry4OguTYIkyHI5v2IEQqpdOTYwhQ==';

CREATE EXTERNAL DATA SOURCE main_log_data
WITH (    LOCATION   = 'abfss://data@dp203preparation.dfs.core.windows.net', -- data is the container name
          CREDENTIAL = AzureStorageCredential,
          TYPE = HADOOP
)

CREATE EXTERNAL FILE FORMAT TextFileFormat WITH (  
      FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = ',',
        FIRST_ROW = 2))


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
 LOCATION = '/raw/Log.csv',
    DATA_SOURCE = main_log_data,  
    FILE_FORMAT = TextFileFormat
);


SELECT * FROM logdata;