''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Magical Girl Kasziula'

'Fastbasic does not have include directives, so 
'the build script will fake them by basically concatenating files'

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'Begin a simple snippet to try the battle system
'We enforce here to use an INT type and exclude invalid
'values since BASIC won't automatically check for type safety

DIM selection
selection = 0
DIM endbattle
endbattle = 0

WHILE selection < 1 OR selection > 4
    INPUT "SELECT FAMILIAR ID TO TEST, 1-4"; selection
    IF selection < 0 OR selection > 4 THEN PRINT "Invalid selection, try again"
WEND 
CLS
PRINT "You have selected the number", selection
?
CURRENT_FAM = selection

EXEC FAMILIAR_STRING CURRENT_FAM



INPUT ""; selection

WHILE endbattle = 1
    'Essentially, the battle loop goes here until endbattle is 1'

WEND
CLS

EXEC INIT_GRAPHICAL_BATTLE
EXEC COPY_MONSTER_DEST CURRENT_FAM, 10, 10
EXEC COPY_MONSTER_DEST_MIRROR_H 3, 240, 80

POSITION 10, 20
PRINT "FAMILIAR: "; Fbuffer$[1, 7]
POSITION 120, 20
PRINT "MOVE1: " ; Fbuffer$[15, 9]
INPUT ; TEST$

