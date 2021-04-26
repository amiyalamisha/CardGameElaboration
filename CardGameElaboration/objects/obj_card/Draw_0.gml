/// @description Insert description here
// You can write your code in this editor

draw_self();		// draw card

// move cards visually quickly
if (x != movetoX){
	x = lerp(x, movetoX, 0.2);	//move the card smoothly from x to new x 
}

if (y != movetoY){
	y = lerp(y, movetoY, 0.2);
}