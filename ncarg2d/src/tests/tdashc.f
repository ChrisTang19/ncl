C
C	$Id: tdashc.f,v 1.3 1994-07-08 19:41:26 stautler Exp $
C
C
C Define error file, Fortran unit number, and workstation type,
C and workstation ID.
C
      PARAMETER (IERRF=6, LUNIT=2, IWTYPE=SED_WSTYPE, IWKID=1)
C
C OPEN GKS, OPEN WORKSTATION OF TYPE 1, ACTIVATE WORKSTATION
C
      CALL GOPKS (IERRF, ISZDM)
      CALL GOPWK (IWKID, LUNIT, IWTYPE)
      CALL GACWK (IWKID)
C
C INVOKE DEMO DRIVER
C
      CALL TDASHC(IERR)
C
C DEACTIVATE AND CLOSE WORKSTATION, CLOSE GKS.
C
      CALL GDAWK (IWKID)
      CALL GCLWK (IWKID)
      CALL GCLKS
C
      STOP
      END
C
      SUBROUTINE TDASHC (IERROR)
C
C PURPOSE                To provide a simple demonstration of DASHCHAR
C
C USAGE                  CALL TDASHC (IERROR)
C
C ARGUMENTS
C
C ON OUTPUT              IERROR
C                          An integer variable
C                          = 0, if the test was successful,
C                          = 1, otherwise
C
C I/O                    If the test is successful, the message
C
C               DASHCHAR TEST EXECUTED--SEE PLOT TO CERTIFY
C
C                        is printed on unit 6.  In addition, 1
C                        frame is produced on the machine graphics
C                        device.  In order to determine if the test
C                        was successful, it is necessary to examine
C                        the plot.
C
C PRECISION              Single
C
C REQUIRED ROUTINES      DASHCHAR
C
C REQUIRED GKS LEVEL     0A
C
C LANGUAGE               FORTRAN 77
C
C ALGORITHM              TDASHC utilizes the software DASHCHAR
C                        routines DASHDB, DASHDC, FRSTD, VECTD,
C                        LINED, and CURVED to draw 5 curves on 1
C                        picture using 5 different DASHCHAR patterns.
C                        Each curve is centered about solid axis
C                        lines and labelled with the character
C                        representation of the DASHCHAR pattern used.
C
C X contains the abscissae and Y the ordinates of the curve to be plotted.
C
      DIMENSION       X(31)      ,Y(31)
C
C Select normalization transformation 0.
C
      CALL GSELNT(0)
C
C Set a solid dash pattern,  1111111111111111 (BINARY).
C Boolean operations (using locally-implemented support
C routines) are used to support porting to hosts with 16
C bit integers.
C
      ISOLID = IOR (ISHIFT (32767,1), 1)
C
      DO 130 K=1,5
         CALL DASHDB (ISOLID)
         ORG =1.07-0.195*K
C
C Draw the central axis for each curve.
C
         CALL FRSTD (.50,ORG-0.03)
         CALL VECTD (.50,ORG+0.03)
         CALL LINED (.109,ORG,.891,ORG)
C
C Call DASHDC with a different dashed line and character combination
C for each of 5 different curves.
C
         GO TO ( 10, 20, 30, 40, 50),K
   10    CALL DASHDC ('$''$''$''$''$''$''$''$K = 1',10,12)
         GO TO  60
   20    CALL DASHDC ('$$$$$$''$''$$$$$$K = 2',10,12)
         GO TO  60
   30    CALL DASHDC ('$$$$''$$$$''$$$$''K = 3',10,12)
         GO TO  60
   40    CALL DASHDC ('$$$$$''''''''''$$$$$K = 4',10,12)
         GO TO  60
   50    CALL DASHDC ('$$$''$$$''$$$''$$$K = 5',10,12)
   60    CONTINUE
C
C Compute some curve coordinates and draw the curves.
C
         DO  70 I=1,31
            THETA = FLOAT(I-1)*3.1415926535897932/15.
            X(I) = 0.5+.4*COS(THETA)
            Y(I) = ORG+.075*SIN(FLOAT(K)*THETA)
   70    CONTINUE
         CALL CURVED (X,Y,31)
C
C Label the curves with the character representation of the appropriate
C DASHCHAR pattern.  In the pattern labels, A and D should be interpreted
C as the apostrophe and dollar sign.
C
C Locate the string at the left end, but vertically centered.
C
        CALL GSTXAL(1,3)
C
C Set the character height.
C
         CALL GSCHH(.012)
C
         ORY = ORG+.089
         GO TO ( 80, 90,100,110,120),K
   80    CALL GTX(.1,ORY,'IPAT=DADADADADADADADK=1')
         GO TO 130
   90    CALL GTX(.1,ORY,'IPAT=DDDDDDADADDDDDDK=2')
         GO TO 130
  100    CALL GTX(.1,ORY,'IPAT=DDDDADDDDADDDDAK=3')
         GO TO 130
  110    CALL GTX(.1,ORY,'IPAT=DDDDDAAAAADDDDDK=4')
         GO TO 130
  120    CALL GTX(.1,ORY,'IPAT=DDDADDDADDDADDDK=5')
C
  130 CONTINUE
C
      CALL GSTXAL(2,3)
      CALL GTX (.5,.985,'DEMONSTRATION PLOT FOR DASHCHAR')
      CALL GTX (.5,.015,'IN IPAT STRINGS, A AND D SHOULD BE INTERPRETED
     1AS APOSTROPHE AND DOLLAR SIGN')
      CALL FRAME
C
      IERROR = 0
      WRITE (6,1001)
C
      RETURN
 1001 FORMAT (' DASHCHAR TEST EXECUTED--SEE PLOT TO CERTIFY')
C
      END
