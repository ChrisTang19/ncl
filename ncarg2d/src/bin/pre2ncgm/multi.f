C
C	$Id: multi.f,v 1.3 2000-08-22 04:34:22 haley Exp $
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
      SUBROUTINE MULTI(IOS,STATUS)
C
C  PROCESS THE MULTIBYTE INSTRUCTIONS
C
C  OUTPUT
C       IOS-THE I/O STATUS VALID IF STATUS SET TO AN I/O ERROR
C       STATUS-THE ERROR STATUS DEFINED BY COMMON TREROR
C
      COMMON/TREROR/ ALLOK, MFRCHK, MTOPER, METRDC, REDERR, TYPCHG
     1             ,INVTYP, MINVLD, TYPERR, FRMEND, ENCINT, IVDCDT
     2             ,GCOERR, GCRERR, GCCERR, FCOERR, FCRERR, FCCERR
     3             ,PLIDXG, PMIDXG, TXIDXG, PGIDXG, INVLMT, CELERR
     4             ,COIERR, COLNRM, UNKNOW, UNKOPC, ENDMTF, VNEROR
     5             ,BADRSZ, DEVOUT, NOVERS, BADFNT, PGMERR, FASERR
     6             ,HINERR, VDWERR, RDWERR, RIXLIM
      INTEGER        ALLOK, MFRCHK, MTOPER, METRDC, REDERR, TYPCHG
     1             ,INVTYP, MINVLD, TYPERR, FRMEND, ENCINT, IVDCDT
     2             ,GCOERR, GCRERR, GCCERR, FCOERR, FCRERR, FCCERR
     3             ,PLIDXG, PMIDXG, TXIDXG, PGIDXG, INVLMT, CELERR
     4             ,COIERR, COLNRM, UNKNOW, UNKOPC, ENDMTF, VNEROR
     5             ,BADRSZ, DEVOUT, NOVERS, BADFNT, PGMERR, FASERR
     6             ,HINERR, VDWERR, RDWERR, RIXLIM
      COMMON/TRINOT/ IPTR, MBUFOT, MAXBYT, DEVUNT, METUNT,
     1          METIPT, ERRUNT, FNTUNT
      INTEGER MAXCNT
      PARAMETER (MAXCNT=200)
      INTEGER IPTR, MBUFOT(MAXCNT), MAXBYT, DEVUNT, METUNT, ERRUNT,
     1        FNTUNT
      LOGICAL METIPT
      COMMON /TRINST/ OPCL, OPID, LEN, CONT
      INTEGER OPCL, OPID, LEN
      LOGICAL CONT
      COMMON /TRMTYP/ FOURBT, MULTBT, TWOBT, PTSFLG, CURCOL, IPWRIT,
     1                IFRAME, ISETOP, IRANG, IPTS, ICAS, IINT, IORNT,
     2                ISIZE, IFONT, IPAT, ISSIZ, ICENT, ICOLR,
     3                MCENT, MSIZE, MOR, OLDX, OLDY, MCASE, MINTEN,
     4                MFONT, MDASH, MSPOT, MCOLOR, MLIMIT, PTSYM,
     5                SAVX, SAVY
      INTEGER FOURBT, MULTBT, TWOBT, PTSFLG, CURCOL, IPWRIT,
     1                IFRAME, ISETOP, IRANG, IPTS, ICAS, IINT, IORNT,
     2                ISIZE, IFONT, IPAT, ISSIZ, ICENT, ICOLR,
     3                MCENT, MSIZE, MOR, OLDX, OLDY, MCASE, MINTEN,
     4                MFONT, MDASH, MSPOT, MCOLOR(3), MLIMIT(4), PTSYM,
     5                SAVX, SAVY
C
      INTEGER IOS, STATUS
      INTEGER OPLN, CTLN
C
C  DEFINE THE OPCODE AND COUNT FIELD LENGTHS
C
      DATA OPLN,CTLN/6,8/
C
C  INITIALIZE THE ERROR STATUS
C
      STATUS = ALLOK
C
C  GET THE OPCODE, NO NEED FOR BUFFER ERROR TESTING
C  THE OPCODE AND COUNT ARE IN THE 16 BIT PACKET THAT IS STARTED
C
      CALL MNINST(OPLN,IOS,STATUS)
C
C  PARSE THE OPCODE
C
      IF (OPCL .EQ. IPWRIT) THEN
C
C       PWRIT OPCODE
C
        CALL PWT(IOS,STATUS)
C
      ELSE IF (OPCL .EQ. IFRAME) THEN
C
C       FRAME CALL RESET DEVICE TO DEFAULT
C
        CALL FRM(IOS,STATUS)
C
      ELSE IF (OPCL .EQ. ISETOP) THEN
C
C       OPTION SETTING INSTRUCTION
C
        CALL SETOP(IOS,STATUS)
C
      ELSE IF (OPCL .EQ. IRANG) THEN
C
C       RANGE INSTRUCTION
C
        CALL SETRNG(IOS,STATUS)
C
      ELSE IF (OPCL .EQ. IPTS) THEN
C
C       POINT SYMBOL MODE INSTRUCTION
C
        CALL PNT(IOS,STATUS)
C
      ELSE
C
C       UNKNOWN OPCODE SET ERROR MESSAGE
C
        WRITE(6,'('' Unknown opcode ='',I6)') OPCL
        CALL ALOVER(IOS,STATUS)
      END IF
C
      RETURN
      END
