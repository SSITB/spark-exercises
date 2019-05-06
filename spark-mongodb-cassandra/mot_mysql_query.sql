
-- RfR Volumes and Distinct Test Failures 2008 for Class 7 Vehicles by Top Level Test Item Group (For vehicles as presented for initial test)
SELECT d.ITEMNAME
	,COUNT(*) AS RFR_VOLUME
	,COUNT(DISTINCT a.TESTID) AS TEST_VOLUME
FROM TESTRESULT AS a
	INNER JOIN TESTITEM AS b
		ON a.TESTID=b.TESTID
	INNER JOIN TESTITEM_DETAIL AS c
		ON b.RFRID=c.RFRID
		AND a.TESTCLASSID = c.TESTCLASSID
	INNER JOIN TESTITEM_GROUP AS d
		ON c.TSTITMSETSECID = d.TSTITMID
		AND c.TESTCLASSID = d.TESTCLASSID
WHERE a.TESTDATE BETWEEN '2005-01-01' AND '2005-12-31'
	AND a.TESTCLASSID = '7'
	AND a.TESTTYPE='NT'
	AND a.TESTRESULT IN ('F','PRS')
	AND b.RFRTYPE IN('F','P')
GROUP BY d.ITEMNAME;



-- Initial, Completed Test Volumes by Class 2009-10 (As calculated in DVSA effectiveness report)
SELECT TESTCLASSID
	,TESTRESULT
	,COUNT(*) AS TEST_VOLUME
FROM TESTRESULT
WHERE TESTTYPE='NT'
	AND TESTRESULT IN ('P','F','PRS')
	AND TESTDATE BETWEEN '2005-04-01' AND '2010-03-31'
GROUP BY TESTCLASSID
	,TESTRESULT;


-- Basic Expansion of RfR Hierarchy for Class 5 Vehicles
SELECT a.RFRID
	,a.RFRDESC
	,b.ITEMNAME AS LEVEL1
	,c.ITEMNAME AS LEVEL2
	,d.ITEMNAME AS LEVEL3
	,e.ITEMNAME AS LEVEL4
	,f.ITEMNAME AS LEVEL5
FROM TESTITEM_DETAIL AS a
	INNER JOIN TESTITEM_GROUP AS b
		ON a.TSTITMID = b.TSTITMID
		AND a.TESTCLASSID = b.TESTCLASSID
	LEFT JOIN TESTITEM_GROUP AS c
		ON b.PARENTID = c.TSTITMID
		AND b.TESTCLASSID = c.TESTCLASSID
	LEFT JOIN TESTITEM_GROUP AS d
		ON c.PARENTID = d.TSTITMID
		AND c.TESTCLASSID = d.TESTCLASSID
	LEFT JOIN TESTITEM_GROUP AS e
		ON d.PARENTID = e.TSTITMID
		AND d.TESTCLASSID = e.TESTCLASSID
	LEFT JOIN TESTITEM_GROUP AS f
		ON e.PARENTID = f.TSTITMID
		AND e.TESTCLASSID = f.TESTCLASSID
WHERE a.TESTCLASSID = '5';
