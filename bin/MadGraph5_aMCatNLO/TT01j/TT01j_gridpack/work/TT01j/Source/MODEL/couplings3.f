ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c      written by the UFO converter
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      SUBROUTINE COUP3()

      IMPLICIT NONE
      INCLUDE 'model_functions.inc'

      DOUBLE PRECISION PI, ZERO
      PARAMETER  (PI=3.141592653589793D0)
      PARAMETER  (ZERO=0D0)
      INCLUDE 'input.inc'
      INCLUDE 'coupl.inc'
      GC_385 = (MDL_CTGIM*MDL_COMPLEXI*G*MDL_VEVHAT)
     $ /(MDL_LAMBDASMEFT__EXP__2*MDL_SQRT__2)
      GC_386 = (MDL_CTGRE*G*MDL_VEVHAT)/(MDL_LAMBDASMEFT__EXP__2
     $ *MDL_SQRT__2)
      GC_6 = -(MDL_COMPLEXI*G)
      GC_7 = G
      GC_8 = MDL_COMPLEXI*MDL_G__EXP__2
      END
