-- Project: Nebulator details
project "Nebulator"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "src/**.h",
        "src/**.cpp",
    }

    includedirs
    {
        "src",  
        "vendor/spdlog/include",
        "%{IncludeDirs.GLFW}",
        "%{IncludeDirs.Glad}"

    }
    links
    {
        "GLFW",
        "Glad",
        "opengl32.lib"
    }

    pchheader "nrpch.h"
    pchsource "src/nrpch.cpp"


    filter "system:windows"
        systemversion "latest"

        defines
        {
            "NR_PLATFORM_WINDOWS",
            "GLFW_INCLUDE_NONE"
        }

    filter "configurations:Debug"
        defines "NR_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "NR_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "NR_DIST"
        runtime "Release"
        optimize "on"