--partition file to partition dataset into test and train
--to be executed after load script
--dataset here is letter
--two new tables are created for train data and test data

CONNECT TO SAMPLE@
DROP TABLE TESTDATA@
DROP TABLE TRAINDATA@

CREATE TABLE TESTDATA(instance integer, column integer, val varchar(10), class varchar(5))@
CREATE TABLE TRAINDATA(instance integer, column integer, val varchar(10), class varchar(5))@
BEGIN ATOMIC
	FOR temp AS SELECT * FROM DATASET ORDER BY id DO
	IF rand() > 0.75 THEN
		INSERT INTO TESTDATA VALUES
		(temp.id, 1, temp.horizontal, temp.class),
		(temp.id, 2, temp.vertical, temp.class),
		(temp.id, 3, temp.width, temp.class),
		(temp.id, 4, temp.height, temp.class),
		(temp.id, 5, temp.total, temp.class),
		(temp.id, 6, temp.xmean, temp.class),
		(temp.id, 7, temp.ymean, temp.class),
		(temp.id, 8, temp.xvar, temp.class),
		(temp.id, 9, temp.yvar, temp.class),
		(temp.id, 10, temp.correlation, temp.class),
		(temp.id, 11, temp.meanx, temp.class),
		(temp.id, 12, temp.meany, temp.class),
		(temp.id, 13, temp.leftedge, temp.class),
		(temp.id, 14, temp.xcorr, temp.class),
		(temp.id, 15, temp.bottomedge, temp.class),
		(temp.id, 16, temp.ycorr, temp.class);
	ELSE
		INSERT INTO TRAINDATA VALUES
		(temp.id, 1, temp.horizontal, temp.class),
		(temp.id, 2, temp.vertical, temp.class),
		(temp.id, 3, temp.width, temp.class),
		(temp.id, 4, temp.height, temp.class),
		(temp.id, 5, temp.total, temp.class),
		(temp.id, 6, temp.xmean, temp.class),
		(temp.id, 7, temp.ymean, temp.class),
		(temp.id, 8, temp.xvar, temp.class),
		(temp.id, 9, temp.yvar, temp.class),
		(temp.id, 10, temp.correlation, temp.class),
		(temp.id, 11, temp.meanx, temp.class),
		(temp.id, 12, temp.meany, temp.class),
		(temp.id, 13, temp.leftedge, temp.class),
		(temp.id, 14, temp.xcorr, temp.class),
		(temp.id, 15, temp.bottomedge, temp.class),
		(temp.id, 16, temp.ycorr, temp.class);
	END IF;
	END FOR;
END@

--SELECT * FROM TRAINDATA@
--SELECT * FROM TESTDATA@

CONNECT RESET@
TERMINATE@
