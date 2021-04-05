net.Receive('CandC::SendingNet::NetworKing', function(len, ply)

	local id = net.ReadUInt(8)


	c_and_c.func[id](len, ply)
end )