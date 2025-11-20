''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Xmonka'

'Fastbasic does not have include directives, so 
'the build script will fake them by basically concatenating files'

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'Begin a simple snippet to try the battle system
'We enforce here to use an INT type and exclude invalid
'values since BASIC won't automatically check for type safety

DIM selection
selection = -1
DIM endbattle
endbattle = 0
cursor = 0

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



INPUT "", PLACEHOLDER

INPUT ""; selection


CLS



EXEC INIT_GRAPHICAL_BATTLE

EXEC DRAW_MAIN_UI
EXEC COPY_MONSTER_DEST CURRENT_FAM, 10, 10
EXEC COPY_MONSTER_DEST_MIRROR_H CURRENT_FOE_FAMILIAR(0), 240, 10

EXEC DRAW_INITIAL_HP




WHILE endbattle = 0
    'Essentially, the battle loop goes here until endbattle is 1'
    EXEC SHOWCURSOR cursor
    EXEC SET_UI_OPTION cursor
    PRINT ""; UIBuffer$
    ?

    'CURRENT_FAMILIAR(1) = CURRENT_FAMILIAR(1) - 1
    
    IF cursor < 3
    cursor = (cursor + 1) 
    else
    cursor = 0
    endif
    
    IF CURRENT_FAMILIAR(1) < 1 THEN endbattle = 1
    INPUT "", PLACEHOLDER
WEND

EXEC DRAW_MAX_HP_SELF CURRENT_FAMILIAR(1)
PRINT "Your monster: " ;
EXEC PRINT_FAMILIAR_NAME 
PRINT "has been defeated"
INPUT ""; PLACEHOLDER


