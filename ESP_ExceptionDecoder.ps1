
#Push-Location ".\.pio\build"
[array]$ProjectEnvironments= (Get-ChildItem .\.pio\build -Exclude 'project.checksum').Name

[string]$elf_file=""
$i=1
[uint16]$ProjectIndex=1

do
{
    $i=1
    Clear-Host
    if ($ProjectIndex -notin 1..$ProjectEnvironments.Count){
        Write-Host "Select a valid one!!!"
        $i=1
    }
    Write-Host "Choose project environment"
    Write-Host ""
    $ProjectEnvironments | %{ Write-Host "[$($i;$i++)] $_" }

    $ProjectIndex= [string][console]::ReadKey().KeyChar

} while ($ProjectIndex -notin 1..$ProjectEnvironments.Count)
$elf_file= ".\.pio\build\$($ProjectEnvironments[$ProjectIndex-1])\firmware.elf"



### analizying ELF to select correct ESP decoder .exe ###
Write-Host ""
Write-Host ""
Write-Host "Analyzing ELF file, please wait..."
Write-Host ""
if (Get-Content $elf_file | Select-String -SimpleMatch "xtensa-lx106-elf" -Quiet)
{
    ### Select ESP8266 decoder
    $addr2line_exe= $env:USERPROFILE+"\.platformio\packages\toolchain-xtensa\bin\xtensa-lx106-elf-addr2line.exe"
    Write-Host "ESP8266 ELF detected!!!"
}
elseif (Get-Content $elf_file | Select-String -SimpleMatch "xtensa-esp32-elf" -Quiet)
{
    ### Select ESP32 decoder
    $addr2line_exe= $env:USERPROFILE+"\.platformio\packages\toolchain-xtensa-esp32\bin\xtensa-esp32-elf-addr2line.exe"
    Write-Host "ESP32 ELF detected!!!"
}
else
{
    Write-Host "FAILED TO DETERMINE PROCESSOR!!!`n ABORTING..." -ForegroundColor Red -BackgroundColor Black
    Start-Sleep -Seconds 5
    exit
}

Start-Sleep -Seconds 3

### input hexas


Clear-Host
Write-Host "Input Exception data"
Write-Host "Enter a empty line to continue"

[System.Array]$ExceptionData=@()
do {
    $ExceptionData+= Read-Host
} while ($ExceptionData[-1] -ne "")
$ExceptionData = $ExceptionData|?{$_}


    ### Process prepare... ###
$ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
$ProcessInfo.FileName = $addr2line_exe
$ProcessInfo.WorkingDirectory = Get-Location
$ProcessInfo.CreateNoWindow = $true
$ProcessInfo.RedirectStandardError = $true
$ProcessInfo.RedirectStandardOutput = $true
$ProcessInfo.UseShellExecute = $false
$ProcessInfo.Arguments=  "-a -p -f -C -r -e $elf_file $ExceptionData"
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $ProcessInfo
    ##########################

    ### Start processing... & Set priority ###
$p.Start() | Out-Null
    ###########################

Clear-Host
Write-Host "RESULT:"
Write-Host ""
Write-Host ""
Write-Host ""
$p.StandardOutput.ReadToEnd()
Write-Host ""
Write-Host ""
Write-Host ""
pause

#Pop-Location