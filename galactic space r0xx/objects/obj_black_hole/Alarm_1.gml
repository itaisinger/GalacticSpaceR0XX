/// @description finish creation

state = BSTATES.natural;

alpha_dest = 1;
scale_dest = size;
instance_destroy(vfx[0]);
vfx[0] = create_effect(spr_black_hole_creation_3,10);
vfx[0].depth = -5;

pull_force_mult = -100;

//create over image
vfx[1] = create_effect(sprite_index);
vfx[1].loop = 1;
vfx[1].depth = DEPTH.black_hole_top;

