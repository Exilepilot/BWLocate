--------------------------------------------
-- Handle command line interface
--------------------------------------------

local MODE = 
{
}

function MODE:save(thePlayer)
	if thePlayer then
		local interior = getElementInterior(thePlayer)
		if interior ~= 0 then
			local x, y, z = getElementPosition(thePlayer)
			--------------------------------------------
			-- Set element data
			--------------------------------------------
			setElementData(thePlayer, "location.x",x         )
			setElementData(thePlayer, "location.y",y         )
			setElementData(thePlayer, "location.z",z		 )
			setElementData(thePlayer, "location.int",interior)
			outputChatBox("#FF0000[LOCATION] #FFFFFFSaved location", thePlayer, 0,0,0, true)
			return true
		end
		outputChatBox("#FF0000[LOCATION] #FFFFFFYou must be inside an interior to use this command", thePlayer, 0,0,0, true)
	end
	return false
end

function MODE:load(thePlayer, option)
	if thePlayer then
		if getElementInterior(thePlayer)  == 0 then
			local x, y, z, int =
			getElementData(thePlayer, "location.x",x         ),
			getElementData(thePlayer, "location.y",y         ),
			getElementData(thePlayer, "location.z",z		 ),
			getElementData(thePlayer, "location.int",interior)
			if x and y and z and int then
				--setElementPosition(thePlayer, x,y,z)
				setElementInterior(thePlayer, int, x,y,z)
				outputChatBox("#FF0000[LOCATION] #FFFFFFLoaded position.", thePlayer, 0,0,0, true)
				if option == "del" or option == "delete" then
					setElementData(thePlayer, "location.x"  ,false     )
					setElementData(thePlayer, "location.y"  ,false     )
					setElementData(thePlayer, "location.z"  ,false     )
					setElementData(thePlayer, "location.int",false     )
					outputDebugString("Deleted element data")
					outputChatBox("#FF0000[LOCATION] #FFFFFFDeleting element data.", thePlayer, 0,0,0, true)
				end
				return true
			end
		end
	end
	return false
end

addCommandHandler("location",
	function(thePlayer, cmd, mode, option)
		mode = mode or "save"
		if thePlayer and mode then
			if mode == "save" then
				MODE:save(thePlayer)
			elseif mode == "load" then
				if not option then option = nil end
				MODE:load(thePlayer, option)
			end
		end
	end
)