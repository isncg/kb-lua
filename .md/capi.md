# C API

## 遍历参数
    #include <stdio.h>
    #include <lua.h>
    #include <lauxlib.h>
    #include <lualib.h>

    static int print_args(lua_State *L) {
        int nargs = lua_gettop(L);  // 获取参数个数
        printf("参数个数: %d\n", nargs);

        for (int i = 1; i <= nargs; i++) {
            int type = lua_type(L, i);
            const char *type_name = lua_typename(L, type);
            printf("参数 %d: 类型 = %s", i, type_name);

            // 可选：打印部分类型的值以便观察
            switch (type) {
                case LUA_TNIL:
                    printf(", 值 = nil");
                    break;
                case LUA_TBOOLEAN:
                    printf(", 值 = %s", lua_toboolean(L, i) ? "true" : "false");
                    break;
                case LUA_TNUMBER:
                    printf(", 值 = %g", lua_tonumber(L, i));
                    break;
                case LUA_TSTRING:
                    printf(", 值 = \"%s\"", lua_tostring(L, i));
                    break;
                case LUA_TTABLE:
                    printf(", 值 = (table)");
                    break;
                case LUA_TFUNCTION:
                    printf(", 值 = (function)");
                    break;
                case LUA_TTHREAD:
                    printf(", 值 = (thread)");
                    break;
                case LUA_TLIGHTUSERDATA:
                case LUA_TUSERDATA:
                    printf(", 值 = (userdata)");
                    break;
            default:
                    printf(", 值 = (unknown)");
            }
            printf("\n");
        }
        return 0;  // 该函数没有返回值给 Lua
    }