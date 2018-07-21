-- Command to shrink database file  log files.
checkpoint


use tempdb
dbcc shrinkfile (tempdev, 10)
dbcc shrinkfile (templog, 10)