C
C $Id: mpipan.f,v 1.4 1999-07-29 22:55:47 kennison Exp $
C
      INTEGER FUNCTION MPIPAN (IAIN,ANME)
C
        PARAMETER (MNAI=6000)
C
        CHARACTER*(*) ANME
C
C The value of MPIPAI (IAIN,ANME) is non-zero if and only if the area
C with area identifier IAIN is a part of some area having the name ANME.
C
        COMMON /MAPCMX/ IATY(MNAI),ISCI(MNAI),IPAR(MNAI)
        SAVE   /MAPCMX/
C
        COMMON /MAPCMY/ NAME(MNAI),FLNS
        CHARACTER*64    NAME,FLNS
        SAVE   /MAPCMY/
C
        MPIPAN=0
C
        IF (ANME.EQ.' ') RETURN
C
        ITMP=IAIN
        NSTP=0
C
  101   IF (ITMP.GE.1.AND.ITMP.LE.MNAI) THEN
          IF (NAME(ITMP).NE.ANME) THEN
            IF (IPAR(ITMP).NE.0.AND.NSTP.LT.10) THEN
              ITMP=IPAR(ITMP)
              NSTP=NSTP+1
              GO TO 101
            END IF
          ELSE
            MPIPAN=1
          END IF
        END IF
C
        RETURN
C
      END
