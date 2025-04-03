import requests
import json
import datetime

# Discord webhook URL
webhook_url = "https://discord.com/api/webhooks/1357395980299014224/VHqKfAsLDqGIUQ5icewgv8YX-SblIBEsmG3NmaMG83y68hQcGrfTEXmdW0rCy0P98zuz"

# Current timestamp in ISO format
timestamp = datetime.datetime.now().isoformat()

# Create webhook data
data = {
    "content": "📢 This is a test message from LAJ HUB! The webhook is working correctly. ✅",
    "embeds": [{
        "title": "LAJ HUB Webhook Test",
        "description": "This message confirms that your Discord webhook is properly configured and functional.",
        "color": 5814783,  # Blue color
        "footer": {
            "text": "LAJ HUB v3.0.0-ULTIMATE"
        },
        "timestamp": timestamp
    }]
}

# Send webhook
print("Sending test webhook message...")
response = requests.post(
    webhook_url,
    data=json.dumps(data),
    headers={"Content-Type": "application/json"}
)

# Print results
print(f"Status code: {response.status_code}")
if response.status_code == 204:
    print("Success! The webhook message was sent to Discord.")
else:
    print(f"Error: {response.text}")