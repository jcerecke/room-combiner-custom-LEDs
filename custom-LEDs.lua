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
            Name = "LED mode",
            Type = "enum",
            Choices = {"Standard on/off", "Manual (Specify on/off colors)"},
            Value = "Standard on/off"
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
    if props["LED mode"].Value == "Manual (Specify on/off colors)" then
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
    if props["LED mode"].Value == "Manual (Specify on/off colors)" then
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
    local sizeY = props["LED mode"].Value == "Manual (Specify on/off colors)" and 110 or 90
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
    if props["LED mode"].Value == "Manual (Specify on/off colors)" then
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
        if props["LED mode"].Value == "Manual (Specify on/off colors)" then
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
