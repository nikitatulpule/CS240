--script for 1R classifier
--maxclass is a table which stores count for values of columns present per class
--split is the table used to find column with least error count using maxclass and traindata tables
--classifier assigns values based on the column attribute with least error rate
--results_oner contains accuracy for the classifier = 100*correctly classified/total instances

CONNECT TO SAMPLE@
DROP TABLE MAXCLASS@
DROP TABLE SPLIT@
DROP TABLE RESULTS_ONER@

CREATE TABLE SPLIT(col integer)@
CREATE TABLE MAXCLASS(column integer, val varchar(10), num_class integer, class varchar(5))@
CREATE TABLE RESULTS_ONER(accuracy decimal(11,05))@

INSERT INTO MAXCLASS
	WITH TEMP1 AS(SELECT column, val,COUNT(class) AS num_class, class FROM TRAINDATA GROUP BY column,val,class),
	TEMP2 AS(SELECT column,val,MAX(num_class) AS max_num_class FROM TEMP1 GROUP BY column,val),
	TEMP3 AS(SELECT T1.column, T1.val, T1.num_class, T1.class FROM TEMP1 AS T1,TEMP2 AS T2
	WHERE T1.num_class=T2.max_num_class AND T1.column=T2.column)
	SELECT * FROM TEMP3@

INSERT INTO SPLIT
	WITH TEMP1 AS(SELECT T.column,COUNT(T.column) AS ERROR
		FROM TRAINDATA AS T,maxclass as f 
		where T.column=f.column 
		and T.val=f.val 
		and T.class!=f.class 
		group by T.column ),
	TEMP2 AS(SELECT column,ERROR FROM TEMP1 WHERE ERROR= (SELECT MIN(ERROR) FROM TEMP1))
	SELECT column FROM TEMP2@

INSERT INTO RESULTS_ONER VALUES
	100*CAST((SELECT COUNT(DISTINCT T.instance) FROM TESTDATA AS T , SPLIT AS S, MAXCLASS AS F
		WHERE T.column=S.col AND F.column=S.col AND T.column=F.column AND T.val=F.val AND T.class=F.class) AS decimal(10,0))
	/CAST((SELECT COUNT(DISTINCT instance) FROM TESTDATA) AS decimal(10,0))@

SELECT * FROM MAXCLASS@
SELECT * FROM SPLIT@
SELECT * FROM RESULTS_ONER@

CONNECT RESET@
TERMINATE@
