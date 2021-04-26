/// @description Insert description here
// You can write your code in this editor

// when mouse does not touch previously selected card
if(global.selected_card == id){
	movetoY = obj_dealer.player_hand_Y;		// puts card back in original non-selected position
	
	// selected card is empty
	global.selected_card = noone;
}