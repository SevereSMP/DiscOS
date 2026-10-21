@echo off
setlocal enabledelayedexpansion
cls
title DiscOS
if %1 equ "/oi" goto installer
if %1 equ "/?" (
    echo ------ DiscOS ------
    echo CMDLN ARGS
    echo *NONE* ...........  Open Main Menu
    echo /oi ..............  Open Setup Menu
)

::CMDLN ARGS
:: /oi ........ Open Setup Directly

echo ------ DiscOS ------
echo 1. Open Installer
echo 2. Run Test (Not)
echo 3. Edit Licence Keys (Not)
echo 4. Options (Not)
echo 5. Uninstaller (Not)
echo ------ DiscOS ------
set /p "ans=Enter One Of The Above [1-4]: "

::Choose ANS
if %ans% equ 1 goto installer

echo Thats Not A Valid Answer.
pause
cls
exit

::Real Codes

::Installer Code
:installer
cls
title DiscOS_Installer
echo ------ DiscOS Installer ------
echo 1. Run Full Setup
echo 2. Auto Run
echo    ^|- 2A. Add Auto Run Scheduler Task
echo    ^+- 2B. Remove Auto Run Scheduler Task
echo 3. Install Deps.
echo 4. Check For Updates (*Reqires Deps)
echo 5. Back
echo ------ DiscOS Installer ------
set /p "ans=Enter One Of The Above [1-5/AB]: "


::procec ans

if %ans% equ 1 (
    title DiscOS_Setup
    cls
    set /p "nk=Enter Your Licence Key: "
    for /f "delims=" %%i in ('curl -s "https://cmds.severesmp.org/bash_proj/discos/keys/kmgt.php?key=!nk!&has-src=valid"') do set "ansc=%%i"
    if !ansc! equ "true" (
        echo The Key Seems To Be Valid!
        setx dskKey !nk!
    ) else if !ansc! equ "false" (
        echo That Key Does Not Seem To Be Valid Anymore!
        pause
        exit
    ) else (
        echo That Key Seems To Be Wrong!
        pause
        exit
    )
    cls
    echo ------ DiscOS Setup ------
    echo Licence Key: !nk!
    echo Copy Core Files: Next
    echo Downloaded Image Files: ???
    echo Chose OS: ???
    echo Add Scheduler Task: ???
    echo ------ DiscOS Setup ------
    pause
    cls
    echo ------ DiscOS Setup ------
    echo Licence Key: !nk!
    echo Copy Core Files: Running
    echo Downloaded Image Files: ???
    echo Chose OS: ???
    echo Add Scheduler Task: ???
    echo ------ DiscOS Setup ------
    set /p "ans=Would You Like to Copy Core files [Y/N]: "

    if !ans! equ y (

    )
)