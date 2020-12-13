SELECT COUNT(*) as `Offline in last week`

FROM (((DatabaseFails 
JOIN Computers USING (ComputerID)) 
JOIN Agents USING (AgentID)) 
JOIN Clients ON Clients.ClientID=Computers.ClientID) 
JOIN Locations ON Locations.LocationID=Computers.LocationID

WHERE Agents.CheckAction=0 
AND Agents.Comparor <> 17 
AND Agents.Name Like 'LT - Offline Servers'
AND TIMESTAMPDIFF(Minute, Computers.LastContact, NOW()) < 10080