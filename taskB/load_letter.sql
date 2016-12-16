--load script for letter dataset
--letter data stored as comma separated text
--purpose of load file is load the data into table dataset from given data file

CONNECT TO SAMPLE@
DROP TABLE DATASET@
CREATE TABLE DATASET(id integer NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , horizontal varchar (5),vertical varchar(5), width varchar (5), height varchar (5),total varchar (5),Xmean varchar (5), Ymean varchar (5), Xvar varchar (5), Yvar varchar (5), Correlation varchar (5), Meanx varchar (5), Meany varchar (5), Leftedge varchar (5), Xcorr varchar (5), Bottomedge varchar (5), Ycorr varchar (5), class varchar (5))@
LOAD FROM '/home/db2inst1/project2/data/data_letter.data' OF del INSERT INTO DATASET(Class, Horizontal, Vertical, Width, Height, Total, Xmean, Ymean, Xvar, Yvar, Correlation, Meanx, Meany, Leftedge, Xcorr, Bottomedge, Ycorr)@
--SELECT * FROM DATASET@
CONNECT RESET @
TERMINATE@
