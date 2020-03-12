/*****************************************************************************************************************
 * Procedure Name: 	  [spS_PullDBSchemaForReport]                                                               *
 * Procedure Version: 1.0																						 *
 *****************************************************************************************************************
 * Pulls data from RaffleDec2018TORLMP which will be used to create a report									 *
 *****************************************************************************************************************
 * Created By: Matt Ferlaino																					 *
 * Date: 	   May 16th 2019																				     *
 *****************************************************************************************************************/
--ALTER PROCEDURE [dbo].[spS_PullDBSchemaForReport]
--AS
BEGIN
	-- Variables --
	DECLARE @dbKeys TABLE 
	(
		table_keys VARCHAR(64),
		key_types VARCHAR(64)
	)

	DECLARE @dbTriggers TABLE 
	(
		names VARCHAR(64),
		table_triggers VARCHAR(64)
	)

	DECLARE @dbTablesInfo TABLE
	(
		table_names VARCHAR(64),
		column_names VARCHAR(64),
		column_types VARCHAR(64),
		triggers VARCHAR(64)
	)
	
	DECLARE @dbTableNames TABLE 
	(
		db_table_names VARCHAR(64)
	)

	-- Insert into 'dbKeys' table the 'Primary table_keys' and 'Foreign table_keys' and their 'type' from the table_names in the database --
	INSERT INTO @dbKeys (table_keys, key_types)
		SELECT SYSOBJECTS.NAME, SYSOBJECTS.XTYPE
		FROM SYSOBJECTS
			WHERE XTYPE = 'PK' OR XTYPE = 'F' 

	-- Insert into 'dbTriggers' table the 'table_names' and the 'table_triggers' from the database --
	INSERT INTO @dbTriggers(names, table_triggers)
		SELECT OBJECT_NAME(PARENT_OBJ), SYSOBJECTS.NAME
		FROM SYSOBJECTS 
			JOIN SYS.TABLES
			ON SYSOBJECTS.PARENT_OBJ = OBJECT_ID 
			WHERE XTYPE = 'TR'

	-- Inserting into 'dbTablesInfo' information from other tables and the INFORMATION_SCHEMA --
	INSERT INTO @dbTablesInfo (table_names, column_names, column_types)
		SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE 
		FROM INFORMATION_SCHEMA.COLUMNS

	-- Inserting into 'dbTableNames' information from the INFORMATION_SCHEMA --
	INSERT INTO @dbTableNames (db_table_names) 
		SELECT TABLE_NAME 
		FROM INFORMATION_SCHEMA.TABLES

	-- Final Select Statements --
	SELECT table_names, column_names, column_types, table_triggers
	FROM @dbTriggers JOIN @dbTablesInfo
		ON table_names = names
		WHERE table_names = names 
		ORDER BY names

	SELECT table_keys, key_types 
	FROM @dbKeys 
		ORDER BY table_keys
	
	SELECT db_table_names
	FROM @dbTableNames
		ORDER BY db_table_names

RETURN
END