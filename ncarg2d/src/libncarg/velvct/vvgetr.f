C
C	$Id: vvgetr.f,v 1.7 1993-01-27 20:59:51 dbrown Exp $
C
C
C-----------------------------------------------------------------------
C
      SUBROUTINE VVGETR (CNM,RVL)
C
      CHARACTER*(*) CNM
C
C This subroutine is called to retrieve the real value of a specified
C parameter.
C
C CNM is the name of the parameter whose value is to be retrieved.
C
C RVL is a real variable in which the desired value is to be returned
C by VVGETR.
C
C ---------------------------------------------------------------------
C
C NOTE:
C Since implicit typing is used for all real and integer variables
C a consistent length convention has been adopted to help clarify the
C significance of the variables encountered in the code for this 
C utility. All local variable and subroutine parameter identifiers 
C are limited to 1,2,or 3 characters. Four character names identify  
C members of common blocks. Five and 6 character variable names 
C denote PARAMETER constants or subroutine or function names.
C
C Declare the VV common blocks.
C
      PARAMETER (IPLVLS = 64)
C
C Integer and real common block variables
C
C
      COMMON /VVCOM/
     +                IUD1       ,IVD1       ,IPD1       ,IXDM       ,
     +                IYDN       ,VLOM       ,VHIM       ,ISET       ,
     +                VMXL       ,VFRC       ,IXIN       ,IYIN       ,
     +                ISVF       ,UUSV       ,UVSV       ,
     +                UPSV       ,IMSK       ,ICPM       ,UVPS       ,
     +                UVPL       ,UVPR       ,UVPB       ,UVPT       ,
     +                UWDL       ,UWDR       ,UWDB       ,UWDT       ,
     +                UXC1       ,UXCM       ,UYC1       ,UYCN       ,
     +                NLVL       ,IPAI       ,ICTV       ,WDLV       ,
     +                UVMN       ,UVMX       ,PMIN       ,PMAX       ,
     +                ISPC       ,ITHN       ,IPLR       ,IVST       ,
     +                IVPO       ,ILBL       ,IDPF       ,IMSG       ,
     +                ICLR(IPLVLS)           ,TVLU(IPLVLS)
C
C Arrow size/shape parameters
C
	COMMON / VVARO /
     +                HDSZ       ,HINF       ,HANG       ,
     +	              HSIN       ,HCOS       ,FAMN       ,FAMX

C
C Text related parameters
C
	COMMON /VVTXP /
     +                FCWM    ,ICSZ    ,
     +                FMNS    ,FMNX    ,FMNY    ,IMNP    ,IMNC  ,
     +                FMXS    ,FMXX    ,FMXY    ,IMXP    ,IMXC  ,
     +                FZFS    ,FZFX    ,FZFY    ,IZFP    ,IZFC  ,
     +                FILS    ,FILX    ,FILY    ,IILP    ,IILC  ,
     +                FLBS    ,ILBC

C
C Character variable declartions
C
      CHARACTER*160 CSTR
      PARAMETER (IPCHSZ=36)
      CHARACTER*(IPCHSZ)  CMNT,CMXT,CZFT,CLBT,CILT
C
C Text string parameters
C
      COMMON /VVCHAR/ CSTR,CMNT,CMXT,CZFT,CLBT,CILT
C
      SAVE /VVCOM/, /VVARO/, /VVTXP/, /VVCHAR/
C
C The mapping common block: made available to user mapping routines
C
      COMMON /VVMAP/
     +                IMAP       ,
     +                XVPL       ,XVPR       ,YVPB       ,YVPT       ,
     +                WXMN       ,WXMX       ,WYMN       ,WYMX       ,
     +                XLOV       ,XHIV       ,YLOV       ,YHIV       ,
     +                SXDC       ,SYDC       ,NXCT       ,NYCT       ,
     +                RLEN       ,LNLG       ,INVX       ,INVY       ,
     +                ITRT       ,IWCT       ,FW2W       ,FH2H       ,
     +                DVMN       ,DVMX       ,RBIG       ,IBIG
C
      SAVE /VVMAP/
C
C Math constants
C
      PARAMETER (PDTOR  = 0.017453292519943,
     +           PRTOD  = 57.2957795130823,
     +           P1XPI  = 3.14159265358979,
     +           P2XPI  = 6.28318530717959,
     +           P1D2PI = 1.57079632679489,
     +           P5D2PI = 7.85398163397448) 
C
C --------------------------------------------------------------------
C
C Check for a parameter name that is too short.
C
      IF (LEN(CNM).LT.3) THEN
        CSTR(1:46)='VVGETI OR VVGETR - PARAMETER NAME TOO SHORT - '
        CSTR(47:46+LEN(CNM))=CNM
        CALL SETER (CSTR(1:46+LEN(CNM)),1,2)
        STOP
      END IF
C
C Check for incorrect use of the index parameter.
C
      IF (CNM(1:3).EQ.'CLR'.OR.CNM(1:3).EQ.'clr'
     +    .OR.CNM(1:3).EQ.'TVL'.OR.CNM(1:3).EQ.'tvl') THEN
         IF (IPAI.LT.1.OR.IPAI.GT.NLVL) THEN
            CSTR(1:46)='VVGETI OR VVGETR - GETTING XXX - PAI INCORRECT'
            CSTR(28:30)=CNM(1:3)
            CALL SETER (CSTR(1:46),2,2)
            STOP
         END IF
      END IF
C
C Get the appropriate parameter value.
C
C Values in VVCOM
C
      IF (CNM(1:3).EQ.'UD1'.OR. CNM(1:3).EQ.'ud1') THEN
         RVL=REAL(IUD1)
      ELSE IF (CNM(1:3).EQ.'VD1'.OR. CNM(1:3).EQ.'vd1') THEN
         RVL=REAL(IVD1)
      ELSE IF (CNM(1:3).EQ.'PD1'.OR. CNM(1:3).EQ.'pd1') THEN
         RVL=REAL(IPD1)
      ELSE IF (CNM(1:3).EQ.'XDM'.OR. CNM(1:3).EQ.'xdm') THEN
         RVL=REAL(IXDM)
      ELSE IF (CNM(1:3).EQ.'YDN'.OR. CNM(1:3).EQ.'ydn') THEN
         RVL=REAL(IYDN)
      ELSE IF (CNM(1:3).EQ.'VLM'.OR.CNM(1:3).EQ.'vlm') THEN
        RVL=VLOM
      ELSE IF (CNM(1:3).EQ.'VHM'.OR.CNM(1:3).EQ.'vhm') THEN
        RVL=VHIM
      ELSE IF (CNM(1:3).EQ.'SET'.OR. CNM(1:3).EQ.'set') THEN
         RVL=REAL(ISET)
      ELSE IF (CNM(1:3).EQ.'VML'.OR. CNM(1:3).EQ.'vml') THEN
         RVL=VMXL
      ELSE IF (CNM(1:3).EQ.'VFR'.OR. CNM(1:3).EQ.'vfr') THEN
         RVL=VFRC
      ELSE IF (CNM(1:3).EQ.'SVF'.OR. CNM(1:3).EQ.'svf') THEN
         RVL=REAL(ISVF)
      ELSE IF (CNM(1:3).EQ.'USV'.OR.CNM(1:3).EQ.'usv') THEN
         RVL=UUSV
      ELSE IF (CNM(1:3).EQ.'VSV'.OR.CNM(1:3).EQ.'vsv') THEN
         RVL=UVSV
      ELSE IF (CNM(1:3).EQ.'PSV'.OR.CNM(1:3).EQ.'psv') THEN
         RVL=UPSV
      ELSE IF (CNM(1:3).EQ.'CPM'.OR. CNM(1:3).EQ.'cpm') THEN
         RVL=REAL(ICPM)
      ELSE IF (CNM(1:3).EQ.'WML'.OR. CNM(1:3).EQ.'wml') THEN
         RVL=RLEN
      ELSE IF (CNM(1:3).EQ.'MSK'.OR. CNM(1:3).EQ.'msk') THEN
         RVL=REAL(IMSK)
      ELSE IF (CNM(1:3).EQ.'VPS'.OR. CNM(1:3).EQ.'vps') THEN
         RVL=REAL(UVPS)
      ELSE IF (CNM(1:3).EQ.'VPL'.OR.CNM(1:3).EQ.'vpl') THEN
         RVL=UVPL
      ELSE IF (CNM(1:3).EQ.'VPR'.OR.CNM(1:3).EQ.'vpr') THEN
         RVL=UVPR
      ELSE IF (CNM(1:3).EQ.'VPB'.OR.CNM(1:3).EQ.'vpb') THEN
         RVL=UVPB
      ELSE IF (CNM(1:3).EQ.'VPT'.OR.CNM(1:3).EQ.'vpt') THEN
         RVL=UVPT
      ELSE IF (CNM(1:3).EQ.'WDL'.OR.CNM(1:3).EQ.'wdl') THEN
         RVL=UWDL
      ELSE IF (CNM(1:3).EQ.'WDR'.OR.CNM(1:3).EQ.'wdr') THEN
         RVL=UWDR
      ELSE IF (CNM(1:3).EQ.'WDB'.OR.CNM(1:3).EQ.'wdb') THEN
         RVL=UWDB
      ELSE IF (CNM(1:3).EQ.'WDT'.OR.CNM(1:3).EQ.'wdt') THEN
         RVL=UWDT
      ELSE IF (CNM(1:3).EQ.'XC1'.OR.CNM(1:3).EQ.'xc1') THEN
         RVL=UXC1
      ELSE IF (CNM(1:3).EQ.'XCM'.OR.CNM(1:3).EQ.'xcm') THEN
         RVL=UXCM
      ELSE IF (CNM(1:3).EQ.'YC1'.OR.CNM(1:3).EQ.'yc1') THEN
         RVL=UYC1
      ELSE IF (CNM(1:3).EQ.'YCN'.OR.CNM(1:3).EQ.'ycn') THEN
         RVL=UYCN
      ELSE IF (CNM(1:3).EQ.'NLV'.OR.CNM(1:3).EQ.'nlv') THEN
        RVL=REAL(NLVL)
      ELSE IF (CNM(1:3).EQ.'PAI'.OR.CNM(1:3).EQ.'pai') THEN
        RVL=REAL(IPAI)
      ELSE IF (CNM(1:3).EQ.'CTV'.OR.CNM(1:3).EQ.'ctv') THEN
        RVL=REAL(ICTV)
      ELSE IF (CNM(1:3).EQ.'LWD'.OR.CNM(1:3).EQ.'lwd') THEN
        RVL=WDLV
      ELSE IF (CNM(1:3).EQ.'VMN'.OR.CNM(1:3).EQ.'vmn') THEN
        RVL=UVMN
      ELSE IF (CNM(1:3).EQ.'VMX'.OR.CNM(1:3).EQ.'vmx') THEN
        RVL=UVMX
      ELSE IF (CNM(1:3).EQ.'DMN'.OR.CNM(1:3).EQ.'dmn') THEN
        RVL=DVMN
      ELSE IF (CNM(1:3).EQ.'DMX'.OR.CNM(1:3).EQ.'dmx') THEN
        RVL=DVMX
      ELSE IF (CNM(1:3).EQ.'PMN'.OR.CNM(1:3).EQ.'pmn') THEN
        RVL=PMIN
      ELSE IF (CNM(1:3).EQ.'PMX'.OR.CNM(1:3).EQ.'pmx') THEN
        RVL=PMAX
      ELSE IF (CNM(1:3).EQ.'SPC'.OR. CNM(1:3).EQ.'spc') THEN
         RVL=REAL(ISPC)
      ELSE IF (CNM(1:3).EQ.'THN'.OR. CNM(1:3).EQ.'thn') THEN
         RVL=REAL(ITHN)
      ELSE IF (CNM(1:3).EQ.'MAP'.OR. CNM(1:3).EQ.'map') THEN
         RVL=REAL(IMAP)
      ELSE IF (CNM(1:3).EQ.'PLR'.OR. CNM(1:3).EQ.'plr') THEN
         RVL=REAL(IPLR)
      ELSE IF (CNM(1:3).EQ.'VST'.OR. CNM(1:3).EQ.'vst') THEN
         RVL=REAL(IVST)
      ELSE IF (CNM(1:3).EQ.'VPO'.OR. CNM(1:3).EQ.'vpo') THEN
         RVL=REAL(IVPO)
      ELSE IF (CNM(1:3).EQ.'LBL'.OR. CNM(1:3).EQ.'lbl') THEN
         RVL=REAL(ILBL)
      ELSE IF (CNM(1:3).EQ.'DPF'.OR. CNM(1:3).EQ.'dpf') THEN
         RVL=REAL(IDPF)
      ELSE IF (CNM(1:3).EQ.'MSG'.OR. CNM(1:3).EQ.'msg') THEN
         RVL=REAL(IMSG)
C
C arrow min, max
C
      ELSE IF (CNM(1:3).EQ.'AMN'.OR.CNM(1:3).EQ.'amn') THEN
        RVL=FAMN
      ELSE IF (CNM(1:3).EQ.'AMX'.OR.CNM(1:3).EQ.'amx') THEN
        RVL=FAMX
C
C character multiplier
C
      ELSE IF (CNM(1:3).EQ.'CWM'.OR.CNM(1:3).EQ.'cwm') THEN
        RVL=FCWM
C
C character attributes
C
      ELSE IF (CNM(1:3).EQ.'MNS'.OR.CNM(1:3).EQ.'mns') THEN
         RVL=FMNS
      ELSE IF (CNM(1:3).EQ.'MNX'.OR.CNM(1:3).EQ.'mnx') THEN
         RVL=FMNX
      ELSE IF (CNM(1:3).EQ.'MNY'.OR.CNM(1:3).EQ.'mny') THEN
         RVL=FMNY
      ELSE IF (CNM(1:3).EQ.'MNP'.OR. CNM(1:3).EQ.'mnp') THEN
         RVL=REAL(IMNP)
      ELSE IF (CNM(1:3).EQ.'MNC'.OR. CNM(1:3).EQ.'mnc') THEN
         RVL=REAL(IMNC)
C
      ELSE IF (CNM(1:3).EQ.'MXS'.OR.CNM(1:3).EQ.'mxs') THEN
         RVL=FMXS
      ELSE IF (CNM(1:3).EQ.'MXX'.OR.CNM(1:3).EQ.'mxx') THEN
         RVL=FMXX
      ELSE IF (CNM(1:3).EQ.'MXY'.OR.CNM(1:3).EQ.'mxy') THEN
         RVL=FMXY
      ELSE IF (CNM(1:3).EQ.'MXP'.OR. CNM(1:3).EQ.'mxp') THEN
         RVL=REAL(IMXP)
      ELSE IF (CNM(1:3).EQ.'MXC'.OR. CNM(1:3).EQ.'mxc') THEN
         RVL=REAL(IMXC)
C
      ELSE IF (CNM(1:3).EQ.'ZFS'.OR.CNM(1:3).EQ.'zfs') THEN
         RVL=FZFS
      ELSE IF (CNM(1:3).EQ.'ZFX'.OR.CNM(1:3).EQ.'zfx') THEN
         RVL=FZFX
      ELSE IF (CNM(1:3).EQ.'ZFY'.OR.CNM(1:3).EQ.'zfy') THEN
         RVL=FZFY
      ELSE IF (CNM(1:3).EQ.'ZFP'.OR. CNM(1:3).EQ.'zfp') THEN
         RVL=REAL(IZFP)
      ELSE IF (CNM(1:3).EQ.'ZFC'.OR. CNM(1:3).EQ.'zfc') THEN
         RVL=REAL(IZFC)
C
      ELSE IF (CNM(1:3).EQ.'LBS'.OR.CNM(1:3).EQ.'lbs') THEN
         RVL=FLBS
      ELSE IF (CNM(1:3).EQ.'LBC'.OR. CNM(1:3).EQ.'lbc') THEN
         RVL=REAL(ILBC)
C
      ELSE IF (CNM(1:3).EQ.'ILS'.OR.CNM(1:3).EQ.'ils') THEN
         RVL=FILS
      ELSE IF (CNM(1:3).EQ.'ILX'.OR.CNM(1:3).EQ.'ilx') THEN
         RVL=FILX
      ELSE IF (CNM(1:3).EQ.'ILY'.OR.CNM(1:3).EQ.'ily') THEN
         RVL=FILY
      ELSE IF (CNM(1:3).EQ.'ILP'.OR. CNM(1:3).EQ.'ilp') THEN
         RVL=REAL(IILP)
      ELSE IF (CNM(1:3).EQ.'ILC'.OR. CNM(1:3).EQ.'ilc') THEN
         RVL=REAL(IILC)
C
C color field parameters
C
      ELSE IF (CNM(1:3).EQ.'CLR'.OR.CNM(1:3).EQ.'clr') THEN
         RVL=REAL(ICLR(IPAI))
      ELSE IF (CNM(1:3).EQ.'TVL'.OR.CNM(1:3).EQ.'tvl') THEN
         RVL=TVLU(IPAI)
      ELSE IF (CNM(1:3).EQ.'TRT'.OR. CNM(1:3).EQ.'trt') THEN
         RVL=REAL(ITRT)
      ELSE
         CSTR(1:46)='VVGETI OR VVGETR - PARAMETER NAME NOT KNOWN - '
         CSTR(47:49)=CNM(1:3)
         CALL SETER (CSTR(1:49),3,2)
         STOP
      END IF
C
 9900 CONTINUE
C
C Done.
C
      RETURN
C
      END
