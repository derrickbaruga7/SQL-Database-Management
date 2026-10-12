-- All example people, staff codes, and phone labels below are fictional placeholders.
-- Demo setup: creates cit01 only when it does not already exist.
-- Existing databases cause an error rather than being silently deleted.
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
    DesignerCode VARCHAR(9),
    DesFname VARCHAR(50),
    DesLname VARCHAR(50),
    PRIMARY KEY (DesID, DesignerCode),
    UNIQUE (DesID)
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
    TechnicianID VARCHAR(9),
    TTFname VARCHAR(50),
    TTLname VARCHAR(50),
    PRIMARY KEY (TechnicianID)
);

CREATE TABLE outfit (
    OutfitID VARCHAR(2), # in case more outfits are made in future, I changed it to 2
    OutfitPrice DECIMAL(10, 2),
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
    DesignerCode VARCHAR(9),
	FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID),
    FOREIGN KEY (DesID, DesignerCode) REFERENCES designer(DesID, DesignerCode)
);

CREATE TABLE soldto (
    CustID VARCHAR(3),
    OutfitID VARCHAR(2),   
    FOREIGN KEY (CustID) REFERENCES customer(CustID),
    FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID)
);

CREATE TABLE workson (
    OutfitID VARCHAR(2),
    TechnicianID VARCHAR(9),
    DateStarted DATE,
    FOREIGN KEY (OutfitID) REFERENCES outfit(OutfitID),
    FOREIGN KEY (TechnicianID) REFERENCES tailoringtech(TechnicianID)
);

CREATE TABLE participatesin (
    DesID VARCHAR(2),
    FSID VARCHAR(2),
    FOREIGN KEY (DesID) REFERENCES designer(DesID),
    FOREIGN KEY (FSID) REFERENCES fashionshow(FSID)
);

INSERT INTO tailoringtech VALUES ('TECH001','Technician','One');
INSERT INTO tailoringtech VALUES ('TECH002','Technician','Two');
 
INSERT INTO customer VALUES ('200', 'Demo Customer 200');
INSERT INTO customer VALUES ('201', 'Demo Customer 201');
INSERT INTO customer VALUES ('202', 'Demo Customer 202');
INSERT INTO customer VALUES ('203', 'Demo Customer 203');
 
INSERT INTO designer VALUES ('10','DES001','Designer','One');
INSERT INTO designer VALUES ('20','DES002','Designer','Two');
INSERT INTO designer VALUES ('30','DES003','Designer','Three');
 
INSERT INTO fashionshow VALUES ('5','2016-11-05','San Francisco');
INSERT INTO fashionshow VALUES ('6','2016-12-06','New York');
INSERT INTO fashionshow VALUES ('7','2017-12-07','Chicago');
INSERT INTO fashionshow VALUES ('8','2018-01-08','Los Angeles');
 
INSERT INTO custphone VALUES ('DEMO-PHONE-200', '200');
INSERT INTO custphone VALUES ('DEMO-PHONE-201-A', '201');
INSERT INTO custphone VALUES ('DEMO-PHONE-201-B', '201');
INSERT INTO custphone VALUES ('DEMO-PHONE-202', '202');
INSERT INTO custphone VALUES ('DEMO-PHONE-203', '203');
 
INSERT INTO outfit VALUES ('1',100,'2016-10-12','200','10');
INSERT INTO outfit VALUES ('2',150,'2016-10-13','203','10');
INSERT INTO outfit VALUES ('3',300,'2017-11-14','202','10');
INSERT INTO outfit VALUES ('4',225,'2017-11-15','200','10');
INSERT INTO outfit VALUES ('5',75,'2018-09-06','201','10');
INSERT INTO outfit VALUES ('6',300,'2018-09-08','203','10');
              
INSERT INTO workson VALUES ('1','TECH001','2016-08-12');
INSERT INTO workson VALUES ('2','TECH001','2016-08-13');
INSERT INTO workson VALUES ('2','TECH002','2017-08-14');
INSERT INTO workson VALUES ('3','TECH002','2017-08-15');
INSERT INTO workson VALUES ('4','TECH001','2017-08-16');
INSERT INTO workson VALUES ('4','TECH002','2018-08-17');
INSERT INTO workson VALUES ('5','TECH001','2019-08-18');
INSERT INTO workson VALUES ('5','TECH002','2019-08-19');
INSERT INTO workson VALUES ('6','TECH002','2019-08-20');
 
INSERT INTO participatesin VALUES ('10','5');
INSERT INTO participatesin VALUES ('10','7');
INSERT INTO participatesin VALUES ('10','8');
INSERT INTO participatesin VALUES ('20','6');
INSERT INTO participatesin VALUES ('20','7');
INSERT INTO participatesin VALUES ('30','6');
INSERT INTO participatesin VALUES ('30','7');
INSERT INTO participatesin VALUES ('30','8');

-- Populate the sale relation from the customer assigned to each sample outfit.
INSERT INTO soldto (CustID, OutfitID)
SELECT CustID, OutfitID FROM outfit WHERE CustID IS NOT NULL;

SELECT customer.CustName, outfit.OutfitPrice
	FROM customer
	JOIN soldto ON customer.CustID = soldto.CustID
	JOIN outfit ON soldto.OutfitID = outfit.OutfitID
;

SELECT tailoringtech.TTFname, tailoringtech.TTLname, workson.DateStarted, outfit.OutfitDOC
	FROM tailoringtech
	JOIN workson ON tailoringtech.TechnicianID = workson.TechnicianID
	JOIN outfit ON workson.OutfitID = outfit.OutfitID
;

SELECT designer.DesFname, designer.DesLname, fashionshow.FSLocation
	FROM designer
	JOIN participatesin ON designer.DesID = participatesin.DesID
	JOIN fashionshow ON participatesin.FSID = fashionshow.FSID
;
