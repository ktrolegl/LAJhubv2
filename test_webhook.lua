-- Test Discord webhook functionality

local webhookUrl = "https://discord.com/api/webhooks/1357395980299014224/VHqKfAsLDqGIUQ5icewgv8YX-SblIBEsmG3NmaMG83y68hQcGrfTEXmdW0rCy0P98zuz"

-- Function to send a webhook message
local function sendWebhook(message)
    local httpService = game:GetService("HttpService")
    local data = {
        ["content"] = message,
        ["embeds"] = {{
            ["title"] = "LAJ HUB Test Message",
            ["description"] = message,
            ["color"] = 5814783,
            ["footer"] = {
                ["text"] = "LAJ HUB Webhook Test"
            },
            ["timestamp"] = os.date("%Y-%m-%dT%H:%M:%S", os.time())
        }}
    }
    
    local headers = {["Content-Type"] = "application/json"}
    local finalData = httpService:JSONEncode(data)
    
    local request = http_request or request or HttpPost or syn.request
    local response = request({
        Url = webhookUrl,
        Method = "POST",
        Headers = headers,
        Body = finalData
    })
    
    print("Webhook Response Status: " .. (response.StatusCode or "Unknown"))
    return response
end

-- Send test message
print("Sending test webhook message...")
local response = sendWebhook("📢 This is a test message from LAJ HUB! Webhook is working correctly. ✅")
print("Message sent!")
print("Server response:", response and response.Body)