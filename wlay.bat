@echo off
setlocal

:: 1. SET THE PATH TO YOUR IMAGE (Change this to your actual image path)
set "IMAGE_PATH=C:\path\to\your\image.jpg"

:: 2. Create a temporary PowerShell script
set "PS_SCRIPT=%TEMP%\OverlayImage.ps1"

(
echo Add-Type -AssemblyName System.Windows.Forms
echo $form = New-Object System.Windows.Forms.Form
echo $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
echo $form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
echo $form.TopMost = $true
echo $form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual
echo $form.Location = New-Object System.Drawing.Point^(0,0^)
echo $form.Size = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size
echo.
echo $img = [System.Drawing.Image]::FromFile^("%IMAGE_PATH:\=\\%"^)
echo $pictureBox = New-Object System.Windows.Forms.PictureBox
echo $pictureBox.Dock = [System.Windows.Forms.DockStyle]::Fill
echo $pictureBox.Image = $img
echo $pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Stretch
echo.
echo $form.Controls.Add^($pictureBox^)
echo.
echo :: Close the image if the user presses the 'ESC' key
echo $form.KeyPreview = $true
echo $form.Add_KeyDown^({
echo     if ^($_.KeyCode -eq [System.Windows.Forms.Keys]::Escape^) { $form.Close^(^); $img.Dispose^(^) }
echo ^}^)
echo.
echo [System.Windows.Forms.Application]::Run^($form^)
) > "%PS_SCRIPT%"

:: 3. Run the PowerShell script hidden in the background
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%PS_SCRIPT%"

:: 4. Clean up the temporary file after it closes
del "%PS_SCRIPT%"
endlocal
