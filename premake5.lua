if (_ACTION == "xcode4") then
	require "xcode"

	local cpplanguagestandards = {["C++11"] = "c++11", ["C++14"] = "c++14", ["C++17"] = "c++1z"}
	premake.override(premake.modules.xcode, "XCBuildConfiguration_CppLanguageStandard", function(base, settings, cfg)
		if cfg.cppdialect then
			settings["CLANG_CXX_LANGUAGE_STANDARD"] = cpplanguagestandards[cfg.cppdialect] or "compiler-default"
		end
	end)
end

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
	location       ("build/%{_ACTION}/")
	objdir         ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
	targetdir      ("build/%{_ACTION}/%{cfg.platform}/%{cfg.buildcfg}/")
	includedirs    {"src/"}
	sysincludedirs {"src/"}
	cppdialect     ("C++11")
	warnings       ("Extra")
end

workspace      ("Workspace")
platforms      (get_platforms())
configurations {"Debug", "Release"}

project ("LibraryStatic")
kind    ("StaticLib")
base_config()
files {
	"src/library/static/**.cpp",
	"src/library/static/**.h",
}

project ("LibraryShared")
kind    ("SharedLib")
defines {"SHARED_LIB"}
base_config()
files {
	"src/library/shared/**.cpp",
	"src/library/shared/**.h",
}

project ("Project")
kind    ("ConsoleApp")
links   {"LibraryStatic", "LibraryShared"}
base_config()
files {
	"src/project/**.cpp",
	"src/project/**.h",
}
