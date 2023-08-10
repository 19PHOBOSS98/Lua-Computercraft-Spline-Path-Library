os.loadAPI("lib/path_utilities.lua")
local Path = require "lib.paths.Path"

local generateHelix = path_utilities.generateHelix
local recenterStartToOrigin = path_utilities.recenterStartToOrigin
local offsetCoords = path_utilities.offsetCoords

local waypoints = {}

waypoints = {
	
	{pos = vector.new(657,40,-7)},
	{pos = vector.new(650,40,-36)},
	{pos = vector.new(619,30,-12)},
	{pos = vector.new(617,20,-41)},
	{pos = vector.new(643,35,-7)},
	{pos = vector.new(670,40,-43)},
	{pos = vector.new(671,40,-13)},
	
}

local h = generateHelix(10,3,2,15)
recenterStartToOrigin(h)
offsetCoords(h,vector.new(659,24,-66))

print("last helix coord:",h[#h])

local waypoint_length = #waypoints
for i,coord in ipairs(h) do	--adding helix coordinates to waypoints
	waypoints[i+waypoint_length] = {pos = coord}
end

local bLooped = true	--if true then generate a path that loops back to the start
local path = Path(waypoints,bLooped)


print("total_spline_length: ",path.total_spline_length)	--the points of the path are equally spaced appart (normalized) 

--[[
visit https://miabellaai.net/index.html
and paste these in to visualize the generated spline path
]]--
local p = fs.open("Custom_Data_Set", "w")
local spline_coords = path:getNormalizedCoords(0.7,bLooped)


p.writeLine("Interactive 3D Scatter Plot;")
p.writeLine("::X::Y::Z;")

for i,pos in ipairs(spline_coords) do

	p.writeLine(i.."::"..pos.x.."::"..-pos.z.."::"..pos.y.."::0.02::13::A::1::0::0::0::0;")

	p.flush()
end

