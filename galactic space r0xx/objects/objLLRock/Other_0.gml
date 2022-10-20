/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 32D58C3E
/// @DnDComment : Only wrap around on the left side of the screen
/// @DnDArgument : "var" "self.x"
/// @DnDArgument : "op" "1"
if(self.x < 0)
{
	/// @DnDAction : YoYo Games.Movement.Wrap_Room
	/// @DnDVersion : 1
	/// @DnDHash : 268B317B
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "ver" "0"
	move_wrap(1, 0, 0);

	/// @DnDAction : YoYo Games.Random.Get_Random_Number
	/// @DnDVersion : 1
	/// @DnDHash : 1BFBB599
	/// @DnDComment : Get a random position
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "var" "randomPos"
	/// @DnDArgument : "type" "1"
	/// @DnDArgument : "max" "320+(-1*global.bgHspeed*20)"
	randomPos = floor(random_range(0, 320+(-1*global.bgHspeed*20) + 1));

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 0BE32C66
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "expr" "randomPos"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "self.x"
	self.x += randomPos;

	/// @DnDAction : YoYo Games.Random.Get_Random_Number
	/// @DnDVersion : 1
	/// @DnDHash : 60567230
	/// @DnDComment : Random chance to spawn coins$(13_10)on top
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "var" "randomChanceToSpawnCoins"
	/// @DnDArgument : "type" "1"
	/// @DnDArgument : "max" "2"
	randomChanceToSpawnCoins = floor(random_range(0, 2 + 1));

	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7A27AC01
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "var" "randomChanceToSpawnCoins"
	/// @DnDArgument : "value" "1"
	if(randomChanceToSpawnCoins == 1)
	{
		/// @DnDAction : YoYo Games.Loops.For_Loop
		/// @DnDVersion : 1
		/// @DnDHash : 779E52D5
		/// @DnDParent : 7A27AC01
		/// @DnDArgument : "cond" "i < 3"
		for(i = 0; i < 3; i += 1) {
			/// @DnDAction : YoYo Games.Instances.Create_Instance
			/// @DnDVersion : 1
			/// @DnDHash : 13039830
			/// @DnDComment : Spawn 3 coins on top of the rock
			/// @DnDParent : 779E52D5
			/// @DnDArgument : "xpos" "self.x-32+(i*32)"
			/// @DnDArgument : "ypos" "280"
			/// @DnDArgument : "objectid" "objLLCoin"
			/// @DnDSaveInfo : "objectid" "objLLCoin"
			instance_create_layer(self.x-32+(i*32), 280, "Instances", objLLCoin);
		}
	}

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3282C458
	/// @DnDComment : Reset the rock so it can give score$(13_10)the next time it passes by
	/// @DnDParent : 32D58C3E
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "canGiveScore"
	canGiveScore = true;
}