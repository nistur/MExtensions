dofile("plugin.lua")
dofile("embed.lua")

-- Maratis Extensions
solution "MExtensions"

    plugins {
        "MEvent",
        "MSaveFile",
        "MScriptExt",
        "MScriptableBehaviour",
        "MEmbedFile"
    }
    
    -- embed all plugin lua scripts
    embed "scripts"
    embed "behaviors"
    embed "editor"

 
    configurations { "Debug", "Release" }
    language "C++"
    
    -- make sure we can search and link properly
    libdirs { os.getenv("MSDKDIR") .. "/SDK/MCore/Libs",
          os.getenv("MSDKDIR") .. "/SDK/MEngine/Libs" }
    includedirs { os.getenv("MSDKDIR") .. "/SDK/MCore/Includes",
              os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes" }
    
    -- OS defines
    if os.is("windows") then
        defines { "WIN32" }
    end

    configuration "Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    configuration "Release"
        defines { "NDEBUG" }
        flags { "Optimize" } 
        
    loadplugins()

    project "MExtensions"
        kind "SharedLib"
        language "C++"

        -- include all the files, including Maratis SDK ones
        files {
            "src/**.cpp",
            "include/**.h",
            "**.md",
            os.getenv("MSDKDIR") .. "SDK/**.h"
        }
        includedirs { "include" }
        targetdir "bin"
        targetprefix ""

        -- split the files up a bit nicer inside Visual Studio
        vpaths { 
            ["MCore/*"] = os.getenv("MSDKDIR") .. "/SDK/MCore/Includes/**.h",
            ["MEngine/*"] = os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes/**.h",
            ["MExtensions/*"] = { "**.h", "**.cpp" },
            ["Doc/*"] = { "**.md" }
        }
        -- link to Maratis
        links { "MCore", "MEngine" }
        linkplugins() 

