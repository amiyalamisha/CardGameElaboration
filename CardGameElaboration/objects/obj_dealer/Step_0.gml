randomize();		// makes each run different

show_debug_message(global.current_phase);

switch(global.current_phase){
	case global.phase_dealing:
	
		// when cards are being dealt into hands	
		if(timer_phase = 0){
			if(ds_list_size(hand_computer) < hand_size){	// deals to computer
				var card = deck[| ds_list_size(deck)-1];	// the card being taken out at the end of the deck
				
				// edits lists
				ds_list_delete(deck, ds_list_size(deck)-1);
				ds_list_add(hand_computer, card);
				
				// code to move card visually
				card.movetoX = computer_hand_X + hand_spacing * ds_list_size(hand_computer);
				card.movetoY = computer_hand_Y;
				audio_play_sound(snd_card_dealt, 0, 0);		// moving card sound
				
				card.dealt = true;
			}
			else if (ds_list_size(hand_player) < hand_size){	// deals to player
				var card = deck[| ds_list_size(deck) -1];
				
				ds_list_delete(deck, ds_list_size(deck)-1);
				ds_list_add(hand_player, card);
		
				// code to move card visually
				card.movetoX = player_hand_X + hand_spacing * ds_list_size(hand_player);	// adding x distance per hand
				card.movetoY = player_hand_Y;
				audio_play_sound(snd_card_dealt, 0, 0);
				
				card.dealt = true;
			}
			else{
				// sets the cards in player's hand to face up
				for(i = 0; i < hand_size; i++){
					hand_player[|i].faceUp = true;
				}
				global.current_phase = global.phase_computer_chooses;		// next phase
			}
		}
	
	break;
	
	case global.phase_computer_chooses:
	
		// when the computer is choosing a card
		timer_wait++;
		
		if(timer_wait == 40){								// delay before computer plays a card
			// chosing random card from computer's hand
			if(topCard == noone){
				do{
					playIndex = irandom_range(0, ds_list_size(hand_computer)-1);
				}until(hand_computer[| playIndex].type != global.finishing_carbs);	// dont wanna use a finish card
			}
			else{
				if(computer_draw_allowed){
					count = 0;
					for(i = 0; i < ds_list_size(hand_computer); i++){
						if(topCard.color == hand_computer[| i].color){
							playIndex = i;
							count++;
						}
					
						if(count > 0){
							computer_draw = false;
						}
						else{
							computer_draw = true;
						}
					}
				}
			}
			
			if(computer_draw && computer_draw_allowed){
				global.current_phase = global.phase_draw;
			}
			else{
				if(topCard != noone){
					count = 0;
					for(i = 0; i < ds_list_size(hand_computer); i++){
						if(topCard.color == hand_computer[| i].color){
							count++
						}
					}
				}
				
				if(count <= 0 && topCard != noone){
					player_draw_allowed = true;
					global.current_phase = global.phase_draw;
				}
				else if(playIndex != noone){
					playedcard_computer = hand_computer[| playIndex];
			
					// moving card foward
					playedcard_computer.movetoX = room_width/2;		// brings card to center
					playedcard_computer.movetoY = center_deck_Y;
					center_deck_Y += 2
			
					playedcard_computer.faceUp = true;
					ds_list_add(center_pile, playedcard_computer);
			
					audio_play_sound(snd_card_dealt, 0, 0);		// moving card sound
			
					ds_list_delete(hand_computer, playIndex);			// delete from computer's hand
					playIndex = noone;
				}
			}
		}
		
		// a little delay before letting player choose their card
		if(timer_wait == 60){
			timer_wait = 0;
			clickAllowed = true;
			
			if(playedcard_computer.type = global.finishing_carbs){
				global.current_phase = global.phase_result;
			}
			else if(!beginSetup){
				player_draw_allowed = true;
				global.current_phase = global.phase_draw;		// next phase
			}
			else{
				global.current_phase = global.phase_player_chooses;
			}
		}
		
	break;
	
	case global.phase_player_chooses:
	
		// player selecting a card
		
		timer_wait++;
		
		if(topCard != noone){
			for(i = 0; i < ds_list_size(hand_player); i++){
				if(topCard.color == hand_player[| i].color){
					clickAllowed = false;
					clicked = false;
				}
			}
		}
		
		if(mouse_check_button_pressed(mb_left)){
			if(clickAllowed && clicked){
				var card = deck[| ds_list_size(deck)-1];	// the card being taken out at the end of the deck
			
				// edits lists
				ds_list_delete(deck, ds_list_size(deck)-1);
				ds_list_add(hand_player, card);
				
				// code to move card visually
				card.movetoX = player_hand_X + hand_spacing * ds_list_size(hand_player);
				card.movetoY = player_hand_Y;
				audio_play_sound(snd_card_dealt, 0, 0);		// moving card sound
				
				card.dealt = true;
				card.faceUp = true;
				
				clickAllowed = false;
				
				if(topCard != noone && timer_wait > 60){
					count = 0;
					for(i = 0; i < ds_list_size(hand_player); i++){
						if(topCard.color == hand_player[| i].color){
							count++
						}
					}
					
					if(count <= 
					0){
						computer_draw_allowed = true;
						computer_draw = true;
						global.current_phase = global.phase_draw;
					}
					timer_wait = 0;
				}
			}
			else if(global.selected_card != noone){
				var select = ds_list_find_index(hand_player, global.selected_card);
				
				if(global.selected_card.color == topCard.color){
					playedcard_player = global.selected_card;
				
					playedcard_player.movetoX = room_width / 2;		// brings card to center
					playedcard_player.movetoY = center_deck_Y;
					center_deck_Y += 2
				
					audio_play_sound(snd_card_dealt, 0, 0);		// moving card sound
				
					ds_list_add(center_pile, playedcard_player);
					ds_list_delete(hand_player, select);		// delete from player's hand
				
					if(playedcard_player.type = global.finishing_carbs){
						global.current_phase = global.phase_result;		// next phase
					}
					else{
						computer_draw_allowed = true;
						computer_draw = true;
						global.current_phase = global.phase_draw;
					}
				
					beginSetup = false;
					global.selected_card = noone;		// reset's player's selected card variable
				}
			}
			timer_wait = 0;						// resets waiting timer
		}
	
	break;
	
	case global.phase_draw:
		
		timer_wait++;
		
		if(timer_wait == 40){
			show_debug_message(global.current_phase);
			if(computer_draw && computer_draw_allowed){
				var card = deck[| ds_list_size(deck)-1];	// the card being taken out at the end of the deck
				
				// edits lists
				ds_list_delete(deck, ds_list_size(deck)-1);
				ds_list_add(hand_computer, card);
				
				// code to move card visually
				for(i = 0; i < ds_list_size(hand_computer); i++){
					hand_computer[| i].movetoX = computer_hand_X + hand_spacing * (i + 1);
					hand_computer[| i].movetoY = computer_hand_Y;
					audio_play_sound(snd_card_dealt, 0, 0);
				}
				
				card.dealt = true;
			
				computer_draw = false;
				computer_draw_allowed = false;
				global.current_phase = global.phase_computer_chooses;
			}
			
			if(player_draw_allowed && !beginSetup){
				var card = deck[| ds_list_size(deck)-1];	// the card being taken out at the end of the deck
			
				// edits lists
				ds_list_delete(deck, ds_list_size(deck)-1);
				ds_list_add(hand_player, card);
			
				card.dealt = true;
				card.faceUp = true;
			
				// code to move card visually
				for(i = 0; i < ds_list_size(hand_player); i++){
					hand_player[| i].movetoX = player_hand_X + hand_spacing * (i + 1);
					hand_player[| i].movetoY = player_hand_Y;
					audio_play_sound(snd_card_dealt, 0, 0);		// moving card sound
				}
			
				player_draw_allowed = false;
				global.current_phase = global.phase_player_chooses;
			}
			timer_wait = 0;
		}
		
	break;
	
	case global.phase_result:
	
		// compare chosen cards
		
		timer_wait++;
		
		if(timer_wait > 100){
			// get results
			if(playedcard_computer.type == global.finishing_carbs){
				score_computer += ds_list_size(center_pile);
				audio_play_sound(snd_player_lose, 0, 0); // lose sound
				round_done = true;
			}
			else if(playedcard_player.type = global.finishing_carbs){
				score_player += ds_list_size(center_pile);
				audio_play_sound(snd_player_win, 0, 0); // win sound
				round_done = true;
			}
			
			if(round_done){
				rounds++;
				round_done = false;
			}
			
			timer_wait = 0;				// resets waiting timer
			global.current_phase = global.phase_discard;		// next phase
		}
	
	break;
	
	case global.phase_discard:
	
		// put cards in discard pile
		
		timer_wait++;
		
		// delay before discarding cards
		if(timer_phase == 0 && timer_wait > 60){
			if(playedcard_computer.type == global.finishing_carbs){
				if(ds_list_size(center_pile) > 0){
					var discard_card = center_pile[| ds_list_size(center_pile)-1];
				
					ds_list_add(computer_pile, discard_card);
					ds_list_delete(center_pile, ds_list_size(center_pile)-1);		// emptying hand
				
					// visually moves cards to discard pile
					discard_card.movetoX = discardX;
					discard_card.movetoY = discard_computer_Y;
					discard_computer_Y += 2;
				
					audio_play_sound(snd_card_dealt, 0, 0);
				}
				else{
					playedcard_computer = noone;
				}
			}
			else if(playedcard_player.type == global.finishing_carbs){
				if(ds_list_size(center_pile) > 0){
					var discard_card = center_pile[| ds_list_size(center_pile)-1];
				
					ds_list_add(player_pile, discard_card);
					ds_list_delete(center_pile, ds_list_size(center_pile)-1);		// emptying hand
				
					// visually moves cards to discard pile
					discard_card.movetoX = discardX;
					discard_card.movetoY = discard_player_Y;
					discard_player_Y += 2;
				
					audio_play_sound(snd_card_dealt, 0, 0);
				}
				else{
					playedcard_player = noone;
				}
			}
			timer_wait = 0;
		}
		
		if(timer_wait > 40){
			// end blah
		}
	
	
	break;
}	// end of switch

if(ds_list_empty(center_pile)){
	topCard = noone;
}
else{
	topCard = center_pile[| ds_list_size(center_pile)-1];
}

// trackings time between phases/moves
timer_phase++;
if (timer_phase == 16){
	timer_phase = 0;
}