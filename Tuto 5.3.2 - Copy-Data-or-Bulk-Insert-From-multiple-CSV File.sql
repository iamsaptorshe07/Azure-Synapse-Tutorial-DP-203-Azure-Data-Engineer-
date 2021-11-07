SELECT COUNT(*) AS count FROM [dbo].[logdata];

-- Here there is no authentication/authorization, so you need to allow public access for the container
COPY INTO logdata FROM 'https://dp203preparation.blob.core.windows.net/data/raw/*.csv'
WITH
(
    FIRSTROW = 2,
    CREDENTIAL = (IDENTITY= 'Shared Access Signature', SECRET='?sv=2020-08-04&ss=b&srt=sco&sp=rl&se=2021-12-05T18:18:04Z&st=2021-11-05T10:18:04Z&spr=https,http&sig=RAe5lM2ra85eF6oe6dcmiF0kHdnysy67VPTrPEzXdVk%3D')
)

SELECT COUNT(*) AS count FROM [dbo].[logdata];

