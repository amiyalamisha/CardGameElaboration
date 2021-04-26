/// @description Insert description here
// You can write your code in this editor

// if player is allowed to choose a card, only let them choose the ones face up and dealt to them
if(global.current_phase == global.phase_player_chooses && faceUp && dealt){
	// check this card exists in the player's hand
	if(ds_list_find_index(obj_dealer.hand_player,id) >= 0){
		draw = false;
		
		if(!draw){
			movetoY = hover;	// 'maybe selected' position
		}
		
		// sets to the id of the instance
		global.selected_card = id;
	}
}

if(global.current_phase == global.phase_player_chooses && faceUp == false && dealt == false){
	if(ds_list_find_index(obj_dealer.deck,id) >= 0){
		// sets to the id of the instance
		global.selected_card = id;
		draw = true;
	}
}