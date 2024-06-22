SELECT 
 'SAP_US' As DBSource
,CAST(JE.[Origin Number] AS INT) AS 'Origin_Number_Int'
,JE.[Department]
,JE.[Account name]
,JE.[Transaction type]
,CAST(SFD.[SalesRepCode] AS INT) AS 'Sales_Rep_Code'
,JE.[Posting Date]
,SUM(JE.Credit + CASE WHEN JE.Debit IS NOT NULL THEN -JE.Debit ELSE 0 END) AS Total
FROM vwJournalEntry JE
INNER JOIN vwDimDate DD ON DD.[DateID] = JE.[DateID]
LEFT JOIN 
    (SELECT DISTINCT [Document No. A/R], [SalesRepCode] FROM vwSalesFactDetail) SFD 
        ON SFD.[Document No. A/R] = JE.[Origin Number]
WHERE DD.PK_Date >= '2022/01/01' AND DD.PK_Date <= DATEADD(day, -1, GETDATE())
GROUP BY
 JE.[Origin Number] 
,JE.[Department]
,JE.[Account name]
,JE.[Transaction type]
,SFD.[SalesRepCode]
,JE.[Posting Date]


UNION ALL

SELECT 
 'SAP_EU' As DBSource
,CAST(JE.[Origin Number] AS INT) AS 'Origin_Number_Int'
,JE.[Department]
,JE.[Account name]
,JE.[Transaction type]
,CAST(SFD.[SalesRepCode] AS INT) AS 'Sales_Rep_Code'
,JE.[Posting Date]
,SUM(JE.Credit + CASE WHEN JE.Debit IS NOT NULL THEN -JE.Debit ELSE 0 END) AS Total
FROM FOTH_BI_NL.dbo.vwJournalEntry JE 
INNER JOIN FOTH_BI_NL.dbo.vwDimDate DD ON DD.[DateID] = JE. [DateID]
LEFT JOIN 
    (SELECT DISTINCT [Document No. A/R], [SalesRepCode] FROM FOTH_BI_NL.dbo.vwSalesFactDetail) SFD 
        ON SFD.[Document No. A/R] = JE.[Origin Number]
WHERE DD.PK_Date >= '2022/01/01' AND DD.PK_Date <= DATEADD(day, -1, GETDATE())
GROUP BY
 JE.[Origin Number] 
,JE.[Department]
,JE.[Account name]
,JE.[Transaction type]
,SFD.[SalesRepCode]
,JE.[Posting Date]