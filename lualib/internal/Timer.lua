local ti = require "timer"
local co_new = coroutine.create
local co_start = coroutine.resume
local co_wakeup = coroutine.resume
local co_suspend = coroutine.yield
local co_self = coroutine.running

local insert = table.insert
local remove = table.remove

local Timer = {}

local TIMER_LIST = {}

function Timer.get_timer()
    if #TIMER_LIST > 0 then
        return remove(TIMER_LIST)
    end
    return ti:new()
end

-- 超时器 --
function Timer.timeout(timeout, cb)
    if not timeout or timeout < 0 then
        return
    end
    local ti = Timer.get_timer()
    if not ti then
        print("[INFO] Create timer class error! memory maybe not enough...")
        return
    end
    local t = {
        stop = function ( ... )
            ti:stop()
            insert(TIMER_LIST, ti)
        end,
        co = co_new(function ( ... )
            local ok, err = pcall(cb)
            if not ok then
                print ("[INFO] timeout error:", err)
            end
            ti:stop()
            insert(TIMER_LIST, ti)
        end)
    }
    ti:start(timeout, timeout, t.co)
    return t
end

return Timer