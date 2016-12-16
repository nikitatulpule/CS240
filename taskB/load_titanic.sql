--load script for titanic dataset
--titanic data stored as comma separated text
--purpose of load file is load the data into table dataset from given data file

CONNECT TO SAMPLE@
DROP TABLE DATASET@
CREATE TABLE DATASET(id integer NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , shipclass varchar (10),age varchar(10), gender varchar (10), class varchar (5))@
LOAD FROM '/home/db2inst1/project2/data/data_titanic.data' OF del INSERT INTO DATASET(ShipClass, Age, Gender, Class)@
SELECT * FROM DATASET@
CONNECT RESET @
TERMINATE@
