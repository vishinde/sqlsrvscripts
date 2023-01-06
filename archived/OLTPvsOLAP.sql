--OTLP vs OLAP heavy workload
--look for Reads_Pct vs Writes_Pct

SELECT DB_NAME(DB_ID()) AS [DB_Name], DFS.name AS [Logical_Name], DIVFS.[file_id], 
DFS.physical_name AS [PH_Name], DIVFS.num_of_reads, DIVFS.num_of_writes, DIVFS.io_stall_read_ms, DIVFS.io_stall_write_ms,
CAST(100. * DIVFS.io_stall_read_ms/(DIVFS.io_stall_read_ms + DIVFS.io_stall_write_ms) AS DECIMAL(10,1)) AS [IO_Stall_Reads_Pct],
CAST(100. * DIVFS.io_stall_write_ms/(DIVFS.io_stall_write_ms + DIVFS.io_stall_read_ms) AS DECIMAL(10,1)) AS [IO_Stall_Writes_Pct],
(DIVFS.num_of_reads + DIVFS.num_of_writes) AS [Writes + Reads], 
CAST(DIVFS.num_of_bytes_read/1048576.0 AS DECIMAL(10, 2)) AS [MB Read], 
CAST(DIVFS.num_of_bytes_written/1048576.0 AS DECIMAL(10, 2)) AS [MB Written],
CAST(100. * DIVFS.num_of_reads/(DIVFS.num_of_reads + DIVFS.num_of_writes) AS DECIMAL(10,1)) AS [# Reads Pct],
CAST(100. * DIVFS.num_of_writes/(DIVFS.num_of_reads + DIVFS.num_of_writes) AS DECIMAL(10,1)) AS [# Write Pct],
CAST(100. * DIVFS.num_of_bytes_read/(DIVFS.num_of_bytes_read + DIVFS.num_of_bytes_written) AS DECIMAL(10,1)) AS [Read Bytes Pct],
CAST(100. * DIVFS.num_of_bytes_written/(DIVFS.num_of_bytes_read + DIVFS.num_of_bytes_written) AS DECIMAL(10,1)) AS [Written Bytes Pct]
FROM sys.dm_io_virtual_file_stats(DB_ID(), NULL) AS DIVFS
INNER JOIN sys.database_files AS DFS WITH (NOLOCK)
ON DIVFS.[file_id]= DFS.[file_id] ;
