C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     ProjP(2,1)*ProjP(4,3) + ProjM(2,1)*ProjM(4,3)
C     
      SUBROUTINE FFFF27_1(F2, F3, F4, COUP, M1, W1,F1)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 F2(*)
      COMPLEX*16 COUP
      COMPLEX*16 TMP111
      REAL*8 P1(0:3)
      REAL*8 M1
      REAL*8 W1
      COMPLEX*16 F1(6)
      COMPLEX*16 DENOM
      COMPLEX*16 F3(*)
      COMPLEX*16 TMP50
      COMPLEX*16 F4(*)
      F1(1) = +F2(1)+F3(1)+F4(1)
      F1(2) = +F2(2)+F3(2)+F4(2)
      P1(0) = -DBLE(F1(1))
      P1(1) = -DBLE(F1(2))
      P1(2) = -DIMAG(F1(2))
      P1(3) = -DIMAG(F1(1))
      TMP50 = (F4(5)*F3(5)+F4(6)*F3(6))
      TMP111 = (F4(3)*F3(3)+F4(4)*F3(4))
      DENOM = COUP/(P1(0)**2-P1(1)**2-P1(2)**2-P1(3)**2 - M1 * (M1 -CI
     $ * W1))
      F1(3)= DENOM*(-CI)*(TMP50*(F2(5)*(P1(0)+P1(3))+F2(6)*(P1(1)+CI
     $ *(P1(2))))-F2(3)*M1*TMP111)
      F1(4)= DENOM*CI*(TMP50*(F2(5)*(+CI*(P1(2))-P1(1))+F2(6)*(P1(3)
     $ -P1(0)))+F2(4)*M1*TMP111)
      F1(5)= DENOM*CI*(TMP111*(F2(3)*(P1(3)-P1(0))+F2(4)*(P1(1)+CI
     $ *(P1(2))))+F2(5)*M1*TMP50)
      F1(6)= DENOM*(-CI)*(TMP111*(F2(3)*(+CI*(P1(2))-P1(1))+F2(4)
     $ *(P1(0)+P1(3)))-F2(6)*M1*TMP50)
      END


