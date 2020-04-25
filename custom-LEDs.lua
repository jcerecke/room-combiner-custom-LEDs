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
        },
		{
			Name = "Status",
			ControlType = "Indicator",
			IndicatorType = "Status",
			Count = 1,
			PinStyle = "Output",
			UserPin = true
		}
	}
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
	local x, y = 162, 40
	
	for i = 1, roomQty do
		table.insert(
		graphics,
		{
			Type = "Text",
			Text = tostring(i),
			FontSize = 11,
			HTextAlign = "Center",
			Color = Colors.Black,
			Position = {x, y},
			Size = {36, 16}
		}
		)
		layout["Colors " .. tostring(i)] = {
            PrettyName = "Colors~Room " .. tostring(i),
			Style = "Text",
			TextBoxStyle = "Normal",
			Position = {x, y + 16},
			Size = {36, 16},
			HTextAlign = "Center",
			FontSize = 9,
			Color = Colors.White,
			StrokeColor = Colors.Stroke,
			StrokeWidth = 1
        }
        layout["LEDs " .. tostring(i)] = {
            PrettyName = "LEDs~Room " .. tostring(i),
            Style = "Led",
            Position = {x + 10, y + 32},
            Size = {16, 16}
        }
		x = x + 36
    end
	layout["RoomCombineTarget"] = {
		PrettyName = "Room Combiner Name",
		Style = "ComboBox",
		Position = {162, 114},
		Size = {288, 20},
		FontSize = 11
	}
	layout["Status"] = {
		PrettyName = "Status",
		Style = "Indicator",
		IndicatorStyle = "Status",
		Position = {162, 138},
		Size = {288, 48},
		FontSize = 11,
		ZOrder = 16
	}
	
	table.insert(
	graphics,
	{
		Type = "GroupBox",
		Text = "Room",
		FontSize = 11,
		FontStyle = "Regular",
		HTextAlign = "Left",
		StrokeColor = Colors.Stroke,
		StrokeWidth = 1,
		CornerRadius = 8,
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {158, 20},
		Size = {roomQty * 36 + 8, 90},
		ZOrder = 1
	}
    )
    table.insert(
        graphics, {
        Type = "Text",
        Text = "Colors",
        FontSize = 11,
        FontStyle = "Regular",
		HTextAlign = "Right",
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {18, 56},
		Size = {136, 20},
		ZOrder = 1
        }
    )
	table.insert(
	    graphics, {
		Type = "Text",
		Text = "Room Combiner Name",
		FontSize = 11,
		FontStyle = "Regular",
		HTextAlign = "Right",
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {18, 114},
		Size = {136, 20},
		ZOrder = 1
	}
	)
	table.insert(
	graphics,
	{
		Type = "Text",
		Text = "Status",
		FontSize = 11,
		FontStyle = "Regular",
		HTextAlign = "Right",
		Color = {51, 51, 51, 255},
		Fill = {0, 0, 0, 0},
		Position = {18, 138},
		Size = {136, 48},
		ZOrder = 1
	}
	)
	
	return layout, graphics
end
