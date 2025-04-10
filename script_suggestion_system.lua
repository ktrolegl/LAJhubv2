-- Script Suggestion System for LAJ HUB
-- Suggests the best script for the current game with ratings

local ScriptSuggestionSystem = {}

-- Map game IDs to their script ratings
ScriptSuggestionSystem.GameScriptRatings = {
    -- Da Strike x Da Hood (Da Hood)
    [2788229376] = {
        ["Psalm"] = {
            rating = 4,
            description = "Excellent aimbot and silent aim",
            strengths = "Aim assistance, wallbang",
            weaknesses = "Sometimes detected by anti-cheat"
        },
        ["DHB Official"] = {
            rating = 3,
            description = "Good for beginners",
            strengths = "Easy to use, simple interface",
            weaknesses = "Limited advanced features"
        },
        ["Frostbyte"] = {
            rating = 4,
            description = "Great for skilled players",
            strengths = "Advanced features, customization",
            weaknesses = "Complex interface for beginners"
        },
        ["GS100"] = {
            rating = 3,
            description = "Easy to use with basic functions",
            strengths = "Simplicity, stability",
            weaknesses = "Limited feature set"
        },
        ["SpeedHub"] = {
            rating = 3,
            description = "Good utility features",
            strengths = "Speed modifications, teleports",
            weaknesses = "Limited combat features"
        },
        ["ThanHub"] = {
            rating = 4,
            description = "Good target selection and combat",
            strengths = "Targeting system, combat assistance",
            weaknesses = "Limited utility functions"
        },
        ["RiftHub"] = {
            rating = 5,
            description = "Best overall script with excellent features",
            strengths = "Premium aimbot, ESP, utility features",
            weaknesses = "None significant"
        },
        ["S6Ware"] = {
            rating = 3,
            description = "Basic but reliable features",
            strengths = "Reliability, simplicity",
            weaknesses = "Limited advanced options"
        },
        ["HomoHack"] = {
            rating = 2,
            description = "Limited functionality",
            strengths = "Small size, basic features",
            weaknesses = "Lacking advanced options"
        },
        ["GN Hub"] = {
            rating = 3,
            description = "Average performance and features",
            strengths = "Balanced feature set",
            weaknesses = "Nothing exceptional"
        },
        ["Raito Hub"] = {
            rating = 2,
            description = "Limited features for specific uses",
            strengths = "Specific use cases",
            weaknesses = "Not comprehensive"
        },
        ["Zenith Hub"] = {
            rating = 3,
            description = "Good for beginners with simple interface",
            strengths = "User-friendly, good for starters",
            weaknesses = "Lacks advanced features"
        },
        ["Lunor"] = {
            rating = 4,
            description = "Good all-around functionality",
            strengths = "Well-balanced feature set",
            weaknesses = "Some stability issues"
        },
        ["Keel"] = {
            rating = 2,
            description = "Basic features only",
            strengths = "Simplicity",
            weaknesses = "Very limited functionality"
        }
    },
    
    -- Murder Mystery 2
    [142823291] = {
        ["Eclipse Hub"] = {
            rating = 5,
            description = "Best overall with ESP and teleport",
            strengths = "ESP, teleport, auto-farm",
            weaknesses = "None significant"
        },
        ["Visual Hub"] = {
            rating = 4,
            description = "Great ESP features",
            strengths = "Advanced visual features",
            weaknesses = "Limited utility"
        },
        ["Murder Mystery X"] = {
            rating = 3,
            description = "Average features and performance",
            strengths = "Balanced functionality",
            weaknesses = "Nothing standout"
        },
        ["Express Hub"] = {
            rating = 5,
            description = "Best aimbot and ESP with trolling options",
            strengths = "Aimbot, ESP, trolling, teleport",
            weaknesses = "None significant"
        }
    },
    
    -- Blox Fruits (all seas)
    [2753915549] = { -- First Sea
        ["Mukuro Hub"] = {
            rating = 5,
            description = "Best auto-farm script with premium features",
            strengths = "Auto-farm, raid assistance, fruit finder",
            weaknesses = "None significant"
        },
        ["Hoho Hub"] = {
            rating = 4,
            description = "Good all-around script",
            strengths = "Well-balanced for most activities",
            weaknesses = "Not specialized in any area"
        },
        ["Domadic Hub"] = {
            rating = 4,
            description = "Great for raids and dungeons",
            strengths = "Raid optimization, dungeon farming",
            weaknesses = "Less effective for general farming"
        },
        ["Table Hub"] = {
            rating = 3,
            description = "Average features for general play",
            strengths = "Easy to use, stable",
            weaknesses = "Limited advanced features"
        },
        ["Thunder Z"] = {
            rating = 3,
            description = "Good for beginners",
            strengths = "User-friendly interface",
            weaknesses = "Limited advanced options"
        },
        ["Mango Hub"] = {
            rating = 3,
            description = "Good for PvP content",
            strengths = "Combat assistance, PvP features",
            weaknesses = "Limited farming capabilities"
        },
        ["Zen Hub"] = {
            rating = 3,
            description = "Average features across the board",
            strengths = "Balanced functionality",
            weaknesses = "Nothing exceptional"
        },
        ["Ripper Hub"] = {
            rating = 2,
            description = "Limited features but stable",
            strengths = "Stability",
            weaknesses = "Very limited feature set"
        }
    },
    [4442272183] = { -- Second Sea (same ratings as First Sea)
        ["Mukuro Hub"] = {
            rating = 5,
            description = "Best auto-farm script with premium features",
            strengths = "Auto-farm, raid assistance, fruit finder",
            weaknesses = "None significant"
        },
        ["Hoho Hub"] = {
            rating = 4,
            description = "Good all-around script",
            strengths = "Well-balanced for most activities",
            weaknesses = "Not specialized in any area"
        },
        ["Domadic Hub"] = {
            rating = 4,
            description = "Great for raids and dungeons",
            strengths = "Raid optimization, dungeon farming",
            weaknesses = "Less effective for general farming"
        }
    },
    [7449423635] = { -- Third Sea (same ratings as First Sea)
        ["Mukuro Hub"] = {
            rating = 5,
            description = "Best auto-farm script with premium features",
            strengths = "Auto-farm, raid assistance, fruit finder",
            weaknesses = "None significant"
        },
        ["Hoho Hub"] = {
            rating = 4,
            description = "Good all-around script",
            strengths = "Well-balanced for most activities",
            weaknesses = "Not specialized in any area"
        }
    },
    
    -- Doors
    [6516141723] = {
        ["Vynixius"] = {
            rating = 5,
            description = "Best overall with entity ESP",
            strengths = "ESP, item finder, auto-complete",
            weaknesses = "None significant"
        },
        ["MSDOORS"] = {
            rating = 4,
            description = "Good for beginners",
            strengths = "Easy to use, helpful features",
            weaknesses = "Less advanced than Vynixius"
        },
        ["Parasite"] = {
            rating = 3,
            description = "Average features but stable",
            strengths = "Stability",
            weaknesses = "Limited advanced options"
        },
        ["Kodbol Hub"] = {
            rating = 5,
            description = "Best ESP features and door bypass",
            strengths = "Entity ESP, door bypass, item ESP",
            weaknesses = "None significant"
        }
    },
    
    -- Other games follow similar pattern
    -- (Abbreviated for other games)
}

-- Get the script ratings for the current game
function ScriptSuggestionSystem:GetCurrentGameScriptRatings()
    local placeId = game and game.PlaceId or 0
    return self.GameScriptRatings[placeId] or {}
end

-- Get the best script for the current game
function ScriptSuggestionSystem:GetBestScriptForCurrentGame()
    local scriptRatings = self:GetCurrentGameScriptRatings()
    local bestScript = nil
    local bestRating = 0
    
    for scriptName, info in pairs(scriptRatings) do
        if info.rating > bestRating then
            bestRating = info.rating
            bestScript = {
                name = scriptName,
                rating = info.rating,
                description = info.description,
                strengths = info.strengths,
                weaknesses = info.weaknesses
            }
        end
    end
    
    return bestScript
end

-- Get all scripts for the current game, sorted by rating
function ScriptSuggestionSystem:GetAllScriptsForCurrentGame()
    local scriptRatings = self:GetCurrentGameScriptRatings()
    local scripts = {}
    
    for scriptName, info in pairs(scriptRatings) do
        table.insert(scripts, {
            name = scriptName,
            rating = info.rating,
            description = info.description,
            strengths = info.strengths,
            weaknesses = info.weaknesses
        })
    end
    
    -- Sort by rating (highest first)
    table.sort(scripts, function(a, b) return a.rating > b.rating end)
    
    return scripts
end

-- Get rating stars based on rating value
function ScriptSuggestionSystem:GetRatingStars(rating)
    local stars = ""
    
    for i = 1, 5 do
        if i <= rating then
            stars = stars .. "⭐"
        else
            stars = stars .. "☆"
        end
    end
    
    if rating >= 5 then
        stars = stars .. " [BEST]"
    end
    
    return stars
end

-- Get info text for a script
function ScriptSuggestionSystem:GetScriptInfoText(scriptInfo)
    if not scriptInfo then
        return "No scripts available for this game."
    end
    
    local text = scriptInfo.name .. " - " .. self:GetRatingStars(scriptInfo.rating) .. "\n"
    text = text .. "Description: " .. scriptInfo.description .. "\n"
    text = text .. "Strengths: " .. scriptInfo.strengths .. "\n"
    text = text .. "Weaknesses: " .. (scriptInfo.weaknesses ~= "None significant" and scriptInfo.weaknesses or "None")
    
    return text
end

-- Update button labels with script ratings
function ScriptSuggestionSystem:UpdateScriptButtonLabels(tab, gameScriptMapping)
    if not tab or not gameScriptMapping then return end
    
    local placeId = game and game.PlaceId or 0
    local scriptRatings = self.GameScriptRatings[placeId] or {}
    
    -- Update each button in the tab
    for scriptName, buttonInfo in pairs(gameScriptMapping) do
        local rating = scriptRatings[scriptName] and scriptRatings[scriptName].rating or 0
        local originalName = buttonInfo.OriginalName or scriptName
        
        if rating > 0 then
            local stars = ""
            for i = 1, rating do
                stars = stars .. "⭐"
            end
            
            -- Add [BEST] tag for highest rated scripts
            if rating >= 5 then
                buttonInfo.NewName = originalName .. " " .. stars .. " [BEST]"
            else
                buttonInfo.NewName = originalName .. " " .. stars
            end
        end
    end
end

-- Create suggestion section in a tab
function ScriptSuggestionSystem:CreateSuggestionSection(tab)
    if not tab then return end
    
    local bestScript = self:GetBestScriptForCurrentGame()
    
    if not bestScript then
        tab:CreateSection("No script suggestions available for this game")
        return
    end
    
    tab:CreateSection("Recommended Script")
    
    tab:CreateParagraph({
        Title = bestScript.name .. " " .. self:GetRatingStars(bestScript.rating),
        Content = bestScript.description .. "\n\nStrengths: " .. bestScript.strengths .. 
                "\nWeaknesses: " .. (bestScript.weaknesses ~= "None significant" and bestScript.weaknesses or "None")
    })
    
    -- List other top scripts
    local allScripts = self:GetAllScriptsForCurrentGame()
    if #allScripts > 1 then
        tab:CreateSection("Other Top Scripts")
        
        for i = 2, math.min(4, #allScripts) do
            local script = allScripts[i]
            tab:CreateParagraph({
                Title = script.name .. " " .. self:GetRatingStars(script.rating),
                Content = script.description
            })
        end
    end
end

return ScriptSuggestionSystem
