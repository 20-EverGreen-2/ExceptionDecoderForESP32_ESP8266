# ExceptionDecoderForESP32_ESP8266
Exception decoder powershell script for ESP8266 &amp; ESP32

How to install:
1. Copy .ps1 file to your root proyect folder. Example: %USERPROFILE%\Documents\PlatformIO\Projects\MY_ESP_PROJECT (In other words, where platformio.ini is located)
2. Thats all folk's!!!


How to use:
1. Compile & upload your project.
2. Get exception data from serial monitor (Copy all hexa codes, but not empty lines).
3. Open new terminal on VS Code and run script (Normally you only need to write script name and press Enter). Example: .\ESP_ExceptionDecoder.ps1 ( DO NOT forget the .\ at begin or you get a CommandNotFoundException).
4. Select your correct environment. (script analyze your .elf automatically to select the correct addr2line.exe).
5. Paste backtrace with right mouse click.
6. Press enter and you get exception data decoded!!!



How to generate a exception:
1. Make a object of any class.
2. delete object with Arduino function. Example: delete &ClassNameToDelete;
3. on setup() or loop() call any functions of the deleted class.



Additional info:
Script tested under Windows + VS Code + PlatformIO + Arduino Framework.
Script not tested on VS Code linux version!!!.
Script not tested on ESP-IDF framework!!!.
