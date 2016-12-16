--script is for the training phase of the naive bayes classifier
--probability of each value for each column is calculated per class
--bayes_class table contains total probabilities of each class

CONNECT TO SAMPLE@

DROP TABLE NAIVE_BAYES@
DROP TABLE BAYES_CLASS@

CREATE TABLE NAIVE_BAYES(column integer, val varchar(10), class varchar(5), prob decimal(11,05))@
CREATE TABLE BAYES_CLASS(class varchar(5), prob decimal(11,05))@

INSERT INTO NAIVE_BAYES(Column, Val, Class, Prob)
	WITH GroupedData(Column, Val, Class, PSum) AS
		(SELECT Column, Val, Class, count(Column) FROM TRAINDATA GROUP BY GROUPING SETS( (Column, Class), (Column, Class, Val)))
	(SELECT col_class.column, col_class.val, col_class.class, CAST(col_class.PSum AS decimal(4,0))/CAST(class_val.PSum AS decimal(4,0))
		FROM GroupedData AS col_class, GroupedData AS class_val
		WHERE col_class.column = class_val.column
		AND col_class.class = class_val.class
		AND col_class.val IS NOT NULL
		AND class_val.val IS NULL)@

INSERT INTO BAYES_CLASS(Class, Prob)
	WITH
		Total(Val) AS (SELECT count(distinct(instance)) FROM TRAINDATA),
		Class(Class, Val) AS (SELECT Class, Count(distinct(instance)) FROM TRAINDATA GROUP BY Class)
	(SELECT num_class.class, CAST(num_class.val AS decimal(10,0)) / CAST(num_total.val AS decimal(10,0)) FROM Total AS num_total, Class AS num_class)@
		
--SELECT * FROM NAIVE_BAYES@
--SELECT * FROM BAYES_CLASS@

CONNECT RESET@
TERMINATE@
