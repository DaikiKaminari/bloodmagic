-- [V0.1]

--- INIT ---
if not fs.exists("lib/objectJSON") then
    shell.run("pastebin get zqV8ihh0 lib/objectJSON")
end
os.loadAPI("lib/objectJSON")

--- FUNCTIONS ---
local function alreadyPresent(recipes, itemID)
    for output,input in ipairs(recipes) do
        if output == itemID then
            return true
        end
    end
    return false
end

--- CALL ---
function addItem(jsonFile, inputChest, outputChest)
    local recipes = objectJSON.decodeFromFile(jsonFile)
    local inputItemID = item.getItemIDFromSlot(inputChest, 1)
    local outputItemID = item.getItemIDFromSlot(outputChest, 1)

    if alreadyPresent(recipes, outputItemID) then
        print("Item is already present.")
        print("Do you want to change the recipe ? Answer with Y or N")
        local str = io.read()
        if str == "Y" or str == "y" then
            recipes[outputItemID] = inputItemID
        end
        print("Recipe changed.\n")
    else
        recipes[outputItemID] = inputItemID
        print("New item added to recipe list.\n")
    end

    objectJSON.encodeAndSavePretty(jsonFile, recipes)
end