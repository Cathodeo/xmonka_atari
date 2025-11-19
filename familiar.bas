'Familiars are the battling entities'
'Akin to monster cards in other exchangable monster card games'
'Each familiar has a definite level of healthpoints (4 to 16),
'a primary move, which can be further boosted by SPARKLE'


'Generic arrays that will contain every card property'
'For the purpose of this demo, only 4 familiars + a placeholder

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Structure of the F(amiliar)buffer, considering its 1-indexed:'

'1-7 positions: Ally familiar name'
'Empty'
'15-24 positions: Ally move1,
'25-34 positions: Ally move2,
'35-84 positions: Ally move1 Description,
'85-134 positions: Ally move2 Description '
'135-144 positions: Ally ability name, when applies'
'145-184 positions: Ally ability description'
'185-193 Positions: Ally type"                                                  "
'194-254 Positions : Boosted move tooltip'
'''''''''''''''''''''''''''''''''''''''''
'''Foe descriptions are not needed, as they
'''are only used to display a short move description'

'Familiar buffer'
FBuffer$="" 
'Copy buffer'
CBuffer$=""
'Ui messages buffer'
UIBuffer$=""




'Types: 1 Animal, 2 Robot, 3 Biohazard, 4 Radio 5 Mythical' 


'Familiar discrete healthpoints'
DIM F_HP(4)
'Familiar elemental type'
DIM F_TYPE(4)
'Familiar primary move - Boosted move is always primary + 1'
DIM F_MOVE(4)
'Familiar special ability - 0 means no additional ability'
DIM F_ABILITY(4)
'Cooldown to retire the card'
DIM F_COOLDOWN(4)

'Biona:'
    F_HP(0) = 6
    F_TYPE(0) = 3
    F_MOVE(0) = 1
    F_ABILITY(0) = 0
    F_COOLDOWN(0) = 1

'Marzena'
    F_HP(1) = 7
    F_TYPE(1) = 5
    F_MOVE(1) = 3
    F_ABILITY(1) = 1
    F_COOLDOWN(1) = 2 

'Ratdio'
    F_HP(2) = 4
    F_TYPE(2) = 4
    F_MOVE(2) = 6
    F_ABILITY(2) = 2 
    F_COOLDOWN(2) = 0

'Robert'
    F_HP(3) = 6
    F_TYPE(3) = 2
    F_MOVE(3) = 9
    F_ABILITY(3) = 0
    F_COOLDOWN(3) = 1
    
'Zubrix'
    F_HP(4) = 11
    F_TYPE(4) = 1
    F_MOVE(4) = 11
    F_ABILITY(4) = 0
    F_COOLDOWN(4) = 3



'Array to track the familiar in game'

    DIM CURRENT_FAMILIAR(9)

    '0 = SPECIES'
    '1 = CURRENT_HP'
    '2 = TYPE'
    '3 = MOVE1'
    '4 = MOVE1_BOOSTED'
    '5 = CURRENT_EQUIP'
    '6 = STATUS'
    '7 = CURRENT_COOLDOWN'
    '8 = ABILITY'


'Init a familiar'

PROC INIT_NEW_FAMILIAR SPECIES
    CURRENT_FAMILIAR(0) = SPECIES
    CURRENT_FAMILIAR(1) = F_HP(SPECIES)
    CURRENT_FAMILIAR(2) = F_TYPE(SPECIES)
    CURRENT_FAMILIAR(3) = F_MOVE(SPECIES)
    CURRENT_FAMILIAR(4) = F_MOVE(SPECIES) + 1
    CURRENT_FAMILIAR(5) = 0
    CURRENT_FAMILIAR(6) = 0
    CURRENT_FAMILIAR(7) = F_COOLDOWN(SPECIES)
    CURRENT_FAMILIAR(8) = F_ABILITY(SPECIES)
ENDPROC



PROC SECOND_MOVE_NAME
    CURRENT_EQUIP = CURRENT_FAMILIAR(5)
    IF CURRENT_EQUIP = 0
        FBuffer$=+"          "
    ENDIF
ENDPROC  


PROC SECOND_NAME_DESCRIPTION
    CURRENT_EQUIP = CURRENT_FAMILIAR(5)
    IF CURRENT_EQUIP = 0
        FBuffer$=+"                                                  "
    ENDIF
ENDPROC


PROC ABILITY_NAME
    CURRENT_ABILITY = CURRENT_FAMILIAR(8)
    IF CURRENT_ABILITY = 0
        FBuffer$=+"          "
    ELSE
        'Careful, nested if spaghetti'
        IF CURRENT_ABILITY = 1
             FBuffer$=+"SPRING END"
        ELSE
            FBuffer$=+"TAMPER FM "
        'ELSE should be replaced by elif when more than two abilities
        'are to be introduced'
        ENDIF

    ENDIF

ENDPROC


PROC ABILITY_DESCRIPTION
    CURRENT_ABILITY = CURRENT_FAMILIAR(8)
    IF CURRENT_ABILITY = 0
        FBuffer$="                                        "
    ELSE
        'Careful, nested if spaghetti'
        IF CURRENT_ABILITY = 1
             FBuffer$=+"DISCARD MARZENA AND DEAL DAMAGE = HER HP"
        ELSE
            FBuffer$=+"PASSIVE: THE FOE SWITCHES AT RANDOM NOW."
        'ELSE should be replaced by elif when more than two abilities
        'are to be introduced'
        ENDIF

    ENDIF

ENDPROC

'Display the current familiar in play'
'Painful to write as there is no CASE/SELECT statement in FastBasic'
'Ah, also, the String type uses 256 bytes, so we are using an array of BYTES'
PROC FAMILIAR_STRING CURRENT_FAM

    IF CURRENT_FAM = 0
        FBuffer$= "BIONA  "
        FBuffer$=+ "       "
        FBuffer$=+"PESTILENCE"
        EXEC SECOND_MOVE_NAME
        FBuffer$=+ "FLIP A COIN, IF HEADS, THE ENEMY IS NOW POISONED. "
        EXEC SECOND_NAME_DESCRIPTION
        EXEC ABILITY_NAME

    ELIF CURRENT_FAM = 1
        FBuffer$ = "MARZENA"
        FBuffer$=+ "       "
        Fbuffer$=+ "BLOSSOM   "
        EXEC SECOND_MOVE_NAME
        FBuffer$=+ "DRAW AN ADDITIONAL CARD. MARZENA SELF HEALS 1HP.  "
        EXEC SECOND_NAME_DESCRIPTION
        EXEC ABILITY_NAME
    ELIF CURRENT_FAM = 2
        FBuffer$ = "RATDIO "
        FBuffer$=+ "       "
        FBuffer$=+ "SINE WAVE "
        EXEC SECOND_MOVE_NAME
        FBuffer$=+ "EVERY SECOND TURN THE ATTACK DEALS DOUBLE DAMAGE. "
        EXEC SECOND_NAME_DESCRIPTION
        EXEC ABILITY_NAME
        
    ELIF CURRENT_FAM = 3
        FBuffer$ = "ROBERT "
        FBuffer$=+ "       "
        FBuffer$=+ "PISTOLET  "
        EXEC SECOND_MOVE_NAME
        FBuffer$=+ "3 COINS, EVERY SUCCESSFUL HEAD DOUBLES DAMAGE     ."
        EXEC SECOND_NAME_DESCRIPTION
        EXEC ABILITY_NAME

    ELIF CURRENT_FAM = 4
        FBuffer$ = "ZUBRIX "
        FBuffer$=+ "       "
        FBuffer$=+ "RAMPAGE   "
        EXEC SECOND_MOVE_NAME
        FBuffer$=+ "IF THE FOE IS HOLDING A BOOSTER, IT IS DISCARDED. "
        EXEC SECOND_NAME_DESCRIPTION
        EXEC ABILITY_NAME


    ENDIF   
ENDPROC



