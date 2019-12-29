
local IsAddon = true -- Set this to 'true' if you're running from an addon, set to 'false' if you're running from a gamemode.

--[[
    GlorifiedInclude - A library for including files & folders with ease.
    © 2020 GlorifiedInclude Developers

    Please read usage guide @ https://github.com/GlorifiedPig/glorifiedinclude/blob/master/README.md

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]--

local giVersion = 1.0

if GlorifiedInclude or GlorifiedInclude.Version > giVersion then return end

GlorifiedInclude = {
    Version = giVersion,
    Realm = {
        Server = 0,
        Client = 1,
        Shared = 2
    }
}

function GlorifiedInclude.IncludeFile( fileName, realm )
    if IsAddon == false then fileName = GM.FolderName .. "/gamemode/" .. fileName end 

    if( realm == GlorifiedInclude.Realm.Shared || fileName:find( "sh_" ) ) then
        if SERVER then AddCSLuaFile( fileName ) end
        include( fileName )
    elseif( realm == GlorifiedInclude.Realm.Server || ( SERVER && fileName:find( "sv_" ) ) ) then
        include( fileName )
    elseif( realm == GlorifiedInclude.Realm.Client || fileName:find( "cl_" ) ) then
        if SERVER then AddCSLuaFile( fileName )
        else include( fileName ) end
    end
end

function GlorifiedInclude.IncludeFolder( folderName, ignoreFiles, ignoreFolders )
    if( string.Right( folderName, 1 ) != "/" ) then folderName = folderName .. "/" end

    local filesInFolder, foldersInFolder = file.Find( folderName .. "*", "LUA" )

    if ignoreFiles != true then
        for k, v in ipairs( filesInFolder ) do
            GlorifiedInclude.IncludeFile( folderName .. v )
        end
    end

    if ignoreFolders != true then
        for k, v in ipairs( foldersInFolder ) do
            GlorifiedInclude.IncludeFolder( folderName .. v .. "/" )
        end
    end
end

--[[
    -- Common practice would be to put all your includes here, for example:
        GlorifiedInclude.IncludeFolder( "modules/" )
        GlorifiedInclude.IncludeFile( "sh_config.lua" )
    -- Remember that files load in the order you include them in.
]]--