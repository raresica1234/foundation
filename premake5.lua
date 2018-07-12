local function get_arch()
	return io.popen("uname -m", "r"):read("*l")
end

local function get_platforms()
	local platforms = { get_arch() }

	-- Add x86 target for x64 Windows builds
	if os.host() == "windows" and platforms[1] == "x86_64" then
		table.insert(platforms, "x86")
	end

	return platforms
end

local function base_config()
	location  ("build/%{_ACTION}/")
	objdir    ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
	targetdir ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
end

workspace("Workspace")
	platforms (get_platforms())
	configurations {
		"Debug", "Release"
	}

project  ("Project")
kind     ("WindowedApp")
base_config()
warnings ("Extra")
files {
	"src/project/**.cpp",
	"src/project/**.h",
}
includedirs {
	"src/project/",
}
