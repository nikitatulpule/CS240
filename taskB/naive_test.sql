--script contains test phase of naive bayes
--it is to be executed after naive_bayes.sql
--test_results combines 1.calculation of partial probabilities for given testdata 2. adding the values for all the values for particular test instance 3. summing log of values according to the bayes theorem 4. finding max probability to assign class label
--results table stores final accuracy of the classifier = 100*correct_classified/total instances

CONNECT TO SAMPLE@

DROP TABLE TEST_RESULTS@
DROP TABLE RESULTS@

CREATE TABLE TEST_RESULTS(id integer, actual varchar(5), predicted varchar(5))@
CREATE TABLE RESULTS(accuracy decimal(11,05))@

INSERT INTO TEST_RESULTS(id, actual, predicted)
	WITH
		Partial_Probability(id, predicted, probability) AS 
			(SELECT test.instance, nbc.class, nbc.prob
				FROM TESTDATA AS test, NAIVE_BAYES AS nbc
				WHERE test.column = nbc.column AND test.val = nbc.val),
		Sum_Probability(sumdatarow, sumpredicted, sumprob) AS
			(SELECT id, predicted, SUM(LOG(probability)) FROM Partial_Probability GROUP BY id, predicted),
		Probability(wdatarow, wpredicted, wprob) AS
			(SELECT sp.sumdatarow, sp.sumpredicted, sp.sumprob+LOG(nb.prob)
				FROM Sum_Probability AS sp, Bayes_Class AS nb WHERE sp.sumpredicted = nb.class),
		Max_Probability(maxdatarow, maxprob) AS
			(SELECT wdatarow, MAX(wprob) FROM Probability GROUP BY wdatarow)
	(SELECT test.instance, test.class, wp.wpredicted
		FROM TESTDATA AS test, Max_Probability AS mp, Probability AS wp
		WHERE test.instance = mp.maxdatarow
		AND test.instance = wp.wdatarow
		AND mp.maxprob = wp.wprob
		AND test.column = 1)@	
		
INSERT INTO RESULTS(accuracy) VALUES
	100*CAST((SELECT COUNT(Predicted) FROM TEST_RESULTS WHERE Predicted = Actual) AS decimal(10,0))
	/CAST((SELECT COUNT(Predicted) FROM TEST_RESULTS) AS decimal(10,0))@


--SELECT * FROM TEST_RESULTS@
SELECT * FROM RESULTS@

CONNECT RESET@
TERMINATE@
