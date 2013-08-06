dofile("bin2c.lua")
dofile("os.lua")

local function do_embed(plugindir, dir)
	local srcdir = _WORKING_DIR .. "/" .. plugindir .. "/" .. dir .."/"
	if not os.isdir(srcdir) then return end
	local embeddir =  _WORKING_DIR .. "/" .. dir .."/"
	
	-- embed all lua files in the embed dir
	for i, filename in os.dir(srcdir, "%.lua$") do
	    local file = io.open(embeddir .. filename:gsub("%.lua$", "Lua%.c"), "w")
	    file:write(bin2c({path.getrelative(_WORKING_DIR, srcdir .. filename)}))
	    file:close()
	end
end

function embed(dir)
	if plugindirs then
		for k, v in plugindirs() do do_embed(v, dir) end
	else do_embed("", dir) end

	-- also add the directory to the include path so we can
	-- #include them if required
	includedirs { dir }
end