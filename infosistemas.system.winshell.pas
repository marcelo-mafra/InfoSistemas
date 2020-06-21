unit infosistemas.system.winshell;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses SysUtils, WinApi.Windows, Forms, WinApi.Messages, System.Win.Registry, ActiveX,
     ShlObj, ShellAPI, System.Win.ComObj,  mmsystem, winsock, Classes, Controls,
     winsvc, TlHelp32, AnsiStrings;

const
  SHFMT_ID_DEFAULT = $FFFF;
  SHFMT_OPT_QUICKFORMAT = $0000;
 // SHFMT_OPT_FULL = $1111;
  //SHFMT_OPT_SYSONLY = $2222;

type
  EShellOleError = class(Exception);
  EInvalidDest = class(EStreamError);
  EFCantMove = class(EStreamError);

  { operating system (OS)constants }
  TOSIdentifier = class
    const
     cOsUnknown: integer = -1;
     cOsWin95: integer = 0;
     cOsWin98: integer = 1;
     cOsWin98SE: integer = 2;
     cOsWinME: integer = 3;
     cOsWinNT: integer = 4;
     cOsWin2000: integer = 5;
     cOsXP: integer = 6;
     cOsVista: integer = 7;
     cOsSeven: integer = 8;
     csOsEight: integer = 9;
     csOsTen: integer = 10;
  end;

  //Comandos conhecidos pela Shell e o Explorer.exe.
  TShellCommands = class
   const ExplorerFileCmd: string = 'explorer.exe';
   const OpenCmd: string = 'OPEN';
   const Rundll32Cmd: string = 'rundll32.exe shell32.dll,Control_RunDLL ';
   const SelectParamCmd: string = '/select,';
  end;

  TShellNetworkInfo = class
   const FolderSeparator: string = '\';
   const InvalidIPMsg: string = 'O endereço de IP é inválido!';
   const IPNumberMask: string = '.';
   const LocalHostIP: string = '127.0.0.1';
  end;

  //Info de arquivos de atalhos.
  TShellFilesInfo = class
    const LinkExtension: string = 'lnk';
  end;

  TShellLinkInfo = class
    PathName: string;
    Arguments: string;
    Description: string;
    WorkingDirectory: string;
    IconLocation: string;
    IconIndex: integer;
    ShowCmd: integer;
    HotKey: word;
  end;

  //Tipos de arquivos binários de diversos S.O's e arquivos.
  TShellWinBinaryType = class
    const Win16Bin: string = 'Executável do Win16';
    const Win32Bin: string = 'Executável do Win32';
    const Win64Bin: string = 'Executável do Win64';
    const MSDOSBin: string = 'Executável do DOS';
    const OS216Bin: string = 'Executável OS/2 16 bits';
    const PIFFileBin: string = 'Arquivo PIF';
    const POSIXBin: string = 'Executável POSIX';
    const UnknownBin: string = 'Executável desconhecido';
    const NotBinFile: string = 'O arquivo não é um executável';
  end;

  TSpecialFolderInfo = record
    Name: string;
    ID: Integer;
  end;

type
  TFileVersionInfo = record
    FileType,
    CompanyName,
    FileDescription,
    FileVersion,
    InternalName,
    LegalCopyRight,
    LegalTradeMarks,
    OriginalFileName,
    ProductName,
    ProductVersion,
    Comments,
    SpecialBuildStr,
    PrivateBuildStr,
    FileFunction: string;
    DebugBuild,
    PreRelease,
    SpecialBuild,
    PrivateBuild,
    Patched,
    InfoInferred: Boolean;
  end;

 TShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU, _OTHERFOLDER);


 TWinShell = class
  class function CreateShellLink(const AppName, Desc: string;
     Dest: Integer): string; overload;
  class function CreateShellLink(SourceFileName: string; Location: TShortcutType;
     SubFolder, WorkingDir, Parameters, Description: string): string; overload;
  class procedure GetShellLinkInfo(const LinkFile: WideString; var SLI: TShellLinkInfo);
  class procedure SetShellLinkInfo(const LinkFile: WideString; const SLI: TShellLinkInfo);
  class function GetLongFileName(Const FileName : String) : String;
  class function GetShortName(sLongName : string): string;
  class function HasSoundCard:Boolean;
  class function GetFileVersion: String;
  class function GetComputerName: string;
  class procedure AddToStartDocumentsMenu(sFilePath: string);
  class function DeleteFileWithUndo(sFileName: string): boolean;
  class function IsFileInUse(fName : string ) : boolean;
  class function GetExeType(Filename:string):string;
  class procedure GetInfoSys(Info: TStrings);
  class function GetWinUserLogin: String;
  class function GetNetworkDriveMappings(sl: TStrings) : integer;
  class function GetNetStationInfo(Tipo:Integer) : string;
  class procedure GetCDROMDrives(list: TStrings);
  class procedure GetDialUpConnection(ConnectionList: TStrings);
  class procedure DragForm(Form: TForm);
  class function CreateProgramGroup(Foldername: string; aLocation: integer): boolean;
  class function GetFileSize(const FileName: string): LongInt;
  class function GetFileDateTime(const FileName: string): TDateTime;
  class function HasAttr(const FileName: string; Attr: Word): Boolean;
  class function ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
  class function GetPortAddress(PortNo: integer): word; //assembler; stdcall;
  class function GetCurrentUserName: string;
  class procedure HideTaskBarIcon(Handle: HWND);
  class function GetOperatingSystem: Integer;
  class function IsWinNT32: Boolean;
  class function IsWin2000: Boolean;
  class function IsWinME: Boolean;
  class function IsWIn95: Boolean;
  class function IsWinXP: Boolean;
  class function IsWinVista: Boolean;
  class function IsWin7: boolean;
  class function IsWin8: boolean;
  class function XPThemeActive: boolean;
  class function UserIsAdministrator: boolean;
  class procedure SendEmail(Handle: THandle; EMail, Subject, CCEmail, BCCEmail, Body: string);
  class function EmailIsValid(const s: string): boolean;
  class procedure SetClockStatus(const Show: boolean);
  class procedure ChangeShellClock(const Year, Month, Day, Hour, Minute, Second: word);
  class function FormatDrive(Handle: HWND; Drive, ID, Options: Word): LongInt;
  class function FileVersionInfo(const sAppNamePath: TFileName): TFileVersionInfo;

//Manipulação de arquivos e programas
  class procedure OpenFile(FileName: string);
  class procedure PrintFile(FileName: string);
  class procedure OpenProgram(prog, params: string);
  class procedure BrowseToURL(const Url: string);
  class function ExecAndWait(const FileName, Params: string; WindowState: Word): Boolean;
  class function ExecCmdLineAndWait(const CmdLine: string; WindowState: Word): Boolean;
  class function OpenCmdLine(const CmdLine: string; WindowState: Word): Boolean;
  class function GetLongIP(IP : string) : string;
  class function GetShortIP(const S: string): string;
  class procedure StartScreenSave(Handle: THandle);
  class function CanHibernate: Boolean;
  class procedure GoToFile(Handle: HWND; FileName: TFileName);
  class function ProcessExists(exeFileName: string): Boolean;

//Manipulação de serviços
  class procedure DisableXPFirewal;
  class procedure OpenLocalEventLogService;
  class procedure OpenRemoteEventLogService(const ComputerName: string);
  class function GetServiceStatus(sMachine, sService: PChar): DWORD;
 end;

 TShellFolders = class
  class function GetWinDir: String;
  class function GetSysDir: String;
  class function GetTempDir : string;
  class function GetMyDocumentsDir: string;
  class function GetCommonAppDataFolder: string;
  class function GetMyAppDataFolder: string;
  class function GetMyLocalAppDataFolder: string;
  class function GetCommonDocumentsFolder: string;
  class function GetProgramsFilesFolder: string;
  class function GetSpecialFolderPath(Folder: Integer;
     CanCreate: Boolean): string;
  class function GetPreviousDir(const Directory: string): string; overload;
  class function GetPreviousDir(const FileName: TFileName;
     RelativePath: boolean): string; overload;
  class function CreateFolder(const FolderName: string): boolean;
  class function FolderExists(const FolderName: string): boolean;
  class function FolderIsEmpty(const FolderName: string): boolean;    
 end;


 function SHFormatDrive(Handle: HWND; Drive, ID, Options: Word): LongInt; stdcall; external 'shell32.dll' name 'SHFormatDrive';

 const

  SpecialFolders: array[0..29] of TSpecialFolderInfo = (
    (Name: 'Alt Startup'; ID: CSIDL_ALTSTARTUP),
    (Name: 'Application Data'; ID: CSIDL_APPDATA),
    (Name: 'Recycle Bin'; ID: CSIDL_BITBUCKET),
    (Name: 'Common Alt Startup'; ID: CSIDL_COMMON_ALTSTARTUP),
    (Name: 'Common Desktop'; ID: CSIDL_COMMON_DESKTOPDIRECTORY),
    (Name: 'Common Favorites'; ID: CSIDL_COMMON_FAVORITES),
    (Name: 'Common Programs'; ID: CSIDL_COMMON_PROGRAMS),
    (Name: 'Common Start Menu'; ID: CSIDL_COMMON_STARTMENU),
    (Name: 'Common Startup'; ID: CSIDL_COMMON_STARTUP),
    (Name: 'Controls'; ID: CSIDL_CONTROLS),
    (Name: 'Cookies'; ID: CSIDL_COOKIES),
    (Name: 'Desktop'; ID: CSIDL_DESKTOP),
    (Name: 'Desktop Directory'; ID: CSIDL_DESKTOPDIRECTORY),
    (Name: 'Drives'; ID: CSIDL_DRIVES),
    (Name: 'Favorites'; ID: CSIDL_FAVORITES),
    (Name: 'Fonts'; ID: CSIDL_FONTS),
    (Name: 'History'; ID: CSIDL_HISTORY),
    (Name: 'Internet'; ID: CSIDL_INTERNET),
    (Name: 'Internet Cache'; ID: CSIDL_INTERNET_CACHE),
    (Name: 'Network Neighborhood'; ID: CSIDL_NETHOOD),
    (Name: 'Network Top'; ID: CSIDL_NETWORK),
    (Name: 'Personal'; ID: CSIDL_PERSONAL),
    (Name: 'Printers'; ID: CSIDL_PRINTERS),
    (Name: 'Printer Links'; ID: CSIDL_PRINTHOOD),
    (Name: 'Programs'; ID: CSIDL_PROGRAMS),
    (Name: 'Recent Documents'; ID: CSIDL_RECENT),
    (Name: 'Send To'; ID: CSIDL_SENDTO),
    (Name: 'Start Menu'; ID: CSIDL_STARTMENU),
    (Name: 'Startup'; ID: CSIDL_STARTUP),
    (Name: 'Templates'; ID: CSIDL_TEMPLATES));



implementation



class function TWinShell.CreateShellLink(const AppName, Desc: string; Dest: Integer): string;
{ Cria um atalho para aplicações ou documentos especificados em AppName com
 a descrição especificada em Desc.  O atalho será localizado na pasta indicada
 em Dest, que é uma das constantes de string exibidas no topo desta unidade.
 O resultado da função é o path completo do arquivo referenciado pelo atalho.}
var
  SL: IShellLink;
  PF: IPersistFile;
  LnkName: WideString;
begin
  OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER,
    IShellLink, SL));
  { O implementador da interface IShellLink deve suportar a interface
   IPersistFile. }
  PF := SL as IPersistFile;
  OleCheck(SL.SetPath(PChar(AppName)));
  if Desc <> '' then
    OleCheck(SL.SetDescription(PChar(Desc)));

  LnkName := TShellFolders.GetSpecialFolderPath(Dest, True) + TShellNetworkInfo.FolderSeparator +
             ChangeFileExt(AppName, TShellFilesInfo.LinkExtension);
  PF.Save(PWideChar(LnkName), True);
  Result := LnkName;

end;

class procedure TWinShell.GetShellLinkInfo(const LinkFile: WideString; var SLI: TShellLinkInfo);
{ Retorna informações sobre um atalho da shell. }
var
  SL: IShellLink;
  PF: IPersistFile;
  FindData: TWin32FindData;
  AStr: array[0..MAX_PATH] of char;
begin
  OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER,
    IShellLink, SL));

  PF := SL as IPersistFile;

  OleCheck(PF.Load(PWideChar(LinkFile), STGM_READ));

  OleCheck(SL.Resolve(0, SLR_ANY_MATCH or SLR_NO_UI));

  with SLI do
  begin
    OleCheck(SL.GetPath(AStr, MAX_PATH, FindData, SLGP_SHORTPATH));
    PathName := AStr;
    OleCheck(SL.GetArguments(AStr, MAX_PATH));
    Arguments := AStr;
    OleCheck(SL.GetDescription(AStr, MAX_PATH));
    Description := AStr;
    OleCheck(SL.GetWorkingDirectory(AStr, MAX_PATH));
    WorkingDirectory := AStr;
    OleCheck(SL.GetIconLocation(AStr, MAX_PATH, IconIndex));
    IconLocation := AStr;
    OleCheck(SL.GetShowCmd(ShowCmd));
    OleCheck(SL.GetHotKey(HotKey));
  end;
end;

class procedure TWinShell.SetShellLinkInfo(const LinkFile: WideString; const SLI: TShellLinkInfo);
var
  SL: IShellLink;
  PF: IPersistFile;
begin
  OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER,
    IShellLink, SL));

  PF := SL as IPersistFile;

  OleCheck(PF.Load(PWideChar(LinkFile), STGM_SHARE_DENY_WRITE));

  OleCheck(SL.Resolve(0, SLR_ANY_MATCH or SLR_UPDATE or SLR_NO_UI));

  with SLI, SL do
  begin
    OleCheck(SetPath(PChar(PathName)));
    OleCheck(SetArguments(PChar(Arguments)));
    OleCheck(SetDescription(PChar(Description)));
    OleCheck(SetWorkingDirectory(PChar(WorkingDirectory)));
    OleCheck(SetIconLocation(PChar(IconLocation), IconIndex));
    OleCheck(SetShowCmd(ShowCmd));
    OleCheck(SetHotKey(HotKey));
  end;

  PF.Save(PWideChar(LinkFile), True); //Salva o arquivo.
end;


class procedure TWinShell.StartScreenSave(Handle: THandle);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_SCREENSAVE, 0);
end;

class function TWinShell.GetLongFileName(Const FileName : String) : String;
var
  aInfo: TSHFileInfo;
begin
  if SHGetFileInfo(PChar(FileName),0,aInfo,Sizeof(aInfo),SHGFI_DISPLAYNAME)<>0 then
   Result:= String(aInfo.szDisplayName)
   else
   Result:= FileName;
end;

class function TWinShell.GetShortName(sLongName : string): string;
begin
  Result := ExtractFileName(sLongName);
end;

class function TWinShell.HasSoundCard:Boolean;
begin
  Result := WaveOutGetNumDevs > 0;
end;

class function TWinShell.GetFileVersion: String;
var
VerInfoSize: DWord;
VerInfo: Pointer;
VerValueSize: DWord;
VerValue: PVSFixedFileInfo;
Dummy: DWord;
begin
 VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
 GetMem(VerInfo, VerInfoSize);
 GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
 VerQueryValue(VerInfo, PWideChar(TShellNetworkInfo.FolderSeparator), Pointer(VerValue), VerValueSize);
 with VerValue^ do
  begin
  result := IntTostr(dwFileVersionMS shr 16);
  result := result + '.' +  IntTostr(dwFileVersionMS and $FFFF);
  result := result +'.' + IntTostr(dwFileVersionLS shr 16);
  result := result + '.' + IntTostr(dwFileVersionLS and $FFFF);
  end;

 FreeMem(VerInfo, VerInfoSize);
end;


class function TWinShell.FileVersionInfo(
  const sAppNamePath: TFileName): TFileVersionInfo;
var
  rSHFI: TSHFileInfo;
  iRet: Integer;
  VerSize: Integer;
  VerBuf: PChar;
  VerBufValue: Pointer ;
  VerHandle: Cardinal;
  VerBufLen: Cardinal;
  FixedFileInfo: PVSFixedFileInfo;

  // dwFileType, dwFileSubtype
  function GetFileSubType(FixedFileInfo: PVSFixedFileInfo): string;
  begin
    case FixedFileInfo.dwFileType of

      VFT_UNKNOWN: Result    := 'Unknown';
      VFT_APP: Result        := 'Application';
      VFT_DLL: Result        := 'DLL';
      VFT_STATIC_LIB: Result := 'Static-link Library';

      VFT_DRV:
        case
          FixedFileInfo.dwFileSubtype of
          VFT2_UNKNOWN: Result         := 'Unknown Driver';
          VFT2_DRV_COMM: Result        := 'Communications Driver';
          VFT2_DRV_PRINTER: Result     := 'Printer Driver';
          VFT2_DRV_KEYBOARD: Result    := 'Keyboard Driver';
          VFT2_DRV_LANGUAGE: Result    := 'Language Driver';
          VFT2_DRV_DISPLAY: Result     := 'Display Driver';
          VFT2_DRV_MOUSE: Result       := 'Mouse Driver';
          VFT2_DRV_NETWORK: Result     := 'Network Driver';
          VFT2_DRV_SYSTEM: Result      := 'System Driver';
          VFT2_DRV_INSTALLABLE: Result := 'InstallableDriver';
          VFT2_DRV_SOUND: Result       := 'Sound Driver';
        end;
      VFT_FONT:
        case FixedFileInfo.dwFileSubtype of
          VFT2_UNKNOWN: Result       := 'Unknown Font';
          VFT2_FONT_RASTER: Result   := 'Raster Font';
          VFT2_FONT_VECTOR: Result   := 'Vector Font';
          VFT2_FONT_TRUETYPE: Result := 'Truetype Font';
          else;
        end;
      VFT_VXD: Result := 'Virtual Defice Identifier = ' +
          IntToHex(FixedFileInfo.dwFileSubtype, 8);
    end;
  end;


  function HasdwFileFlags(FixedFileInfo: PVSFixedFileInfo; Flag: Word): Boolean;
  begin
    Result := (FixedFileInfo.dwFileFlagsMask and
      FixedFileInfo.dwFileFlags and
      Flag) = Flag;
  end;

  function GetFixedFileInfo: PVSFixedFileInfo;
  begin
    if not VerQueryValue(VerBuf, '', Pointer(Result), VerBufLen) then
      Result := nil
  end;

  function GetInfo(const aKey: string): string;
  begin
    Result := '';
    {VerKey := Format('\StringFileInfo\%.4x%.4x\%s',
      [LoWord(Integer(VerBufValue^)),
      HiWord(Integer(VerBufValue^)), aKey]);
    if VerQueryValue(VerBuf, PChar(VerKey), VerBufValue, VerBufLen) then
      Result := StrPas(VerBufValue);}
  end;

  function QueryValue(const aValue: string): string;
  begin
    Result := '';
    // obtain version information about the specified file
    if GetFileVersionInfo(PChar(sAppNamePath), VerHandle, VerSize, VerBuf) and
      // return selected version information
      VerQueryValue(VerBuf, '\VarFileInfo\Translation', VerBufValue, VerBufLen) then
      Result := GetInfo(aValue);
  end;
begin
  // Initialize the Result
  with Result do
  begin
    FileType         := '';
    CompanyName      := '';
    FileDescription  := '';
    FileVersion      := '';
    InternalName     := '';
    LegalCopyRight   := '';
    LegalTradeMarks  := '';
    OriginalFileName := '';
    ProductName      := '';
    ProductVersion   := '';
    Comments         := '';
    SpecialBuildStr  := '';
    PrivateBuildStr  := '';
    FileFunction     := '';
    DebugBuild       := False;
    Patched          := False;
    PreRelease       := False;
    SpecialBuild     := False;
    PrivateBuild     := False;
    InfoInferred     := False;
  end;

  // Get the file type
  if SHGetFileInfo(PChar(sAppNamePath), 0, rSHFI, SizeOf(rSHFI),
    SHGFI_TYPENAME) <> 0 then
  begin
    Result.FileType := rSHFI.szTypeName;
  end;

  iRet := SHGetFileInfo(PChar(sAppNamePath), 0, rSHFI, SizeOf(rSHFI), SHGFI_EXETYPE);
  if iRet <> 0 then
  begin
    // determine whether the OS can obtain version information
    VerSize := GetFileVersionInfoSize(PChar(sAppNamePath), VerHandle);
    if VerSize > 0 then
    begin
      VerBuf := AllocMem(VerSize);
      try
        with Result do
        begin
          CompanyName      := QueryValue('CompanyName');
          FileDescription  := QueryValue('FileDescription');
          FileVersion      := QueryValue('FileVersion');
          InternalName     := QueryValue('InternalName');
          LegalCopyRight   := QueryValue('LegalCopyRight');
          LegalTradeMarks  := QueryValue('LegalTradeMarks');
          OriginalFileName := QueryValue('OriginalFileName');
          ProductName      := QueryValue('ProductName');
          ProductVersion   := QueryValue('ProductVersion');
          Comments         := QueryValue('Comments');
          SpecialBuildStr  := QueryValue('SpecialBuild');
          PrivateBuildStr  := QueryValue('PrivateBuild');
          // Fill the VS_FIXEDFILEINFO structure
          FixedFileInfo := GetFixedFileInfo;
          DebugBuild    := HasdwFileFlags(FixedFileInfo, VS_FF_DEBUG);
          PreRelease    := HasdwFileFlags(FixedFileInfo, VS_FF_PRERELEASE);
          PrivateBuild  := HasdwFileFlags(FixedFileInfo, VS_FF_PRIVATEBUILD);
          SpecialBuild  := HasdwFileFlags(FixedFileInfo, VS_FF_SPECIALBUILD);
          Patched       := HasdwFileFlags(FixedFileInfo, VS_FF_PATCHED);
          InfoInferred  := HasdwFileFlags(FixedFileInfo, VS_FF_INFOINFERRED);
          FileFunction  := GetFileSubType(FixedFileInfo);
        end;
      finally
        FreeMem(VerBuf, VerSize);
      end
    end;
  end

end;

class procedure TWinShell.DisableXPFirewal;
var
  SCM, hService: LongWord;
  sStatus: TServiceStatus;
begin
  SCM      := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  hService := OpenService(SCM, PChar('SharedAccess'), SERVICE_ALL_ACCESS);

  ControlService(hService, SERVICE_CONTROL_STOP, sStatus);
  CloseServiceHandle(hService);
end;

class function TWinShell.GetComputerName: string;
var
I: LongWord;
begin
 SetLength(Result, MAX_COMPUTERNAME_LENGTH + 1);
 I := Length(Result);
 if WinApi.Windows.GetComputerName(@Result[1], i) then
  SetLength(Result, i);
end;

class procedure TWinShell.AddToStartDocumentsMenu(sFilePath: string);
begin  //Adiciona um atalho para o menu Iniciar/documentos
  SHAddToRecentDocs(SHARD_PATH, PChar( sFilePath ) );
end;

class function TWinShell.DeleteFileWithUndo(sFileName: string): boolean;
var //Envia um arquivo para a lixeira
  fos : TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos),0);
  with fos do
  begin
    wFunc  := FO_DELETE;
    pFrom  := PChar(sFileName);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := (0 = ShFileOperation(fos));
end;

class function TWinShell.IsFileInUse(fName : string ) : boolean;
//checa se um arquivo está sendo usado
var
  HFileRes : HFILE;
begin
  Result := false;
  if not FileExists(fName) then
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,0, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;


class function TWinShell.GetExeType(Filename:string):string;
var
  BinaryType: DWORD;
begin
  //Define o tipo de executável binário de um arquivo.
  If GetBinaryType(Pchar(Filename), Binarytype) then
    case BinaryType of
      SCS_DOS_BINARY  : Result := TShellWinBinaryType.MSDOSBin;
      SCS_WOW_BINARY  : Result := TShellWinBinaryType.Win16Bin;
      SCS_32BIT_BINARY: Result := TShellWinBinaryType.Win32Bin;
      SCS_64BIT_BINARY: Result := TShellWinBinaryType.Win64Bin;
      SCS_PIF_BINARY  : Result := TShellWinBinaryType.PIFFileBin;
      SCS_POSIX_BINARY: Result := TShellWinBinaryType.POSIXBin;
      SCS_OS216_BINARY: Result := TShellWinBinaryType.OS216Bin;
    else
      Result := TShellWinBinaryType.UnknownBin;
    end
  else
    Result := TShellWinBinaryType.NotBinFile;
end;

class procedure TWinShell.GetInfoSys(Info: TStrings);
// Requer a Registry declarada na clausula uses da unit
var
CurVerKey,WinVersion,PlatForm,CPUType,CPUNum,UserName,CompanyName,WinSerialNum  : String;
Reg : TRegistry;
SystemInfo    : TSystemInfo;
OSVersionInfo : TOSVersionInfo;
begin
OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
GetVersionEx(OSVersionInfo);
case OSVersionInfo.dwPlatformID of
 VER_PLATFORM_WIN32_WINDOWS: begin
                             PlatForm  := 'WinPlatForm: Windows 95';
                             CurVerKey := 'SOFTWAREMicrosoftWindowsCurrentVersion';
                             end;
 VER_PLATFORM_WIN32_NT:   begin
                          PlatForm  := 'WinPlatForm: Windows NT';
                          CurVerKey := 'SOFTWAREMicrosoftWindows NTCurrentVersion';
                          end;
else
   begin
   PlatForm  := 'WinPlatForm: UNKNOWN';
   CurVerKey := '';
   end;
end;
WinVersion := 'WinVersion: ' +
              Format('Version %d.%.2d',
              [OSVersionInfo.dwMajorVersion,OSVersionInfo.dwMinorVersion]);
case SystemInfo.dwProcessorType OF
     386 : CPUType := 'CPUType: 80386';
     486 : CPUType := 'CPUType: 80486';
     586 : CPUType := 'CPUType: Pentium';
else
   CPUType := 'CPUType: ' + Format('Unknown %d',[SystemInfo.dwProcessorType]);
end;
IntToStr(SystemInfo.dwNumberOfProcessors);
Reg := TRegistry.Create;
try
 // Info := TStringList.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if Reg.OpenKey(CurVerKey, False) then
     begin
     UserName    := 'UserName: ' +Reg.ReadString('RegisteredOwner');
     CompanyName := 'CompanyName: ' + Reg.ReadString('RegisteredOrganization');
     if OSVersionInfo.dwPlatformID =  VER_PLATFORM_WIN32_WINDOWS then
        begin
        WinSerialNum := 'WinSerialNum: ' + Reg.ReadString('ProductID');
        end;
     end;
finally
  with Info do
    begin
    Add(WinVersion);
    Add(PlatForm);
    Add(CPUType);
    Add(CPUNum);
    Add(UserName);
    Add(CompanyName);
    Add(WinSerialNum);
    end;
  Reg.Free;
  end;
end;


class function TWinShell.GetWinUserLogin: String;
// Retorna o Usuario que está logado na rede. Esta função requer a unit DBitypes
// na clausula Uses da unit.
var
dwUserNameLen : DWord;
FUserName: String;
begin
//dwUserNameLen := dbiMaxUserNameLen + 1; //DBiTypes
SetLength(FUserName, dwUserNameLen);
if GetUserName(PChar(FUserName), dwUserNameLen) then //AdvApi32.Dll
   Begin
   SetLength(FUserName, dwUserNameLen);
   end
else
   Begin
   SetLength(FUserName, 0);
   end;
Result := FUserName;
end;

class procedure TWinShell.GoToFile(Handle: HWND; FileName: TFileName);
begin
//Seleciona um arquivo no Explorer...
 if FileName <> '' then
  ShellExecute(Handle, PWideChar(TShellCommands.OpenCmd), PChar(TShellCommands.ExplorerFileCmd),
   PChar(TShellCommands.SelectParamCmd + FileName), nil, SW_NORMAL);
end;

//retorna o número de  conexoes da rede e seu path completo
class function TWinShell.GetNetworkDriveMappings(sl : TStrings ) : integer;
var
i  : integer;
sNetPath : string;
dwMaxNetPathLen : DWord;
begin
sl.Clear;
dwMaxNetPathLen := MAX_PATH;
SetLength( sNetPath,dwMaxNetPathLen );
for i := 0 to 25 do
  begin
   if (NO_ERROR = WinAPI.Windows.WNetGetConnection(PChar('' +
      Chr(65 + i) + ':'),PChar(sNetPath),dwMaxNetPathLen ) )then
     begin
      sl.Add( Chr( 65 + i ) + ': ' + sNetPath );
     end;
  end;
Result := sl.Count;
end;


//Retorna informações sobre o Computador na rede
class function TWinShell.GetNetStationInfo(Tipo:Integer) : string;
// Requer a Registry declarada na clausula uses da unit
// Tipo :  1 - Nome do Computador na rede
//         2 - Nome do Grupo de trabalho
//         3 - Descrição do computador na rede
var
Reg : TRegistry;
begin
Reg := TRegistry.create;
Result := '(n/a)';
with Reg do
     try
       RootKey := HKEY_LOCAL_MACHINE;
       if OpenKey('SystemCurrentControlSetServicesVxDVNETSUP', false) then
          begin
          Case Tipo of
               1: Result := ReadString('ComputerName');
               2: Result := ReadString('Workgroup');
               3: Result := ReadString('Comment');
          end;
          end;
     Finally
        CloseKey;
        free;
     end;
end;

class procedure TWinShell.GetCDROMDrives(list: TStrings);
var
  DriveBits: set of 0..25;
  Drives,DriveNum: integer;
  DriveLetter: string;
begin
  list.Clear;
  Drives := GetLogicalDrives;
  if Drives <> 0 then
  begin
    integer(DriveBits) := Drives;
    for DriveNum := 0 to 25 do
    begin
      if (DriveNum in DriveBits) then
      begin
        DriveLetter := char(DriveNum+Ord('A'))+':';
        if GetDriveType(PChar(DriveLetter)) = DRIVE_CDROM then
          list.Add(DriveLetter);
      end;
    end;
  end;
end;


class procedure TWinShell.GetDialUpConnection(ConnectionList: TStrings);
begin
//obtém uma lista das conexoes dial up instaladas

end;

class procedure TWinShell.DragForm(Form: TForm);
begin
//permite mover um formulário sem barra de título
//basta chamar no evento onMousedown esta procedure
ReleaseCapture;
SendMessage(Form.Handle, wm_SysCommand,$f012,0);
end;

class function TWinShell.CreateProgramGroup(Foldername: string; aLocation: integer): boolean;
var pIdl: PItemIDList; //Cria um grupo de programas do win
    hPath: PChar;
begin
Result := False;
if SUCCEEDED(SHGetSpecialFolderLocation(0, aLocation, pidl)) then
   begin
   hPath := StrAlloc(max_path);
   SHGetPathFromIDList(pIdl, hPath);
   SetLastError(0);
   CreateDirectory(PChar(hPath + '\\' + Foldername), nil );
   if (GetLastError()=0) or (GetLastError()=ERROR_ALREADY_EXISTS) then
   Result := true;
   StrDispose(hPath);
   end;
end;


class function TWinShell.CreateShellLink(SourceFileName: string;
  Location: TShortcutType; SubFolder, WorkingDir, Parameters,
  Description: string): string;
const
  SHELL_FOLDERS_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\Explorer';
  QUICK_LAUNCH_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\GrpConv';
var
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  Directory, LinkName: string;
  WFileName: WideString;
  Reg: TRegIniFile;
begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;

  MySLink.SetPath(PChar(SourceFileName));
  MySLink.SetArguments(PChar(Parameters));
  MySLink.SetDescription(PChar(Description));

  LinkName := ChangeFileExt(SourceFileName, '.lnk');
  LinkName := ExtractFileName(LinkName);

  // Quicklauch
  if Location = _QUICKLAUNCH then
  begin
    Reg := TRegIniFile.Create(QUICK_LAUNCH_ROOT);
    try
      Directory := Reg.ReadString('MapGroups', 'Quick Launch', '');
    finally
      Reg.Free;
    end;
  end
  else
  // Other locations
  begin
    Reg := TRegIniFile.Create(SHELL_FOLDERS_ROOT);
    try
    case Location of
      _OTHERFOLDER : Directory := SubFolder;
      _DESKTOP     : Directory := Reg.ReadString('Shell Folders', 'Desktop', '');
      _STARTMENU   : Directory := Reg.ReadString('Shell Folders', 'Start Menu', '');
      _SENDTO      : Directory := Reg.ReadString('Shell Folders', 'SendTo', '');
    end;

    finally
      Reg.Free;
    end;
  end;

  if Directory <> '' then
  begin
    if (SubFolder <> '') and (Location <> _OTHERFOLDER) then
      WFileName := Directory + TShellNetworkInfo.FolderSeparator + SubFolder +
      TShellNetworkInfo.FolderSeparator + LinkName
    else
      WFileName := Directory + TShellNetworkInfo.FolderSeparator + LinkName;


    if WorkingDir = '' then
      MySLink.SetWorkingDirectory(PChar(ExtractFilePath(SourceFileName)))
    else
      MySLink.SetWorkingDirectory(PChar(WorkingDir));

    MyPFile.Save(PWChar(WFileName), False);
    Result := WFileName;
  end;

end;

class function TWinShell.GetFileSize(const FileName: string): LongInt;
{
  Retorna o tamanho de um arquivo sem abri-lo.  Se o arquivo não existir
  retorna -1.
}
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

class function TWinShell.GetFileDateTime(const FileName: string): System.TDateTime;
var
 ADateTime: TDateTime;
begin
  if FileAge(FileName, ADateTime) then
   Result := ADateTime
  else
   Result := now;// default
end;


class function TWinShell.HasAttr(const FileName: string; Attr: Word): Boolean;
var
 FileAttr: Integer;
begin
  FileAttr := FileGetAttr(FileName);
  if FileAttr = -1 then FileAttr := 0;
  Result := (FileAttr and Attr) = Attr;
end;


class function TWinShell.ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(Application.Handle, PWideChar(TShellCommands.OpenCmd),
    PWideChar(FileName), PWideChar(Params), PWideChar(DefaultDir), ShowCmd);
end;

class function TWinShell.GetPortAddress(PortNo: integer): word; //assembler; stdcall;
asm
{$IFDEF WIN32}
  push es
  push ebx
  mov ebx, PortNo
  shl ebx,1
  mov ax,40h // Endereço do segmento Dos
  mov es,ax
  mov ax,ES:[ebx+6] // Pega o end. da porta em modo 16Bit :)
  pop ebx
  pop es
{$ENDIF}
end;


class function TWinShell.GetCurrentUserName: string;
var
Len: Cardinal; { This will have to be Integer, not cardinal, in Delphi 3. }
begin
Len := 255;  { arbitrary length to allocate for username string, plus one for
               null terminator }
SetLength(Result, Len - 1); { set the length }
if GetUserName(PChar(Result), Len) then  { get the username }
   SetLength(Result, Len - 1) { set the exact length if it succeeded }
   else
     begin
     RaiseLastOSError; { raise exception if it failed }
     end;
end;

class procedure TWinShell.HideTaskBarIcon(Handle: HWND);
begin
SetWindowLong(Application.Handle,GWL_EXSTYLE,
   GetWindowLong(Application.Handle, GWL_EXSTYLE) or
   WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);

end;


class function TWinShell.GetLongIP(IP : string) : string;
var
  IPaddr   : array[1..4] of integer;
  temp     : string;
  res      : Longword;
  i        : integer;

begin
  temp := ip;
  temp := temp + TShellNetworkInfo.IPNumberMask;
  for i := 1 to 4 do
  begin
    ipaddr[i] := strtoint(copy(temp, 1, pos(TShellNetworkInfo.IPNumberMask,temp) - 1));
    delete(temp, 1, pos(TShellNetworkInfo.IPNumberMask, temp));
  end;
  // Checa o IP
  for i := 1 to 4 do
  begin
    try
       inttostr(ipaddr[i]);
    except
       result := TShellNetworkInfo.InvalidIPMsg;
       exit;
    end;
  end;

  res := (ipaddr[1] * $FFFFFF) + ipaddr[1] +
           (ipaddr[2] * $FFFF)   + ipaddr[2] +
           (ipaddr[3] * $FF)     + ipaddr[3] +
           (ipaddr[4]);
           result := inttostr(res);
end;


class function TWinShell.GetShortIP(const S: string): string;
var
  IP        : integer;
  A, B, C, D: byte;
begin
  IP:=StrToInt(S);
  A:=(IP and $FF000000) shr 24;
  B:=(IP and $FF0000) shr 16;
  C:=(IP and $FF00) shr 8;
  D:=IP and $FF;
  result:=Format('%d.%d.%d.%d', [A, B, C, D]);
end;


class function TWinShell.GetOperatingSystem: Integer;
var
  osVerInfo: TOSVersionInfo;
  majorVer, minorVer: Integer;
begin
  Result := TOSIdentifier.cOsUnknown;
  { set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
        begin
          if majorVer <= 4 then
            Result := TOSIdentifier.cOsWinNT
          else if (majorVer = 5) and (minorVer = 0) then
            Result := TOSIdentifier.cOsWin2000
          else if (majorVer = 5) and (minorVer = 1) then
            Result := TOSIdentifier.cOsXP
          else if (majorVer = 6) and (minorVer = 0) then
            Result := TOSIdentifier.cOsVista
          else if (majorVer = 6) and (minorVer = 1) then
            Result := TOSIdentifier.cOsSeven
          else if (majorVer = 6) and (minorVer = 2) then
            Result := TOSIdentifier.csOsEight;
        end;
      VER_PLATFORM_WIN32_WINDOWS:  { Windows 9x/ME }
        begin
          if (majorVer = 4) and (minorVer = 0) then
            Result := TOSIdentifier.cOsWin95
          else if (majorVer = 4) and (minorVer = 10) then
          begin
            if osVerInfo.szCSDVersion[1] = 'A' then
              Result := TOSIdentifier.cOsWin98SE
            else
              Result := TOSIdentifier.cOsWin98;
          end
          else if (majorVer = 4) and (minorVer = 90) then
            Result := TOSIdentifier.cOsWinME
          else
            Result := TOSIdentifier.cOsUnknown;
        end;
      else
        Result := TOSIdentifier.cOsUnknown;
    end;
  end
  else
    Result := TOSIdentifier.cOsUnknown;
end;


class function TWinShell.IsWinNT32: Boolean;
var
  OS: TOSVersionInfo;
begin
  ZeroMemory(@OS, SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  Result := OS.dwPlatformId = VER_PLATFORM_WIN32_NT;
end;

class function TWinShell.IsWinVista: Boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := VerInfo.dwMajorVersion >= 6;
end;

class function TWinShell.IsWin2000: Boolean;
var
  OS: TOSVersionInfo;
begin
  ZeroMemory(@OS, SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  Result := (OS.dwMajorVersion >= 5) and
    (OS.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

class function TWinShell.IsWin7: boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := VerInfo.dwMajorVersion >= 7;
end;

class function TWinShell.IsWin8: boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := VerInfo.dwMajorVersion >= 8;
end;

class function TWinShell.IsWinME: Boolean;
var
  OS: TOSVersionInfo;
begin
  ZeroMemory(@OS, SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  Result := (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 90) and
    (OS.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
end;


class function TWinShell.IsWin95: Boolean;
var
  OS: TOSVersionInfo;
begin
  ZeroMemory(@OS, SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  Result := (OS.dwMajorVersion >= 4) and (OS.dwMinorVersion = 0) and
    (OS.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
end;

class function TWinShell.IsWinXP: Boolean;
var
  OS: TOSVERSIONINFO;
begin
  OS.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);
  GetVersionEx(os);
  Result := (OS.dwPlatformId = VER_PLATFORM_WIN32_NT) and
    (OS.dwMajorVersion = 5) and (OS.dwMinorVersion = 1);
end; 



class procedure TWinShell.SendEmail(Handle: THandle; EMail, Subject, CCEmail,
  BCCEmail, Body: string);
var
Param: string;
begin
 Param := 'mailto:%s?subject=%s&cc=%s&bcc=%s&Body=%s';
 Param := Format(Param, [Email, Subject, CCEmail, BCCEmail, Body]);
 ShellExecute(Handle, 'open', PChar(Param), nil, nil, SW_SHOWNORMAL);
end;

class function TWinShell.GetServiceStatus(sMachine, sService: PChar): DWORD;
{******************************************}
  {*** Parameters: ***}
  {*** sService: specifies the name of the service to open
  {*** sMachine: specifies the name of the target computer
  {*** ***}
  {*** Return Values: ***}
  {*** -1 = Error opening service ***}
  {*** 1 = SERVICE_STOPPED ***}
  {*** 2 = SERVICE_START_PENDING ***}
  {*** 3 = SERVICE_STOP_PENDING ***}
  {*** 4 = SERVICE_RUNNING ***}
  {*** 5 = SERVICE_CONTINUE_PENDING ***}
  {*** 6 = SERVICE_PAUSE_PENDING ***}
  {*** 7 = SERVICE_PAUSED ***}
  {******************************************}
var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;

end;

//Open a file or starts a programm (without parameters) }

class procedure TWinShell.OpenFile(FileName: string);
var
  c: array[0..800] of Char;
begin
  StrPCopy(c, FileName);
  ShellExecute(Application.Handle, 'open', c, nil, nil, SW_NORMAL); //do not localize!
end;

class procedure TWinShell.OpenLocalEventLogService;
var
 lEXEName: string;
begin
//Acessa o Visualizador de Eventos
 lEXEName := TShellFolders.GetSysDir + '\' + 'eventvwr.exe'; //do not localize!
 TWinShell.OpenProgram(lEXEName,'');
end;

{ Starts a programm with commandline parameters }

class procedure TWinShell.OpenProgram(prog, params: string);
 var
  Startupinfo: TStartupInfo;
  Processinfo: Tprocessinformation;
begin
 if GetOperatingSystem <= TOSIdentifier.cOsSeven then
  ShellExecute(Application.Handle, 'open', PWideChar(prog), PWideChar(params), nil, SW_NORMAL)  //do not localize!
 else
  begin
    Fillchar(Startupinfo, Sizeof(Startupinfo), #0);
    Startupinfo.cb := Sizeof(Startupinfo);
    Startupinfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    Startupinfo.wShowWindow := SW_SHOWNORMAL;

    if not Createprocess(nil, PWideChar(Prog), nil, nil, False,
      CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, Startupinfo,
      Processinfo) then
      ABORT;

    if Processinfo.Hprocess <> 0 then
     CloseHandle(Processinfo.Hprocess);
    if Processinfo.Hthread <> 0 then
     CloseHandle(Processinfo.Hthread);
  end;
end; 

class procedure TWinShell.OpenRemoteEventLogService(const ComputerName: string);
const
 sEventViewer = 'eventvwr.exe'; //do not localize!
var
 lEXEName: string;
begin
//Acessa o Visualizador de Eventos de um computador remoto
 lEXEName := TShellFolders.GetSysDir + sEventViewer; //do not localize!
 TWinShell.OpenProgram(lEXEName, ComputerName);
end;

class procedure TWinShell.PrintFile(FileName: string);
var
  c: array[0..800] of Char;
begin
  StrPCopy(c, FileName);
  ShellExecute(Application.Handle, 'print', c, nil, nil, SW_NORMAL);//do not localize!
end;

class function TWinShell.ProcessExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);

end;

class function TWinShell.EmailIsValid(const s: string): boolean;
begin
  Result := (Trim(s) <> '')  and (Pos('@', s) > 1);
end;

class function TWinShell.ExecAndWait(const FileName, Params: string; 
  WindowState: Word): Boolean; 
var 
  SUInfo: TStartupInfo; 
  ProcInfo: TProcessInformation;
  CmdLine: string; 
begin 
  { Enclose filename in quotes to take care of 
    long filenames with spaces. } 
  CmdLine := '"' + FileName + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0); 
  with SUInfo do 
  begin 
    cb := SizeOf(SUInfo); 
    dwFlags := STARTF_USESHOWWINDOW; 
    wShowWindow := WindowState; 
  end; 
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False,
    CREATE_NEW_CONSOLE or
    NORMAL_PRIORITY_CLASS, nil,
    PChar(ExtractFilePath(FileName)),
    SUInfo, ProcInfo); 
  { Wait for it to finish. }
  if Result then 
    WaitForSingleObject(ProcInfo.hProcess, INFINITE); 
end; 

{ Execute a complete shell command line and waits until terminated. } 

class function TWinShell.ExecCmdLineAndWait(const CmdLine: string; 
  WindowState: Word): Boolean; 
var 
  SUInfo: TStartupInfo; 
  ProcInfo: TProcessInformation;
begin 
  { Enclose filename in quotes to take care of 
    long filenames with spaces. } 
  FillChar(SUInfo, SizeOf(SUInfo), #0); 
  with SUInfo do 
  begin 
    cb := SizeOf(SUInfo); 
    dwFlags := STARTF_USESHOWWINDOW; 
    wShowWindow := WindowState;
  end; 
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False, 
    CREATE_NEW_CONSOLE or 
    NORMAL_PRIORITY_CLASS, nil,
    nil {PChar(ExtractFilePath(Filename))}, 
    SUInfo, ProcInfo); 
  { Wait for it to finish. } 
  if Result then 
    WaitForSingleObject(ProcInfo.hProcess, INFINITE); 
end;

{ Execute a complete shell command line without waiting. } 

class function TWinShell.OpenCmdLine(const CmdLine: string; 
  WindowState: Word): Boolean;
var 
  SUInfo: TStartupInfo; 
  ProcInfo: TProcessInformation; 
begin 
  { Enclose filename in quotes to take care of 
    long filenames with spaces. } 
  FillChar(SUInfo, SizeOf(SUInfo), #0); 
  with SUInfo do 
  begin
    cb := SizeOf(SUInfo); 
    dwFlags := STARTF_USESHOWWINDOW; 
    wShowWindow := WindowState; 
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False, 
    CREATE_NEW_CONSOLE or 
    NORMAL_PRIORITY_CLASS, nil, 
    nil {PChar(ExtractFilePath(Filename))}, 
    SUInfo, ProcInfo); 
end;

class function TWinShell.UserIsAdministrator: boolean;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
    (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  x: Integer;
  bSuccess: BOOL;
begin
  Result   := False;
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
        hAccessToken);
  end;
  if bSuccess then
  begin
    GetMem(ptgGroups, 1024);
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups,
      ptgGroups, 1024, dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
        0, 0, 0, 0, 0, 0, psidAdministrators);
      {$R-}
      for x := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups.Groups[x].Sid) then
        begin
          Result := True;
          Break;
        end;
      {$R+}
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
end;

class function TWinShell.XPThemeActive: boolean;
// Returna True o usuário está usando o estilo XP
const
  themelib = 'uxtheme.dll';  //do not localize!
type
  TIsThemeActive = function: BOOL; stdcall;
var
  IsThemeActive: TIsThemeActive;
  huxtheme: HINST;
begin
  Result := False;
  // Cheque se o s.o. é o XP ou superior
  if (Win32Platform  = VER_PLATFORM_WIN32_NT) and
     (((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) or
      (Win32MajorVersion > 5)) then
  begin
    huxtheme := LoadLibrary(themelib);
    if huxtheme <> 0 then
    begin
      try
        IsThemeActive := GetProcAddress(huxtheme, 'IsThemeActive'); //do not localize!
        Result := IsThemeActive;
      finally
       if huxtheme > 0 then
          FreeLibrary(huxtheme);
      end;
    end;
  end;
end;

class procedure TWinShell.SetClockStatus(const Show: boolean);
begin
//Esconde ou exibe o relógio da shell
end;

class procedure TWinShell.BrowseToURL(const Url: string);
begin
  ShellExecute(0, nil, PChar(URL), nil, nil, SW_SHOWNOACTIVATE);
end;

class function TWinShell.CanHibernate: Boolean;
type
  TIsPwrHibernateAllowed = function: Boolean;
  stdcall;
var
  hPowrprof: HMODULE;
  IsPwrHibernateAllowed: TIsPwrHibernateAllowed;
begin
  Result := False;
  //if IsNT4Or95 then Exit;
  hPowrprof := LoadLibrary('powrprof.dll'); //do not localize!
  if hPowrprof <> 0 then
  begin
    try
      @IsPwrHibernateAllowed := GetProcAddress(hPowrprof, 'IsPwrHibernateAllowed');  //do not localize!
      if @IsPwrHibernateAllowed <> nil then
      begin
        Result := IsPwrHibernateAllowed;
      end;
    finally
      FreeLibrary(hPowrprof);
    end;
  end;

end;

class procedure TWinShell.ChangeShellClock(const Year, Month, Day, Hour, Minute,
  Second: word);
var
SystemTime: TSystemTime;
begin
//Altera o relógio do sistema.
 with SystemTime do
  begin
   wYear := Year;
   wMonth := Month;
   wDay := Day;
   wHour := Hour;
   wMinute := Minute;
   wSecond := Second;
  end;
 SetLocalTime(SystemTime);
end;

class function TWinShell.FormatDrive(Handle: HWND; Drive, ID,
  Options: Word): LongInt;
begin
 Result := SHFormatDrive(Handle, Drive, ID, Options) ;
end;

class function TShellFolders.GetWinDir :string;
begin
  Result := self.GetSpecialFolderPath(CSIDL_WINDOWS, False);
end;

class function TShellFolders.GetSysDir : string;
begin
  Result := self.GetSpecialFolderPath(CSIDL_SYSTEM, False);
end;

class function TShellFolders.GetTempDir : string;
var
  Buffer: array [0 .. MAX_PATH] of WideChar;
begin
  GetTempPath(Length(Buffer), Buffer);
  Result := StrPas(Buffer);
end;

class function TShellFolders.GetPreviousDir(const Directory: string): string;
var
I: integer;
begin
 for I := Length(Directory) downto 0 do
   begin
    if Copy(Directory, I, 1) = PathDelim then
     begin
      Result := Copy(Directory,1,I);
      Exit;
     end;
   end;
end;

class function TShellFolders.CreateFolder(const FolderName: string): boolean;
begin
 Result := ForceDirectories(FolderName);
end;

class function TShellFolders.FolderExists(const FolderName: string): boolean;
begin
 Result := SysUtils.DirectoryExists(FolderName);
end;

class function TShellFolders.FolderIsEmpty(const FolderName: string): boolean;
var
  SearchRec: TSearchRec;
begin
//Testa se uma pasta está vazia
  try
   Result := (FindFirst(FolderName + '\*.*', faAnyFile, SearchRec) = 0) and //do not localize!
             (FindNext(SearchRec) = 0) and (FindNext(SearchRec) <> 0) ;
  finally
    SysUtils.FindClose(SearchRec) ;
  end;
end;

class function TShellFolders.GetCommonAppDataFolder: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_COMMON_APPDATA, False);
end;

class function TShellFolders.GetCommonDocumentsFolder: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_COMMON_DOCUMENTS, False);
end;

class function TShellFolders.GetMyAppDataFolder: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_APPDATA, False);
end;

class function TShellFolders.GetMyDocumentsDir: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_MYDOCUMENTS, False);
end;

class function TShellFolders.GetMyLocalAppDataFolder: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_LOCAL_APPDATA, False);
end;

class function TShellFolders.GetPreviousDir(const FileName: TFileName;
  RelativePath: boolean): string;
var
Path: string;
Unidade: string;
begin
 if RelativePath = False then
   begin
    Path := ExtractFileDir(FileName);
    Result := GetPreviousDir(Path);
   end
 else
   begin
     Unidade := ExtractFileDrive(FileName);
     Result := ExtractRelativePath(Unidade,FileName);
   end;
end;

class function TShellFolders.GetProgramsFilesFolder: string;
begin
 Result := self.GetSpecialFolderPath(CSIDL_PROGRAM_FILES, False);
end;

class function TShellFolders.GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): string;
var
  FilePath: array[0..MAX_PATH] of char;
begin
  SHGetSpecialFolderPath(0, FilePath, Folder, CanCreate);
  Result := FilePath;
end;




end.
