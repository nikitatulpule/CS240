--sample load script loads buys_computer dataset into sql
--purpose of load file is load the data into table dataset from given data file

CONNECT TO SAMPLE@
DROP TABLE DATASET@
CREATE TABLE DATASET(id integer NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , age varchar (1),income varchar (1),student varchar(1), credit varchar (1), class varchar (5))@
LOAD FROM '/home/db2inst1/project2/data/data1.data' OF del INSERT INTO DATASET(Age, Income, Student, Credit, Class)@
SELECT * FROM DATASET@
CONNECT RESET @
TERMINATE@
