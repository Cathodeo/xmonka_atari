''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Magical Girl Kasziula'

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

WHILE endbattle = 1
    'Essentially, the battle loop goes here until endbattle is 1'

WEND
CLS

EXEC INIT_GRAPHICAL_BATTLE
EXEC COPY_MONSTER_DEST CURRENT_FAM, 10, 10
EXEC COPY_MONSTER_DEST_MIRROR_H 3, 240, 80

POSITION 10, 20
exec PRINT_MOVE1_NAME
POSITION 0, 0
INPUT ""; PLACEHOLDER

