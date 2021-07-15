@echo off
SetLocal EnableDelayedExpansion

rem repositories
set repos[0]=eo-engine
set repos[1]=eo-core
set repos[2]=fed-core
set repos[3]=fed-documentformats
set repos[4]=eo-np
set repos[5]=eo-employees
set repos[6]=sbis-sbis3controls
set repos[7]=saby-wasaby-controls
set repos[8]=eo-employees
set reposCount=8

rem commands
set comands[0]=all
set comands[1]=rt
set comands[2]=df
set comands[3]=eo
set comands[4]=pl
set comandsCount=4

rem relations
set all=0 1 2 3 4 5 6 7 8
set rt=0 1 2 4 8
set df=3
set eo=4 5
set pl=6 7

echo Avaliable repositories:
for /L %%r in (0, 1, %reposCount%) do (
    echo %%r - !repos[%%r]!
)
echo /

echo Avaliable commands:
for /L %%c in (0, 1, %comandsCount%) do (
    echo %%c - !comands[%%c]!
)

set /P selectedRepos="Enter your choice: "

for %%r in (%selectedRepos%) do (
    for /L %%c in (0, 1, %comandsCount%) do (
        if %%r==!comands[%%c]! (
            set selected=!comands[%%c]!
        )
    )
)
if defined selected (
    set selectedRepos=!%selected%!
)

for %%r in (%selectedRepos%) do (
    echo %%r - !repos[%%r]!
)
echo /

set /P bn="Enter current brunch name: "
for %%r in (%selectedRepos%) do (
    echo on
    @cd G:\repos\!repos[%%r]!
    git -c http.sslBackend=schannel -c core.quotepath=false -c log.showSignature=false checkout -b  %bn% origin/%bn%
    git -c http.sslBackend=schannel -c core.quotepath=false -c log.showSignature=false checkout %bn%
    git -c http.sslBackend=schannel -c core.quotepath=false -c log.showSignature=false -c core.commentChar= pull --no-stat -v --progress origin %bn%
    @echo off
)
echo /

echo Change brunches done
pause
exit