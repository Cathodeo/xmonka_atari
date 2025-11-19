
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

FOR row = 0 TO 62

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

PROC DRAW_MAX_HP_SELF total

FOR heart = 0 to total - 1
    EXEC COPY_ICON 0,10 + (heart * 16),90
NEXT heart

ENDPROC

PROC DRAW_CURRENT_HP_SELF total

IF total > 0
FOR heart = 0 to total - 1
    EXEC COPY_ICON 1,10 + (heart * 16),90
NEXT heart
ENDIF

ENDPROC


