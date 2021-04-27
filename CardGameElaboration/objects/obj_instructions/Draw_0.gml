draw_set_font(fnt_title);		// calling your new font
draw_set_color(c_white);

draw_set_halign(fa_center);		// centering text
draw_set_valign(fa_center);

draw_text(room_width/2, 50, "Instuctions");
draw_text(room_width/2, room_height-50, "Press SPACE to start");

draw_set_font(fnt_instructions);
draw_text(room_width/2, 300, "Match the right ingrediants with the meal!\nCollect the most cards to win!\n\n- Match the card color for the right ingrediant\n- Cards with a black boarder are 'finshing' cards,\nonly use to collect the center deck\n- If you don't have a matching color, click on the draw\ndeck to draw 1 card");