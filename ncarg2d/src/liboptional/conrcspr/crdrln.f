C
C       $Id: crdrln.f,v 1.4 2004-06-29 17:14:39 kennison Exp $
C                                                                      
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C This file is free software; you can redistribute it and/or modify
C it under the terms of the GNU General Public License as published
C by the Free Software Foundation; either version 2 of the License, or
C (at your option) any later version.
C
C This software is distributed in the hope that it will be useful, but
C WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
C General Public License for more details.
C
C You should have received a copy of the GNU General Public License
C along with this software; if not, write to the Free Software
C Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
C USA.
C
      SUBROUTINE CRDRLN (Z,L,MM,NN)
      SAVE
      DIMENSION       Z(L,NN)
C
C THIS ROUTINE TRACES A CONTOUR LINE WHEN GIVEN THE BEGINNING BY STLINE.
C TRANSFORMATIONS CAN BE ADDED BY DELETING THE STATEMENT FUNCTIONS FOR
C FX AND FY IN CRDRLN AND MINMAX AND ADDING EXTERNAL FUNCTIONS.
C X=1. AT Z(1,J), X=FLOAT(M) AT Z(M,J). X TAKES ON NON-INTEGER VALUES.
C Y=1. AT Z(I,1), Y=FLOAT(N) AT Z(I,N). Y TAKES ON NON-INTEGER VALUES.
C
      COMMON /CONRE2/ IX         ,IY         ,IDX        ,IDY        ,
     1                IS         ,ISS        ,NP         ,CV         ,
     2                INX(8)     ,INY(8)     ,IR(2000)   ,NR
      COMMON /CONRE1/ IOFFP      ,SPVAL      ,IHILO
      COMMON /CONRE3/ IXBITS     ,IYBITS
      LOGICAL         IPEN       ,IPENO
      DATA IPEN,IPENO/.TRUE.,.TRUE./
C
C     FX(X,Y) = X
C     FY(X,Y) = Y
      IXYPAK(IXX,IYY) = ISHIFT(IXX,IYBITS)+IYY
      CFCN(P1,P2) = (P1-CV)/(P1-P2)
C
      M = MM
      N = NN
      IF (IOFFP .EQ. 0) GO TO 101
      JUMP = 1
      GO TO 102
      JUMP = 2
  102 IX0 = IX
      IY0 = IY
      IS0 = IS
      IF (IOFFP .EQ. 0) GO TO 103
      IX2 = IX+INX(IS)
      IY2 = IY+INY(IS)
      IPEN = Z(IX,IY).NE.SPVAL .AND. Z(IX2,IY2).NE.SPVAL
      IPENO = IPEN
  103 IF (IDX .EQ. 0) GO TO 104
      Y = IY
      ISUB = IX+IDX
      X = CFCN(Z(IX,IY),Z(ISUB,IY))*FLOAT(IDX)+FLOAT(IX)
      GO TO 105
  104 X = IX
      ISUB = IY+IDY
      Y = CFCN(Z(IX,IY),Z(IX,ISUB))*FLOAT(IDY)+FLOAT(IY)
  105 CALL FRSTD (FX(X,Y),FY(X,Y))
  106 IS = IS+1
      IF (IS .GT. 8) IS = IS-8
      IDX = INX(IS)
      IDY = INY(IS)
      IX2 = IX+IDX
      IY2 = IY+IDY
      IF (ISS .NE. 0) GO TO 107
      IF (IX2.GT.M .OR. IY2.GT.N .OR. IX2.LT.1 .OR. IY2.LT.1) GO TO 119
  107 IF (CV-Z(IX2,IY2)) 108,108,109
  108 IS = IS+4
      IX = IX2
      IY = IY2
      GO TO 106
  109 IF (IS/2*2 .EQ. IS) GO TO 106
      GO TO (110,112) , JUMP
  110 ISBIG = IS+(8-IS)/6*8
      IX3 = IX+INX(ISBIG-1)
      IY3 = IY+INY(ISBIG-1)
      IX4 = IX+INX(ISBIG-2)
      IY4 = IY+INY(ISBIG-2)
      IPENO = IPEN
      IF (ISS .NE. 0) GO TO 111
      IF (IX3.GT.M .OR. IY3.GT.N .OR. IX3.LT.1 .OR. IY3.LT.1) GO TO 119
      IF (IX4.GT.M .OR. IY4.GT.N .OR. IX4.LT.1 .OR. IY4.LT.1) GO TO 119
  111 IPEN = Z(IX,IY).NE.SPVAL .AND. Z(IX2,IY2).NE.SPVAL .AND.
     1       Z(IX3,IY3).NE.SPVAL .AND. Z(IX4,IY4).NE.SPVAL
  112 IF (IDX .EQ. 0) GO TO 113
      Y = IY
      ISUB = IX+IDX
      X = CFCN(Z(IX,IY),Z(ISUB,IY))*FLOAT(IDX)+FLOAT(IX)
      GO TO 114
  113 X = IX
      ISUB = IY+IDY
      Y = CFCN(Z(IX,IY),Z(IX,ISUB))*FLOAT(IDY)+FLOAT(IY)
  114 GO TO (115,116) , JUMP
  115 IF (.NOT.IPEN) GO TO 117
      IF (IPENO) GO TO 1151
C
C END OF LINE SEGMENT
C
      CALL LASTD
      CALL FRSTD (FX(XOLD,YOLD),FY(XOLD,YOLD))
C
C CONTINUE LINE SEGMENT
 1151 CONTINUE
  116 CALL VECTD (FX(X,Y),FY(X,Y))
  117 XOLD = X
      YOLD = Y
      IF (IS .NE. 1) GO TO 118
      NP = NP+1
      IF (NP .GT. NR) GO TO 119
      IR(NP) = IXYPAK(IX,IY)
  118 IF (ISS .EQ. 0) GO TO 106
      IF (IX.NE.IX0 .OR. IY.NE.IY0 .OR. IS.NE.IS0) GO TO 106
C
C END OF LINE
C
  119 CALL LASTD
      RETURN
      END
