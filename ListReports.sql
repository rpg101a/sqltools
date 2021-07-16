SELECT Path, Name,

SourceCode = CAST(CAST(content AS VARBINARY(max)) AS XML)

FROM ReportServer.dbo.Catalog

WHERE Type IN (2,6)

ORDER BY Path, Type, Name