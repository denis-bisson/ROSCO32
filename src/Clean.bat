::********************************************************************************
::* ROSCO32                                                                      *
::* -----------------------------------------------------------------------------*
::* Application to make some fun with past draw results of Loto-Québec 6/49      *
::* lottery draw results.                                                        *
::* May be executed prior build, commmit, backup, etc. to remove unused files.   *
::* Written by Denis Bisson, Drummondville, Québec, 2021-09-16.                  *
::* -----------------------------------------------------------------------------*
::* Originally written by Denis Bisson, Drummondville, Québec, Canada            *
::*   https://github.com/denis-bisson/                                           *
::*   2021-09-16                                                                 *
::* -----------------------------------------------------------------------------*
::* You should not remove these comments.                                        *
::********************************************************************************
::*
@ECHO off
ECHO "Cleaning files..."
RD /Q /S __recovery
RD /Q /S __history
DEL /Q /S *.dcu
DEL /Q /S *.local
DEL /Q /S *.res
DEL /Q /S *.map
DEL /Q /S *.drc
DEL /Q /S *.stat
DEL /Q /S *.local
DEL /Q /S *.~dsk
DEL /Q /S *.identcache
DEL /Q /S *.dsk
DEL /Q /S *.tvsconfig
DEL /Q /S *.groupproj
DEL Rosco32.exe
ECHO "Clean is done!"
