SELECT 
   COUNT(computers.computerid) as `Number of Servers`,
   Computers.BiosMFG as `Computer.Hardware.Manufacturer`
   
FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)

WHERE((((IF(INSTR(computers.os, 'server')>0, 1, 0)<>0) and not (Computers.BiosMFG like 'Microsoft Corporation' or Computers.BiosMFG like 'VMware, Inc.'))))

GROUP by Computers.BiosMFG
ORDER BY `Number of Servers` DESC