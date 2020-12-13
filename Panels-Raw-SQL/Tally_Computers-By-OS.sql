SELECT 
	Count(computers.computerid) as `Number`,
	IF(INSTR(IFNULL(inv_operatingsystem.Name, Computers.OS), 'windows')>0, 'Windows', IF(INSTR(IFNULL(inv_operatingsystem.Name, Computers.OS), 'darwin') >0, 'Mac OS', 'Linux')) as `Computer.OS.Type`

FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)

GROUP BY `Computer.OS.Type`
ORDER BY Number DESC