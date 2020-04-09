-- [V1.2]

--- INIT ---
if not fs.exists("json") then
	shell.run("pastebin get 4nRg9CHU json")
end
os.loadAPI("json")

--- FUNCTIONS ---
-- returns json object with the list of players
function listConnectedPlayers()
	local str = http.get("http://api.mineaurion.com/v1/serveurs").readAll()
	local arrObj = json.decode(str) -- array of json object containing each server
	return arrObj
end

-- convert text (in json format) into a JSON object (table) and returns it
function decode(text)
	return json.decode(text)
end

-- get the content of a file and returns a JSON object (table)
function decodeFromFile(filename)
	return json.decodeFromFile(filename)
end

-- get the content of a HTTP link and returns a JSON object (table)
function decodeHTTP(link)
	return json.decode(http.get(link).readAll())
end

-- get the content of a HTTP link and save it to a file
function decodeHTTPSave(link, filename)
	local h = fs.open(filename, "w")
	h.write(encodePretty(decode(http.get(link).readAll())))
	h.close()
end

-- convert JSON object (table) into a string
function encode(obj)
	return json.encore(obj)
end

-- convert JSON object (table) into a string (pretty json)
function encodePretty(obj)
	return json.encore(obj)
end

-- save a table to a JSON file
function encodeAndSavePretty(filename, obj)
	if not fs.exists(filename) then
		error("File " .. filename .. " does not exist.")
	end
	local h = fs.open(filename, "w")
	h.write(encodePretty(obj))
	h.close()
end