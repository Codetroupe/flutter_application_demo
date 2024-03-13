[Setup]
AppName=flutter_application_demo
AppVersion=1.0
DefaultDirName={pf}\flutter_application_demo
DefaultGroupName=flutter_application_demo
UninstallDisplayIcon={app}\flutter_application_demo.exe
OutputDir=..\build\windows\install

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs

[Icons]
Name: "{commonprograms}\flutter_application_demo"; Filename: "{app}\flutter_application_demo.exe"

[Run]
Filename: "{app}\flutter_application_demo.exe"; Description: "Run flutter_application_demo"; Flags: postinstall nowait