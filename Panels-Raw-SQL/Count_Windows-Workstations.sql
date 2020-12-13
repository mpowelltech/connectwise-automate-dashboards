SELECT count(*)

FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)

WHERE ((IF(INSTR(IFNULL(inv_operatingsystem.Name, Computers.OS), 'windows')>0, 1, IF(INSTR(IFNULL(inv_operatingsystem.Name, Computers.OS), 'darwin') >0, 2, 3)) = '1') AND (IF(INSTR(computers.os, 'server')>0, 1, 0)=0))