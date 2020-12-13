SELECT 
	computers.computerid as `Computer Id`,
	computers.name as `Server`,
	clients.name as `Client`,
	computers.domain as `Computer Domain`,
	computers.username as `Computer User`,
	Drives.Letter as `Computer.Drives.Letter`,
	FLOOR(Drives.Size/1024) as `Computer.Drives.Size.GB`,
	FLOOR(Drives.Free/1024) as `Computer.Drives.Free.GB`,
	IFNULL(ROUND((Drives.Size-Drives.Free)/Drives.Size*100,0),0) as `Computer.Drives.Used.Percent`,
	IFNULL(ROUND(100-(Drives.Size-Drives.Free)/Drives.Size*100,0),0) as `Computer.Drives.Free.Percent`,
	IF(INSTR(computers.os, 'server')>0, 1, 0) as `Computer.OS.IsServer`,
	CASE 
		WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) IN('CD', 'DVD') 
			THEN 3 
		WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) = 'USB' 
			THEN 2 
		WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) IN('IDE', 'SCSI') 
			THEN 1 
		WHEN Drives.FileSystem IN('NTFS', 'FAT32', 'FAT', 'HFS', 'ext2', 'ext3', 'ext4', 'btrfs', 'jfs', 'xfs', 'reiser4', 'reiserfs') 
			THEN IF(INSTR(LOWER(Drives.Model), 'usb')>0, 2, 1) 
		ELSE 4 
	END as `Computer.Drives.Type`

FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)
LEFT JOIN Drives ON (Drives.ComputerId=Computers.ComputerId)

WHERE (
	(IF(INSTR(Computers.OS, 'server')>0, 1, 0) <> 0) 
	AND (Drives.Letter like '%') 
	AND (FLOOR(Drives.Size/1024) > 32) 
	AND (IFNULL(ROUND((Drives.Size-Drives.Free)/Drives.Size*100,0),0) >= 75) 
	AND (
		CASE 
			WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) IN('CD', 'DVD') 
				THEN 3 
			WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) = 'USB' 
				THEN 2 
			WHEN LEFT(Drives.SmartStatus, INSTR(Drives.SmartStatus, ':')-1) IN('IDE', 'SCSI') 
				THEN 1 
			WHEN Drives.FileSystem IN('NTFS', 'FAT32', 'FAT', 'HFS', 'ext2', 'ext3', 'ext4', 'btrfs', 'jfs', 'xfs', 'reiser4', 'reiserfs') 
				THEN IF(INSTR(LOWER(Drives.Model), 'usb')>0, 2, 1) 
			ELSE 4 
		END 
		<> '3'
	)
)

ORDER BY IFNULL(ROUND(100-(Drives.Size-Drives.Free)/Drives.Size*100,0),0), FLOOR(Drives.Free/1024)