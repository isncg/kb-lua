local lfs = require "lfs"
local markdown = require "markdown"
local file_utils = require "file_utils"
local aspect_template = require "aspect.template"
local aspect = aspect_template.new()

local function str_end_with(str, ending)
    return str:sub(- #ending) == ending
end

local function str_replace_start(str, start_str, replace_str)
    if str:sub(1, #start_str) == start_str then
        return replace_str .. str:sub(#start_str + 1)
    else
        return str
    end
end

local str_replace_end = function(str, ending, replace_str)
    if str:sub(- #ending) == ending then
        return str:sub(1, - #ending - 1) .. replace_str
    else
        return str
    end
end

aspect.loader = function(name)
    local file_path = "../.templates/" .. name .. ".html"
    local file = io.open(file_path, "r")
    if not file then
        print("file not found: " .. file_path)
        return nil
    end
    return file:read("*a")
end


local input_root_directory = "../.md"
local output_root_directory = ".."
local function traverse(directory, doc_root)
    for file_name in lfs.dir(directory) do
        if file_name ~= "." and file_name ~= ".." then
            local input_file_path = directory .. "/" .. file_name
            local attr = lfs.attributes(input_file_path)
            if attr.mode == "file" then
                if str_end_with(file_name, ".md") then
                    local content = file_utils.read(input_file_path)
                    local markdown_html = markdown(content)
                    local result, error = aspect:render("post", { markdown_html = markdown_html, doc_root = doc_root })
                    if error then
                        print(error)
                    else
                        local output_file_path = str_replace_start(input_file_path, input_root_directory,
                            output_root_directory)
                        output_file_path = str_replace_end(output_file_path, ".md", ".html")
                        print("Generating " .. output_file_path)

                        -- io.open(output_file_path, "w"):write(html):close()
                        file_utils.write(output_file_path, tostring(result))
                    end
                end
            elseif attr.mode == "directory" then
                traverse(input_file_path, doc_root .. "../")
            end
        end
    end
end

traverse(input_root_directory, "./")
