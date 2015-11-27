;;============================================================================
;; File: software.psm
;; This is the PicoBlaze program for EE178 Lab #8.
;;============================================================================

;;============================================================================
;; Port address declarations.
;;============================================================================

CONSTANT stax            , 00 ; port for 8-bit start-x
CONSTANT stay            , 01 ; port for 8-bit start-y
CONSTANT endx            , 02 ; port for 8-bit end-x
CONSTANT endy            , 03 ; port for 8-bit end-y
CONSTANT busy            , 04 ; port for 8-bit busy
CONSTANT beam            , 05 ; port for 8-bit beam
CONSTANT mode            , 06 ; port for 8-bit mode
CONSTANT prng            , 07 ; port for 8-bit prng
CONSTANT leds_lo         , 08 ; port for 8-bit led data out
CONSTANT leds_hi         , 09 ; port for 8-bit led data out
CONSTANT qssd_lo         , 0a ; port for 8-bit qssd data out
CONSTANT qssd_hi         , 0b ; port for 8-bit qssd data out
CONSTANT qssd_dp         , 0c ; port for 8-bit qssd data out
CONSTANT switches_lo     , 0d ; port for 8-bit switch input
CONSTANT switches_hi     , 0e ; port for 8-bit switch input
CONSTANT buttons         , 0f ; port for 8-bit button input

CONSTANT zero            , 00 ; zero
CONSTANT one             , 01 ; one

CONSTANT busy_go         , 01 ; go command and busy status

CONSTANT beam_hi         , 0f ; beam high intensity
CONSTANT beam_md         , 07 ; beam med intensity
CONSTANT beam_lo         , 03 ; beam low intensity

CONSTANT mode_hld        , 00 ; mode hold framebuffer
CONSTANT mode_clr        , 01 ; mode clear framebuffer
CONSTANT mode_lin        , 02 ; mode linear decay
CONSTANT mode_exp        , 03 ; mode exponential decay

CONSTANT buttons_ct      , 10 ; center
CONSTANT buttons_up      , 08 ; up
CONSTANT buttons_dn      , 04 ; down
CONSTANT buttons_lf      , 02 ; left
CONSTANT buttons_rt      , 01 ; right

;;============================================================================
;; Boot.
;;============================================================================

         boot: LOAD s0, zero                       ; initialize
               LOAD s1, zero                       ; initialize
               LOAD s2, zero                       ; initialize
               LOAD s3, zero                       ; initialize
               LOAD s4, zero                       ; initialize
               LOAD sC, 80                         ; starting helicopter position
               LOAD sD, 05                         ; initialize (needed later)
               LOAD sE, FF                         ; load 255 into sE (horizontal coordinate of block)
               LOAD sF, 62                         ; load 108 into sF (vertical coordinate of block)
               LOAD s5, mode_exp                   ; load desired mode
               OUTPUT s5, mode                     ; set desired mode
               LOAD s5, beam_hi                    ; load desired beam
               OUTPUT s5, beam                     ; set desired beam
               ENABLE INTERRUPT                    ; enable interrupts

;;============================================================================
;; Main.
;;============================================================================

         main: INPUT s0, buttons                   ; get center button value
               INPUT s1, switches_hi               ; get hi switch values
               OUTPUT s0, leds_lo                  ; put lo led values
               ;OUTPUT s1, leds_hi                  ; put hi led values
               JUMP main                           ; go back and repeat

;;============================================================================
;; Interrupt - Service Routine.
;;============================================================================

          isr: INPUT s2, buttons                    ; get center button value
               INPUT s3, switches_hi               ; get hi switch values
               INPUT s4, buttons                   ; get button values
               OUTPUT s2, qssd_lo                  ; put lo qssd values
               OUTPUT s3, qssd_hi                  ; put hi qssd values
               OUTPUT s4, qssd_dp                  ; put dp qssd values
               ;OUTPUT s2, stax                     ; set desired stax
               ;OUTPUT s3, stay                     ; set desired stay
               ;INPUT s5, prng                      ; load random endx
               ;OUTPUT s5, endx                     ; set random endx
               ;INPUT s5, prng                      ; load random endy
               ;OUTPUT s5, endy                     ; set random endy
               CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)
               CALL play                           ; call play subroutine
               RETURNI ENABLE                      ; done with isr

;;============================================================================
;; Play - Play Subroutine
;;============================================================================

         play: INPUT s5, buttons                   ; get center button values
               CALL map                            ; draw the map using map subroutine

               INPUT s5, buttons                   ; get button values
               COMPARE s5, buttons_ct              ; check if center button is pressed
               CALL Z, move_heli_up                ; call subroutine that moves the helicopter up

               CALL draw_helicopter                ; draw the helicopter
               CALL random_block_location          ; determines a random place for the block (y direction only)
               CALL draw_block                     ; draw the block using draw_block subroutine
               SUB sE, 01;
               ADD sC, 01;
               RETURN                              ; finished with play subroutine

;;============================================================================
;; Map - Draw Map Subroutine
;;============================================================================

         map: LOAD s5, zero                       ; load zero into s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s5, 0F                         ; load 15 into s5
              OUTPUT s5, stay                     ; set desired stay
              LOAD s5, FF                         ; load 255 into s5
              OUTPUT s5, endx                     ; set desired endx
              LOAD s5, 0F                         ; load 15 into s5
              OUTPUT s5, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              LOAD s5, zero                       ; load zero into s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s5, F0                         ; load 240 into s5
              OUTPUT s5, stay                     ; set desired stay
              LOAD s5, FF                         ; load 255 into s5
              OUTPUT s5, endx                     ; set desired endx
              LOAD s5, F0                         ; load 240 into s5
              OUTPUT s5, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)
              RETURN                              ; finished with map subroutine

;;============================================================================
;; Draw Block - Draw Block Subroutine
;;============================================================================

  draw_helicopter: 

              CALL draw_helicopter_cockpit       ; call the subroutine to draw the cockpit
              CALL draw_helicopter_blades        ; call the subroutine to draw the blades
              CALL draw_helicopter_tail          ; call the subroutine to draw the tail

              RETURN                              ; go back from drawing helicopter


;;============================================================================
;; Draw Block - Draw Block Subroutine
;;============================================================================

  draw_block: 
              
              ;;============================================================================
              ;; Draws Top Line of Block 
              ;;============================================================================

              LOAD s5, sE                         ; load 255 into s5 (horizontal center of block)
              LOAD s6, E1                         ; load 245 into s6
              COMPARE s6, s5                      ; checking if the block is done "peaking out" from the right (initial compare: 245 ? 255)
              JUMP C, right_edge                  ; jump to right_edge
              LOAD s6, 0A                         ; load 10 into s6
              COMPARE s5, s6                      ; comparing s5 and s6
              JUMP C, left_edge                   ; jump to left_edge
              JUMP Z, left_edge                   ; jump to left_edge
              JUMP in_middle                      ; jump to in_middle

  right_edge: OUTPUT s5, stax                     ; set desired stax
              SUB s5, 0A;
              OUTPUT s5, endx                     ; set desired stax
              JUMP finished1                      ; jump to draw_ys

   left_edge: OUTPUT s5, stax                     ; set desired stax
              LOAD s6, 00                         ; put 255 into s5
              OUTPUT s6, endx                     ; set desired stax
              JUMP finished1                      ; jump to draw_ys

   in_middle: OUTPUT s5, stax                     ; set desired stax
              SUB s5, 0A                          ; subtract the width of block to get the other x coordinate
              OUTPUT s5, endx                     ; set desired endx

   finished1: OUTPUT sF, stay                     ; set desired stay
              OUTPUT sF, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Bottom Line of Block 
              ;;============================================================================

              LOAD s5, sF                         ; load sF into s5
              ADD s5, 3C                          ; add 40 to s5
              OUTPUT s5, stay                     ; set desired stay
              OUTPUT s5, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Right Vertical Line of Block 
              ;;============================================================================

              OUTPUT sE, stax                     ; set desired stax
              OUTPUT sE, endx                     ; set desired endx
              OUTPUT sF, stay                     ; set desired stay
              LOAD s5, sF                         ; load sF into s5
              ADD s5, 3C                          ; add 60 to y coordinate
              OUTPUT s5, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Left Vertical Line of Block 
              ;;============================================================================

              LOAD s5, sE                         ; load sE into s5
              SUB s5, 0A                          ; subtract 10 from s5
              OUTPUT s5, stax                     ; set desired stax
              OUTPUT s5, endx                     ; set desired endx
              OUTPUT sF, stay                     ; set desired stay
              LOAD s5, sF                         ; load sF into s5
              ADD s5, 3C                          ; add 60 to y coordinate
              OUTPUT s5, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)
              RETURN                              ; finished with draw_block subroutine



;;============================================================================
;; Random Block Location - Random Block Location Subroutine
;;============================================================================

random_block_location: 
               COMPARE sE, 00                      ; is it time to create a new variable?
               JUMP Z, new_random                  ; jump to new random creator
               JUMP NZ, skip_everything            ; goes back
skip_everything: RETURN                            ; returns back
  new_random: INPUT s5, prng                       ; create to new random number
               COMPARE s5, 0F                      ; check if it's in range
               JUMP NC, check_other_bound_range    ; check lower bound of map
               JUMP C, new_random                  ; get new variable
check_other_bound_range:
               COMPARE s5, B4                      ; compare s5 to 180
               JUMP NC, new_random                 ; get a new random number
               LOAD sF, s5                         ; a new y coordinate generated
               RETURN                              ; get out of subroutine
               
;;============================================================================
;; Move Helicopter Up - Move Helicopter Up Subroutine
;;============================================================================

move_heli_up:
               SUB sC, 02                          ; move the helicopter up
               RETURN                              ; get out of subroutine

;;============================================================================
;; Draw Helicopter Cockpit - Draw Helicopter Cockpit Subroutine
;;============================================================================

draw_helicopter_cockpit:

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 1a)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 01                          ; subtract 7 from s5
              OUTPUT s5, endx                     ; set desired endx
              SUB s6, 03                          ; go up by 5
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 1b)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 01                          ; subtract 7 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 03                          ; go up by 5
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 04                          ; subtract 7 from s5
              OUTPUT s5, endx                     ; set desired endx
              SUB s6, 02                          ; go up by 5
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)


              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 2a)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 01                          ; subtract 1 from s5
              OUTPUT s5, endx                     ; set desired endx
              ADD s6, 03                          ; go down by 3
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 2b)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 01                          ; subtract 1 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              ADD s6, 03                          ; go down by 3
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 04                          ; subtract 7 from s5
              OUTPUT s5, endx                     ; set desired endx
              ADD s6, 02                          ; go down by 5
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 3)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 05                          ; sub 5 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 05                          ; go up by 5 using subtraction
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 07                          ; subtract 5 from s5
              OUTPUT s5, endx                     ; set desired endx
              ADD s6, 05                          ; go down by 5
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 4)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 05                          ; sub 5 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              ADD s6, 05                          ; go down by 5 using addition
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 07                          ; subtract 5 from s5
              OUTPUT s5, endx                     ; set desired endx
              SUB s6, 05                          ; go back up by 5
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Cockpit of Helicopter (Line 5)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 01                          ; sub 1 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              ADD s6, 01                          ; go down by 5 using addition
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 04                          ; subtract 5 from s5
              OUTPUT s5, endx                     ; set desired endx
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)


              RETURN                              ; go back from subroutine

;;============================================================================
;; Draw Helicopter Tail - Draw Helicopter Tail Subroutine
;;============================================================================

draw_helicopter_tail:

              ;;============================================================================
              ;; Draws Tail of Helicopter (Line 1)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 0A                          ; subtract 0xA from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 02                          ; subtract 2 from s6
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 07                          ; subtract 7 from s5
              OUTPUT s5, endx                     ; set desired endx
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Tail of Helicopter (Line 2)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 0C                          ; subtract 0xC from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 08                          ; subtract 7 from s5
              OUTPUT s5, endx                     ; set desired endx
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Tail of Helicopter (Line 3)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 0A                          ; subtract 0x0A from s5
              SUB s5, 08                          ; subtract 0x10 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 02                          ; subtract 2 from s6
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 02                          ; subtract 2 from s5
              OUTPUT s5, endx                     ; set desired endx
              SUB s6, 02                          ; subtract 2 from s6
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Tail of Helicopter (Line 4)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 0C                          ; subtract 0x0C from s5
              SUB s5, 09                          ; subtract 0x09 from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              ;SUB s5, 01                          ; subtract 2 from s5
              OUTPUT s5, endx                     ; set desired endx
              ADD s6, 01                          ; add 1 to s6
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Tail of Helicopter (Line 5)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 0A                          ; subtract 0x0A from s5
              SUB s5, 0A                          ; subtract 0x0A from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 04                          ; subtract 4 from s6
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              OUTPUT s5, endx                     ; set desired endx
              ADD s6, 05                          ; add 1 to s6
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              RETURN                              ; go back from subroutine

;;============================================================================
;; Draw Helicopter Blades - Draw Helicopter Blades Subroutine
;;============================================================================

draw_helicopter_blades:

              ;;============================================================================
              ;; Draws Blades of Helicopter (Line 1)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              SUB s5, 05                          ; subtract 0xA from s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 05                          ; subtract 2 from s6
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              OUTPUT s5, endx                     ; set desired endx
              SUB s6, 02                          ; subtract 2 from s6
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              ;;============================================================================
              ;; Draws Blades of Helicopter (Line 2)
              ;;============================================================================

              ;; STARTING POINT
              LOAD s5, 64                         ; load 100 into s5
              OUTPUT s5, stax                     ; set desired stax
              LOAD s6, sC                         ; load sC into s5
              SUB s6, 07                          ; subtract 2 from s6
              OUTPUT s6, stay                     ; set desired stay

              ;; ENDING POINT
              SUB s5, 0A                          ; subtract 10 from s5
              OUTPUT s5, endx                     ; set desired endx
              OUTPUT s6, endy                     ; set desired endy
              CALL draw_line                      ; draws a line (careful: this subroutine overwrites s5)

              RETURN                              ; go back from subroutine


;;============================================================================
;; Draw Line - Draw Line Subroutine
;;============================================================================

   draw_line: LOAD s5, busy_go                    ; load go command
              OUTPUT s5, busy                     ; send go command
        wait: INPUT s5, busy                      ; read busy status
              COMPARE s5, busy_go                 ; check busy status
              JUMP Z, wait                        ; if busy, wait more
              RETURN                              ; leave line drawing subroutine


;;============================================================================
;; Interrupt - Vector.
;;============================================================================

               ADDRESS 7FF                         ; must be located here
   isr_vector: JUMP isr                            ; always jump to isr

;;============================================================================
;;
;;============================================================================
