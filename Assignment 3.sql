/************** Part 1 **************/
/* Creating Tables */
/* Question 1. */
CREATE TABLE Fern_Parts2 
	AS SELECT * FROM Fern_Parts WHERE 1=0;

/* Question 2. */
SELECT LENGTH(City) AS LengthOfValues
    FROM Fern_Suppliers;
ALTER TABLE Fern_Suppliers
	MODIFY CITY VARCHAR2(40);

/* Question 3. */
SELECT * FROM USER_CONSTRAINTS 
	ORDER BY TABLE_NAME ASC;

/* Question 4. */
/* a. */
ALTER TABLE Fern_Suppliers
    ADD CONSTRAINT fsuppliers_pk 
    PRIMARY KEY (SUPPLIER_ID);

/* b. */
ALTER TABLE Fern_Inventory
    ADD CONSTRAINT finventory_pk 
    PRIMARY KEY (SUPPLIER_ID, PART_ID);

/* c. */
ALTER TABLE Fern_Parts
	ADD CONSTRAINT fparts_partnumber UNIQUE (PART_ID);

/* d. */
ALTER TABLE Fern_Inventory
	ADD CONSTRAINT finventory_fk FOREIGN KEY (SUPPLIER_ID)
	REFERENCES Fern_Suppliers (SUPPLIER_ID);

/* e. */
ALTER TABLE Fern_Suppliers
	MODIFY SUPPLIER_NAME NOT NULL;

/* f. */
ALTER TABLE Fern_Inventory
	ADD CONSTRAINT finventory_nonzero CHECK (quantity > 0);

ALTER TABLE Fern_Parts
	ADD CONSTRAINT fparts_nonzero CHECK (part_weight > 0);


/* Question 3 */
CREATE TABLE Fern_Jobs(
    JNO varchar(100),
    JNAME varchar(100),
    CITY varchar(100)
);

CREATE TABLE Fern_Suppliers2(
    SNO varchar(100),
    SNAME varchar(100),
    STATUS integer,
    CITY varchar(100)
);

CREATE TABLE Fern_SPJ (
    SNO varchar(100),
    PNO varchar(100),
    JNO varchar(100),
    SHIPDATE date,
    QTY integer
);

/* Insert Data */
INSERT INTO Fern_Jobs VALUES ('J1', 'Sorter', 'Paris');
INSERT INTO Fern_Jobs VALUES ('J2', 'Punch', 'Rome');
INSERT INTO Fern_Jobs VALUES ('J3', 'Reader', 'Athens');
INSERT INTO Fern_Jobs VALUES ('J4', 'Console', 'Athens');
INSERT INTO Fern_Jobs VALUES ('J5', 'Collator', 'London');
INSERT INTO Fern_Jobs VALUES ('J6', 'Terminal', 'Oslo');
INSERT INTO Fern_Jobs VALUES ('J7', 'Tape', 'London');

INSERT INTO Fern_Suppliers2 VALUES ('S1', 'Smith', '20', 'London');
INSERT INTO Fern_Suppliers2 VALUES ('S2', 'Jones', '10', 'Paris');
INSERT INTO Fern_Suppliers2 VALUES ('S3', 'Blake', '30', 'Paris');
INSERT INTO Fern_Suppliers2 VALUES ('S4', 'Clark', '20', 'London');
INSERT INTO Fern_Suppliers2 VALUES ('S5', 'Adams', '30', 'Athens');

INSERT INTO Fern_Parts2 VALUES ('1', 'Nut', 'Red', 12, 'London');
INSERT INTO Fern_Parts2 VALUES ('2', 'Bolt', 'Green', 17, 'Paris');
INSERT INTO Fern_Parts2 VALUES ('3', 'Screw', 'Blue', 17, 'Rome');
INSERT INTO Fern_Parts2 VALUES ('4', 'Screw', 'Red', 14, 'London');
INSERT INTO Fern_Parts2 VALUES ('5', 'Cam', 'Blue', 12, 'Paris');
INSERT INTO Fern_Parts2 VALUES ('6', 'Cog', 'Red', 19, 'London');

INSERT INTO Fern_SPJ VALUES ('S1', 'P1', 'J1', '3/3/1999', '200');
INSERT INTO Fern_SPJ VALUES ('S1', 'P1', 'J4', '4/4/1988', '700');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J1', '6/6/1988', '100');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J2', '8/8/1999', '200');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J3', '7/7/1977', '200');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J4', '8/9/1999', '500');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J5', '8/7/1999', '600');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J6', '8/7/1998', '400');
INSERT INTO Fern_SPJ VALUES ('S2', 'P3', 'J7', '8/8/1988', '800');
INSERT INTO Fern_SPJ VALUES ('S2', 'P5', 'J2', '9/9/1999', '100');
INSERT INTO Fern_SPJ VALUES ('S3', 'P3', 'J1', '9/9/1999', '200');
INSERT INTO Fern_SPJ VALUES ('S3', 'P4', 'J2', '9/8/1999', '500');
INSERT INTO Fern_SPJ VALUES ('S4', 'P6', 'J3', '9/9/1999', '400');
INSERT INTO Fern_SPJ VALUES ('S4', 'P6', 'J7', '9/8/1988', '300');
INSERT INTO Fern_SPJ VALUES ('S5', 'P2', 'J4', '8/8/1988', '100');
INSERT INTO Fern_SPJ VALUES ('S5', 'P5', 'J5', '7/8/1999', '500');
INSERT INTO Fern_SPJ VALUES ('S5', 'P5', 'J7', '8/8/1999', '100');
INSERT INTO Fern_SPJ VALUES ('S5', 'P6', 'J2', '7/8/1999', '200');
INSERT INTO Fern_SPJ VALUES ('S5', 'P1', 'J4', '6/8/1999', '100');
INSERT INTO Fern_SPJ VALUES ('S5', 'P3', 'J4', '6/6/2000', '200');
INSERT INTO Fern_SPJ VALUES ('S5', 'P4', 'J4', '9/7/2000', '800');
INSERT INTO Fern_SPJ VALUES ('S5', 'P5', 'J4', '7/7/1999', '400');
INSERT INTO Fern_SPJ VALUES ('S5', 'P6', 'J4', '7/8/2000', '500');

/* 1. */
SELECT PART_NAME FROM Fern_Parts2
    WHERE PART_WEIGHT BETWEEN 25 AND 30;

/* 2. */
SELECT SNAME FROM Fern_Suppliers2 
	JOIN Fern_SPJ ON Fern_Suppliers2.SNO = Fern_SPJ.SNO
	JOIN Fern_Jobs ON Fern_SPJ.JNO = Fern_Jobs.JNO
	WHERE Fern_Jobs.JName = 'Tape';

/* 3. */
SELECT DISTINCT JNAME FROM Fern_Jobs
	JOIN Fern_SPJ ON Fern_Jobs.JNO = Fern_SPJ.SNO
	JOIN Fern_Parts2 ON Fern_SPJ.PNO = Fern_Parts2.PNO
	WHERE Fern_Parts2.COLOR = 'Red';

/* 4. */
SELECT DISTINCT SNAME FROM Fern_Suppliers2
	JOIN Fern_SPJ ON Fern_Suppliers2.SNO = Fern_SPJ.SNO
	WHERE EXTRACT (YEAR FROM Fern_SPJ.SHIPDATE) != 1999;

/* 5. */
SELECT SNAME FROM Fern_Suppliers2 
	JOIN Fern_SPJ ON Fern_Suppliers2.SNO = Fern_SPJ.SNO
	WHERE QTY = (SELECT MAX(qty) FROM Fern_SPJ);

/* 6. */
SELECT SUM(QTY) FROM Fern_SPJ
	JOIN Fern_Jobs ON Fern_SPJ.SNO = Fern_Jobs.JNO
	WHERE Fern_Jobs.JNAME = 'Tape';

/* 7. */
SELECT DISTINCT PART_NAME FROM Fern_Parts
	JOIN Fern_SPJ ON PART_ID = Fern_SPJ.PNO
	JOIN Fern_Suppliers2 ON Fern_SPJ.SNO = Fern_Suppliers2.SNO
	WHERE Fern_Suppliers2.SNAME = 'Clark';

/* 8. */
SELECT JNO FROM Fern_SPJ
	WHERE SHIPDATE = (SELECT MAX(SHIPDATE) FROM Fern_SPJ);

/* 9. */
SELECT PART_WEIGHT * Fern_SPJ.QTY FROM Fern_Parts2
	JOIN Fern_SPJ ON PNO = Fern_SPJ.PNO
	JOIN Fern_Jobs ON Fern_SPJ.JNO = Fern_Jobs.JNO
	WHERE JNAME = 'Terminal';

/* 10. */
SELECT SNAME FROM Fern_Suppliers2
	WHERE STATUS = (SELECT  MIN(STATUS) FROM Fern_Suppliers2);

/* 11. */
SELECT sum(PART_WEIGHT) FROM Fern_Parts2;

/* 12. */
SELECT DISTINCT JNO FROM Fern_Jobs
	INNER JOIN Fern_Parts2 ON CITY = Fern_Parts2.LOCATION;

/* 13. */
SELECT DISTINCT PART_NAME FROM Fern_Parts2
	JOIN FERN_SPJ ON PNO = FERN_SPJ.PNO
	JOIN Fern_Jobs ON FERN_SPJ.JNO = Fern_Jobs.JNO
	WHERE JNAME = 'Tape';

/* 14. */
SELECT CITY, SUM(QTY) FROM Fern_SPJ
	JOIN Fern_Parts2 ON Fern_SPJ.PNO = Fern_Parts2.PART_ID
	GROUP BY CITY;