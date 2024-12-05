;***********************************************************
; Programming Assignment 4
; Student Name: 
; UT Eid:
; -------------------Save Simba (Part II)---------------------
; This is the starter code. You are given the main program
; and some declarations. The subroutines you are responsible for
; are given as empty stubs at the bottom. Follow the contract. 
; You are free to rearrange your subroutines if the need were to 
; arise.

;***********************************************************

.ORIG x4000

;***********************************************************
; Main Program
;***********************************************************
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_INITIAL
        TRAP  x22 
        LDI   R0,BLOCKS
        JSR   LOAD_JUNGLE
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_LOADED
        TRAP  x22                        ; output end message
HOMEBOUND
        LEA   R0, LC_OUT_STRING
        TRAP  x22
        LDI   R0,LC_LOC
        LD    R4,ASCII_OFFSET_POS
        ADD   R0, R0, R4
        TRAP  x21
        LEA   R0,PROMPT
        TRAP  x22
        TRAP  x20                        ; get a character from keyboard into R0
        TRAP  x21                        ; echo character entered
        LD    R3, ASCII_Q_COMPLEMENT     ; load the 2's complement of ASCII 'Q'
        ADD   R3, R0, R3                 ; compare the first character with 'Q'
        BRz   EXIT                       ; if input was 'Q', exit
;; call a converter to convert i,j,k,l to up(0) left(1),down(2),right(3) respectively
        JSR   IS_INPUT_VALID      
        ADD   R2, R2, #0                 ; R2 will be zero if the move was valid
        BRz   VALID_INPUT
        LEA   R0, INVALID_MOVE_STRING    ; if the input was invalid, output corresponding
        TRAP  x22                        ; message and go back to prompt
        BRnzp    HOMEBOUND
VALID_INPUT                 
        JSR   APPLY_MOVE                 ; apply the move (Input in R0)
        JSR   DISPLAY_JUNGLE
        JSR   SIMBA_STATUS      
        ADD   R2, R2, #0                 ; R2 will be zero if reached Home or -1 if Dead
        BRp  HOMEBOUND                     ; otherwise, loop back
EXIT   
        LEA   R0, GOODBYE_STRING
        TRAP  x22                        ; output a goodbye message
        TRAP  x25                        ; halt
JUNGLE_LOADED       .STRINGZ "\nJungle Loaded\n"
JUNGLE_INITIAL      .STRINGZ "\nJungle Initial\n"
ASCII_Q_COMPLEMENT  .FILL    x-71    ; two's complement of ASCII code for 'q'
ASCII_OFFSET_POS        .FILL    x30
LC_OUT_STRING    .STRINGZ "\n LIFE_COUNT is "
LC_LOC  .FILL LIFE_COUNT
PROMPT .STRINGZ "\nEnter Move up(i) \n left(j),down(k),right(l): "
INVALID_MOVE_STRING .STRINGZ "\nInvalid Input (ijkl)\n"
GOODBYE_STRING      .STRINGZ "\n!Goodbye!\n"
BLOCKS               .FILL x5500

;***********************************************************
; Global constants used in program
;***********************************************************
;***********************************************************
; This is the data structure for the Jungle grid
;***********************************************************
GRID .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
  
;***********************************************************
; this data stores the state of current position of Simba and his Home
;***********************************************************
CURRENT_ROW        .BLKW   #1       ; row position of Simba
CURRENT_COL        .BLKW   #1       ; col position of Simba 
HOME_ROW           .BLKW   #1       ; Home coordinates (row and col)
HOME_COL           .BLKW   #1
LIFE_COUNT         .FILL   #1       ; Initial Life Count is One
                                    ; Count increases when Simba
                                    ; meets a Friend; decreases
                                    ; when Simba meets a Hyena
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
; The code above is provided for you. 
; DO NOT MODIFY THE CODE ABOVE THIS LINE.
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************

;***********************************************************
; DISPLAY_JUNGLE
;   Displays the current state of the Jungle Grid 
;   This can be called initially to display the un-populated jungle
;   OR after populating it, to indicate where Simba is (*), any 
;   Friends (F) and Hyenas(#) are, and Simba's Home (H).
; Input: None
; Output: None
; Notes: The displayed grid must have the row and column numbers
;***********************************************************
DISPLAY_JUNGLE      
; Your Program 3 code goes here

    ST R0, DR0Store
    ST R1, DR1Store
    ST R2, DR2Store
    ST R3, DR3Store
    ST R4, DR4Store
    ST R5, DR5Store
    ST R6, DR6Store
    
    LEA R0, Columns
    TRAP x22
    LD R1, NUM
    LD R2, LOCO
    LD R4, ADDD
    LD R5, ADDER
    LD R6, SPACE
Loop   
    LD R0, SPACE
    TRAP x21
    TRAP x21
    AND R0, R0, #0
    ADD R0, R0, R2
    TRAP x22
    LD R0, NEXT
    TRAP x21
    AND R0, R0, #0
    ADD R0, R0, R1
    TRAP x21
    LD R0, SPACE
    TRAP x21
    ADD R2, R2, R5
    AND R0, R0, #0
    ADD R0, R0, R2
    TRAP x22
    LD R0, NEXT
    TRAP x21
    ADD R1, R1, #1
    ADD R2, R2, R5
    ADD R3, R1, R4
    BRn Loop
    LD R0, SPACE
    TRAP x21
    TRAP x21
    AND R0, R0, #0
    ADD R0, R0, R2
    TRAP x22
    LD R0, NEXT
    TRAP x21
    
    LD R0, DR0Store
    LD R1, DR1Store
    LD R2, DR2Store
    LD R3, DR3Store
    LD R4, DR4Store
    LD R5, DR5Store
    LD R6, DR6Store
    
    JMP R7

Columns
    .STRINGZ "\n   0 1 2 3 4 5 6 7 \n"
LOCO
    .FILL x40AB
NUM
    .FILL x30
NEXT
    .STRINGZ "\n"
ADDD
    .FILL #-56
ADDER
    .FILL #18
SPACE
    .FILL x20
DR0Store
    .BLKW #1
DR1Store
    .BLKW #1
DR2Store
    .BLKW #1
DR3Store
    .BLKW #1
DR4Store
    .BLKW #1
DR5Store
    .BLKW #1
DR6Store
    .BLKW #1
;***********************************************************
; LOAD_JUNGLE
; Input:  R0  has the address of the head of a linked list of
;         gridblock records. Each record has four fields:
;       0. Address of the next gridblock in the list
;       1. row # (0-7)
;       2. col # (0-7)
;       3. Symbol (can be I->Initial,H->Home, F->Friend or #->Hyena)
;    The list is guaranteed to: 
;               * have only one Inital and one Home gridblock
;               * have zero or more gridboxes with Hyenas/Friends
;               * be terminated by a gridblock whose next address 
;                 field is a zero
; Output: None
;   This function loads the JUNGLE from a linked list by inserting 
;   the appropriate characters in boxes (I(*),#,F,H)
;   You must also change the contents of these
;   locations: 
;        1.  (CURRENT_ROW, CURRENT_COL) to hold the (row, col) 
;            numbers of Simba's Initial gridblock
;        2.  (HOME_ROW, HOME_COL) to hold the (row, col) 
;            numbers of the Home gridblock
;       
;***********************************************************
LOAD_JUNGLE 
; Your Program 3 code goes here
    ST R0, LR0Store
    ST R1, LR1Store
    ST R2, LR2Store
    ST R3, LR3Store
    ST R4, LR4Store
    ST R5, LR5Store

Step0
    LD R3, LOCO
    ADD R3, R3, #9
    ADD R3, R3, #9
    LD R5, InitialCheck
    LDR R4, R0, #3
    ADD R4, R4, R5
    BRnp HomeChecker
    LDR R2, R0, #2
    LDR R1, R0, #1
    ST R2, CURRENT_COL
    ST R1, CURRENT_ROW
HomeChecker
    LD R5, HomeCheck
    LDR R4, R0, #3
    ADD R4, R4, R5
    BRnp Skipp
    LDR R2, R0, #2
    LDR R1, R0, #1
    ST R2, HOME_COL
    ST R1, HOME_ROW
Skipp
    LDR R2, R0, #2
    LDR R1, R0, #1
    BRz Step2
Step1
    ADD R3, R3, #9
    ADD R3, R3, #9
    ADD R3, R3, #9
    ADD R3, R3, #9
    ADD R1, R1, #-1
    BRp Step1
Step2
    ADD R3, R3, #1
    ADD R3, R3, R2
    ADD R3, R3, R2
    LDR R2, R0, #3
    STR R2, R3, #0
    LDR R0, R0, #0
    BRnp Step0

    LD R0, LR0Store
    LD R1, LR1Store
    LD R2, LR2Store
    LD R3, LR3Store
    LD R4, LR4Store
    LD R5, LR5Store
    
    JMP  R7

LR0Store
    .BLKW #1
LR1Store
    .BLKW #1
LR2Store
    .BLKW #1
LR3Store
    .BLKW #1
LR4Store
    .BLKW #1
LR5Store
    .BLKW #1
InitialCheck
    .FILL #-73
HomeCheck
    .FILL #-72

;***********************************************************
; GRID_ADDRESS
; Input:  R1 has the row number (0-7)
;         R2 has the column number (0-7)
; Output: R0 has the corresponding address of the space in the GRID
; Notes: This is a key routine.  It translates the (row, col) logical 
;        GRID coordinates of a gridblock to the physical address in 
;        the GRID memory.
;***********************************************************
GRID_ADDRESS     
; Your Program 3 code goes here

    ST R1, GR1Store
    ST R2, GR2Store
 
Step00
    LD R0, LOCO
    ADD R0, R0, #9
    ADD R0, R0, #9
    ADD R1, R1, #0
    BRz Step20
Step10
    ADD R0, R0, #9
    ADD R0, R0, #9
    ADD R0, R0, #9
    ADD R0, R0, #9
    ADD R1, R1, #-1
    BRp Step10
Step20
    ADD R0, R0, #1
    ADD R0, R0, R2
    ADD R0, R0, R2

    LD R1, GR1Store
    LD R2, GR2Store
    
    JMP R7

GR1Store
    .BLKW #1
GR2Store
    .BLKW #1
;***********************************************************
; IS_INPUT_VALID
; Input: R0 has the move (character i,j,k,l)
; Output:  R2  zero if valid; -1 if invalid
; Notes: Validates move to make sure it is one of i,j,k,l
;        Only checks if a valid character is entered
;***********************************************************

IS_INPUT_VALID
; Your New (Program4) code goes here
    ST R0, IR0Store
    ST R1, IR1Store
    ST R3, IR3Store
    LD R3, ValidCheckerNum
    AND R2, R2, #0
    AND R1, R1, #0
    ADD R1, R1, R0
    ADD R1, R1, R3
    BRz YesValid
    ADD R3, R3, #-1
    AND R1, R1, #0
    ADD R1, R1, R0
    ADD R1, R1, R3
    BRz YesValid
    ADD R3, R3, #-1
    AND R1, R1, #0
    ADD R1, R1, R0
    ADD R1, R1, R3
    BRz YesValid
    ADD R3, R3, #-1
    AND R1, R1, #0
    ADD R1, R1, R0
    ADD R1, R1, R3
    BRz YesValid
    ADD R2, R2, #-1
YesValid
    LD R0, IR0Store
    LD R1, IR1Store
    LD R3, IR3Store
    
    JMP R7
ValidCheckerNum
    .FILL #-105
IR0Store
    .BLKW #1
IR1Store
    .BLKW #1
IR3Store
    .BLKW #1
;***********************************************************
; CAN_MOVE
; This subroutine checks if a move can be made and returns 
; the new position where Simba would go to if the move is made. 
; To be able to make a move is to ensure that movement 
; does not take Simba off the grid; this can happen in any direction.
; In coding this routine you will need to translate a move to 
; coordinates (row and column). 
; Your APPLY_MOVE subroutine calls this subroutine to check 
; whether a move can be made before applying it to the GRID.
; Inputs: R0 - a move represented by 'i', 'j', 'k', or 'l'
; Outputs: R1, R2 - the new row and new col, respectively 
;              if the move is possible; 
;          if the move cannot be made (outside the GRID), 
;              R1 = -1 and R2 is untouched.
; Note: This subroutine does not check if the input (R0) is valid. 
;       You will implement this functionality in IS_INPUT_VALID. 
;       Also, this routine does not make any updates to the GRID 
;       or Simba's position, as that is the job of the APPLY_MOVE function.
;***********************************************************

CAN_MOVE      
; Your New (Program4) code goes here
    ST R0, CStoreR0
    ST R2, CStoreR2
    ST R3, CStoreR3
    ST R4, CStoreR4
    LD R1, CURRENT_ROW
    LD R2, CURRENT_COL
    LD R3, ValidCheckerNum
    AND R4, R4, #0
    ADD R4, R4, R0
    ADD R4, R4, R3
    BRnp jChecker
    ADD R1, R1, #-1
    BR CanMoveDone
jChecker
    AND R4, R4, #0
    ADD R4, R4, R0
    ADD R3, R3, #-1
    ADD R4, R4, R3
    BRnp kChecker
    ADD R2, R2, #-1
    BR CanMoveDone
kChecker
    AND R4, R4, #0
    ADD R4, R4, R0
    ADD R3, R3, #-1
    ADD R4, R4, R3
    BRnp lChecker
    ADD R1, R1, #1
    BR CanMoveDone
lChecker
    AND R4, R4, #0
    ADD R4, R4, R0
    ADD R3, R3, #-1
    ADD R4, R4, R3
    BRnp CanMoveDone
    ADD R2, R2, #1
CanMoveDone
    ADD R1, R1, #0
    BRn CanNotMove
    ADD R2, R2, #0
    BRn CanNotMove
    AND R4, R4, #0
    ADD R4, R4, R1
    ADD R4, R4, #-7
    BRp CanNotMove
    AND R4, R4, #0
    ADD R4, R4, R2
    ADD R4, R4, #-7
    BRp CanNotMove
    BR CanMoveIsFinished
CanNotMove
    AND R1, R1, #0
    ADD R1, R1, #-1
    LD R2, CStoreR2
CanMoveIsFinished
    LD R0, CStoreR0
    LD R3, CStoreR3
    LD R4, CStoreR4
    JMP R7
CStoreR0
    .BLKW #1
CStoreR2
    .BLKW #1
CStoreR3
    .BLKW #1
CStoreR4
    .BLKW #1
;***********************************************************
; APPLY_MOVE
; This subroutine makes the move if it can be completed. 
; It checks to see if the movement is possible by calling 
; CAN_MOVE which returns the coordinates of where the move 
; takes Simba (or -1 if movement is not possible as detailed above). 
; If the move is possible then this routine moves Simba
; symbol (*) to the new coordinates and clears any walls (|'s and -'s) 
; as necessary for the movement to take place. 
; In addition,
;   If the movement is off the grid - Output "Cannot Move" to Console
;   If the move is to a Friend's location then you increment the
;     LIFE_COUNT variable; 
;   If the move is to a Hyena's location then you decrement the
;     LIFE_COUNT variable; IF this decrement causes LIFE_COUNT
;     to become Zero then Simba's Symbol changes to X (dead)
; Input:  
;         R0 has move (i or j or k or l)
; Output: None; However yous must update the GRID and 
;               change CURRENT_ROW and CURRENT_COL 
;               if move can be successfully applied.
;               appropriate messages are output to the console 
; Notes:  Calls CAN_MOVE and GRID_ADDRESS
;***********************************************************

APPLY_MOVE   
; Your New (Program4) code goes here
    ST R0, AStoreR0
    ST R1, AStoreR1
    ST R2, AStoreR2
    ST R3, AStoreR3
    ST R4, AStoreR4
    ST R5, AStoreR5
    ST R6, AStoreR6
    ST R7, AStoreR7
    
    ADD R6, R0, #0
    
    LD R1, CurrentRow
    LD R2, CurrentCol
    LDR R1, R1, #0
    LDR R2, R2, #0
    JSR GRID_ADDRESS
    ADD R5, R0, #0
    
    ADD R0, R6, #0
    
    JSR CAN_MOVE
    ADD R1, R1, #0
    BRn ItsOver
    LD R3, CurrentRow
    LD R4, CurrentCol
    STR R1, R3, #0
    STR R2, R4, #0
    JSR GRID_ADDRESS
    
    LD R3, HyenaChecker
    LDR R4, R0, #0
    ADD R4, R4, R3
    BRnp AFriendChecker
    LD R4, LifeCount
    LDR R4, R4, #0
    ADD R4, R4, #-1
    LD R3, LifeCount
    STR R4, R3, #0
    ADD R4, R4, #0
    BRp AFriendChecker
    LD R3, DeadSymbol
    STR R3, R0, #0
    BR SecondWaitUp
AFriendChecker
    LD R3, FriendChecker
    LDR R4, R0, #0
    ADD R4, R4, R3
    BRnp WaitUp
    LD R4, LifeCount
    LDR R4, R4, #0
    ADD R4, R4, #1
    LD R3, LifeCount
    STR R4, R3, #0
WaitUp
    LD R3, SimbaCharacter
    STR R3, R0, #0
SecondWaitUp
    LD R4, SPACE
    STR R4, R5, #0
    LD R1, ValidCheckerNum
    ADD R3, R6, #0
    ADD R3, R3, R1
    BRnp AjChecker
    STR R4, R0, #18
AjChecker
    LD R1, ValidCheckerNum
    ADD R1, R1, #-1
    ADD R3, R6, #0
    ADD R3, R3, R1
    BRnp AkChecker
    STR R4, R0, #1
AkChecker
    LD R1, ValidCheckerNum
    ADD R1, R1, #-2
    ADD R3, R6, #0
    ADD R3, R3, R1
    BRnp AlChecker
    STR R4, R0, #-18
Alchecker
    LD R1, ValidCheckerNum
    ADD R1, R1, #-3
    ADD R3, R6, #0
    ADD R3, R3, R1
    BRnp WrapItUp
    STR R4, R0, #-1
ItsOver
    LEA R0, StringToOutput
    TRAP x22
WrapItUp
    LD R0, AStoreR0
    LD R1, AStoreR1
    LD R2, AStoreR2
    LD R3, AStoreR3
    LD R4, AStoreR4
    LD R5, AStoreR5
    LD R6, AStoreR6
    LD R7, AStoreR7
    JMP R7
StringToOutput
    .STRINGZ "\nCannot Move\n"
SimbaCharacter
    .FILL #42
HyenaChecker
    .FILL #-35
FriendChecker
    .FILL #-70
LifeCount
    .FILL x41E1
CurrentRow
    .FILL x41DD
CurrentCol
    .FILL x41DE
DeadSymbol
    .FILL #88
AStoreR0
    .BLKW #1
AStoreR1
    .BLKW #1
AStoreR2
    .BLKW #1
AStoreR3
    .BLKW #1
AStoreR4
    .BLKW #1
AStoreR5
    .BLKW #1
AStoreR6
    .BLKW #1
AStoreR7
    .BLKW #1
;***********************************************************
; SIMBA_STATUS
; Checks to see if the Simba has reached Home; Dead or still
; Alive
; Input:  None
; Output: R2 is ZERO if Simba is Home; Also Output "Simba is Home"
;         R2 is +1 if Simba is Alive but not home yet
;         R2 is -1 if Simba is Dead (i.e., LIFE_COUNT =0); Also Output"Simba is Dead"
; 
;***********************************************************

SIMBA_STATUS    
    ; Your code goes here
    ST R0, SStoreR0
    ST R1, SStoreR1
    ST R3, SStoreR3
    ST R7, SStoreR7
    LD R1, HomeRow
    LD R2, HomeCol
    LDR R1, R1, #0
    LDR R2, R2, #0
    JSR GRID_ADDRESS
    ADD R3, R0, #0
    LD R1, CurrentRow
    LD R2, CurrentCol
    LDR R1, R1, #0
    LDR R2, R2, #0
    JSR GRID_ADDRESS
    NOT R3, R3
    ADD R3, R3, #1
    ADD R0, R0, R3
    BRnp NotAtHome
    AND R2, R2, #0
    LEA R0, FinshedString
    TRAP x22
    BR WeAreFinallyDone
NotAtHome
    LD R0, LifeCount
    LDR R0, R0, #0
    BRp WeStillAlive
    AND R2, R2, #0
    ADD R2, R2, #-1
    LEA R0, DeadString
    TRAP x22
    BR WeAreFinallyDone
WeStillAlive
    AND R2, R2, #0
    ADD R2, R2, #1
WeAreFinallyDone
    LD R0, SStoreR0
    LD R1, SStoreR1
    LD R3, SStoreR3
    LD R7, SStoreR7
    JMP R7
HomeRow
    .FILL x41DF
HomeCol
    .FILL x41E0
SStoreR7
    .BLKW #1
SStoreR0
    .BLKW #1
SStoreR1
    .BLKW #1
SStoreR3
    .BLKW #1
FinshedString
    .STRINGZ "\nSimba is Home"
DeadString
    .STRINGZ "\nSimba is Dead"
    .END

; This section has the linked list for the
; Jungle's layout: #(0,1)->H(4,7)->I(2,1)->#(1,1)->#(6,3)->F(3,5)->F(4,4)->#(5,6)
	.ORIG	x5500
	.FILL	Head   ; Holds the address of the first record in the linked-list (Head)
blk2
	.FILL   blk4
	.FILL   #1
    .FILL   #1
	.FILL   x23

Head
	.FILL	blk1
    .FILL   #0
	.FILL   #1
	.FILL   x23

blk1
	.FILL   blk3
	.FILL   #4
	.FILL   #7
	.FILL   x48

blk3
	.FILL   blk2
	.FILL   #2
	.FILL   #1
	.FILL   x49

blk4
	.FILL   blk5
	.FILL   #6
	.FILL   #3
	.FILL   x23

blk7
	.FILL   #0
	.FILL   #5
	.FILL   #6
	.FILL   x23
blk6
	.FILL   blk7
	.FILL   #4
	.FILL   #4
	.FILL   x46
blk5
	.FILL   blk6
	.FILL   #3
	.FILL   #5
	.FILL   x46
	.END
