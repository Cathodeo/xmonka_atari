'Ui messages buffer'
UIBuffer$=""


'Copy a monster from the spritesheet into the left
'part of the screen (Own monster)

PROC COPY_MONSTER_DEST monster sx sy 

SCR = DPEEK(88)




FOR row = 0 TO 62
  src = ADR(mons1) + row*40 + monster*8
  dst = SCR + (sy + row)*40 + (sx/8)
  MOVE src, dst, 8
NEXT row

ENDPROC

'Copy the reverse sprite of a monster on the right
'side of the screen (Enemy)'

PROC COPY_MONSTER_DEST_MIRROR_H monster sx sy 

SCR = DPEEK(88)

FOR row = 1 TO 63

  ' read 8 bytes from the monster sheet
  src = ADR(mons1) + row*40 + monster*8

  ' reverse byte order AND bit order
  FOR col = 0 TO 7
    b = PEEK(src + col)
    b = bitrev(b)               ' reverse bits
    temp(7-col) = b             ' reverse byte order
  NEXT col

  ' draw mirrored row
  dst = SCR + (sy + row)*40 + (sx/8)
  MOVE ADR(temp), dst, 8

NEXT row

ENDPROC

'Copy 16x16 icons as needed for the battle UI'

PROC COPY_ICON id sx sy 

  SCR = DPEEK(88)

  FOR row = 0 TO 15
    src = ADR(icons1) + row*40 + id*2
    dst = SCR + (sy + row)*40 + (sx/8)
    MOVE src, dst, 2
  NEXT row

ENDPROC


PROC COPY_CURSOR id sx sy 

  SCR = DPEEK(88)

  FOR row = 0 TO 15
    src = ADR(arrow) + row*40 + id*2
    dst = SCR + (sy + row)*40 + (sx/8)
    MOVE src, dst, 2
  NEXT row

  ENDPROC



PROC WIPE_CURSOR id sx sy

  SCR = DPEEK(88)

  FOR row = 0 TO 16
    src = ADR(nullimg)
    dst = SCR + (sy + row)*40 + (sx/8)
    MOVE src, dst, 2
  NEXT row

ENDPROC

PROC DRAW_MAX_HP_SELF total

  FOR heart = 0 TO total - 1
      IF heart < 6
          EXEC COPY_ICON 0, 80 + (heart * 16), 10
      ELSE
          EXEC COPY_ICON 0, 80 + ((heart - 6) * 16), 26
      ENDIF
  NEXT heart

ENDPROC


PROC DRAW_CURRENT_HP_SELF total

  FOR heart = 0 TO total - 1
      IF heart < 6
          EXEC COPY_ICON 1, 80 + (heart * 16), 10
      ELSE
          EXEC COPY_ICON 1, 80 + ((heart - 6) * 16), 26
      ENDIF
  NEXT heart

ENDPROC


PROC DRAW_MAX_HP_FOE total

 FOR heart = 0 TO total - 1
      IF heart < 6
          EXEC COPY_ICON 0, 220 + (heart * 16), 80
      ELSE
          EXEC COPY_ICON 0, 220 + ((heart - 6) * 16), 96
      ENDIF
  NEXT heart
ENDPROC

PROC DRAW_CURRENT_HP_FOE total

 FOR heart = 0 TO total - 1
      IF heart < 6
          EXEC COPY_ICON 1, 220 + (heart * 16), 80
      ELSE
          EXEC COPY_ICON 1, 220 + ((heart - 6) * 16), 96
      ENDIF
  NEXT heart


ENDPROC

PROC DRAW_MAIN_UI
  'Fight option '
  EXEC COPY_ICON 10, 40, 76
  'Hand option'
  EXEC COPY_ICON 5, 40, 96
  'Switch option'
  EXEC COPY_ICON 3, 40, 116
  'Do nothing option'
  EXEC COPY_ICON 4, 40, 136

ENDPROC




'Show the arrow pointing to the current option'

PROC SHOWCURSOR option_no

    IF option_no > 0
        EXEC COPY_CURSOR 0, 16, 76 + (20 * option_no)
        EXEC WIPE_CURSOR 0, 16, 76 + (20 * (option_no - 1))
    ELSE
        EXEC COPY_CURSOR 0, 16, 76     
        EXEC WIPE_CURSOR 0, 16, 76 + (20 * 3)  
    ENDIF

ENDPROC

PROC SET_UI_OPTION option_no

    IF option_no = 0
      UIBuffer$="Fight"
    elif option_no = 1
      UIBuffer$="Hand"
    elif option_no = 2
      UIBuffer$="Change familiar"
    elif option_no = 3
      UIBuffer$="Skip turn"
    endif


ENDPROC


PROC REDRAW_SELF_HP
    EXEC DRAW_MAX_HP_SELF F_HP(CURRENT_FAMILIAR(0))
    EXEC DRAW_CURRENT_HP_SELF CURRENT_FAMILIAR(1)
ENDPROC

PROC REDRAW_FOE_HP
    EXEC DRAW_MAX_HP_FOE F_HP(CURRENT_FOE_FAMILIAR(0))
    EXEC DRAW_CURRENT_HP_FOE CURRENT_FOE_FAMILIAR(1)
ENDPROC


PROC DRAW_INITIAL_HP

    EXEC REDRAW_FOE_HP
    EXEC REDRAW_SELF_HP
    
ENDPROC