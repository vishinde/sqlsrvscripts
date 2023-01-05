SELECT name AS synonym_name,
base_object_name AS synonym_definition,
COALESCE (PARSENAME (base_object_name, 4), @@servername) AS server_name,
COALESCE (PARSENAME (base_object_name, 3), DB_NAME (DB_ID ())) AS DB_name,
COALESCE (PARSENAME (base_object_name, 2), SCHEMA_NAME (SCHEMA_ID ())) AS schema_name,
PARSENAME (base_object_name, 1) AS table_name,
create_date,
modify_date
FROM sys.synonyms
