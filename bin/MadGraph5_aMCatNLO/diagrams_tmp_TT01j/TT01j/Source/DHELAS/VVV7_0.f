C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     -(P(1,2)*P(2,3)*P(3,1)) + P(1,3)*P(2,1)*P(3,2) +
C      P(-1,2)*P(-1,3)*P(3,1)*Metric(1,2) - P(-1,1)*P(-1,3)*P(3,2)*Metr
C     ic(1,2) - P(-1,2)*P(-1,3)*P(2,1)*Metric(1,3) +
C      P(-1,1)*P(-1,2)*P(2,3)*Metric(1,3) + P(-1,1)*P(-1,3)*P(1,2)*Metr
C     ic(2,3) - P(-1,1)*P(-1,2)*P(1,3)*Metric(2,3)
C     
      SUBROUTINE VVV7_0(V1, V2, V3, COUP,VERTEX)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 V2(*)
      COMPLEX*16 V3(*)
      REAL*8 P1(0:3)
      COMPLEX*16 TMP22
      REAL*8 P2(0:3)
      COMPLEX*16 TMP23
      REAL*8 P3(0:3)
      COMPLEX*16 TMP69
      COMPLEX*16 TMP30
      COMPLEX*16 COUP
      COMPLEX*16 TMP26
      COMPLEX*16 TMP28
      COMPLEX*16 TMP27
      COMPLEX*16 TMP29
      COMPLEX*16 TMP24
      COMPLEX*16 VERTEX
      COMPLEX*16 TMP48
      COMPLEX*16 TMP25
      COMPLEX*16 V1(*)
      COMPLEX*16 TMP38
      P1(0) = DBLE(V1(1))
      P1(1) = DBLE(V1(2))
      P1(2) = DIMAG(V1(2))
      P1(3) = DIMAG(V1(1))
      P2(0) = DBLE(V2(1))
      P2(1) = DBLE(V2(2))
      P2(2) = DIMAG(V2(2))
      P2(3) = DIMAG(V2(1))
      P3(0) = DBLE(V3(1))
      P3(1) = DBLE(V3(2))
      P3(2) = DIMAG(V3(2))
      P3(3) = DIMAG(V3(1))
      TMP24 = (V3(3)*P2(0)-V3(4)*P2(1)-V3(5)*P2(2)-V3(6)*P2(3))
      TMP25 = (P1(0)*V2(3)-P1(1)*V2(4)-P1(2)*V2(5)-P1(3)*V2(6))
      TMP26 = (V3(3)*V1(3)-V3(4)*V1(4)-V3(5)*V1(5)-V3(6)*V1(6))
      TMP27 = (P3(0)*V2(3)-P3(1)*V2(4)-P3(2)*V2(5)-P3(3)*V2(6))
      TMP22 = (V2(3)*V1(3)-V2(4)*V1(4)-V2(5)*V1(5)-V2(6)*V1(6))
      TMP23 = (V3(3)*P1(0)-V3(4)*P1(1)-V3(5)*P1(2)-V3(6)*P1(3))
      TMP69 = (P1(0)*P2(0)-P1(1)*P2(1)-P1(2)*P2(2)-P1(3)*P2(3))
      TMP48 = (P3(0)*P1(0)-P3(1)*P1(1)-P3(2)*P1(2)-P3(3)*P1(3))
      TMP28 = (V3(3)*V2(3)-V3(4)*V2(4)-V3(5)*V2(5)-V3(6)*V2(6))
      TMP29 = (P2(0)*V1(3)-P2(1)*V1(4)-P2(2)*V1(5)-P2(3)*V1(6))
      TMP38 = (P3(0)*P2(0)-P3(1)*P2(1)-P3(2)*P2(2)-P3(3)*P2(3))
      TMP30 = (P3(0)*V1(3)-P3(1)*V1(4)-P3(2)*V1(5)-P3(3)*V1(6))
      VERTEX = COUP*(TMP22*(-CI*(TMP23*TMP38)+CI*(TMP24*TMP48))+(TMP25
     $ *(-CI*(TMP24*TMP30)+CI*(TMP26*TMP38))+(TMP27*(-CI*(TMP26*TMP69)
     $ +CI*(TMP23*TMP29))+TMP28*(-CI*(TMP29*TMP48)+CI*(TMP30*TMP69)))))
      END


