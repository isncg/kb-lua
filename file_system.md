# 文件系统

## lfs安装
    luarocks install luafilesystem

## 遍历文件
    local lfs = require("lfs")

    function list_files(directory)
        for file in lfs.dir(directory) do
            if file ~= "." and file ~= ".." then
                local path = directory .. "/" .. file
                local attr = lfs.attributes(path)
                if attr.mode == "file" then
                    print("文件:", path)
                elseif attr.mode == "directory" then
                    print("目录:", path)
                end
            end
        end
    end

    list_files("./myfolder")