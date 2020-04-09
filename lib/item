-- Returns true if a slot of a container contains item(s), itemID may be specified
function slotContainsItem(container, slot, itemID)
    if container == nil then
        error("Container is nil.")
    end
    local slotInfo = container.getStackInSlot(slot)
    if (slotInfo == nil) or (itemID ~= nil and slotInfo.id ~= itemID) then
        return false
    end
    return true
end

-- Returns true if a container contains item(s), itemID may be specified
function containsItem(container, itemID)
    local n = container.getInventorySize()
    local i = 1
    while i <= n do
        if slotContainsItem(container, i, itemID) then
            return true
        end
        i = i + 1
    end
    return false
end

-- Push an specified quantity of item from a container to another
function pushItem(inputContainer, outputSide, quantity)
    local n = inputContainer.getInventorySize()
    local i = 1
    while (not slotContainsItem(inputContainer, i)) do
        i = i + 1
        if i > n then
            error("Slot id should not be bigger than inventory capacity : i = " .. i .. ", n = " .. n)
        end
    end
    return inputContainer.pushItem(outputSide, i, quantity)
end

-- Returns item ID from a slot in a container
function getItemIDFromSlot(container, slot)
    local item = container.getStackInSlot(slot)
    if item == nil then
        error("Container is not recognized or slot " .. tostring(slot) .. " is empty")
    end
    return item.id
end