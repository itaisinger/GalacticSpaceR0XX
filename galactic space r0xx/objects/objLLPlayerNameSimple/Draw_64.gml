/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 344DE53B
draw_set_halign(fa_left);
draw_set_valign(fa_top);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 4E784073
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "-20"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""
/// @DnDArgument : "var" ""Player ID: "+string(LLPlayerID())"
draw_text(x + 0, y + -20,  + string("Player ID: "+string(LLPlayerID())));

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 0AD756B0
/// @DnDArgument : "var" "enteringName"
/// @DnDArgument : "value" "true"
if(enteringName == true)
{
	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 5D845D0E
	/// @DnDParent : 0AD756B0
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "var" ""Player Name:"+keyboard_string+"\nPress Enter to submit\nESC to cancel""
	draw_text(x + 0, y + 0,  + string("Player Name:"+keyboard_string+"\nPress Enter to submit\nESC to cancel"));
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 427A551F
else
{
	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 55DB8341
	/// @DnDParent : 427A551F
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "var" ""Player Name: "+LLPlayerName()+"\nPress C to change""
	draw_text(x + 0, y + 0,  + string("Player Name: "+LLPlayerName()+"\nPress C to change"));
}