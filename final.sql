drop database if exists cit01;
create database cit01;

use cit01;

drop table if exists participatesin;
drop table if exists soldto;
drop table if exists workson;
drop table if exists designs;
drop table if exists outfit;
drop table if exists custphone;
drop table if exists fashionshow;
drop table if exists designer;
drop table if exists tailoringtech;
drop table if exists customer;


CREATE TABLE designer (
	DesID VARCHAR(2),
    DesSSN VARCHAR(9),
    DesFname VARCHAR(50),
    DesLname VARCHAR(50),
    PRIMARY KEY (DesID, DesSSN)
);

CREATE TABLE customer (
    CustID VARCHAR(3),
    CustName VARCHAR(50),
    PRIMARY KEY (CustID)
);

CREATE TABLE custphone (
    CustPhone VARCHAR(50),
	CustID VARCHAR(3),
    FOREIGN KEY (CustID) REFERENCES customer(CustID)
);

CREATE TABLE tailoringtech (
    TTSSN VARCHAR(9),
    TTFname VARCHAR(50),
    TTLname VARCHAR(50),
    PRIMARY KEY (TTSSN)
);

CREATE TABLE outfit (
    OutfitID VARCHAR(2), # in case more outfits are made in future, I changed it to 2
    OutfitPrice VARCHAR(3),
    OutfitDOC DATE,
    CustID VARCHAR(3),
    DesID VARCHAR(2),
    PRIMARY KEY (OutfitID),
    FOREIGN KEY (CustID) REFERENCES customer(CustID),
    FOREIGN KEY (DesID) REFERENCES designer(DesID)
);

CREATE TABLE fashionshow (
    FSID VARCHAR(2), # in case more shows happen in future, I changed it to 2
    FSDate DATE, 
    FSLocation VARCHAR(50),
    PRIMARY KEY (FSID)
);

CREATE TABLE designs (
    OutfitID VARCHAR(2),
    DesID VARCHAR(2),
    DesSSN VARCHAR(9),    
	FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID),
    FOREIGN KEY (DesID, DesSSN) REFERENCES designer(DesID, DesSSN)
);

CREATE TABLE soldto (
    CustID VARCHAR(3),
    OutfitID VARCHAR(2),   
    FOREIGN KEY (CustID) REFERENCES customer(CustID),
    FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID)
);

CREATE TABLE workson (
    OutfitID VARCHAR(2),
    TTSSN VARCHAR(9),
    DateStarted DATE,
    FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID),
    FOREIGN KEY (TTSSN) REFERENCES tailoringtech(TTSSN)
);

CREATE TABLE participatesin (
    DesID VARCHAR(2),
    FSID VARCHAR(2),
    FOREIGN KEY (DesID) REFERENCES designer(DesID),
    FOREIGN KEY (FSID) REFERENCES fashionshow(FSID)
);

INSERT INTO tailoringtech VALUES ('111111111','Sally','Swanson');
INSERT INTO tailoringtech VALUES ('222222222','Tim','Tillman');
 
INSERT INTO customer VALUES ('200', 'Jeff');
INSERT INTO customer VALUES ('201', 'Bill');
INSERT INTO customer VALUES ('202', 'Ruth');
INSERT INTO customer VALUES ('203', 'Nancy');
 
INSERT INTO designer VALUES ('10','333333333','Kelly','Klein');
INSERT INTO designer VALUES ('20','444444444','David','Danson');
INSERT INTO designer VALUES ('30','555555555','Nora','Neils');
 
INSERT INTO fashionshow VALUES ('5','2016-11-05','San Francisco');
INSERT INTO fashionshow VALUES ('6','2016-12-06','New York');
INSERT INTO fashionshow VALUES ('7','2017-12-07','Chicago');
INSERT INTO fashionshow VALUES ('8','2018-01-08','Los Angeles');
 
INSERT INTO custphone VALUES ('5555551000', '200');
INSERT INTO custphone VALUES ('5555552000', '201');
INSERT INTO custphone VALUES ('5555553000', '201');
INSERT INTO custphone VALUES ('5555554000', '202');
INSERT INTO custphone VALUES ('5555555000', '203');
 
INSERT INTO outfit VALUES ('1',100,'2016-10-12','200','10');
INSERT INTO outfit VALUES ('2',150,'2016-10-13','203','10');
INSERT INTO outfit VALUES ('3',300,'2017-11-14','202','10');
INSERT INTO outfit VALUES ('4',225,'2017-11-15','200','10');
INSERT INTO outfit VALUES ('5',75,'2018-09-06','201','10');
INSERT INTO outfit VALUES ('6',300,'2018-09-08','203','10');
              
INSERT INTO workson VALUES ('1','111111111','2016-08-12');
INSERT INTO workson VALUES ('2','111111111','2016-08-13');
INSERT INTO workson VALUES ('2','222222222','2017-08-14');
INSERT INTO workson VALUES ('3','222222222','2017-08-15');
INSERT INTO workson VALUES ('4','111111111','2017-08-16');
INSERT INTO workson VALUES ('4','222222222','2018-08-17');
INSERT INTO workson VALUES ('5','111111111','2019-08-18');
INSERT INTO workson VALUES ('5','222222222','2019-08-19');
INSERT INTO workson VALUES ('6','222222222','2019-08-20');
 
INSERT INTO participatesin VALUES ('10','5');
INSERT INTO participatesin VALUES ('10','7');
INSERT INTO participatesin VALUES ('10','8');
INSERT INTO participatesin VALUES ('20','6');
INSERT INTO participatesin VALUES ('20','7');
INSERT INTO participatesin VALUES ('30','6');
INSERT INTO participatesin VALUES ('30','7');
INSERT INTO participatesin VALUES ('30','8');

SELECT customer.CustName, outfit.OutfitPrice
	FROM customer
	JOIN soldto ON customer.CustID = soldto.CustID
	JOIN outfit ON soldto.OutfitID = outfit.OutfitID
;

SELECT tailoringtech.TTFname, tailoringtech.TTLname, workson.DateStarted, outfit.OutfitDOC
	FROM tailoringtech
	JOIN workson ON tailoringtech.TTSSN = workson.TTSSN
	JOIN outfit ON workson.OutfitID = outfit.OutfitID
;

SELECT designer.DesFname, designer.DesLname, fashionshow.FSLocation
	FROM designer
	JOIN participatesin ON designer.DesID = participatesin.DesID
	JOIN fashionshow ON participatesin.FSID = fashionshow.FSID
;
