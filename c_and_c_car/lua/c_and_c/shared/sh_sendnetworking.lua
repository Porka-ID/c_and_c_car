c_and_c = c_and_c or {}
c_and_c.func = c_and_c.func or {}
print("FICHIER SH_SENDNETWORKING.LUA")

function c_and_c:SendNet(id, func, target)
	if not id or not isnumber(id) then print(" ID NON VALIDE ! ")  return end 

	net.Start("CandC::SendingNet::NetworKing")
	net.WriteUInt(id, 8)
	if isfunction(func) then 
		func()
	end 
	if SERVER then 
		if IsValid(target) and target:IsPlayer() then 
			net.Send(target)
		end 
		if not target then 
			net.Broadcast()
		end 
	else 
		net.SendToServer()
	end 
end 

function c_and_c:Register(id, func)

	if not id or not isnumber(id) then print("ID INVALIDE")  return end 
	if not func or not isfunction(func) then print("FONCTION NON VÄLIDE")  return end 


	c_and_c.func[id] = func
end 