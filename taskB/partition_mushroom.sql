--partition file to partition dataset into test and train
--to be executed after load script
--dataset here is mushroom
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
		(temp.id, 1, temp.capshape, temp.class),
		(temp.id, 2, temp.capsurface, temp.class),
		(temp.id, 3, temp.capcolour, temp.class),
		(temp.id, 4, temp.bruise, temp.class),
		(temp.id, 5, temp.odor, temp.class),
		(temp.id, 6, temp.attchmnt, temp.class),
		(temp.id, 7, temp.spacing, temp.class),
		(temp.id, 8, temp.siz, temp.class),
		(temp.id, 9, temp.colour, temp.class),
		(temp.id, 10, temp.shape, temp.class),
		(temp.id, 11, temp.root, temp.class),
		(temp.id, 12, temp.sabove, temp.class),
		(temp.id, 13, temp.sbelow, temp.class),
		(temp.id, 14, temp.cabove, temp.class),
		(temp.id, 15, temp.cbelow, temp.class),
		(temp.id, 16, temp.vtype, temp.class),
		(temp.id, 17, temp.vcolour, temp.class),
		(temp.id, 18, temp.rnumber, temp.class),
		(temp.id, 19, temp.rtype, temp.class),
		(temp.id, 20, temp.scolour, temp.class),
		(temp.id, 21, temp.pop, temp.class),
		(temp.id, 22, temp.habitat, temp.class);
	ELSE
		INSERT INTO TRAINDATA VALUES
		(temp.id, 1, temp.capshape, temp.class),
		(temp.id, 2, temp.capsurface, temp.class),
		(temp.id, 3, temp.capcolour, temp.class),
		(temp.id, 4, temp.bruise, temp.class),
		(temp.id, 5, temp.odor, temp.class),
		(temp.id, 6, temp.attchmnt, temp.class),
		(temp.id, 7, temp.spacing, temp.class),
		(temp.id, 8, temp.siz, temp.class),
		(temp.id, 9, temp.colour, temp.class),
		(temp.id, 10, temp.shape, temp.class),
		(temp.id, 11, temp.root, temp.class),
		(temp.id, 12, temp.sabove, temp.class),
		(temp.id, 13, temp.sbelow, temp.class),
		(temp.id, 14, temp.cabove, temp.class),
		(temp.id, 15, temp.cbelow, temp.class),
		(temp.id, 16, temp.vtype, temp.class),
		(temp.id, 17, temp.vcolour, temp.class),
		(temp.id, 18, temp.rnumber, temp.class),
		(temp.id, 19, temp.rtype, temp.class),
		(temp.id, 20, temp.scolour, temp.class),
		(temp.id, 21, temp.pop, temp.class),
		(temp.id, 22, temp.habitat, temp.class);
	END IF;
	END FOR;
END@

--SELECT * FROM TRAINDATA@
--SELECT * FROM TESTDATA@

CONNECT RESET@
TERMINATE@
