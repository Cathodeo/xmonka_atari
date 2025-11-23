''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Xmonka'

'Fastbasic does not have include directives, so 
'the build script will fake them by basically concatenating files'

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'Begin a simple snippet to try the battle system
'We enforce here to use an INT type and exclude invalid
'values since BASIC won't automatically check for type safety

'Initial values'

selection = -1
endbattle = 0
cursor = 0


'Debug battle with a selected familiar
'and a random foe one (see battleflow.bas)

EXEC DEBUG_BATTLE selection

'Init graphical routines and change videomode'

EXEC SWITCH_TO_BATTLE_UI

'Draw both portraits, according to selection and random foe'

EXEC DRAW_FAMILIARS_UI

    EXEC MOVE_CURSOR cursor
    ?


WHILE endbattle = 0
    'Essentially, the battle loop goes here until endbattle is 1'

    
    'CURRENT_FAMILIAR(1) = CURRENT_FAMILIAR(1) - 1
    
    IF CURRENT_FAMILIAR(1) < 1 THEN endbattle = 1
    REPEAT
        REPEAT : UNTIL KEY()
        GET KEYPRESS
    UNTIL KEYPRESS = 155 OR KEYPRESS = 127
       
    IF KEYPRESS = 155 AND CURSOR = 1
        EXEC SHOW_MOVE_LIST
    ELIF KEYPRESS = 127
        EXEC MOVE_CURSOR cursor
        ?

    ENDIF

WEND

EXEC DRAW_MAX_HP_SELF CURRENT_FAMILIAR(1)
PRINT "Your monster: " ;
PRINT "has been defeated"
INPUT ""; PLACEHOLDER


