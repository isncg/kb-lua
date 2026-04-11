# Windows 开发环境

## 安装 MSYS2

1. 安装MSYS2

    https://www.msys2.org/#installation


2. 安装Lua

    打开MSYS2终端, 输入：`pacman -S mingw-w64-x86_64-lua`
 

3. 安装LuaRocks

    打开MSYS2终端, 输入：`pacman -S mingw-w64-x86_64-luarocks`


## MSYS2 终端环境

MSYS2 有多种环境（如 MSYS、MINGW64、UCRT64、CLANG64 等）。你应使用与当前打开终端相匹配的包

MSYS2 提供了多个不同的环境（如 MINGW64、UCRT64、CLANG64 等），它们的主要区别在于：

- 使用的 C 运行时库（CRT）不同
- 工具链（GCC 或 Clang）不同
- 目标平台 ABI 兼容性不同
- 包命名和安装路径不同

### 1. MINGW64  

- **C 运行时：** 链接到 msvcrt.dll（Microsoft 的旧版 C 运行时，Windows 95/98/XP 时代遗留）。
- **工具链：**使用 MinGW-w64 GCC（GNU 编译器套件）。
- **特点：**
    - 兼容性极广，几乎所有 Windows 系统都自带 msvcrt.dll。
    - 但对 C99 等新标准的支持不够完善（msvcrt 的限制）。
    - 许多传统的开源项目默认使用此环境。
- **安装路径：**/mingw64/（可执行文件在 /mingw64/bin/）。

### 2. UCRT64

- **C 运行时：**链接到 ucrtbase.dll（Universal C Runtime，Windows 10/11 及 Windows 8/7 通过更新支持）。
- **工具链：**同样使用 MinGW-w64 GCC。
- **特点：**
    - 更好的 C/C++ 标准符合性（C99/C11/C++14/17 等）。
    - 微软官方推荐的新运行时，性能和安全更好。
    - 从 Windows 10 开始系统自带，旧版 Windows 可能需要安装更新（通常用户已安装）。
- **安装路径：**/ucrt64/（可执行文件在 /ucrt64/bin/）。

### 3. CLANG64

- **C 运行时：**链接到 ucrtbase.dll（与 UCRT64 相同）。
- **工具链：**使用 LLVM/Clang 而非 GCC。
- **特点：**
    - 更快的编译速度、更友好的错误信息。
    - 与 Clang 生态（如 libc++、compiler-rt）完全兼容。
    - 适合习惯 Clang 或需要 Clang 特定功能的项目。

- **安装路径：**/clang64/（可执行文件在 /clang64/bin/）。


## Git Bash 环境变量
由于 VS Code 默认使用 Git Bash 终端，因此需要设置 Git Bash 的环境变量。

编辑 ~/.bashrc 文件，添加以下内容

```
# 将 MSYS2 的核心工具和 MINGW64 工具链添加到 PATH
export PATH="/c/msys64/mingw64/bin:$PATH"

export LUA_CPATH="/c/msys64/mingw64/lib/lua/5.4/?.so;/c/msys64/mingw64/lib/lua/5.4/?.dll;;"
export LUA_PATH="/c/msys64/mingw64/share/lua/5.4/?.lua;/c/msys64/mingw64/share/lua/5.4/?/init.lua;;"
```

@date 2026-4-1