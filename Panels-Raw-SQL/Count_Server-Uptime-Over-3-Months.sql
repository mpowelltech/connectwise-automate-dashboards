SELECT COUNT(*)

FROM computers
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)

WHERE computers.uptime > 131400
AND ((IF(INSTR(computers.os, 'server')>0, 1, 0)<>0))