local cos = math.cos
local sin = math.sin
local pi = math.pi
local two_pi = 2*pi

--generates a helix with the origin at the center... use quaternions to rotate coordinates
function generateHelix(radius,gap,loops,resolution)
	local helix = {}

	for t=0,two_pi*loops,two_pi/resolution do
		local coord = vector.new(radius*cos(t),radius*sin(t),gap*t)
		table.insert(helix,coord)
	end
	return helix
end

--recenters the start of the path to the origin 0,0,0
function recenterStartToOrigin(coords)
	local coord_i = coords[1]
	for i,coord in ipairs(coords) do
		coords[i] = coord-coord_i
	end
end

--moves the path to start at the "offset" coordinate
function offsetCoords(coords,offset)
	local coord_i = coords[1]
	for i,coord in ipairs(coords) do
		coords[i] = coord+offset
	end
end

