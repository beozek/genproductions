C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     ProjM(2,3)*ProjM(4,1) + ProjP(2,3)*ProjP(4,1)
C     
      SUBROUTINE FFFF112_4(F1, F2, F3, COUP, M4, W4,F4)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 DENOM
      REAL*8 W4
      COMPLEX*16 F1(*)
      COMPLEX*16 TMP47
      COMPLEX*16 F2(*)
      COMPLEX*16 F3(*)
      REAL*8 M4
      REAL*8 P4(0:3)
      COMPLEX*16 TMP95
      COMPLEX*16 COUP
      COMPLEX*16 F4(6)
      F4(1) = +F1(1)+F2(1)+F3(1)
      F4(2) = +F1(2)+F2(2)+F3(2)
      P4(0) = -DBLE(F4(1))
      P4(1) = -DBLE(F4(2))
      P4(2) = -DIMAG(F4(2))
      P4(3) = -DIMAG(F4(1))
      TMP95 = (F2(3)*F3(3)+F2(4)*F3(4))
      TMP47 = (F2(5)*F3(5)+F2(6)*F3(6))
      DENOM = COUP/(P4(0)**2-P4(1)**2-P4(2)**2-P4(3)**2 - M4 * (M4 -CI
     $ * W4))
      F4(3)= DENOM*CI*(TMP47*(F1(5)*(P4(0)-P4(3))+F1(6)*(+CI*(P4(2))
     $ -P4(1)))+F1(3)*M4*TMP95)
      F4(4)= DENOM*(-CI)*(TMP47*(F1(5)*(P4(1)+CI*(P4(2)))-F1(6)*(P4(0)
     $ +P4(3)))-F1(4)*M4*TMP95)
      F4(5)= DENOM*(-CI)*(TMP95*(F1(3)*(-1D0)*(P4(0)+P4(3))+F1(4)*(+CI
     $ *(P4(2))-P4(1)))-F1(5)*M4*TMP47)
      F4(6)= DENOM*CI*(TMP95*(F1(3)*(P4(1)+CI*(P4(2)))+F1(4)*(P4(0)
     $ -P4(3)))+F1(6)*M4*TMP47)
      END


