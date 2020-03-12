/***** Question 1 *****/
CREATE TABLE Fern_Parts2(
	PART_ID INT CHECK(PART_ID >= 0)
	PART_NAME VARCHAR(50)
	PART_COLOR VARCHAR(50)
	PART_WEIGHT INT CHECK(PART_WEIGHT >= 0)
	LOCATION VARCHAR(50)
	
	CONSTRAINT CONSTR_PARTS UNIQUE (PART_NAME, PART_COLOR, PART_WEIGHT, LOCATION)
	PRIMARY KEY (PART_ID)
	FOREIGN KEY (PART_ID) REFERENCES Fern_Suppliers(PART_ID)
);

/* 2 */
/* a. */
INSERT INT Fern_Parts2(NULL, 'a', 'b', 0, 'c')

/* b. */
UPDATE Fern_Parts2 
	SET PART_ID = NULL

/* c. */
INSERT INTO Fern_Parts2(1, ‘a’, ‘b’, 0, ‘c’) 
	WHERE Fern_Parts2.PART_ID = 10

/* d. */
DELETE PART_ID FRM Fern_Parts2 
	WHERE PART_ID = 1 AND Fern_Parts2.PART_ID = 10

/* e. */
UPDATE Fern_Parts2 
	SET PART_ID = 1 
	WHERE Fern_Parts2.PART_ID = 10

/* f. */
INSERT INTO Fern_Parts2(-1, ‘a’, ‘b’, 0, ‘c’)

/* g. */
UPDATE Fern_Parts2 
	SET PART_ID = -1