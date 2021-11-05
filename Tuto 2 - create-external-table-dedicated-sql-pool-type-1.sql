-- Lab - SQL Pool - External Tables - CSV

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd@123';

-- Here we are using the Storage account key for authorization

CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
  IDENTITY = 'dp203azuresynapse',
  SECRET = '1CEYB3D9EjUv3FwVi3KOKSqxq2Se6zFmIzfCxjGDbL3LhIC83qaB4dGNjCCB8jJAo0N3orGuIDEN5bP4wba5PQ==';

-- In the SQL pool, we can use Hadoop drivers to mention the source
CREATE EXTERNAL DATA SOURCE main_log_data
WITH (    LOCATION   = 'abfss://data@dp203azuresynapse.dfs.core.windows.net', -- data is the container name
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


SELECT [Operationname] , COUNT([Operationname]) as [OperationCount]
FROM logdata
GROUP BY [Operationname]
ORDER BY [OperationCount]