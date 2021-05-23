PluginInfo =
{
  Name = "Room Combiner Add-ons~Custom LEDs",
  Version = "0.1.0",
  Id = "1ad2ee4f-f857-4aaa-8b4b-5af20df5d40a",
  Description = "Set your own colours for the Room Combiner!",
  Author = "Joshua Cerecke - Ceretech Audiovisual Solutions",
  URL = "https://github.com/jcerecke/room-combiner-custom-LEDs"
}

function GetPrettyName(props)
	return "Custom LEDs for Room Combiner V" .. PluginInfo.Version
end

function GetColor(props)
    return { 191, 226, 249 } --Same colour as Room Combiner component
  end

local Colors = {
	White = {255, 255, 255},
	Black = {0, 0, 0},
	Red = {255, 0, 0},
	Green = {0, 255, 0},
	Transparent = "FFFFFFFF"
}

function GetProperties()
	props = {
		{
			Name = "Rooms",
			Type = "integer",
			Value = 8,
			Min = 2,
			Max = 256
        },
        {
            Name = "Custom Off Colors",
            Type = "boolean",
            Value = "false"
        }
	}
	return props
end

function GetControls(props)
	ctls = {
		{
			Name = "RoomCombineTarget",
			ControlType = "Text",
			TextBoxStyle = "ComboBox",
			Count = 1,
			PinStyle = "Input",
			UserPin = true
        },
        {
			Name = "Status",
			ControlType = "Indicator",
			IndicatorType = "Status",
			Count = 1,
			PinStyle = "Output",
			UserPin = true
		},
		{
			Name = "Colors",
			ControlType = "Text",
			TextBoxStyle = "Normal",
			Count = props["Rooms"].Value,
			PinStyle = "Input",
			UserPin = true
        },
        {
			Name = "LEDs",
			ControlType = "Indicator",
			IndicatorType = "Led",
			Count = props["Rooms"].Value,
			PinStyle = "Output",
            UserPin = true
        }
    }
    if props["Custom Off Colors"].Value then
        table.insert(ctls, {
            Name = "OffColors",
            ControlType = "Text",
            TextBoxStyle = "Normal",
            Count = props.Rooms.Value,
            PinStyle = "Input",
            UserPin = true
            }
        )
        table.insert(ctls, {
            Name = "LEDState",
            ControlType = "Button",
            ButtonType = "Toggle",
            Count = 1,
        })

    end

	return ctls
end

-- This function allows you to layout pages in your plugin.
function GetControlLayout(props)
	local roomQty = props["Rooms"].Value
	-- layout holds representaiton of Controls
	local layout = {}
	-- graphics holds aesthetic & design items
	local graphics = {}
	-- x,y allows an easy method of knowing where you are relative to the section being designed

    table.insert(
	    graphics, {
            Type = "Text",
            Text = "Room Combiner Name",
            FontSize = 11,
            FontStyle = "Regular",
            HTextAlign = "Right",
            Color = {51, 51, 51, 255},
            Fill = {0, 0, 0, 0},
            Position = {20, 20},
            Size = {136, 20},
            ZOrder = 1
        }
    )
    layout["RoomCombineTarget"] = {
		PrettyName = "Room Combiner Name",
		Style = "ComboBox",
		Position = {166, 20},
		Size = {288, 20},
		FontSize = 11
    }
	table.insert(
        graphics, {
            Type = "Text",
            Text = "Status",
            FontSize = 11,
            FontStyle = "Regular",
            HTextAlign = "Right",
            Color = {51, 51, 51, 255},
            Fill = {0, 0, 0, 0},
            Position = {20, 44},
            Size = {136, 48},
            ZOrder = 1
        }
	)
	layout["Status"] = {
		PrettyName = "Status",
		Style = "Indicator",
		IndicatorStyle = "Status",
		Position = {166, 44},
		Size = {288, 48},
		FontSize = 11,
		ZOrder = 16
	}
    local x, y = 162, 106
    if props["Custom Off Colors"].Value then
        table.insert(
            graphics, {
                Type = "Text",
                Text = "LED State",
                FontSize = 11,
                FontStyle = "Regular",
                HTextAlign = "Right",
                Color = {51, 51, 51, 255},
                Fill = {0, 0, 0, 0},
                Position = {20, 96},
                Size = {136, 16},
                ZOrder = 1
            }
        )
        layout["LEDState"] = {
            PrettyName = "LED State",
            Style = "Button",
            ButtonStyle = "Toggle",
            Position = {166, 96},
            Size = {40, 20},
            FontSize = 11,
            ZOrder = 16
        }
        y = 126
    end
    local sizeY = props["Custom Off Colors"].Value and 110 or 90
    table.insert(
        graphics, {
            Type = "GroupBox",
            Text = "Rooms",
            FontSize = 11,
            FontStyle = "Regular",
            HTextAlign = "Left",
            StrokeColor = Colors.Stroke,
            StrokeWidth = 1,
            CornerRadius = 8,
            Color = {51, 51, 51, 255},
            Fill = {0, 0, 0, 0},
            Position = {x, y},
            Size = {roomQty * 36 + 8, sizeY},
            ZOrder = 1
        }
    )
    x, y = 20, y + 20
    table.insert(
        graphics, {
        Type = "Text",
        Text = "Custom LED",
        FontSize = 11,
        FontStyle = "Regular",
		HTextAlign = "Right",
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {x, y + 16},
		Size = {136, 16},
		ZOrder = 1
        }
    )
    table.insert(
        graphics, {
        Type = "Text",
        Text = "Color",
        FontSize = 11,
        FontStyle = "Regular",
		HTextAlign = "Right",
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {x, y + 32},
		Size = {136, 16},
		ZOrder = 1
        }
    )
    if props["Custom Off Colors"].Value then
        table.insert(
            graphics, {
            Type = "Text",
            Text = "Off Color",
            FontSize = 11,
            FontStyle = "Regular",
            HTextAlign = "Right",
            Color = {51, 51, 51, 255},
            Fill = {0, 0, 0, 0},
            Position = {x, y + 48},
            Size = {136, 16},
            ZOrder = 1
            }
        )
    end
    x = 166
	for i = 1, roomQty do
		table.insert(
            graphics,{
                Type = "Text",
                Text = tostring(i),
                FontSize = 11,
                HTextAlign = "Center",
                Color = Colors.Black,
                Position = {x, y},
                Size = {36, 16}
            }
        )
        layout["LEDs " .. tostring(i)] = {
            PrettyName = "LEDs~Room " .. tostring(i),
            Style = "Led",
            Position = {x + 10, y + 16},
            Size = {16, 16}
        }
		layout["Colors " .. tostring(i)] = {
            PrettyName = "Colors~Room " .. tostring(i),
			Style = "Text",
			TextBoxStyle = "Normal",
			Position = {x, y + 32},
			Size = {36, 16},
			HTextAlign = "Center",
			FontSize = 9,
			Color = Colors.White,
			StrokeColor = Colors.Stroke,
			StrokeWidth = 1
        }
        if props["Custom Off Colors"].Value then
            layout["OffColors "..tostring(i)] = {
                PrettyName = "Off Colors~Room " .. tostring(i),
                Style = "Text",
                TextBoxStyle = "Normal",
                Position = {x, y + 48},
                Size = {36, 16},
                HTextAlign = "Center",
                FontSize = 9,
                Color = Colors.White,
                StrokeColor = Colors.Stroke,
                StrokeWidth = 1
            }
        end
		x = x + 36
    end




	
	return layout, graphics
end

if Controls then

    --[[ ******************************* ]]--
	--[[ ******* Global Variables ****** ]]--
    --[[ ******************************* ]]--
    
    roomCombinerNames = {}
    for i, v in pairs(Component.GetComponents()) do
		if v.Type == "room_combiner" then
			table.insert(roomCombinerNames, v.Name)
		end
    end
    
    Controls.RoomCombineTarget.Choices = roomCombinerNames
    
	rooms = {} -- key = room number, value = table of LED controls (color shows group membership), color Text Box controls, LEDs
	groups = {} -- sort of reverse table of rooms[room][group] info. Keys are group names (LED colors), Values are room numbers that are members of that group.
	walls = {} -- key = index, value = control

    --[[ ******************************* ]]--
	--[[ ********** Functions ********** ]]--
    --[[ ******************************* ]]--
    
    function UpdateStatus(val, msg) -- Updates status, "val" can be passed a number or string.
		if type(val) == "string" then
			val = val == "OK" and 0 or val
			val = val == "Compromised" and 1 or val
			val = val == "Fault" and 2 or val
			val = val == "Not Present" and 3 or val
			val = val == "Missing" and 4 or val
			val = val == "Initializing" and 5 or val
			if type(val) ~= "number" then
				error("UpdateStatus val is incorrectly formatted: Expecting integer 0-5 or valid status string, Received: "..val)
			end
		end
		Controls.Status.Value = val
		if msg ~= nil then
			Controls.Status.String = msg
		end
    end
    
    function IsComponentValid(name)  -- returns true or false if a named component is found.
		return #Component.GetControls(name) ~= 0 and true or false
    end
    
    function UpdateTextBoxColor(ctl, valid) -- Updates textbox color
        valid = ctl.String == "" or valid -- Textbox is white if the Text box is blank.
		ctl.Color = valid and "White" or "Red"  -- Textbox is white if the entry is valid, red if it's not valid.
    end
    
    function UpdateGroupsTable() 
        groups = {}
        local groupNo = 0 -- Room Number of the first room in a group
        for room, t in ipairs(rooms) do
            if groupNo == 0 or t.LEDs.Color ~= rooms[groupNo].LEDs.Color then -- If there's no GroupNo or the color is different
                groupNo = room
            end

            rooms[room]["groupNo"] = groupNo

            if groups["groupNo"] == nil then
                groups["groupNo"] = {room}
            else
                table.insert(groups["groupNo"], room)
            end
        end
    end
    
    function UpdateLEDs()
        for room, roomTbl in ipairs(rooms) do
            if roomTbl.rcLED.Boolean then -- the room is combined - set it to the on state
                if Properties["Custom Off Colors"].Value then
                    roomTbl.myLED.Color = rooms[roomTbl.groupNo].myColor.String
                else
                    roomTbl.myLED.Boolean = true
                end
            else
                if Properties["Custom Off Colors"].Value then
                    roomTbl.myLED.Color = roomTbl.myOffColor.String
                else
                    roomTbl.myLED.Boolean = false
                end
            end
        end
    end

    function WallHasChanged() -- Room Combiner Walls Control EventHandler Function
        UpdateGroupsTable()
        UpdateLEDs()
    end
    
    function GetFirstRoom(group) -- returns the first room number
        table.sort(group)
        return #group > 0 and group[1] or false
    end
    
    function ColorChange(ctl)
        print("Color changed to "..ctl.String)
    end

    function InitialiseAll()
		UpdateStatus("Initializing")
		
		local componentValid = IsComponentValid(Controls.RoomCombineTarget.String) --Check Room Combiner Component Exists
		UpdateTextBoxColor(Controls.RoomCombineTarget, componentValid)

		if componentValid then
			roomCombiner = Component.New(Controls.RoomCombineTarget.String)

            for room = 1, Properties.Rooms.Value do -- Initialise rooms table with plugin controls
                rooms[room] = {}
                rooms[room]["myLED"] = Controls.LEDs[room]
                rooms[room]["myColor"] = Control.Colors[room]
                if Properties["Custom Off Colors"].Value then
                    rooms[room]["myOffColor"] = Controls.OffColors[room]
                end
            end

			for name, control in pairs(roomCombiner) do -- Initialise room combiner controls
				if name:find("output%.%d+%.combined") then
                    local room = tonumber(name:match("output%.(%d+)%.combined"))
                    if room <= Properties.Rooms.Value then
                        rooms[room]["rcLED"] = control
                        rooms[room]["group"] = control.Color
                    else
                        UpdateStatus("Fault", "Room Combiner number of rooms does not match this plugin - Room Combiner: "..tostring(roomCombinerRoomQty)..", This Plugin: "..tostring(Properties.Rooms.Value))
                    end
					
				elseif name:find("wall%.%d+%.open") then -- Add each wall's open button into an array and assign eventhandler to watch it
					local wall = tonumber(name:match("wall%.(%d+)%.open"))
					walls[wall] = control
					control.EventHandler = function() 
						WallHasChanged()
					end
				end
			end

            WallHasChanged()		
		
			if Controls.Status.String == "Initializing" then -- Finished initialising with no faults, update status to OK.
                UpdateStatus("OK")
                --SyncroniseAllGroups()
			end
		else
            UpdateStatus("Fault", "Room Combiner target not a valid component. Check component name and try again.")
		end
	end

	--Run all eventhandler code on startup:
	InitialiseAll()

    for i = 1, Properties.rooms.Value do
        Controls.Colors.EventHandler = ColorChange
        if Properties["Custom Off Colors"].Value then
            Controls.OffColors.EventHandler = WallHasChanged
        end
    end

    if Properties["Custom Off Colors"].Value then
        Controls["LED State"].EventHandler = function()
            for room, roomTbl in ipairs(rooms) do
                roomTbl.myLED.Boolean = Controls["LED State"].boolean
            end
            WallHasChanged()
        end
    end
end