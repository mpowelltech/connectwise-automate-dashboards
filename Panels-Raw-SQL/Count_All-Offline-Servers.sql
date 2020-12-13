SELECT COUNT(*) as `Total Offline Servers`

FROM (((DatabaseFails 
JOIN Computers USING (ComputerID)) 
JOIN Agents USING (AgentID)) 
JOIN Clients ON Clients.ClientID=Computers.ClientID) 
JOIN Locations ON Locations.LocationID=Computers.LocationID 

WHERE Agents.CheckAction=0 
AND Agents.Comparor <> 17 
AND Agents.Name Like 'LT - Offline Servers'