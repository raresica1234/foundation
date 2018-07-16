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
	location   ("build/%{_ACTION}/")
	objdir     ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
	targetdir  ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
	cppdialect ("C++11")
	warnings   ("Extra")
end

workspace      ("Workspace")
platforms      (get_platforms())
configurations {"Debug", "Release"}

project     ("LibraryStatic")
kind        ("StaticLib")
includedirs {"src/"}
base_config()
files {
	"src/library/static/**.cpp",
	"src/library/static/**.h",
}

project     ("LibraryShared")
kind        ("SharedLib")
defines     {"SHARED_LIB"}
includedirs {"src/"}
base_config()
files {
	"src/library/shared/**.cpp",
	"src/library/shared/**.h",
}

project     ("Project")
kind        ("ConsoleApp")
includedirs {"src/"}
links       {"LibraryStatic", "LibraryShared"}
base_config()
files {
	"src/project/**.cpp",
	"src/project/**.h",
}
