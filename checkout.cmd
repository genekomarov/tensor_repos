@echo off
SetLocal EnableDelayedExpansion

rem repositories
set repos[0]=eo-engine
set repos[1]=eo-core
set repos[2]=fed-core
set repos[3]=fed-documentformats

set repos[4]=sbis-engine
set repos[5]=sbis-sbis3controls
set repos[6]=saby-wasaby-controls
set repos[7]=saby-ui
set repos[8]=sbis-rmi
set repos[9]=saby-types
set repos[10]=sbis-sdn
set repos[11]=sbis-ws
set repos[12]=saby-wasaby-app
set repos[13]=saby-i18n
set repos[14]=saby-wasaby-requirejs-loader
set repos[15]=sbis-permission
set repos[16]=saby-inferno

set reposCount=16

rem commands
set comands[0]=all
set comands[1]=rt
set comands[2]=df
set comands[3]=eo
set comands[4]=pl
set comandsCount=4

rem relations
set all=0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
set rt=0 1 2
set df=3
set pl=4 5 6 7 8 9 10 11 12 13 14 15 16

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