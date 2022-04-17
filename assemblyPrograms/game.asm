section d
; Runtime vars (define before constants because they're used more so should be at start of memory)
i temp1
i temp2
i input
i frame_count 0
i enemy_move_counter 0
i playing 1
i died 0
i player_pos_x 30
i player_pos_y 30
i enemy_pos_x 5
i enemy_pos_y 5
i player_offset_x
i player_offset_y

; Constants
i false 0
i true 1
i half_max_int 128
i int_to_digit 48
i player_char 64 ; @ symbol
i enemy_char 88 ; capital X
s heading 11 Weird Game
s instructions 71 Use arrow keys to move around. Press q to quit. Press any key to start.
s lose_text 9 You died
s win_text 15 You won somehow
i enemy_move_interval 3
i quit_button 113 ; q
i left 17
i right 18
i up 19
i down 20
i reset_cursor 2

section t

; Introduction
; ------------
cls
outa heading
lbr
outa instructions
ich input

; Main loop
; ---------
luz playing
  ; Get input
  ; ---------
  ich input

  ; check quit button
  sub quit_button input
  ifz input
    zer playing
  eifz input
  add quit_button input

  ; check left arrow
  sub left input
  ifz input
    dec player_pos_x
  eifz input
  add left input
  
  ; check right arrow
  sub right input
  ifz input
    inc player_pos_x
  eifz input
  add right input

  ; check up arrow
  sub up input
  ifz input
    dec player_pos_y
  eifz input
  add up input

  ; check down arrow
  sub down input
  ifz input
    inc player_pos_y
  eifz input
  add down input

  ; Move Enemy
  ; ----------
  inc enemy_move_counter
  cpy enemy_move_counter temp1
  sub enemy_move_interval temp1
  ifz temp1
    zer enemy_move_counter
    inc enemy_pos_x
  eifz temp1

  ; Calculate player/enemy offset (used later) 
  ; ------------------------------------------
  cpy player_pos_x player_offset_x
  sub enemy_pos_x player_offset_x

  cpy player_pos_y player_offset_y
  sub enemy_pos_y player_offset_y

  ; Check enemy colliding with player
  ; ---------------------------------

  ifz player_offset_x
    ifz player_offset_y
      zer playing
      inc died
    eifz
  eifz

  cls

  ; Draw the player
  ; ---------------
  cpy player_pos_x temp1
  cpy player_pos_y temp2

  ; Go to correct column
  luz temp1
    dec temp1
    out right
  eluz temp1

  ; Go to correct row
  luz temp2
    dec temp2
    out down
  eluz temp2

  out player_char
  
  ; Draw the enemy
  ; ---------------
  cpy enemy_pos_x temp1
  cpy enemy_pos_y temp2

  out reset_cursor

  ; Go to correct column
  luz temp1
    dec temp1
    out right
  eluz temp1

  ; Go to correct row
  luz temp2
    dec temp2
    out down
  eluz temp2

  out enemy_char


  inc frame_count
eluz playing

; Print outcome
; -------------

cls

; won
ifz died
  outa win_text
eifz
; died
luz died
  outa lose_text
  zer died
eluz died

