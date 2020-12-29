---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dee.
--- DateTime: 2019/3/7 11:27
--- FIFO
---

queue = queue or {}

---@return Queue
function queue.create()
    ---数据容器
    local data = {}
    ---数据长度
    local lenght = 0
    ---队首索引
    local first = 1

    ---获取队首值
    local peek = function()
        return data[first]
    end

    ---压入数据
    local enqueue = function(v)
        assert(v ~= nil, "nil value")
        lenght = lenght + 1
        table.insert(data, v)
    end

    ---弹出数据
    local dequeue = function()
        assert(lenght > 0, "nill queue")

        local ret = peek()
        data[first] = nil
        first = first+1
        lenght = lenght - 1

        if math.fmod(first, 1000) == 0 then
            local tmp = {}
            table.move(data, first, first + lenght, 1, tmp)

            first = 1
            data = nil
            data = tmp
        end

        return ret
    end

    local clear = function()
        data = {}
        first = 1
        lenght = 0
    end

    local __tostring = function()
        local tmp = {}
        for i=1,lenght do
            tmp[i] = data[i + first - 1]
        end
        return table.concat(tmp, ",")
    end

    local __len = function()
        return lenght
    end

    local __index = function(i_t, key)
        error(">> Dee: Limited access")
    end

    local __newindex = function(i_t, key, v)
        error(">> Dee: Limited access")
    end

    local __ipairs = function(i_t)
        local idx = 0
        local function iter(i_t)
            idx = idx + 1
            if idx <= lenght then
                return idx, data[first + idx - 1]
            end
        end

        return iter
    end

    local __pairs = function(i_t)
        error(">> Dee: Limited access")
    end

    local mt = {__tostring = __tostring, __index = __index, __newindex = __newindex, __ipairs = __ipairs, __pairs = __pairs, __len = __len}

    ---@class Queue
    local t = {
        enqueue = enqueue,
        dequeue = dequeue,
        peek = peek,
        clear = clear
    }

    setmetatable(t, mt)

    return t
end

return queue
