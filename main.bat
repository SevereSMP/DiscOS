@echo off
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

if %ans% equ 