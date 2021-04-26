/// @description Insert description here
// You can write your code in this editor

// when faceUp reveal the type sprite of card
if(faceUp){
	// seting the types of each card to the correct sprite
	switch(color){
		case global.blue:
			switch(type){
				case global.vegtable: sprite_index = spr_tomato; break;
				case global.meat: sprite_index = spr_patty; break;
				case global.second_vegatable: sprite_index = spr_lettuce; break;
				case global.finishing_carbs: sprite_index = spr_bread; break;
			}
		break;
		
		case global.green:
			switch(type){
				case global.vegtable: sprite_index = spr_onion; break;
				case global.meat: sprite_index = spr_shrimp; break;
				case global.second_vegatable: sprite_index = spr_pepper; break;
				case global.finishing_carbs: sprite_index = spr_noodle; break;
			}
		break;
		
		case global.yellow:
			switch(type){
				case global.vegtable: sprite_index = spr_spinich; break;
				case global.meat: sprite_index = spr_meat; break;
				case global.second_vegatable: sprite_index = spr_beans; break;
				case global.finishing_carbs: sprite_index = spr_rice; break;
			}
		break;
	}
}
else{
	sprite_index = spr_back;		// else not faceUp show the back
}