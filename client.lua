function displayLoadedRes(res)
	if(getResourceName(res) == "bodyline") then
		local col = engineLoadCOL("models/bodyline.col")
		engineReplaceCOL(col, 2113)
		local txd = engineLoadTXD("models/bodyline.txd")
		engineImportTXD(txd, 2113)
		local dff = engineLoadDFF("models/bodyline.dff")
		engineReplaceModel(dff, 2113)
	end
end
addEventHandler("onClientResourceStart", getRootElement(), displayLoadedRes)



function onWastedEffect(killer, weapon, bodypart, stealth)
	local x,y,z = getElementPosition(source)
	z = getGroundPosition(x,y,z)
	local i = getElementInterior(source)
	local d = getElementDimension(source)
	local ry,rx,rz = getElementRotation(source)
	local ox, oy, oz = getPointInFrontOfPoint(x, y, z, rz-90, -1.1)
	local rand = math.random(1,3)
	if(rand == 1) then
		rx = rx+90
	elseif(rand == 2) then
		rx = rx+90
		ry = ry-90
	end
	local o = createObject(2113, ox, oy, oz-0.91, ry,rx,rz-130)
	setElementInterior(o, i)
	setElementDimension(o, d)
	setElementAlpha(o, 0)
	
	setTimer(function(o)
		setElementAlpha(o, 255)
		setTimer(function(o)
			destroyElement(o)
		end, 60000, 1, o)
	end, 10000, 1, o)
end
addEventHandler("onClientPedWasted", getRootElement(), onWastedEffect)
addEventHandler("onClientPlayerWasted", getRootElement(), onWastedEffect)

 
function getPointInFrontOfPoint(x, y, z, rZ, dist)
	local offsetRot = math.rad(rZ)
	local vx = x + dist * math.cos(offsetRot)
	local vy = y + dist * math.sin(offsetRot)  
	return vx, vy, z
end
