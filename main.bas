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

WHILE selection < 0 OR selection > 4
    INPUT "SELECT FAMILIAR ID TO TEST, 1-4"; selection
    IF selection < 0 OR selection > 4 THEN PRINT "Invalid selection, try again"
WEND 
CLS
PRINT "You have selected the number", selection
?
CURRENT_FAM = selection

exec INIT_NEW_FAMILIAR CURRENT_FAM
exec FAMILIAR_STRING CURRENT_FAM

exec PRINT_FAMILIAR_NAME
exec PRINT_MOVE1_NAME
exec PRINT_MOVE1_DESCRIPTION
exec PRINT_ABILITY_NAME_
exec PRINT_ABILITY_DESCRIPTION

INPUT "", PLACEHOLDER

INPUT ""; selection


CLS

MAX_HP_SELF_FAMILIAR = F_HP(CURRENT_FAM)
CURRENT_HP_SELF_FAMILIAR = CURRENT_FAMILIAR(1)

EXEC INIT_GRAPHICAL_BATTLE




WHILE endbattle = 0
    'Essentially, the battle loop goes here until endbattle is 1'
    EXEC COPY_MONSTER_DEST CURRENT_FAM, 10, 10
    EXEC COPY_MONSTER_DEST_MIRROR_H 4, 240, 10
    EXEC DRAW_MAX_HP_SELF F_HP(CURRENT_FAM)
    EXEC DRAW_CURRENT_HP_SELF CURRENT_FAMILIAR(1)

    POSITION 10, 20
    exec PRINT_MOVE1_NAME
    POSITION 0, 0
    PRINT "Press any key to test damage"

    INPUT ""; PLACEHOLDER
    CURRENT_FAMILIAR(1) = CURRENT_FAMILIAR(1) - 1
    
    IF CURRENT_FAMILIAR(1) < 1 THEN endbattle = 1

WEND

EXEC DRAW_MAX_HP_SELF CURRENT_FAMILIAR(1)
PRINT "Your monster: " ;
EXEC PRINT_FAMILIAR_NAME 
PRINT "has been defeated"
INPUT ""; PLACEHOLDER


