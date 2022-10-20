/// @description Insert description here
// You can write your code in this editor
x += xmom;
y += ymom

xmom = approach(xmom,0.5*sign(xmom),fric);
ymom = approach(ymom,0.5*sign(ymom),fric);
spin_a = approach(spin_a,0.2*sign(spin_a),fric*1.5);

image_angle += spin_a;