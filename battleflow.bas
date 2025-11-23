
PROC DEBUG_BATTLE selection


WHILE selection < 0 OR selection > 4
    INPUT "SELECT FAMILIAR ID TO TEST, 1-4"; selection
    IF selection < 0 OR selection > 4 THEN PRINT "Invalid selection, try again"
WEND 
CLS
PRINT "You have selected the number", selection
?
CURRENT_FAM = selection
FOE_FAM = (-dpeek($D20A)) / 64
exec INIT_NEW_FOE_FAMILIAR FOE_FAM
exec INIT_NEW_FAMILIAR CURRENT_FAM

PRINT "FOE_FAM: ", FOE_FAM 
PRINT "FOE_FAM_HP: ", CURRENT_FOE_FAMILIAR(1)

input ""; placeholder


CLS

ENDPROC


'Initialize the videomode for the turn based card battle'
PROC SWITCH_TO_BATTLE_UI

''Align display list to 1KB increments''
''The display list in Atari 8 bit is a way to mix resolution and graphic/text modes'

    'The 2 color, 320x192 videomode'
    graphics 8
    SETCOLOR 1, 13, 0
    SETCOLOR 2, 13, 6
    SETCOLOR -4, 4, 6 
    cursor = 0

ENDPROC


'provisional test version with only one
'choice until i implement equipables and boosters'
PROC SHOW_MOVE_LIST

    movechoice = 0
    WHILE movechoice < $31 or movechoice > $33
        CLS
        PRINT "Press 1 to use: "; FBuffer$[15, 10]
        'If there are no equiped items, no secondary available'
        IF CURRENT_FAMILIAR(5) = 0 THEN PRINT "No item equipped"
        PRINT "Press 3 to return"
        GET movechoice
        
    
        IF movechoice = $31 THEN EXEC ATTACK CURRENT_FAMILIAR(3)
        'UNAVAILABLE UNTIL IMPLEMENTATION: IF movechoice = 2 THEN EXEC ATTACK CURRENT_FAMILIAR(4)'
        'UNAVAILABLE UNTIL IMPLEMENTATION: IF movechoiCe = 3 THEN EXEC ATTACK GET_MOVE_FROM_ITEM(CURRENT_FAMILIAR(5))'
        IF movechoice = $33
        
            EXEC MOVE_CURSOR 0

        ENDIF
    WEND
    
    

ENDPROC

