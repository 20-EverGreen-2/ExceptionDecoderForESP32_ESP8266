# ExceptionDecoderForESP32_ESP8266
Exception decoder powershell script for ESP8266 &amp; ESP32

How to install:
1. Copy .ps1 file to your root proyect folder. Example: %USERPROFILE%\Documents\PlatformIO\Projects\MY_ESP_PROJECT
2. Thats all folk's!!!

How to use:

1. Compile & upload your project.
2. Get exception data from serial monitor (Copy all hexa codes, but not empty lines).
3. Open new terminal on VS Code and run script (Normally you only need to write script name and press Enter).
4. Select your correct environment. (script analyze your .elf automatically to select the correct addr2line.exe).
5. Paste backtrace with right mouse click.
6. Press enter and you get exception data decoded!!!



Script not tested on VS Code linux version!!!
