C
C $Id: cpsetc.f,v 1.10 2002-01-29 22:48:42 kennison Exp $
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
      SUBROUTINE CPSETC (WHCH,CVAL)
C
      CHARACTER*(*) WHCH,CVAL
C
C This subroutine is called to give a specified character value to a
C specified parameter.
C
C WHCH is the name of the parameter whose value is to be set.
C
C CVAL is a character variable containing the new value of the
C parameter.
C
C
C Declare all of the CONPACK common blocks.
C
C
C CPCOM1 contains integer and real variables.
C
      COMMON /CPCOM1/ ANCF,ANHL,ANIL,ANLL,CDMX,CHWM,CINS,CINT(10)
      COMMON /CPCOM1/ CINU,CLDB(256),CLDL(256),CLDR(256)
      COMMON /CPCOM1/ CLDT(256),CLEV(256),CLWA(259),CXCF
      COMMON /CPCOM1/ CXIL,CYCF,CYIL,DBLF,DBLM,DBLN,DBLV,DFLD,DOPT
      COMMON /CPCOM1/ EPSI,FNCM,GRAV,GRSD,GSDM,HCHL,HCHS,IAIA(259)
      COMMON /CPCOM1/ IAIB(256),IBCF,IBHL,IBIL,IBLL,ICAF,ICCF
      COMMON /CPCOM1/ ICCL(259),ICFF,ICHI,ICHL,ICIL,ICLL(256)
      COMMON /CPCOM1/ ICLO,ICLP(256),ICLS,ICLU(259),ICLV,ICLW
      COMMON /CPCOM1/ IDUF,IGCL,IGLB,IGRM,IGRN,IGVS,IHCF,IHLE,IHLX
      COMMON /CPCOM1/ IHLY,IIWS(2),IIWU,ILBC,IMPF,INCX(8),INCY(8)
      COMMON /CPCOM1/ INHL,INIL,INIT,INLL,IOCF,IOHL,IOLL,IPAI,IPCF
      COMMON /CPCOM1/ IPIC,IPIE,IPIL,IPLL,IRWS(4),IRWU,ISET,IWSO
      COMMON /CPCOM1/ IZD1,IZDM,IZDN,IZDS,JODP,JOMA,JOTZ,LCTM,LEA1
      COMMON /CPCOM1/ LEA2,LEA3,LEE1,LEE2,LEE3,LINS,LINT(10),LINU
      COMMON /CPCOM1/ LIWK,LIWM,LIWS(2),LNLG,LRWC,LRWG,LRWK
      COMMON /CPCOM1/ LRWM,LRWS(4),LSDD,LSDL,LSDM,LTCF,LTHI
      COMMON /CPCOM1/ LTIL,LTLO,MIRO,NCLB(256),NCLV,NDGL,NEXL
      COMMON /CPCOM1/ NEXT,NEXU,NLBS,NLSD,NLZF,NOMF,NOVS,NR04,NSDL
      COMMON /CPCOM1/ NSDR,OORV,PITH,SCFS,SCFU,SEGL,SVAL,T2DS,T3DS
      COMMON /CPCOM1/ UCMN,UCMX,UVPB,UVPL,UVPR,UVPS,UVPT,UWDB,UWDL
      COMMON /CPCOM1/ UWDR,UWDT,UXA1,UXAM,UYA1,UYAN,WCCF,WCHL,WCIL
      COMMON /CPCOM1/ WCLL,WLCF,WLHL,WLIL,WLLL,WOCH,WODA,WTCD,WTGR
      COMMON /CPCOM1/ WTNC,WTOD,WWCF,WWHL,WWIL,WWLL,XAT1,XATM,XLBC
      COMMON /CPCOM1/ XVPL,XVPR,XWDL,XWDR,YAT1,YATN,YLBC,YVPB,YVPT
      COMMON /CPCOM1/ YWDB,YWDT,ZDVL,ZMAX,ZMIN
      EQUIVALENCE (IIWS(1),II01),(LIWS(1),LI01)
      EQUIVALENCE (IIWS(2),II02),(LIWS(2),LI02)
      EQUIVALENCE (IRWS(1),IR01),(LRWS(1),LR01)
      EQUIVALENCE (IRWS(2),IR02),(LRWS(2),LR02)
      EQUIVALENCE (IRWS(3),IR03),(LRWS(3),LR03)
      EQUIVALENCE (IRWS(4),IR04),(LRWS(4),LR04)
      SAVE   /CPCOM1/
C
C CPCOM2 holds character parameters.
C
      COMMON /CPCOM2/ CHEX,CLBL(256),CLDP(259),CTMA,CTMB,FRMT
      COMMON /CPCOM2/ TXCF,TXHI,TXIL,TXLO
      CHARACTER*13 CHEX
      CHARACTER*64 CLBL
      CHARACTER*128 CLDP
      CHARACTER*500 CTMA,CTMB
      CHARACTER*8 FRMT
      CHARACTER*64 TXCF
      CHARACTER*32 TXHI
      CHARACTER*128 TXIL
      CHARACTER*32 TXLO
      SAVE   /CPCOM2/
C
C Check for an uncleared prior error.
C
      IF (ICFELL('CPSETC - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
C Check for a parameter name that is too short.
C
      IF (LEN(WHCH).LT.3) THEN
        CTMB(1:36)='CPSETC - PARAMETER NAME TOO SHORT - '
        CTMB(37:36+LEN(WHCH))=WHCH
        CALL SETER (CTMB(1:36+LEN(WHCH)),2,1)
        RETURN
      END IF
C
C Check for incorrect use of the index parameter.
C
      IF (WHCH(1:3).EQ.'CLD'.OR.WHCH(1:3).EQ.'cld') THEN
        IF (IPAI.GE.1.AND.IPAI.LE.NCLV) THEN
          JPAI=IPAI
        ELSE IF (IPAI.LE.-1.AND.IPAI.GE.-3) THEN
          JPAI=256+ABS(IPAI)
        ELSE
          GO TO 10002
        END IF
      ELSE IF (WHCH(1:3).EQ.'LLT'.OR.WHCH(1:3).EQ.'llt') THEN
        IF (IPAI.LT.1.OR.IPAI.GT.NCLV) THEN
          GO TO 10002
        END IF
      END IF
C
      GO TO 10004
10002 CONTINUE
        CTMB(1:36)='CPSETC - SETTING XXX - PAI INCORRECT'
        CTMB(18:20)=WHCH(1:3)
        CALL SETER (CTMB(1:36),3,1)
        RETURN
10004 CONTINUE
C
C Compute the length of CVAL, excluding blanks.
C
      LCVL=1
C
      DO 10005 I=1,MAX(1,LEN(CVAL))
        IF (CVAL(I:I).NE.' ') LCVL=I
10005 CONTINUE
C
C Set the proper parameter.
C
      IF (WHCH(1:3).EQ.'CFT'.OR.WHCH(1:3).EQ.'cft') THEN
        TXCF=CVAL
        LTCF=MAX(1,MIN(40,LCVL))
      ELSE IF (WHCH(1:3).EQ.'CLD'.OR.WHCH(1:3).EQ.'cld') THEN
        CLDP(JPAI)=CVAL
      ELSE IF (WHCH(1:3).EQ.'CTM'.OR.WHCH(1:3).EQ.'ctm') THEN
        CTMA=CVAL
        LCTM=MAX(1,MIN(500,LCVL))
      ELSE IF (WHCH(1:3).EQ.'HIT'.OR.WHCH(1:3).EQ.'hit') THEN
        TXHI=CVAL
        LTHI=MAX(1,MIN(20,LCVL))
      ELSE IF (WHCH(1:3).EQ.'HLT'.OR.WHCH(1:3).EQ.'hlt') THEN
        TXHI=' '
        LTHI=1
        TXLO=' '
        LTLO=1
        LCVL=LEN(CVAL)
        IF (LCVL.GT.0.AND.CVAL.NE.' ') THEN
          DO 10006 I=1,LCVL
            IF (CVAL(I:I).EQ.'''') THEN
              IF (I.NE.1.AND.CVAL(1:I-1).NE.' ') THEN
                TXHI=CVAL(1:I-1)
                LTHI=MIN(20,I-1)
              END IF
              IF (I.NE.LCVL.AND.CVAL(I+1:LCVL).NE.' ') THEN
                TXLO=CVAL(I+1:LCVL)
                LTLO=MIN(20,LCVL-I)
              END IF
              GO TO 101
            END IF
10006     CONTINUE
          TXHI=CVAL
          LTHI=MAX(1,MIN(20,LCVL))
          TXLO=CVAL
          LTLO=MAX(1,MIN(20,LCVL))
        END IF
      ELSE IF (WHCH(1:3).EQ.'ILT'.OR.WHCH(1:3).EQ.'ilt') THEN
        TXIL=CVAL
        LTIL=MAX(1,MIN(100,LCVL))
      ELSE IF (WHCH(1:3).EQ.'LLT'.OR.WHCH(1:3).EQ.'llt') THEN
        CLBL(IPAI)=CVAL
        NCLB(IPAI)=-LCVL
      ELSE IF (WHCH(1:3).EQ.'LOT'.OR.WHCH(1:3).EQ.'lot') THEN
        TXLO=CVAL
        LTLO=MAX(1,MIN(20,LCVL))
      ELSE
        CTMB(1:36)='CPSETC - PARAMETER NAME NOT KNOWN - '
        CTMB(37:39)=WHCH(1:3)
        CALL SETER (CTMB(1:39),4,1)
        RETURN
      END IF
C
C Done.
C
  101 RETURN
C
      END
