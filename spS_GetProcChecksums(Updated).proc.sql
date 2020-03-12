USE [RaffleDec2018TORLMP]
/*****************************************************************************************************************
 * Procedure Name: 	  [spS_GetProcChecksums]                                                                     *
 * Procedure Version: 1.1																						 *
 *****************************************************************************************************************
 * Used to generate a list of checksums for the database's stored procedures.									 *
 * ---------------------------------------------------------------------------								     *
 * Updated functionality to remove all hidden chars, whitespace, and uppercase all letters before hashing the    *
 * module_definitions																							 *
 *****************************************************************************************************************
 * Created By: Alain Jalbert																					 *
 * Date:	   July 17th 2015																					 *
 * Updated By: Matt Ferlaino																					 *
 * Date: 	   May 8th 2019																						 *
 *****************************************************************************************************************/
--ALTER PROCEDURE [dbo].[spS_GetProcChecksums]
--AS 
BEGIN
	-- Variables --
	DECLARE @hashedHashes VARBINARY(8000) = 0x
	DECLARE @position INT = 1, 
			@length INT, 
			@index INT

	DECLARE @routine_name VARCHAR(128), 
			@module_definition VARCHAR(max), 
			@file_hash VARBINARY(16), 
			@stripped_proc_string VARCHAR(max)

	DECLARE @databaseRoutines TABLE
	(
		routine_name VARCHAR(128),
		module_definition VARCHAR(max),
		file_hash VARBINARY(16)
	)

	-- Populate into 'databaseRoutines' routine_name and the stored procedures source code --
	INSERT INTO @databaseRoutines (routine_name, module_definition)
		SELECT ROUTINE_NAME, ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES 
			JOIN SYS.SQL_MODULES ON OBJECT_ID(ROUTINE_NAME) = OBJECT_ID ORDER BY ROUTINE_NAME

	-- Establish a cursor in memory to be used to generate the checksum for each stored procedure --
	DECLARE hashes CURSOR
		FOR SELECT routine_name, module_definition, file_hash 
			FROM @databaseRoutines
			OPEN hashes 
			FETCH NEXT FROM hashes 
			INTO @routine_name, @module_definition, @file_hash

	-- Looping through the '@databaseRoutines' --
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @position = 1
			SET @length = DATALENGTH(@stripped_proc_string)
			SET @hashedHashes = 0x
			SET @stripped_proc_string = ''
			SET @index = 1

			-- Loop through the module_definition string --
			WHILE @index <= DATALENGTH(@module_definition)
				BEGIN
					-- Strip all whitespaces and capitalize --
					SET @stripped_proc_string = CONCAT(@stripped_proc_string, RTRIM(LTRIM(UPPER(SUBSTRING(@module_definition, @index, 1)))))

					-- Perform a char conversion to unicode value, if char <= 32 (hidden characters) replace it --
					IF UNICODE(SUBSTRING(@module_definition, @index, 1)) <= 32
						BEGIN
							SET @stripped_proc_string = REPLACE(@stripped_proc_string, SUBSTRING(@module_definition, @index, 1), '')
						END
					SET @index += 1			
				END

			-- Create a concatenated string of hashes to account for large procedures --
			WHILE @position < @length
				BEGIN
					SET @hashedHashes += HASHBYTES('MD5', SUBSTRING(@stripped_proc_string, @position, 8000))
					SET @position += 8000
				END

			-- Add the 'routine_name' to the hash to account for procedure names being changed through sql management studio --
			SET @hashedHashes += CONVERT(VARBINARY(128), @routine_name)

			-- Create the hash from the concatenated hashes --
			UPDATE @databaseRoutines
				SET file_hash = HASHBYTES('MD5', @hashedHashes)
					WHERE routine_name = @routine_name

			UPDATE @databaseRoutines 
				SET module_definition = @stripped_proc_string
					
			-- Fetch Next -- 
			FETCH NEXT FROM hashes INTO @routine_name, @module_definition, @file_hash
		END

	-- Reclaim memory from cursor --
	CLOSE hashes 
	DEALLOCATE hashes
	
	-- Displaying the tables --
	SELECT routine_name, file_hash AS DIGEST 
		FROM @databaseRoutines 
		ORDER BY routine_name

RETURN
END