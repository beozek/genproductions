      SUBROUTINE SMATRIX3(P,ANS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.5, 2018-02-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     MadGraph5_aMC@NLO for Madevent Version
C     
C     Returns amplitude squared summed/avg over colors
C     and helicities
C     for the point in phase space P(0:3,NEXTERNAL)
C     
C     Process: g u~ > t t~ u~ NP<=1 NPprop=0 SMHLOOP=0 @1
C     Process: g c~ > t t~ c~ NP<=1 NPprop=0 SMHLOOP=0 @1
C     
      USE DISCRETESAMPLER
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INCLUDE 'genps.inc'
      INCLUDE 'maxconfigs.inc'
      INCLUDE 'nexternal.inc'
      INCLUDE 'maxamps.inc'
      INTEGER                 NCOMB
      PARAMETER (             NCOMB=32)
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=105)
      INTEGER    NDIAGS
      PARAMETER (NDIAGS=105)
      INTEGER    THEL
      PARAMETER (THEL=2*NCOMB)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL),ANS
C     
C     global (due to reading writting) 
C     
      LOGICAL GOODHEL(NCOMB,2)
      INTEGER NTRY(2)
      COMMON/BLOCK_GOODHEL/NTRY,GOODHEL
C     
C     LOCAL VARIABLES 
C     
      INTEGER NHEL(NEXTERNAL,NCOMB)
      INTEGER ISHEL(2)
      REAL*8 T,MATRIX3
      REAL*8 R,SUMHEL,TS(NCOMB)
      INTEGER I,IDEN
      INTEGER JC(NEXTERNAL),II
      REAL*8 HWGT, XTOT, XTRY, XREJ, XR, YFRAC(0:NCOMB)
      INTEGER NGOOD(2), IGOOD(NCOMB,2)
      INTEGER JHEL(2), J, JJ
      INTEGER THIS_NTRY(2)
      SAVE THIS_NTRY
      DATA THIS_NTRY /0,0/
C     This is just to temporarily store the reference grid for
C      helicity of the DiscreteSampler so as to obtain its number of
C      entries with ref_helicity_grid%n_tot_entries
      TYPE(SAMPLEDDIMENSION) REF_HELICITY_GRID
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(MAXAMPS), JAMP2(0:MAXFLOW)
      COMMON/TO_AMPS/  AMP2,       JAMP2

      CHARACTER*101         HEL_BUFF
      COMMON/TO_HELICITY/  HEL_BUFF

      INTEGER IMIRROR
      COMMON/TO_MIRROR/ IMIRROR

      REAL*8 POL(2)
      COMMON/TO_POLARIZATION/ POL

      DOUBLE PRECISION SMALL_WIDTH_TREATMENT
      COMMON/NARROW_WIDTH/SMALL_WIDTH_TREATMENT

      INTEGER          ISUM_HEL
      LOGICAL                    MULTI_CHANNEL
      COMMON/TO_MATRIX/ISUM_HEL, MULTI_CHANNEL
      INTEGER MAPCONFIG(0:LMAXCONFIGS), ICONFIG
      COMMON/TO_MCONFIGS/MAPCONFIG, ICONFIG
      INTEGER SUBDIAG(MAXSPROC),IB(2)
      COMMON/TO_SUB_DIAG/SUBDIAG,IB
      DATA XTRY, XREJ /0,0/
      DATA NGOOD /0,0/
      DATA ISHEL/0,0/
      SAVE YFRAC, IGOOD, JHEL
      DATA (NHEL(I,   1),I=1,5) /-1,-1,-1, 1, 1/
      DATA (NHEL(I,   2),I=1,5) /-1,-1,-1, 1,-1/
      DATA (NHEL(I,   3),I=1,5) /-1,-1,-1,-1, 1/
      DATA (NHEL(I,   4),I=1,5) /-1,-1,-1,-1,-1/
      DATA (NHEL(I,   5),I=1,5) /-1,-1, 1, 1, 1/
      DATA (NHEL(I,   6),I=1,5) /-1,-1, 1, 1,-1/
      DATA (NHEL(I,   7),I=1,5) /-1,-1, 1,-1, 1/
      DATA (NHEL(I,   8),I=1,5) /-1,-1, 1,-1,-1/
      DATA (NHEL(I,   9),I=1,5) /-1, 1,-1, 1, 1/
      DATA (NHEL(I,  10),I=1,5) /-1, 1,-1, 1,-1/
      DATA (NHEL(I,  11),I=1,5) /-1, 1,-1,-1, 1/
      DATA (NHEL(I,  12),I=1,5) /-1, 1,-1,-1,-1/
      DATA (NHEL(I,  13),I=1,5) /-1, 1, 1, 1, 1/
      DATA (NHEL(I,  14),I=1,5) /-1, 1, 1, 1,-1/
      DATA (NHEL(I,  15),I=1,5) /-1, 1, 1,-1, 1/
      DATA (NHEL(I,  16),I=1,5) /-1, 1, 1,-1,-1/
      DATA (NHEL(I,  17),I=1,5) / 1,-1,-1, 1, 1/
      DATA (NHEL(I,  18),I=1,5) / 1,-1,-1, 1,-1/
      DATA (NHEL(I,  19),I=1,5) / 1,-1,-1,-1, 1/
      DATA (NHEL(I,  20),I=1,5) / 1,-1,-1,-1,-1/
      DATA (NHEL(I,  21),I=1,5) / 1,-1, 1, 1, 1/
      DATA (NHEL(I,  22),I=1,5) / 1,-1, 1, 1,-1/
      DATA (NHEL(I,  23),I=1,5) / 1,-1, 1,-1, 1/
      DATA (NHEL(I,  24),I=1,5) / 1,-1, 1,-1,-1/
      DATA (NHEL(I,  25),I=1,5) / 1, 1,-1, 1, 1/
      DATA (NHEL(I,  26),I=1,5) / 1, 1,-1, 1,-1/
      DATA (NHEL(I,  27),I=1,5) / 1, 1,-1,-1, 1/
      DATA (NHEL(I,  28),I=1,5) / 1, 1,-1,-1,-1/
      DATA (NHEL(I,  29),I=1,5) / 1, 1, 1, 1, 1/
      DATA (NHEL(I,  30),I=1,5) / 1, 1, 1, 1,-1/
      DATA (NHEL(I,  31),I=1,5) / 1, 1, 1,-1, 1/
      DATA (NHEL(I,  32),I=1,5) / 1, 1, 1,-1,-1/
      DATA IDEN/96/

C     To be able to control when the matrix<i> subroutine can add
C      entries to the grid for the MC over helicity configuration
      LOGICAL ALLOW_HELICITY_GRID_ENTRIES
      COMMON/TO_ALLOW_HELICITY_GRID_ENTRIES/ALLOW_HELICITY_GRID_ENTRIES

C     ----------
C     BEGIN CODE
C     ----------

      NTRY(IMIRROR)=NTRY(IMIRROR)+1
      THIS_NTRY(IMIRROR) = THIS_NTRY(IMIRROR)+1
      DO I=1,NEXTERNAL
        JC(I) = +1
      ENDDO

      IF (MULTI_CHANNEL) THEN
        DO I=1,NDIAGS
          AMP2(I)=0D0
        ENDDO
        JAMP2(0)=4
        DO I=1,INT(JAMP2(0))
          JAMP2(I)=0D0
        ENDDO
      ENDIF
      ANS = 0D0
      WRITE(HEL_BUFF,'(20I5)') (0,I=1,NEXTERNAL)
      DO I=1,NCOMB
        TS(I)=0D0
      ENDDO

        !   If the helicity grid status is 0, this means that it is not yet initialized.
        !   If HEL_PICKED==-1, this means that calls to other matrix<i> where in initialization mode as well for the helicity.
      IF ((ISHEL(IMIRROR).EQ.0.AND.ISUM_HEL.EQ.0).OR.(DS_GET_DIM_STATUS
     $('Helicity').EQ.0).OR.(HEL_PICKED.EQ.-1)) THEN
        DO I=1,NCOMB
          IF (GOODHEL(I,IMIRROR) .OR. NTRY(IMIRROR).LE.MAXTRIES.OR.(ISU
     $M_HEL.NE.0).OR.THIS_NTRY(IMIRROR).LE.2) THEN
            T=MATRIX3(P ,NHEL(1,I),JC(1))
            DO JJ=1,NINCOMING
              IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0,POL(JJ))
     $         )) THEN
                T=T*ABS(POL(JJ))
              ELSE IF(POL(JJ).NE.1D0)THEN
                T=T*(2D0-ABS(POL(JJ)))
              ENDIF
            ENDDO
            IF (ISUM_HEL.NE.0.AND.DS_GET_DIM_STATUS('Helicity')
     $       .EQ.0.AND.ALLOW_HELICITY_GRID_ENTRIES) THEN
              CALL DS_ADD_ENTRY('Helicity',I,T)
            ENDIF
            ANS=ANS+DABS(T)
            TS(I)=T
          ENDIF
        ENDDO
        IF(NTRY(IMIRROR).EQ.(MAXTRIES+1)) THEN
          CALL RESET_CUMULATIVE_VARIABLE()  ! avoid biais of the initialization
        ENDIF
        IF (ISUM_HEL.NE.0) THEN
            !         We set HEL_PICKED to -1 here so that later on, the call to DS_add_point in dsample.f does not add anything to the grid since it was already done here.
          HEL_PICKED = -1
            !         For safety, hardset the helicity sampling jacobian to 0.0d0 to make sure it is not .
          HEL_JACOBIAN   = 1.0D0
            !         We don't want to re-update the helicity grid if it was already updated by another matrix<i>, so we make sure that the reference grid is empty.
          REF_HELICITY_GRID = DS_GET_DIMENSION(REF_GRID,'Helicity')
          IF((DS_GET_DIM_STATUS('Helicity').EQ.1).AND.(REF_HELICITY_GRI
     $D%N_TOT_ENTRIES.EQ.0)) THEN
              !           If we finished the initialization we can update the grid so as to start sampling over it.
              !           However the grid will now be filled by dsample with different kind of weights (including pdf, flux, etc...) so by setting the grid_mode of the reference grid to 'initialization' we make sure it will be overwritten (as opposed to 'combined') by the running grid at the next update.
            CALL DS_UPDATE_GRID('Helicity')
            CALL DS_SET_GRID_MODE('Helicity','init')
          ENDIF
        ELSE
          JHEL(IMIRROR) = 1
          IF(NTRY(IMIRROR).LE.MAXTRIES.OR.THIS_NTRY(IMIRROR).LE.2)THEN
            DO I=1,NCOMB
              IF (.NOT.GOODHEL(I,IMIRROR) .AND. (DABS(TS(I)).GT.ANS
     $         *LIMHEL/NCOMB)) THEN
                GOODHEL(I,IMIRROR)=.TRUE.
                NGOOD(IMIRROR) = NGOOD(IMIRROR) +1
                IGOOD(NGOOD(IMIRROR),IMIRROR) = I
                PRINT *,'Added good helicity ',I,TS(I)*NCOMB/ANS,' in'
     $           //' event ',NTRY(IMIRROR), 'local:',THIS_NTRY(IMIRROR)
              ENDIF
            ENDDO
          ENDIF
          IF(NTRY(IMIRROR).EQ.MAXTRIES)THEN
            ISHEL(IMIRROR)=MIN(ISUM_HEL,NGOOD(IMIRROR))
          ENDIF
        ENDIF
      ELSE  ! random helicity 
C       The helicity configuration was chosen already by genps and put
C        in a common block defined in genps.inc.
        I = HEL_PICKED

        T=MATRIX3(P ,NHEL(1,I),JC(1))

        DO JJ=1,NINCOMING
          IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0,POL(JJ))))
     $      THEN
            T=T*ABS(POL(JJ))
          ELSE IF(POL(JJ).NE.1D0)THEN
            T=T*(2D0-ABS(POL(JJ)))
          ENDIF
        ENDDO
C       Always one helicity at a time
        ANS = T
C       Include the Jacobian from helicity sampling
        ANS = ANS * HEL_JACOBIAN

        WRITE(HEL_BUFF,'(20i5)')(NHEL(II,I),II=1,NEXTERNAL)
      ENDIF
      IF (ANS.NE.0D0.AND.(ISUM_HEL .NE. 1.OR.HEL_PICKED.EQ.-1)) THEN
        CALL RANMAR(R)
        SUMHEL=0D0
        DO I=1,NCOMB
          SUMHEL=SUMHEL+DABS(TS(I))/ANS
          IF(R.LT.SUMHEL)THEN
            WRITE(HEL_BUFF,'(20i5)')(NHEL(II,I),II=1,NEXTERNAL)
C           Set right sign for ANS, based on sign of chosen helicity
            ANS=DSIGN(ANS,TS(I))
            GOTO 10
          ENDIF
        ENDDO
 10     CONTINUE
      ENDIF
      IF (MULTI_CHANNEL) THEN
        XTOT=0D0
        DO I=1,NDIAGS
          XTOT=XTOT+AMP2(I)
        ENDDO
        IF (XTOT.NE.0D0) THEN
          ANS=ANS*AMP2(SUBDIAG(3))/XTOT
        ELSE IF(ANS.NE.0D0) THEN
          WRITE(*,*) 'Problem in the multi-channeling. All amp2 are'
     $     //' zero but not the total matrix-element'
          STOP 1
        ENDIF
      ENDIF
      ANS=ANS/DBLE(IDEN)
      END


      REAL*8 FUNCTION MATRIX3(P,NHEL,IC)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.5, 2018-02-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Returns amplitude squared summed/avg over colors
C     for the point with external lines W(0:6,NEXTERNAL)
C     
C     Process: g u~ > t t~ u~ NP<=1 NPprop=0 SMHLOOP=0 @1
C     Process: g c~ > t t~ c~ NP<=1 NPprop=0 SMHLOOP=0 @1
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=105)
      INCLUDE 'genps.inc'
      INCLUDE 'nexternal.inc'
      INCLUDE 'maxamps.inc'
      INTEGER    NWAVEFUNCS,     NCOLOR
      PARAMETER (NWAVEFUNCS=24, NCOLOR=4)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      COMPLEX*16 IMAG1
      PARAMETER (IMAG1=(0D0,1D0))
      INTEGER NAMPSO, NSQAMPSO
      PARAMETER (NAMPSO=1, NSQAMPSO=1)
      LOGICAL CHOSEN_SO_CONFIGS(NSQAMPSO)
      DATA CHOSEN_SO_CONFIGS/.TRUE./
      SAVE CHOSEN_SO_CONFIGS
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), IC(NEXTERNAL)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,J,M,N
      COMPLEX*16 ZTEMP
      REAL*8 DENOM(NCOLOR), CF(NCOLOR,NCOLOR)
      COMPLEX*16 AMP(NGRAPHS), JAMP(NCOLOR,NAMPSO)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     Needed for v4 models
      COMPLEX*16 DUM0,DUM1
      DATA DUM0, DUM1/(0D0, 0D0), (1D0, 0D0)/

      DOUBLE PRECISION FK_MDL_WZ
      DOUBLE PRECISION FK_ZERO
      DOUBLE PRECISION FK_MDL_WT
      SAVE FK_MDL_WZ
      SAVE FK_ZERO
      SAVE FK_MDL_WT

      LOGICAL FIRST
      DATA FIRST /.TRUE./
      SAVE FIRST
C     
C     FUNCTION
C     
      INTEGER SQSOINDEX3
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(MAXAMPS), JAMP2(0:MAXFLOW)
      COMMON/TO_AMPS/  AMP2,       JAMP2
      INCLUDE 'coupl.inc'

      DOUBLE PRECISION SMALL_WIDTH_TREATMENT
      COMMON/NARROW_WIDTH/SMALL_WIDTH_TREATMENT
C     
C     COLOR DATA
C     
      DATA DENOM(1)/1/
      DATA (CF(I,  1),I=  1,  4) /   12,    4,    4,    0/
C     1 T(1,2,4) T(3,5)
      DATA DENOM(2)/1/
      DATA (CF(I,  2),I=  1,  4) /    4,   12,    0,    4/
C     1 T(1,2,5) T(3,4)
      DATA DENOM(3)/1/
      DATA (CF(I,  3),I=  1,  4) /    4,    0,   12,    4/
C     1 T(1,3,4) T(2,5)
      DATA DENOM(4)/1/
      DATA (CF(I,  4),I=  1,  4) /    0,    4,    4,   12/
C     1 T(1,3,5) T(2,4)
C     ----------
C     BEGIN CODE
C     ----------
      IF (FIRST) THEN
        FIRST=.FALSE.
        FK_MDL_WT = SIGN(MAX(ABS(MDL_WT), ABS(MDL_MT
     $   *SMALL_WIDTH_TREATMENT)), MDL_WT)
        FK_MDL_WZ = SIGN(MAX(ABS(MDL_WZ), ABS(MDL_MZ
     $   *SMALL_WIDTH_TREATMENT)), MDL_WZ)
        FK_ZERO = SIGN(MAX(ABS(ZERO), ABS(ZERO*SMALL_WIDTH_TREATMENT))
     $   , ZERO)
      ENDIF


      CALL VXXXXX(P(0,1),ZERO,NHEL(1),-1*IC(1),W(1,1))
      CALL OXXXXX(P(0,2),ZERO,NHEL(2),-1*IC(2),W(1,2))
      CALL OXXXXX(P(0,3),MDL_MT,NHEL(3),+1*IC(3),W(1,3))
      CALL IXXXXX(P(0,4),MDL_MT,NHEL(4),-1*IC(4),W(1,4))
      CALL IXXXXX(P(0,5),ZERO,NHEL(5),-1*IC(5),W(1,5))
      CALL FFV1_2(W(1,5),W(1,1),GC_6,ZERO, FK_ZERO,W(1,6))
      CALL FFV2P0_3(W(1,4),W(1,3),GC_357,ZERO, FK_ZERO,W(1,7))
C     Amplitude(s) for diagram number 1
      CALL FFV1_0(W(1,6),W(1,2),W(1,7),GC_2,AMP(1))
      CALL FFV1P0_3(W(1,4),W(1,3),GC_2,ZERO, FK_ZERO,W(1,8))
C     Amplitude(s) for diagram number 2
      CALL FFV1_0(W(1,6),W(1,2),W(1,8),GC_2,AMP(2))
      CALL FFV9P0_3(W(1,4),W(1,3),GC_358,ZERO, FK_ZERO,W(1,9))
C     Amplitude(s) for diagram number 3
      CALL FFV1_0(W(1,6),W(1,2),W(1,9),GC_2,AMP(3))
      CALL FFV2P0_3(W(1,4),W(1,3),GC_451,ZERO, FK_ZERO,W(1,10))
C     Amplitude(s) for diagram number 4
      CALL FFV1_0(W(1,6),W(1,2),W(1,10),GC_2,AMP(4))
      CALL FFV9P0_3(W(1,4),W(1,3),GC_452,ZERO, FK_ZERO,W(1,11))
C     Amplitude(s) for diagram number 5
      CALL FFV1_0(W(1,6),W(1,2),W(1,11),GC_2,AMP(5))
      CALL FFV2_3(W(1,4),W(1,3),GC_367,MDL_MZ, FK_MDL_WZ,W(1,12))
C     Amplitude(s) for diagram number 6
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,12),GC_264,GC_203,AMP(6))
      CALL FFV1_3_3(W(1,4),W(1,3),GC_264,GC_203,MDL_MZ, FK_MDL_WZ,W(1
     $ ,13))
C     Amplitude(s) for diagram number 7
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,13),GC_264,GC_203,AMP(7))
      CALL FFV9_3(W(1,4),W(1,3),GC_369,MDL_MZ, FK_MDL_WZ,W(1,14))
C     Amplitude(s) for diagram number 8
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,14),GC_264,GC_203,AMP(8))
      CALL FFV5_3(W(1,4),W(1,3),GC_524,MDL_MZ, FK_MDL_WZ,W(1,15))
C     Amplitude(s) for diagram number 9
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,15),GC_264,GC_203,AMP(9))
      CALL FFV2_3(W(1,4),W(1,3),GC_441,MDL_MZ, FK_MDL_WZ,W(1,16))
C     Amplitude(s) for diagram number 10
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,16),GC_264,GC_203,AMP(10))
      CALL FFV9_3(W(1,4),W(1,3),GC_442,MDL_MZ, FK_MDL_WZ,W(1,17))
C     Amplitude(s) for diagram number 11
      CALL FFV1_3_0(W(1,6),W(1,2),W(1,17),GC_264,GC_203,AMP(11))
      CALL FFV2P0_3(W(1,4),W(1,3),GC_351,ZERO, FK_ZERO,W(1,18))
C     Amplitude(s) for diagram number 12
      CALL FFV1_0(W(1,6),W(1,2),W(1,18),GC_6,AMP(12))
      CALL FFV1P0_3(W(1,4),W(1,3),GC_6,ZERO, FK_ZERO,W(1,19))
C     Amplitude(s) for diagram number 13
      CALL FFV1_0(W(1,6),W(1,2),W(1,19),GC_6,AMP(13))
      CALL FFV9P0_3(W(1,4),W(1,3),GC_352,ZERO, FK_ZERO,W(1,20))
C     Amplitude(s) for diagram number 14
      CALL FFV1_0(W(1,6),W(1,2),W(1,20),GC_6,AMP(14))
C     Amplitude(s) for diagram number 15
      CALL FFFF4_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_67,AMP(15))
C     Amplitude(s) for diagram number 16
      CALL FFFF4_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_68,AMP(16))
C     Amplitude(s) for diagram number 17
      CALL FFFF17_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_91,AMP(17))
C     Amplitude(s) for diagram number 18
      CALL FFFF18_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_117,AMP(18))
C     Amplitude(s) for diagram number 19
      CALL FFFF18_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_116,AMP(19))
C     Amplitude(s) for diagram number 20
      CALL FFFF17_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_92,AMP(20))
C     Amplitude(s) for diagram number 21
      CALL FFFF4_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_70,AMP(21))
C     Amplitude(s) for diagram number 22
      CALL FFFF4_0(W(1,4),W(1,3),W(1,6),W(1,2),GC_73,AMP(22))
      CALL FFV2_1(W(1,3),W(1,1),GC_351,MDL_MT, FK_MDL_WT,W(1,6))
      CALL FFV1P0_3(W(1,5),W(1,2),GC_2,ZERO, FK_ZERO,W(1,21))
C     Amplitude(s) for diagram number 23
      CALL FFV1_0(W(1,4),W(1,6),W(1,21),GC_2,AMP(23))
      CALL FFV1_3_3(W(1,5),W(1,2),GC_264,GC_203,MDL_MZ, FK_MDL_WZ,W(1
     $ ,22))
C     Amplitude(s) for diagram number 24
      CALL FFV1_3_0(W(1,4),W(1,6),W(1,22),GC_264,GC_203,AMP(24))
      CALL FFV1P0_3(W(1,5),W(1,2),GC_6,ZERO, FK_ZERO,W(1,23))
C     Amplitude(s) for diagram number 25
      CALL FFV1_0(W(1,4),W(1,6),W(1,23),GC_6,AMP(25))
      CALL FFV1_1(W(1,3),W(1,1),GC_6,MDL_MT, FK_MDL_WT,W(1,6))
C     Amplitude(s) for diagram number 26
      CALL FFV2_0(W(1,4),W(1,6),W(1,21),GC_357,AMP(26))
C     Amplitude(s) for diagram number 27
      CALL FFV1_0(W(1,4),W(1,6),W(1,21),GC_2,AMP(27))
C     Amplitude(s) for diagram number 28
      CALL FFV9_0(W(1,4),W(1,6),W(1,21),GC_358,AMP(28))
C     Amplitude(s) for diagram number 29
      CALL FFV2_0(W(1,4),W(1,6),W(1,21),GC_451,AMP(29))
C     Amplitude(s) for diagram number 30
      CALL FFV9_0(W(1,4),W(1,6),W(1,21),GC_452,AMP(30))
C     Amplitude(s) for diagram number 31
      CALL FFV2_0(W(1,4),W(1,6),W(1,22),GC_367,AMP(31))
C     Amplitude(s) for diagram number 32
      CALL FFV1_3_0(W(1,4),W(1,6),W(1,22),GC_264,GC_203,AMP(32))
C     Amplitude(s) for diagram number 33
      CALL FFV9_0(W(1,4),W(1,6),W(1,22),GC_369,AMP(33))
C     Amplitude(s) for diagram number 34
      CALL FFV5_0(W(1,4),W(1,6),W(1,22),GC_524,AMP(34))
C     Amplitude(s) for diagram number 35
      CALL FFV2_0(W(1,4),W(1,6),W(1,22),GC_441,AMP(35))
C     Amplitude(s) for diagram number 36
      CALL FFV9_0(W(1,4),W(1,6),W(1,22),GC_442,AMP(36))
C     Amplitude(s) for diagram number 37
      CALL FFV2_0(W(1,4),W(1,6),W(1,23),GC_351,AMP(37))
C     Amplitude(s) for diagram number 38
      CALL FFV1_0(W(1,4),W(1,6),W(1,23),GC_6,AMP(38))
C     Amplitude(s) for diagram number 39
      CALL FFV9_0(W(1,4),W(1,6),W(1,23),GC_352,AMP(39))
      CALL FFV9_1(W(1,3),W(1,1),GC_352,MDL_MT, FK_MDL_WT,W(1,24))
C     Amplitude(s) for diagram number 40
      CALL FFV1_0(W(1,4),W(1,24),W(1,21),GC_2,AMP(40))
C     Amplitude(s) for diagram number 41
      CALL FFV1_3_0(W(1,4),W(1,24),W(1,22),GC_264,GC_203,AMP(41))
C     Amplitude(s) for diagram number 42
      CALL FFV1_0(W(1,4),W(1,24),W(1,23),GC_6,AMP(42))
C     Amplitude(s) for diagram number 43
      CALL FFFF4_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_67,AMP(43))
C     Amplitude(s) for diagram number 44
      CALL FFFF4_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_68,AMP(44))
C     Amplitude(s) for diagram number 45
      CALL FFFF17_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_91,AMP(45))
C     Amplitude(s) for diagram number 46
      CALL FFFF18_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_117,AMP(46))
C     Amplitude(s) for diagram number 47
      CALL FFFF18_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_116,AMP(47))
C     Amplitude(s) for diagram number 48
      CALL FFFF17_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_92,AMP(48))
C     Amplitude(s) for diagram number 49
      CALL FFFF4_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_70,AMP(49))
C     Amplitude(s) for diagram number 50
      CALL FFFF4_0(W(1,4),W(1,6),W(1,5),W(1,2),GC_73,AMP(50))
      CALL FFV2_2(W(1,4),W(1,1),GC_351,MDL_MT, FK_MDL_WT,W(1,6))
C     Amplitude(s) for diagram number 51
      CALL FFV1_0(W(1,6),W(1,3),W(1,21),GC_2,AMP(51))
C     Amplitude(s) for diagram number 52
      CALL FFV1_3_0(W(1,6),W(1,3),W(1,22),GC_264,GC_203,AMP(52))
C     Amplitude(s) for diagram number 53
      CALL FFV1_0(W(1,6),W(1,3),W(1,23),GC_6,AMP(53))
      CALL FFV1_2(W(1,4),W(1,1),GC_6,MDL_MT, FK_MDL_WT,W(1,6))
C     Amplitude(s) for diagram number 54
      CALL FFV2_0(W(1,6),W(1,3),W(1,21),GC_357,AMP(54))
C     Amplitude(s) for diagram number 55
      CALL FFV1_0(W(1,6),W(1,3),W(1,21),GC_2,AMP(55))
C     Amplitude(s) for diagram number 56
      CALL FFV9_0(W(1,6),W(1,3),W(1,21),GC_358,AMP(56))
C     Amplitude(s) for diagram number 57
      CALL FFV2_0(W(1,6),W(1,3),W(1,21),GC_451,AMP(57))
C     Amplitude(s) for diagram number 58
      CALL FFV9_0(W(1,6),W(1,3),W(1,21),GC_452,AMP(58))
C     Amplitude(s) for diagram number 59
      CALL FFV2_0(W(1,6),W(1,3),W(1,22),GC_367,AMP(59))
C     Amplitude(s) for diagram number 60
      CALL FFV1_3_0(W(1,6),W(1,3),W(1,22),GC_264,GC_203,AMP(60))
C     Amplitude(s) for diagram number 61
      CALL FFV9_0(W(1,6),W(1,3),W(1,22),GC_369,AMP(61))
C     Amplitude(s) for diagram number 62
      CALL FFV5_0(W(1,6),W(1,3),W(1,22),GC_524,AMP(62))
C     Amplitude(s) for diagram number 63
      CALL FFV2_0(W(1,6),W(1,3),W(1,22),GC_441,AMP(63))
C     Amplitude(s) for diagram number 64
      CALL FFV9_0(W(1,6),W(1,3),W(1,22),GC_442,AMP(64))
C     Amplitude(s) for diagram number 65
      CALL FFV2_0(W(1,6),W(1,3),W(1,23),GC_351,AMP(65))
C     Amplitude(s) for diagram number 66
      CALL FFV1_0(W(1,6),W(1,3),W(1,23),GC_6,AMP(66))
C     Amplitude(s) for diagram number 67
      CALL FFV9_0(W(1,6),W(1,3),W(1,23),GC_352,AMP(67))
      CALL FFV9_2(W(1,4),W(1,1),GC_352,MDL_MT, FK_MDL_WT,W(1,24))
C     Amplitude(s) for diagram number 68
      CALL FFV1_0(W(1,24),W(1,3),W(1,21),GC_2,AMP(68))
C     Amplitude(s) for diagram number 69
      CALL FFV1_3_0(W(1,24),W(1,3),W(1,22),GC_264,GC_203,AMP(69))
C     Amplitude(s) for diagram number 70
      CALL FFV1_0(W(1,24),W(1,3),W(1,23),GC_6,AMP(70))
C     Amplitude(s) for diagram number 71
      CALL FFFF4_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_67,AMP(71))
C     Amplitude(s) for diagram number 72
      CALL FFFF4_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_68,AMP(72))
C     Amplitude(s) for diagram number 73
      CALL FFFF17_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_91,AMP(73))
C     Amplitude(s) for diagram number 74
      CALL FFFF18_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_117,AMP(74))
C     Amplitude(s) for diagram number 75
      CALL FFFF18_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_116,AMP(75))
C     Amplitude(s) for diagram number 76
      CALL FFFF17_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_92,AMP(76))
C     Amplitude(s) for diagram number 77
      CALL FFFF4_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_70,AMP(77))
C     Amplitude(s) for diagram number 78
      CALL FFFF4_0(W(1,6),W(1,3),W(1,5),W(1,2),GC_73,AMP(78))
      CALL FFV1_1(W(1,2),W(1,1),GC_6,ZERO, FK_ZERO,W(1,6))
C     Amplitude(s) for diagram number 79
      CALL FFV1_0(W(1,5),W(1,6),W(1,7),GC_2,AMP(79))
C     Amplitude(s) for diagram number 80
      CALL FFV1_0(W(1,5),W(1,6),W(1,8),GC_2,AMP(80))
C     Amplitude(s) for diagram number 81
      CALL FFV1_0(W(1,5),W(1,6),W(1,9),GC_2,AMP(81))
C     Amplitude(s) for diagram number 82
      CALL FFV1_0(W(1,5),W(1,6),W(1,10),GC_2,AMP(82))
C     Amplitude(s) for diagram number 83
      CALL FFV1_0(W(1,5),W(1,6),W(1,11),GC_2,AMP(83))
C     Amplitude(s) for diagram number 84
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,12),GC_264,GC_203,AMP(84))
C     Amplitude(s) for diagram number 85
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,13),GC_264,GC_203,AMP(85))
C     Amplitude(s) for diagram number 86
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,14),GC_264,GC_203,AMP(86))
C     Amplitude(s) for diagram number 87
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,15),GC_264,GC_203,AMP(87))
C     Amplitude(s) for diagram number 88
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,16),GC_264,GC_203,AMP(88))
C     Amplitude(s) for diagram number 89
      CALL FFV1_3_0(W(1,5),W(1,6),W(1,17),GC_264,GC_203,AMP(89))
C     Amplitude(s) for diagram number 90
      CALL FFV1_0(W(1,5),W(1,6),W(1,18),GC_6,AMP(90))
C     Amplitude(s) for diagram number 91
      CALL FFV1_0(W(1,5),W(1,6),W(1,19),GC_6,AMP(91))
C     Amplitude(s) for diagram number 92
      CALL FFV1_0(W(1,5),W(1,6),W(1,20),GC_6,AMP(92))
C     Amplitude(s) for diagram number 93
      CALL FFFF4_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_67,AMP(93))
C     Amplitude(s) for diagram number 94
      CALL FFFF4_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_68,AMP(94))
C     Amplitude(s) for diagram number 95
      CALL FFFF17_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_91,AMP(95))
C     Amplitude(s) for diagram number 96
      CALL FFFF18_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_117,AMP(96))
C     Amplitude(s) for diagram number 97
      CALL FFFF18_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_116,AMP(97))
C     Amplitude(s) for diagram number 98
      CALL FFFF17_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_92,AMP(98))
C     Amplitude(s) for diagram number 99
      CALL FFFF4_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_70,AMP(99))
C     Amplitude(s) for diagram number 100
      CALL FFFF4_0(W(1,4),W(1,3),W(1,5),W(1,6),GC_73,AMP(100))
C     Amplitude(s) for diagram number 101
      CALL VVV5_0(W(1,1),W(1,23),W(1,18),GC_7,AMP(101))
C     Amplitude(s) for diagram number 102
      CALL VVV5_0(W(1,1),W(1,23),W(1,19),GC_7,AMP(102))
C     Amplitude(s) for diagram number 103
      CALL VVV5_0(W(1,1),W(1,23),W(1,20),GC_7,AMP(103))
      CALL FFVV3P0_3(W(1,4),W(1,3),W(1,1),GC_386,ZERO, FK_ZERO,W(1,23))
C     Amplitude(s) for diagram number 104
      CALL FFV1_0(W(1,5),W(1,2),W(1,23),GC_6,AMP(104))
      CALL FFVV1P0_3(W(1,4),W(1,3),W(1,1),GC_385,ZERO, FK_ZERO,W(1,23))
C     Amplitude(s) for diagram number 105
      CALL FFV1_0(W(1,5),W(1,2),W(1,23),GC_6,AMP(105))
C     JAMPs contributing to orders ALL_ORDERS=1
      JAMP(1,1)=+1D0/2D0*(+AMP(53)+AMP(65)+AMP(66)+AMP(67)+AMP(70)
     $ +AMP(72)+AMP(74)+AMP(76)+AMP(78)+AMP(90)+AMP(91)+AMP(92)+AMP(94)
     $ +AMP(96)+AMP(98)+AMP(100)+IMAG1*AMP(101)+IMAG1*AMP(102)+IMAG1
     $ *AMP(103)-IMAG1*AMP(104)-IMAG1*AMP(105))
      JAMP(2,1)=+AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5)+AMP(6)+AMP(7)
     $ +AMP(8)+AMP(9)+AMP(10)+AMP(11)-1D0/6D0*AMP(12)-1D0/6D0*AMP(13)
     $ -1D0/6D0*AMP(14)+AMP(15)-1D0/6D0*AMP(16)+AMP(17)-1D0/6D0*AMP(18)
     $ +AMP(19)-1D0/6D0*AMP(20)+AMP(21)-1D0/6D0*AMP(22)+AMP(79)+AMP(80)
     $ +AMP(81)+AMP(82)+AMP(83)+AMP(84)+AMP(85)+AMP(86)+AMP(87)+AMP(88)
     $ +AMP(89)-1D0/6D0*AMP(90)-1D0/6D0*AMP(91)-1D0/6D0*AMP(92)+AMP(93)
     $ -1D0/6D0*AMP(94)+AMP(95)-1D0/6D0*AMP(96)+AMP(97)-1D0/6D0*AMP(98)
     $ +AMP(99)-1D0/6D0*AMP(100)
      JAMP(3,1)=+AMP(23)+AMP(24)-1D0/6D0*AMP(25)+AMP(26)+AMP(27)
     $ +AMP(28)+AMP(29)+AMP(30)+AMP(31)+AMP(32)+AMP(33)+AMP(34)+AMP(35)
     $ +AMP(36)-1D0/6D0*AMP(37)-1D0/6D0*AMP(38)-1D0/6D0*AMP(39)+AMP(40)
     $ +AMP(41)-1D0/6D0*AMP(42)+AMP(43)-1D0/6D0*AMP(44)+AMP(45)-1D0
     $ /6D0*AMP(46)+AMP(47)-1D0/6D0*AMP(48)+AMP(49)-1D0/6D0*AMP(50)
     $ +AMP(51)+AMP(52)-1D0/6D0*AMP(53)+AMP(54)+AMP(55)+AMP(56)+AMP(57)
     $ +AMP(58)+AMP(59)+AMP(60)+AMP(61)+AMP(62)+AMP(63)+AMP(64)-1D0
     $ /6D0*AMP(65)-1D0/6D0*AMP(66)-1D0/6D0*AMP(67)+AMP(68)+AMP(69)
     $ -1D0/6D0*AMP(70)+AMP(71)-1D0/6D0*AMP(72)+AMP(73)-1D0/6D0*AMP(74)
     $ +AMP(75)-1D0/6D0*AMP(76)+AMP(77)-1D0/6D0*AMP(78)
      JAMP(4,1)=+1D0/2D0*(+AMP(12)+AMP(13)+AMP(14)+AMP(16)+AMP(18)
     $ +AMP(20)+AMP(22)+AMP(25)+AMP(37)+AMP(38)+AMP(39)+AMP(42)+AMP(44)
     $ +AMP(46)+AMP(48)+AMP(50)-IMAG1*AMP(101)-IMAG1*AMP(102)-IMAG1
     $ *AMP(103)+IMAG1*AMP(104)+IMAG1*AMP(105))

      MATRIX3 = 0.D0
      DO M = 1, NAMPSO
        DO I = 1, NCOLOR
          ZTEMP = (0.D0,0.D0)
          DO J = 1, NCOLOR
            ZTEMP = ZTEMP + CF(J,I)*JAMP(J,M)
          ENDDO
          DO N = 1, NAMPSO
            IF (CHOSEN_SO_CONFIGS(SQSOINDEX3(M,N))) THEN
              MATRIX3 = MATRIX3 + ZTEMP*DCONJG(JAMP(I,N))/DENOM(I)
            ENDIF
          ENDDO
        ENDDO
      ENDDO

      AMP2(79)=AMP2(79)+(AMP(79)+AMP(80)+AMP(81)+AMP(82)+AMP(83))
     $ *DCONJG(AMP(79)+AMP(80)+AMP(81)+AMP(82)+AMP(83))
      AMP2(84)=AMP2(84)+(AMP(84)+AMP(85)+AMP(86)+AMP(87)+AMP(88)
     $ +AMP(89))*DCONJG(AMP(84)+AMP(85)+AMP(86)+AMP(87)+AMP(88)+AMP(89)
     $ )
      AMP2(90)=AMP2(90)+(AMP(90)+AMP(91)+AMP(92))*DCONJG(AMP(90)
     $ +AMP(91)+AMP(92))
      AMP2(23)=AMP2(23)+(AMP(23)+AMP(26)+AMP(27)+AMP(28)+AMP(29)
     $ +AMP(30)+AMP(40))*DCONJG(AMP(23)+AMP(26)+AMP(27)+AMP(28)+AMP(29)
     $ +AMP(30)+AMP(40))
      AMP2(24)=AMP2(24)+(AMP(24)+AMP(31)+AMP(32)+AMP(33)+AMP(34)
     $ +AMP(35)+AMP(36)+AMP(41))*DCONJG(AMP(24)+AMP(31)+AMP(32)+AMP(33)
     $ +AMP(34)+AMP(35)+AMP(36)+AMP(41))
      AMP2(25)=AMP2(25)+(AMP(25)+AMP(37)+AMP(38)+AMP(39)+AMP(42))
     $ *DCONJG(AMP(25)+AMP(37)+AMP(38)+AMP(39)+AMP(42))
      AMP2(51)=AMP2(51)+(AMP(51)+AMP(54)+AMP(55)+AMP(56)+AMP(57)
     $ +AMP(58)+AMP(68))*DCONJG(AMP(51)+AMP(54)+AMP(55)+AMP(56)+AMP(57)
     $ +AMP(58)+AMP(68))
      AMP2(52)=AMP2(52)+(AMP(52)+AMP(59)+AMP(60)+AMP(61)+AMP(62)
     $ +AMP(63)+AMP(64)+AMP(69))*DCONJG(AMP(52)+AMP(59)+AMP(60)+AMP(61)
     $ +AMP(62)+AMP(63)+AMP(64)+AMP(69))
      AMP2(53)=AMP2(53)+(AMP(53)+AMP(65)+AMP(66)+AMP(67)+AMP(70))
     $ *DCONJG(AMP(53)+AMP(65)+AMP(66)+AMP(67)+AMP(70))
      AMP2(1)=AMP2(1)+(AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5))
     $ *DCONJG(AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5))
      AMP2(6)=AMP2(6)+(AMP(6)+AMP(7)+AMP(8)+AMP(9)+AMP(10)+AMP(11))
     $ *DCONJG(AMP(6)+AMP(7)+AMP(8)+AMP(9)+AMP(10)+AMP(11))
      AMP2(12)=AMP2(12)+(AMP(12)+AMP(13)+AMP(14))*DCONJG(AMP(12)
     $ +AMP(13)+AMP(14))
      AMP2(101)=AMP2(101)+(AMP(101)+AMP(102)+AMP(103))*DCONJG(AMP(101)
     $ +AMP(102)+AMP(103))
      DO I = 1, NCOLOR
        DO M = 1, NAMPSO
          DO N = 1, NAMPSO
            IF (CHOSEN_SO_CONFIGS(SQSOINDEX3(M,N))) THEN
              JAMP2(I)=JAMP2(I)+DABS(DBLE(JAMP(I,M)*DCONJG(JAMP(I,N))))
            ENDIF
          ENDDO
        ENDDO
      ENDDO

      END

C     Set of functions to handle the array indices of the split orders


      INTEGER FUNCTION SQSOINDEX3(ORDERINDEXA, ORDERINDEXB)
C     
C     This functions plays the role of the interference matrix. It can
C      be hardcoded or 
C     made more elegant using hashtables if its execution speed ever
C      becomes a relevant
C     factor. From two split order indices, it return the
C      corresponding index in the squared 
C     order canonical ordering.
C     
C     CONSTANTS
C     

      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=1, NSQUAREDSO=1, NAMPSO=1)
C     
C     ARGUMENTS
C     
      INTEGER ORDERINDEXA, ORDERINDEXB
C     
C     LOCAL VARIABLES
C     
      INTEGER I, SQORDERS(NSO)
      INTEGER AMPSPLITORDERS(NAMPSO,NSO)
      DATA (AMPSPLITORDERS(  1,I),I=  1,  1) /    1/
      COMMON/AMPSPLITORDERS3/AMPSPLITORDERS
C     
C     FUNCTION
C     
      INTEGER SOINDEX_FOR_SQUARED_ORDERS3
C     
C     BEGIN CODE
C     
      DO I=1,NSO
        SQORDERS(I)=AMPSPLITORDERS(ORDERINDEXA,I)+AMPSPLITORDERS(ORDERI
     $NDEXB,I)
      ENDDO
      SQSOINDEX3=SOINDEX_FOR_SQUARED_ORDERS3(SQORDERS)
      END

      INTEGER FUNCTION SOINDEX_FOR_SQUARED_ORDERS3(ORDERS)
C     
C     This functions returns the integer index identifying the squared
C      split orders list passed in argument which corresponds to the
C      values of the following list of couplings (and in this order).
C     []
C     
C     CONSTANTS
C     
      INTEGER    NSO, NSQSO, NAMPSO
      PARAMETER (NSO=1, NSQSO=1, NAMPSO=1)
C     
C     ARGUMENTS
C     
      INTEGER ORDERS(NSO)
C     
C     LOCAL VARIABLES
C     
      INTEGER I,J
      INTEGER SQSPLITORDERS(NSQSO,NSO)
      DATA (SQSPLITORDERS(  1,I),I=  1,  1) /    2/
      COMMON/SQPLITORDERS3/SQPLITORDERS
C     
C     BEGIN CODE
C     
      DO I=1,NSQSO
        DO J=1,NSO
          IF (ORDERS(J).NE.SQSPLITORDERS(I,J)) GOTO 1009
        ENDDO
        SOINDEX_FOR_SQUARED_ORDERS3 = I
        RETURN
 1009   CONTINUE
      ENDDO

      WRITE(*,*) 'ERROR:: Stopping in function'
      WRITE(*,*) 'SOINDEX_FOR_SQUARED_ORDERS3'
      WRITE(*,*) 'Could not find squared orders ',(ORDERS(I),I=1,NSO)
      STOP

      END

      SUBROUTINE GET_NSQSO_BORN3(NSQSO)
C     
C     Simple subroutine returning the number of squared split order
C     contributions returned when calling smatrix_split_orders 
C     

      INTEGER    NSQUAREDSO
      PARAMETER  (NSQUAREDSO=1)

      INTEGER NSQSO

      NSQSO=NSQUAREDSO

      END

C     This is the inverse subroutine of SOINDEX_FOR_SQUARED_ORDERS.
C      Not directly useful, but provided nonetheless.
      SUBROUTINE GET_SQUARED_ORDERS_FOR_SOINDEX3(SOINDEX,ORDERS)
C     
C     This functions returns the orders identified by the squared
C      split order index in argument. Order values correspond to
C      following list of couplings (and in this order):
C     []
C     
C     CONSTANTS
C     
      INTEGER    NSO, NSQSO
      PARAMETER (NSO=1, NSQSO=1)
C     
C     ARGUMENTS
C     
      INTEGER SOINDEX, ORDERS(NSO)
C     
C     LOCAL VARIABLES
C     
      INTEGER I
      INTEGER SQPLITORDERS(NSQSO,NSO)
      COMMON/SQPLITORDERS3/SQPLITORDERS
C     
C     BEGIN CODE
C     
      IF (SOINDEX.GT.0.AND.SOINDEX.LE.NSQSO) THEN
        DO I=1,NSO
          ORDERS(I) =  SQPLITORDERS(SOINDEX,I)
        ENDDO
        RETURN
      ENDIF

      WRITE(*,*) 'ERROR:: Stopping function GET_SQUARED_ORDERS_FOR_SOIN'
     $ //'DEX3'
      WRITE(*,*) 'Could not find squared orders index ',SOINDEX
      STOP

      END SUBROUTINE

C     This is the inverse subroutine of getting amplitude SO orders.
C      Not directly useful, but provided nonetheless.
      SUBROUTINE GET_ORDERS_FOR_AMPSOINDEX3(SOINDEX,ORDERS)
C     
C     This functions returns the orders identified by the split order
C      index in argument. Order values correspond to following list of
C      couplings (and in this order):
C     []
C     
C     CONSTANTS
C     
      INTEGER    NSO, NAMPSO
      PARAMETER (NSO=1, NAMPSO=1)
C     
C     ARGUMENTS
C     
      INTEGER SOINDEX, ORDERS(NSO)
C     
C     LOCAL VARIABLES
C     
      INTEGER I
      INTEGER AMPSPLITORDERS(NAMPSO,NSO)
      COMMON/AMPSPLITORDERS3/AMPSPLITORDERS
C     
C     BEGIN CODE
C     
      IF (SOINDEX.GT.0.AND.SOINDEX.LE.NAMPSO) THEN
        DO I=1,NSO
          ORDERS(I) =  AMPSPLITORDERS(SOINDEX,I)
        ENDDO
        RETURN
      ENDIF

      WRITE(*,*) 'ERROR:: Stopping function GET_ORDERS_FOR_AMPSOINDEX3'
      WRITE(*,*) 'Could not find amplitude split orders index ',SOINDEX
      STOP

      END SUBROUTINE

C     This function is not directly useful, but included for
C      completeness
      INTEGER FUNCTION SOINDEX_FOR_AMPORDERS3(ORDERS)
C     
C     This functions returns the integer index identifying the
C      amplitude split orders passed in argument which correspond to
C      the values of the following list of couplings (and in this
C      order):
C     []
C     
C     CONSTANTS
C     
      INTEGER    NSO, NAMPSO
      PARAMETER (NSO=1, NAMPSO=1)
C     
C     ARGUMENTS
C     
      INTEGER ORDERS(NSO)
C     
C     LOCAL VARIABLES
C     
      INTEGER I,J
      INTEGER AMPSPLITORDERS(NAMPSO,NSO)
      COMMON/AMPSPLITORDERS3/AMPSPLITORDERS
C     
C     BEGIN CODE
C     
      DO I=1,NAMPSO
        DO J=1,NSO
          IF (ORDERS(J).NE.AMPSPLITORDERS(I,J)) GOTO 1009
        ENDDO
        SOINDEX_FOR_AMPORDERS3 = I
        RETURN
 1009   CONTINUE
      ENDDO

      WRITE(*,*) 'ERROR:: Stopping function SOINDEX_FOR_AMPORDERS3'
      WRITE(*,*) 'Could not find squared orders ',(ORDERS(I),I=1,NSO)
      STOP

      END

