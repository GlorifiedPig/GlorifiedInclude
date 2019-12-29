# GlorifiedInclude
GlorifiedInclude is a library designed to include files and folders as easily as possible.

You don't have to figure out which realm to put your includes in, as it does that automatically for you as long as you follow the naming system of `sv_`, `cl_` and `sh_`. You can also manually enter the realm you'd like to include in if you don't follow that naming system.

Another common (and my personal favourite) use for the library is to include all your files and folders in one file so that you don't have to touch including outside of that file.

# Installation
## Addons
Place the `sh_glorifiedinclude.lua` in your `autorun` folder.

## Gamemodes
You can either:
- Place the contents of `sh_glorifiedinclude.lua` at the bottom of your `shared.lua` file.
- Drag and drop `sh_glorifiedinclude.lua` into your gamemode folder and include it from your `shared.lua` file.

After that, set `IsAddon` to `false` at the top of the file.

# Functions
```lua
GlorifiedInclude.IncludeFile( fileName :: string, realm :: int )
```
- Replace `fileName` with the path to the file you would like to include. Be sure to include the `.lua` extension at the end.
- If you do not follow the `sv_`, `cl_` and `sh_` naming system, specify the `realm` to either be `GlorifiedInclude.Realm.Server`, `GlorifiedInclude.Realm.Client` or `GlorifiedInclude.Realm.Shared`.

```lua
GlorifiedInclude.IncludeFolder( folderName :: string, ignoreFiles :: bool, ignoreFolders :: bool )
```
- Replace `folderName` with the path to the folder.
- To ignore files in that folder, replace `ignoreFiles` with `true`. Leave empty or set to `false` to include files.
- To ignore folders in that folder, replace `ignoreFolders` with `true`. Leave empty or set to `false` to include folders.
- Please remember that all files in folders **have** to follow the `sv_`, `cl_` and `sh_` naming system else the file won't be included!

# Examples
The file path is relative to your addon's `lua` folder or your gamemode's `gamemode` folder.

Here's an example including a file called `sv_test.lua` and a folder called `modules` under the `test` directory:
```lua
GlorifiedInclude.IncludeFile( "sv_test.lua" )
GlorifiedInclude.IncludeFolder( "test/modules/ )
```
### Including all files at once
If you'd like to include all files at once, you have to place all your includes at the bottom of your GlorifiedInclude file. If you'd like to keep your includes seperate, you can create a new shared file and simply include the library.

Please keep in mind that your files will load in the order you include them in.
