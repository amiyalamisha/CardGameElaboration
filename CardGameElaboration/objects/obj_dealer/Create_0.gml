//setting up an enumerator for our card types
global.vegtable = 0;
global.meat = 1;
global.second_vegatable = 2;
global.finishing_carbs = 3;

//enumerator for diff colors of cards
global.blue = 0;
global.green = 1;
global.yellow = 2;


//variables for the case numbers
global.phase_dealing = 0;
global.phase_computer_chooses = 1;
global.phase_player_chooses = 2;
global.phase_draw = 3;
global.phase_result = 4;
global.phase_discard = 5;

global.current_phase = global.phase_dealing;

global.selected_card = noone;	// variable to show which card mous is hovering over

// sizes
deck_size = 24;
hand_size = 4;

//timers
timer_phase = 0;
timer_wait = 0;

rounds = 0;
round_done = false;

score_player = 0;
score_computer = 0;

//chosen cards
playedcard_player = noone;
playedcard_computer = noone;

topCard = noone;
computer_draw = false;
player_draw_allowed = false;
computer_draw_allowed = false;

beginSetup = true;
clicked = false;
clickAllowed = true;

// all my lists
deck = ds_list_create();
hand_player = ds_list_create();
hand_computer = ds_list_create();
center_pile = ds_list_create();
computer_pile = ds_list_create();
player_pile = ds_list_create();

deckresetY = room_height/2 - 15;		// location for all the piles to start

// locaction where the draw deck should be
deckX = 70;
deckY = deckresetY;

center_deck_Y = room_height/2 - 2;

hand_spacing = 90;

computer_hand_X  = 30;
computer_hand_Y = 90;

player_hand_X  = computer_hand_X;
player_hand_Y = room_height - 90;

discardX = room_width - deckX;
discard_computer_Y = computer_hand_Y + 100;
discard_player_Y = player_hand_Y + 100;

//setup deck of cards, of size deck_size
colorCount = 0;
for(i = 0; i < deck_size; i++){
	var newcard = instance_create_layer(deckX, deckY, "Instances", obj_card); // puts new cards in room
	deckY += 2;			// creates stacking visuals
	
	// sets card vars
	newcard.dealt = false;
	newcard.faceUp = false;
	
	// sets what the cards are
	if(i < deck_size / 4){
		newcard.color = global.blue;
	}
	else if(i < (deck_size / 4) * 2){
		newcard.color = global.green;	
	}
	else{	
		newcard.color = global.yellow;	
	}
	
	colorCount = i % 4;
	
	switch(colorCount){
		case 0: newcard.type = global.finishing_carbs; break;
		case 1: newcard.type = global.vegtable; break;
		case 2: newcard.type = global.meat; break;
		case 3: newcard.type = global.second_vegatable; break;
	}
	
	//add the newcard to the deck list
	ds_list_add(deck, newcard);
}

//shuffling
ds_list_shuffle(deck);