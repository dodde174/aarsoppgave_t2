local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("rxi-json-lua")


local End = {}


function End:load()
    self.gameOver = false
end


function End:uploadScore(time)
    -- The URL you want to send the POST request to
    local url = "localhost:80"
    
    -- The JSON payload you want to send
    local payload = {
        score = time
    }
    
    -- Encode the payload as a JSON string
    local payload_json = json.encode(payload)
    
    -- Set the headers for the POST request
    local headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = #payload_json
    }
    
    -- Send the POST request
    local response_body = {}
    local result, status_code, response_headers = http.request{
        method = "POST",
        url = url,
        headers = headers,
        source = ltn12.source.string(payload_json),
        sink = ltn12.sink.table(response_body)
    }
    
    -- Print the response body and status code
    print(table.concat(response_body))
    print(status_code)
end


return End