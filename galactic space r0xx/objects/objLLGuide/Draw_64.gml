/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 79AC35DB
/// @DnDArgument : "halign" "fa_center"
/// @DnDArgument : "valign" "fa_middle"
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

/// @DnDAction : YoYo Games.Drawing.Set_Color
/// @DnDVersion : 1
/// @DnDHash : 71B8A443
draw_set_colour($FFFFFFFF & $ffffff);
var l71B8A443_0=($FFFFFFFF >> 24);
draw_set_alpha(l71B8A443_0 / $ff);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 3A35FB2B
/// @DnDArgument : "x" "room_width/2"
/// @DnDArgument : "y" "20"
/// @DnDArgument : "caption" ""
/// @DnDArgument : "var" ""Left mouse button to go forward, right mouse button to go backward""
draw_text(room_width/2, 20,  + string("Left mouse button to go forward, right mouse button to go backward"));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 3B0E9E3D
/// @DnDArgument : "x" "room_width/2"
/// @DnDArgument : "y" "40"
/// @DnDArgument : "caption" ""
/// @DnDArgument : "var" "string(image_index)+"/"+string(sprite_get_number(sprLLGuidePages)-1)"
draw_text(room_width/2, 40,  + string(string(image_index)+"/"+string(sprite_get_number(sprLLGuidePages)-1)));