local module = {}

--- @param lines string[]
--- @return integer
function module.part1(lines)
    assert(#lines > 0, "lines must not be empty")
    local startIndex = lines[1]:find("S")
    assert(startIndex, "'S' not found on first line")
    ---@type table<integer, boolean>
    local beams = { [startIndex] = true }
    local split = 0
    for _, line in ipairs(lines) do
        for x in pairs(beams) do
            if line:sub(x, x) == '^' then
                -- Split the beam
                split = split + 1
                beams[x] = nil
                if x + 1 <= #line then beams[x + 1] = true end
                if x > 1 then beams[x - 1] = true end
            end
        end
    end
    return split
end

if ... == nil then
    --- @type string[]
    local lines = {}
    for line in io.open("input.txt"):lines() do
        table.insert(lines, line)
    end
    local part1Res = module.part1(lines)
    print(part1Res)
end

return module
