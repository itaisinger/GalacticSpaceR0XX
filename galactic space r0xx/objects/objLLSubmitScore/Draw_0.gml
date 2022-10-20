/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 1D412C48
draw_set_halign(fa_left);
draw_set_valign(fa_top);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 0C0D6DA9
/// @DnDArgument : "x" "-64"
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Current score: ""
/// @DnDArgument : "var" "simpleLeaderboardScore"
draw_text(x + -64, y + 0, string("Current score: ") + string(simpleLeaderboardScore));

/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 113660B5
/// @DnDArgument : "halign" "fa_center"
draw_set_halign(fa_center);
draw_set_valign(fa_top);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 4987145F
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "120"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Press 'SPACE' to upload score\n[Score will only be updated if it is higher than the previous score]""
draw_text(x + 0, y + 120, string("Press 'SPACE' to upload score\n[Score will only be updated if it is higher than the previous score]") + "");