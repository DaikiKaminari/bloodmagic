--- INIT ---
if not fs.exists("lib/json") then
    shell.run("pastebin get 4nRg9CHU lib/json")
end
os.loadAPI("lib/json")


--- FUNCTIONS ---
local function loadAPI(apis)
    for _,v in pairs(apis) do
        print("Loading API : " .. v)
        os.loadAPI(v)
        print("API " .. v .. " loaded !")
    end
    print("")
end

local function getPeripheral(side)
    local p = peripheral.wrap(side)
    if p == nil then
        error("Peripheral on side " .. side .. " not found")
    end
    return p
end

local function wantedOutputID(container)
    print("\nSearching for a wanted item ...")
    while not items.slotContainsItem(container, 1) do
        sleep(1)
    end
    local slotInfo = container.getStackInSlot(1)
    print("Item found ! It is : " .. slotInfo.display_name)
    return slotInfo.id
end

local function newItemToProcess(altar, wantedChest, inputChest, wantedID)
    while items.slotContainsItem(wantedChest, 1) or not items.containsItem(inputChest) do -- continue until the item is removed from wanted chest or input chest is empty
        if items.containsItem(altar) then -- if the altar contains items
            if items.slotContainsItem(altar, 1, wantedID) then -- altar contains wanted item
                items.pushItem(altar, "NORTH") -- send all items from the altar into the output chest
                if items.containsItem(inputChest) then -- if the input chest contains items
                    items.pushItem(inputChest, "NORTH", 1) -- send 2 items from the input chest to the altar
                end
            end
        else -- if the altar is empty
            if items.containsItem(inputChest) then -- if the input chest contains items
                items.pushItem(inputChest, "NORTH", 1) -- send 2 items from the input chest to the altar
            end
        end
        sleep(1)
    end
    print("Removed item")
end

local function hasRedstoneSignal()
    for _,v in pairs(redstone.getSides()) do
        if redstone.getInput(v) then
            return true
        end
    end
    return false
end

local function manageRecipes()
    while true do
        if hasRedstoneSignal() then
            recipesManager.addItem(config.jsonRecipes, config.inputRecipeChest, config.outputRecipeChest)
        end
        sleep(1)
    end
end

--- MAIN ---
local function main()
    -- Loading APIs
    loadAPI({"recipesManager", "lib/items", "lib/objectJSON"})

    -- Loading config
    config = objectJSON.decodeFromFile("config")
    local altar = getPeripheral(config.altar)
    local wantedChest = getPeripheral(config.wantedChest)
    local inputChest = getPeripheral(config.inputChest)
    local outputChest = getPeripheral(config.outputChest)

    -- Begin
    local wantedID = wantedOutputID(wantedChest)
    while true do
        newItemToProcess(altar, wantedChest, inputChest, wantedID)
        items.pushItem(altar, "NORTH") -- send all items from the altar into the output chest
        wantedID = wantedOutputID(wantedChest)
    end
end

main()