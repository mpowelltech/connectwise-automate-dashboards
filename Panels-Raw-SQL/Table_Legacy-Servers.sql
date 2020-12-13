SELECT 
   computers.computerid as `Computer Id`,
   computers.name as `Computer Name`,
   clients.name as `Client Name`,
   computers.domain as `Computer Domain`,
   IF(INSTR(computers.os, 'server')>0, 1, 0) as `Computer.OS.IsServer`,
   inv_operatingsystem.name as `Computer.OS.Name`


FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)

WHERE (inv_operatingsystem.name like '%2008%')
OR (inv_operatingsystem.name like '%2012%')

ORDER BY inv_operatingsystem.name