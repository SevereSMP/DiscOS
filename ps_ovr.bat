@echo off
:: Set your two image path variables here
set "MY_IMAGE=C:\path\to\your\car_image1.jpg"
set "ALT_IMAGE=C:\path\to\your\car_image2.jpg"

:: Verify both images exist before running
if not exist "%MY_IMAGE%" ( echo Error: First image not found at "%MY_IMAGE%" & pause & exit /b )
if not exist "%ALT_IMAGE%" ( echo Error: Second image not found at "%ALT_IMAGE%" & pause & exit /b )

:: Pre-resolve the file paths for PowerShell
set "KILL_FILE=%TEMP%\kill-ovr.txt"
set "ANS_FILE=%TEMP%\ans.txt"

:: Run PowerShell hidden, creating the interactive full-screen canvas
powershell -NoProfile -WindowStyle Hidden -Command "^
    Add-Type -AssemblyName System.Windows.Forms; ^
    Add-Type -AssemblyName System.Drawing; ^
    $form = New-Object System.Windows.Forms.Form; ^
    $form.FormBorderStyle = 'None'; ^
    $form.WindowState = 'Maximized'; ^
    $form.TopMost = $true; ^
    $form.StartPosition = 'Manual'; ^
    $form.Bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; ^
    $img1 = [System.Drawing.Image]::FromFile('%MY_IMAGE:\=\\%'); ^
    $img2 = [System.Drawing.Image]::FromFile('%ALT_IMAGE:\=\\%'); ^
    $global:currentImg = 1; ^
    $form.BackgroundImage = $img1; ^
    $form.BackgroundImageLayout = 'Stretch'; ^
    $form.KeyPreview = $true; ^
    $panel = New-Object System.Windows.Forms.Panel; ^
    $panel.Size = New-Object System.Drawing.Size($form.Width, 60); ^
    $panel.Location = New-Object System.Drawing.Point(0, $form.Height - 80); ^
    $panel.BackColor = [System.Drawing.Color]::FromArgb(150, 0, 0, 0); ^
    $panel.Visible = $false; ^
    $textBox = New-Object System.Windows.Forms.TextBox; ^
    $textBox.Font = New-Object System.Drawing.Font('Arial', 14); ^
    $textBox.Location = New-Object System.Drawing.Point(50, 15); ^
    $textBox.Size = New-Object System.Drawing.Size($form.Width - 250, 30); ^
    $btn = New-Object System.Windows.Forms.Button; ^
    $btn.Text = 'Submit'; ^
    $btn.Font = New-Object System.Drawing.Font('Arial', 12, [System.Drawing.FontStyle]::Bold); ^
    $btn.ForeColor = [System.Drawing.Color]::White; ^
    $btn.BackColor = [System.Drawing.Color]::DarkBlue; ^
    $btn.Location = New-Object System.Drawing.Point($form.Width - 180, 12); ^
    $btn.Size = New-Object System.Drawing.Size(120, 35); ^
    $btn.Add_Click({ ^
        if ($textBox.Text -ne '') { ^
            $textBox.Text | Out-File '%ANS_FILE:\=\\%' -Encoding utf8; ^
            $textBox.Text = ''; ^
            $panel.Visible = $false; ^
            $form.Focus(); ^
        } ^
    }); ^
    $panel.Controls.Add($textBox); ^
    $panel.Controls.Add($btn); ^
    $form.Controls.Add($panel); ^
    $timer = New-Object System.Windows.Forms.Timer; ^
    $timer.Interval = 500; ^
    $timer.Add_Tick({ ^
        if (Test-Path '%KILL_FILE:\=\\%') { ^
            Remove-Item '%KILL_FILE:\=\\%' -Force -ErrorAction SilentlyContinue; ^
            $timer.Stop(); ^
            $form.Close(); ^
            [System.Windows.Forms.Application]::Exit(); ^
        } ^
    }); ^
    $timer.Start(); ^
    $form.Add_KeyDown({ ^
        if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Escape) { ^
            $form.Close(); ^
            [System.Windows.Forms.Application]::Exit(); ^
        } elseif ($_.KeyCode -eq [System.Windows.Forms.Keys]::K) { ^
            if ($global:currentImg -eq 1) { ^
                $form.BackgroundImage = $img2; ^
                $global:currentImg = 2; ^
                $panel.Visible = $true; ^
                $textBox.Focus(); ^
            } else { ^
                $form.BackgroundImage = $img1; ^
                $global:currentImg = 1; ^
                $panel.Visible = $false; ^
            } ^
        } ^
    }); ^
    [System.Windows.Forms.Application]::Run($form);"
