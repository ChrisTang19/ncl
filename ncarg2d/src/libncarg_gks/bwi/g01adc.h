C
C $Id: g01adc.h,v 1.3 2000-08-22 03:45:40 haley Exp $
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

      COMMON  /G01ADC/  VALCHG(37)      ,ANYASF ,AGPEND(4)      ,
     +                  IVPLIX  ,IVLTYP ,IVLWSC ,IVPLCI ,IVPMIX ,
     +                  IVMTYP  ,IVMSZS ,IVPMCI ,IVTXIX ,IVTXP  ,
     +                  IVTXAL  ,IVCHH  ,IVCHOV ,IVTXFO ,IVTXPR ,
     +                  IVCHXP  ,IVCHSP ,IVTXCI ,IVFAIX ,IVPASZ ,
     +                  IVPARF  ,IVFAIS ,IVFASI ,IVFACI ,IVASF  ,
     +                  IP2AEA(26)      ,IL2AEA(26)     ,
     +                  IALTYP  ,IALWSC ,IAPLCI ,IAMTYP ,IAMSZS ,
     +                  IAPMCI  ,IATXFP ,IACHXP ,IACHSP ,IATXCI ,
     +                  IAFAIS  ,IAFASI ,IAFACI ,
     +                  NCGASF  ,NGKASF ,MASMAP(18)
        LOGICAL         VALCHG  ,ANYASF ,AGPEND
        INTEGER         IVPLIX  ,IVLTYP ,IVLWSC ,IVPLCI ,IVPMIX
        INTEGER         IVMTYP  ,IVMSZS ,IVPMCI ,IVTXIX ,IVTXP
        INTEGER         IVTXAL  ,IVCHH  ,IVCHOV ,IVTXFO ,IVTXPR
        INTEGER         IVCHXP  ,IVCHSP ,IVTXCI ,IVFAIX ,IVPASZ
        INTEGER         IVPARF  ,IVFAIS ,IVFASI ,IVFACI ,IVASF
        INTEGER         IP2AEA  ,IL2AEA
        INTEGER         IALTYP  ,IALWSC ,IAPLCI ,IAMTYP ,IAMSZS
        INTEGER         IAPMCI  ,IATXFP ,IACHXP ,IACHSP ,IATXCI
        INTEGER         IAFAIS  ,IAFASI ,IAFACI
        INTEGER         NCGASF  ,NGKASF ,MASMAP
C
        LOGICAL         ASFCHG(13)
        EQUIVALENCE     (VALCHG(25),ASFCHG(1))
