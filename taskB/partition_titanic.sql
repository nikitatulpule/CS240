--partition file to partition dataset into test and train
--to be executed after load script
--dataset here is titanic
--two new tables are created for train data nd test data

CONNECT TO SAMPLE@
DROP TABLE TESTDATA@
DROP TABLE TRAINDATA@

CREATE TABLE TESTDATA(instance integer, column integer, val varchar(10), class varchar(5))@
CREATE TABLE TRAINDATA(instance integer, column integer, val varchar(10), class varchar(5))@

BEGIN ATOMIC
	FOR temp AS SELECT * FROM DATASET ORDER BY id DO
	IF rand() > 0.75 THEN
		INSERT INTO TESTDATA VALUES
		(temp.id, 1, temp.shipclass, temp.class),
		(temp.id, 2, temp.age, temp.class),
		(temp.id, 3, temp.gender, temp.class);
	ELSE
		INSERT INTO TRAINDATA VALUES
		(temp.id, 1, temp.shipclass, temp.class),
		(temp.id, 2, temp.age, temp.class),
		(temp.id, 3, temp.gender, temp.class);
	END IF;
	END FOR;
END@

SELECT * FROM TRAINDATA@
SELECT * FROM TESTDATA@

CONNECT RESET@
TERMINATE@
