/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 46CEF703
/// @DnDComment : Destroy self if outside room on left side
/// @DnDArgument : "var" "self.x"
/// @DnDArgument : "op" "1"
if(self.x < 0)
{
	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 1F621991
	/// @DnDParent : 46CEF703
	instance_destroy();
}