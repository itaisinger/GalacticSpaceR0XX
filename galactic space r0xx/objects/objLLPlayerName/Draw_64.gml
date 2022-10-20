/// @DnDAction : YoYo Games.Drawing.Set_Font
/// @DnDVersion : 1
/// @DnDHash : 1D41EE36
/// @DnDArgument : "font" "fontLLDefaultFont"
/// @DnDSaveInfo : "font" "fontLLDefaultFont"
draw_set_font(fontLLDefaultFont);

/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 1661A990
draw_set_halign(fa_left);
draw_set_valign(fa_top);

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 28823DD5
/// @DnDComment : If we are currently inserting the name$(13_10)show the current keyboard_string
/// @DnDArgument : "var" "insertingName"
/// @DnDArgument : "value" "true"
if(insertingName == true)
{
	/// @DnDAction : YoYo Games.Drawing.Set_Color
	/// @DnDVersion : 1
	/// @DnDHash : 7C8EB2D3
	/// @DnDParent : 28823DD5
	draw_set_colour($FFFFFFFF & $ffffff);
	var l7C8EB2D3_0=($FFFFFFFF >> 24);
	draw_set_alpha(l7C8EB2D3_0 / $ff);

	/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
	/// @DnDVersion : 1
	/// @DnDHash : 354F8F6C
	/// @DnDParent : 28823DD5
	/// @DnDArgument : "x" "520"
	/// @DnDArgument : "y" "450"
	/// @DnDArgument : "xscale" "3"
	/// @DnDArgument : "yscale" "3"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "text" "keyboard_string"
	draw_text_transformed(520, 450, "" + string(keyboard_string), 3, 3, 0);

	/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
	/// @DnDVersion : 1
	/// @DnDHash : 75EE361C
	/// @DnDParent : 28823DD5
	/// @DnDArgument : "x" "520"
	/// @DnDArgument : "y" "530"
	/// @DnDArgument : "xscale" "3"
	/// @DnDArgument : "yscale" "3"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "text" ""Press Enter to change""
	draw_text_transformed(520, 530, "" + string("Press Enter to change"), 3, 3, 0);
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 6A333603
else
{
	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 52D37D80
	/// @DnDComment : If the player doesn't have a name,$(13_10)show "Enter name..." instead
	/// @DnDParent : 6A333603
	/// @DnDArgument : "var" "LLPlayerName()"
	/// @DnDArgument : "value" """"
	if(LLPlayerName() == "")
	{
		/// @DnDAction : YoYo Games.Drawing.Set_Color
		/// @DnDVersion : 1
		/// @DnDHash : 3462ACC8
		/// @DnDParent : 52D37D80
		/// @DnDArgument : "color" "$FF191919"
		draw_set_colour($FF191919 & $ffffff);
		var l3462ACC8_0=($FF191919 >> 24);
		draw_set_alpha(l3462ACC8_0 / $ff);
	
		/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
		/// @DnDVersion : 1
		/// @DnDHash : 52165768
		/// @DnDParent : 52D37D80
		/// @DnDArgument : "x" "520"
		/// @DnDArgument : "y" "450"
		/// @DnDArgument : "xscale" "3"
		/// @DnDArgument : "yscale" "3"
		/// @DnDArgument : "caption" ""
		/// @DnDArgument : "text" ""Enter name...""
		draw_text_transformed(520, 450, "" + string("Enter name..."), 3, 3, 0);
	}

	/// @DnDAction : YoYo Games.Common.Else
	/// @DnDVersion : 1
	/// @DnDHash : 52878C86
	/// @DnDComment : Otherwise, show the players name
	/// @DnDParent : 6A333603
	else
	{
		/// @DnDAction : YoYo Games.Drawing.Set_Color
		/// @DnDVersion : 1
		/// @DnDHash : 210E5DC5
		/// @DnDParent : 52878C86
		draw_set_colour($FFFFFFFF & $ffffff);
		var l210E5DC5_0=($FFFFFFFF >> 24);
		draw_set_alpha(l210E5DC5_0 / $ff);
	
		/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
		/// @DnDVersion : 1
		/// @DnDHash : 3A9E4F70
		/// @DnDParent : 52878C86
		/// @DnDArgument : "x" "520"
		/// @DnDArgument : "y" "450"
		/// @DnDArgument : "xscale" "3"
		/// @DnDArgument : "yscale" "3"
		/// @DnDArgument : "caption" ""
		/// @DnDArgument : "text" "LLPlayerName()"
		draw_text_transformed(520, 450, "" + string(LLPlayerName()), 3, 3, 0);
	}
}