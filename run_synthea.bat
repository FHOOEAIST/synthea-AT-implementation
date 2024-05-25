@echo off
@rem ##########################################################################
@rem
@rem  Synthea launcher for Windows
@rem
@rem ##########################################################################
setlocal EnableDelayedExpansion

IF "%~1" == "" (
  @rem Just run Synthea with no args
  gradlew.bat run
  
) ELSE (
  @rem Running Synthea with arguments
  @rem For simplicity, do nothing and just pass the args to gradle
  SET syntheaArgs= 

  :loop
  if "%~1"=="" goto run
  SET syntheaArgs=!syntheaArgs!'%~1',
  shift
  goto loop

  :run
  gradlew.bat run -Params="[!syntheaArgs!]"
)
