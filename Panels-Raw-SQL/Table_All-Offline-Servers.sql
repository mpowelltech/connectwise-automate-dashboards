SELECT Clients.Name as `Client`, Computers.Name as `Server`, Computers.ComputerID as `Computer ID`, REPLACE(Computers.LastContact, '', ''), TIMESTAMPDIFF(Minute, Computers.LastContact, NOW()) as `Time Offline`, IFNULL(IFNULL(edfAssigned1.Value,edfDefault1.value),'') as `Service Plan`

FROM (((DatabaseFails 
JOIN Computers USING (ComputerID)) 
JOIN Agents USING (AgentID)) 
JOIN Clients ON Clients.ClientID=Computers.ClientID) 
JOIN Locations ON Locations.LocationID=Computers.LocationID 
LEFT JOIN ExtraFieldData edfAssigned1 ON (edfAssigned1.id=Locations.LocationId and edfAssigned1.ExtraFieldId =(
	Select ExtraField.id 
	FROM ExtraField 
	WHERE LTGuid='5ca92306-2d93-11e1-ac0f-3d76979114ae'
))
LEFT JOIN ExtraFieldData edfDefault1 ON (edfDefault1.id=0 and edfDefault1.ExtraFieldId =(
	Select ExtraField.id 
	FROM ExtraField 
	WHERE LTGuid='5ca92306-2d93-11e1-ac0f-3d76979114ae'
))
		
WHERE Agents.CheckAction=0 
AND Agents.Comparor <> 17 
AND  Agents.Name Like 'LT - Offline Servers'

ORDER BY Computers.LastContact DESC