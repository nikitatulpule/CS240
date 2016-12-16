--script for boosting naive bayes
--incorrectly classified instances are duplicated in the training data
--this script is to be executed after executing naive bayes atleast once
--to check results of boosting, we need to execute naive bayes train and test scripts after this
--pre boost and post boost give count of train data before and after boosting

CONNECT TO SAMPLE@

SELECT COUNT(*) AS PRE_BOOST FROM TRAINDATA@
INSERT INTO TRAINDATA(SELECT T.* FROM TESTDATA AS T, TEST_RESULTS AS R WHERE T.INSTANCE=R.ID AND R.ACTUAL!=R.PREDICTED)@
SELECT COUNT(*) AS POST_BOOST FROM TRAINDATA@

CONNECT RESET@
TERMINATE@
