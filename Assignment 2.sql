/* Creating Tables */
CREATE TABLE Fern_Suppliers (
    SUPPLIER_ID NUMBER(3,0),
    SUPPLIER_NAME VARCHAR2(50),
    CITY VARCHAR2(50),
    STATUS NUMBER(3,0),
    PHONENUMBER NUMBER(7,0)
);

CREATE TABLE Fern_Inventory (
   SUPPLIER_ID NUMBER(3,0),
   PART_ID NUMBER(3,0),
   QUANTITY NUMBER(3,0)
);

CREATE TABLE Fern_Parts (
    PART_ID NUMBER(3,0),
    PART_NAME VARCHAR2(50),
    PART_COLOR VARCHAR2(50),
    PART_WEIGHT NUMBER(2,0),
    LOCATION VARCHAR2(50)
);

/* Inserting into Fern_Suppliers */
INSERT INTO Fern_Suppliers (SUPPLIER_ID, SUPPLIER_NAME, CITY, STATUS, PHONENUMBER) VALUES ('100', 'Northern', 'Sudbury', '20', '2562211');
INSERT INTO Fern_Suppliers (SUPPLIER_ID, SUPPLIER_NAME, CITY, STATUS, PHONENUMBER) VALUES ('101', 'Superior', 'Sault Ste Marie', '10', '9491111');
INSERT INTO Fern_Suppliers (SUPPLIER_ID, SUPPLIER_NAME, CITY, STATUS, PHONENUMBER) VALUES ('102', 'Ontario', 'Sault Ste Marie', '30', '2562666');
INSERT INTO Fern_Suppliers (SUPPLIER_ID, SUPPLIER_NAME, CITY, STATUS, PHONENUMBER) VALUES ('103', 'Quality', 'Sudbury', '20', '2578888');
INSERT INTO Fern_Suppliers (SUPPLIER_ID, SUPPLIER_NAME, CITY, STATUS, PHONENUMBER) VALUES ('104', 'ProHardware', 'Thunderbay', '30', '9992222');

/* Inserting into Fern_Inventory */
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '401', '300');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '402', '200');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '403', '400');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '404', '200');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '405', '100');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('100', '406', '100');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('101', '401', '300');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('101', '402', '400');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('102', '402', '200');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('103', '402', '200');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('103', '403', '300');
INSERT INTO Fern_Inventory (SUPPLIER_ID, PART_ID, QUANTITY) VALUES ('103', '404', '400');

/* Inserting into Fern_Parts */
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('401', 'Sink', 'Blue', '10', 'Sudbury');
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('402', 'Cabinet', 'Black', '5', 'Sault Ste Marie');
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('403', 'Counter', 'Black', '2', 'Sudbury');
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('404', 'Faucet', 'Red', '6', 'Thunderbay');
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('405', 'Dishwasher', 'Red', '8', 'Sault Ste Marie');
INSERT INTO Fern_Parts (PART_ID, PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION) VALUES ('406', 'Handle', 'Blue', '5', 'Sudbury');

/* SQL Queries */
/* A */ 
SELECT SUPPLIER_NAME, PHONENUMBER FROM Fern_Suppliers;

/* B */ 
SELECT PART_NAME, PART_COLOR FROM Fern_Parts;

/* C */ 
SELECT * FROM Fern_Suppliers WHERE STATUS >= 40;

/* D */ 
SELECT SUPPLIER_NAME, PART_ID FROM Fern_Suppliers
    INNER JOIN Fern_Inventory
    ON Fern_Inventory.SUPPLIER_ID = Fern_Suppliers.SUPPLIER_ID

/* E */ 
SELECT Fern_Parts.PART_ID, Fern_Parts.PART_NAME FROM Fern_Parts
            INNER JOIN Fern_Inventory
            ON Fern_Inventory.PART_ID = Fern_Parts.PART_ID
            INNER JOIN Fern_Suppliers
            ON Fern_Inventory.SUPPLIER_ID = Fern_Suppliers.SUPPLIER_ID
            WHERE SUPPLIER_NAME = 'Ontario'

/* F */
SELECT SUM(PART_WEIGHT)
    FROM Fern_Parts

/* G */ 
SELECT Supplier_Name FROM Fern_Suppliers
    INNER JOIN Fern_Inventory
    ON Fern_Inventory.SUPPLIER_ID = Fern_Suppliers.SUPPLIER_ID
    INNER JOIN Fern_Parts
    ON Fern_Inventory.PART_ID = Fern_Parts.PART_ID
    WHERE Location = 'Sudbury'

/* H */ 
SELECT COUNT(QUANTITY)
    FROM Fern_Inventory
    WHERE QUANTITY > 200

/* I */ 
SELECT Fern_Parts.PART_ID, Fern_Parts.PART_NAME, Fern_Parts.PART_COLOR, Fern_Parts.PART_WEIGHT, Fern_Inventory.QUANTITY, Fern_Suppliers.SUPPLIER_NAME FROM Fern_Suppliers
    INNER JOIN Fern_Inventory
    ON Fern_Inventory.SUPPLIER_ID = Fern_Suppliers.SUPPLIER_ID
    INNER JOIN Fern_Parts
    ON Fern_Inventory.PART_ID = Fern_Parts.PART_ID
    ORDER BY Fern_Parts.PART_ID