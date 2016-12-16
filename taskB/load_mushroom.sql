--load script for mushroom dataset
--letter data stored as comma separated text
--purpose of load file is load the data into table dataset from given data file

CONNECT TO SAMPLE@
DROP TABLE DATASET@
CREATE TABLE DATASET(id integer NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , capshape varchar(5), capsurface varchar (5), capcolour varchar (5),bruise varchar (5),odor varchar (5),attchmnt varchar (5),spacing varchar (5),siz varchar (5),colour varchar (5),shape varchar (5),root varchar (5),sabove varchar (5),sbelow varchar (5),cabove varchar (5),cbelow varchar (5),vtype varchar (5),vcolour varchar (5),rnumber varchar (5),rtype varchar (5),scolour varchar (5),pop varchar (5),habitat varchar (5), class varchar (5))@
LOAD FROM '/home/db2inst1/project2/data/data_mushroom.data' OF del INSERT INTO DATASET(Class, capshape, capsurface, capcolour, bruise, odor, attchmnt,spacing,siz,colour,shape,root,sabove,sbelow,cabove,cbelow,vtype,vcolour,rnumber,rtype,scolour,pop,habitat)@
SELECT * FROM DATASET@
CONNECT RESET @
TERMINATE@
