unit shared;

interface

uses Windows, SysUtils, Classes, Controls, cport, dialogs, System.Win.ScktComp,
  serial, dateutils;

type
  TMyClass = class
  private
    procedure CSClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcperror(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);

  public
  end;

const
  ra_pack = 11;
  dec_pack = 10;
  lat_pack = 7;
  long_pack = 8;
  coor_pack = ra_pack + dec_pack;

var

  ComPortBT_USB: TComPort;
  ClientSocket1: TClientSocket;
  fullconnect: boolean;
  lastdec, lastar, lastaz, lastalt: Double;
  gmtoffset: Integer;
  imode: Integer;
  Sport: THandle;
  connected: boolean;
  MyClass: TMyClass;
  send: function(values: String): Integer;
  recv: function(var value: string; count: Integer): Integer;
  inbuff: function: Integer;
  clearBuff: procedure(input, output: boolean);

function sendserial(value: string): Integer;
function recvserial(var value: string; count: Integer): Integer;
function sendtcp(value: string): Integer;
function recvtcp(var value: string; count: Integer): Integer;
function inputcountserial(): Integer;
function inputcounttcp(): Integer;
procedure clearbuffSerial(input, output: boolean);
procedure clearbufftcp(input, output: boolean);
procedure set_interface_mode(mode: Integer);
procedure initserial(port: string; baudrate: tbaudrate);
procedure init_tcp(host: string; port: Integer);
Function get_coords(var focus, count: Integer): string;
Function get_coordstpc(var focus, count: Integer): string;
Function get_focuspos(): Integer;
Function get_focusmoving(): Integer;
function FormatString(StringIn, DivideAt: String): TStringList;
function Inttodec(de: Integer; prec: Byte): String;
function IntToAr(ar: Integer; prec: Byte): String;
function LX200Dectoint(dec: String; prec: boolean): Integer;
function LX200Artoint(ar: String; prec: boolean): Integer;
function Artoint(ar: String): Integer;
function longitudetohr(ar: String): Extended;
function longitudetodeg(ar: String): Extended;
function latitudetodeg(ar: String): Extended;
procedure GoSleepp(SleepSecs: Integer);
function Signo(n: Integer): Integer;
function Signof(f: Double): Double;
function Signof1(f: Double): Integer;
function DoubletoLXdec(de: Double; prec: Byte): string;
function DoubleToLXAr(ra: Double; prec: Byte): string;
function LX200AZtoint(az: String; prec: boolean): Integer;
function GetEnvVarValue(const VarName: string): string;
function check_connection(): boolean;
procedure Set_date(date_time: tdatetime);
procedure Set_localtime(date_time: tdatetime);
function Get_Dec(): Double;
function Get_RA: Double;
procedure Pulse_Guide(StrCommand: string);
function Get_Alt(): Double;
function Get_Az(): Double;
function Get_Lat(): Extended;
function Get_Long(): Extended;
procedure Set_TargetDec(value: Double);
procedure Set_TargetRA(value: Double);
procedure Abort_Slew();
procedure Command_Blind(const Command: WideString; Raw: WordBool);
procedure SyncTo_Coord(RightAscension, Declination: Double); overload;
procedure SyncTo_Coord(); overload;
procedure Slew_ToCoor(RightAscension, Declination: Double); overload;
procedure Slew_ToCoor();
overload
procedure Set_longitude(lon: Extended);
procedure Set_latitude(lat: Extended);
procedure Set_offset(offset: Integer);
function get_alignmode(): char;
Function get_track(): Integer;
function get_sideral(): Double;
function get_gmtoffset(): Integer;
function UTCNow: tdatetime;
function Local_Sideral_Time(localdatetime: tdatetime;
  longitude: Double): Double;

implementation

procedure TMyClass.CSClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  // showmessage('conectado socket');//Form1.Memo1.Lines.Add('Client connected.');
end;

procedure TMyClass.CSClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  // showmessage('desconectado socket');
end;

procedure TMyClass.tcperror(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ClientSocket1.active := false;
  ErrorCode := 0;
  if MessageBox(0, 'Connection Lost,Reconnect?', 'Error', MB_YESNO) = 6 then
  begin
    ClientSocket1.active := true;
  end;

end;

function UTCNow: tdatetime;
var
  ASystemTime: TSystemTime;
  UTCnowDateTime: tdatetime;
begin
  GetSystemTime(ASystemTime);
  UTCnowDateTime := SystemTimeToDateTime(ASystemTime);
  Result := UTCnowDateTime;
end;

function sendserial(value: string): Integer;
var
  count: Integer;
begin
  Result := 0;
  if ComPortBT_USB.connected then
  begin
    count := length(value);
    Result := ComPortBT_USB.writestr(value)
  end;

end;

function sendtcp(value: string): Integer;
begin
  if ClientSocket1.Socket.connected then
    Result := ClientSocket1.Socket.SendText(value)
  else
    Result := 0;
end;

function recvserial(var value: string; count: Integer): Integer;

var
  str: string;
  n: cardinal;
begin
  Result := 0;
  if ComPortBT_USB.connected then
  begin
    value := '                             ';
    n := ComPortBT_USB.Readstr(value, count);
    setlength(value, n);
    Result := n;
  end;
end;

function inputcountserial(): Integer;
begin
  inputcountserial := 0;
  if ComPortBT_USB.connected then
  begin
    inputcountserial := ComPortBT_USB.InputCount
  end;

end;

function inputcounttcp(): Integer;

var
  n: Integer;
begin
  n := 0;
  n := ClientSocket1.Socket.ReceiveLength();
  Result := n
end;

procedure clearbuffSerial(input, output: boolean);
var
  str: string;
begin
  // ComPortBT_USB.ClearBuffer(input, output)  ;
  if ComPortBT_USB.connected and (ComPortBT_USB.InputCount > 0) then
    ComPortBT_USB.Readstr(str, ComPortBT_USB.InputCount);

end;

procedure clearbufftcp(input, output: boolean);

var
  str: string;
begin
  str := ' ';
  if (ClientSocket1.Socket.ReceiveLength() > 0) and input then
    str := ClientSocket1.Socket.ReceiveText();

end;

function recvtcp(var value: string; count: Integer): Integer;

var
  str: ansistring;
begin
  Result := 0;
  if ClientSocket1.active then
  begin

    if ClientSocket1.Socket.ReceiveLength() > 0 then
    begin
      value := ClientSocket1.Socket.ReceiveText();
      setlength(value, count);
    end;
    Result := count;
  end;
end;

procedure set_interface_mode(mode: Integer);
begin
  if mode = 0 then
  begin
    send := sendserial;
    recv := recvserial;
    inbuff := inputcountserial;
    clearBuff := clearbuffSerial;
  end
  else
  begin

    send := sendtcp;
    recv := recvtcp;
    inbuff := inputcounttcp;
    clearBuff := clearbufftcp;
  end;
end;

procedure initserial(port: string; baudrate: tbaudrate);
begin
  // ComPortBT_USB := TComPort.Create(nil);
  ComPortBT_USB.port := port;
  ComPortBT_USB.baudrate := baudrate;
  ComPortBT_USB.Events := [];
  ComPortBT_USB.Parity.Bits := prNone;
  ComPortBT_USB.Timeouts.ReadInterval := 100;
  ComPortBT_USB.Timeouts.ReadTotalMultiplier := 1;
  ComPortBT_USB.Timeouts.ReadTotalConstant := 100;
  ComPortBT_USB.Timeouts.WriteTotalMultiplier := 1;
  ComPortBT_USB.Timeouts.WriteTotalConstant := 1000;
  ComPortBT_USB.TriggersOnRxChar := true;
end;

procedure init_tcp(host: string; port: Integer);
begin
  // ClientSocket1 := TClientSocket.Create(nil);
  ClientSocket1.host := host;
  ClientSocket1.port := port;
  // ClientSocket1.active := true;
  ClientSocket1.OnConnect := MyClass.CSClientConnect;
  ClientSocket1.OnDisconnect := MyClass.CSClientDisconnect;
  ClientSocket1.OnError := MyClass.tcperror;
end;

function FormatString(StringIn, DivideAt: String): TStringList;

var
  Lop, StartAt: Integer;

begin

  Result := TStringList.Create;
  (* First clear the Starting Point, it should set to 1, as
    the Copy() function picks the first character twice when
    Starting at 0. *)

  StartAt := 1;
  (* Now start the loop for every string character: *)
  for Lop := 1 to length(StringIn) - 1 do
    if Copy(StringIn, Lop, length(DivideAt)) = DivideAt then
    begin
      (* The adding starts here: *)
      Result.Add(Copy(StringIn, StartAt, Lop - StartAt));
      (* Redefine StartAt, to the Current point + Length of DivideAt: *)
      StartAt := Lop + length(DivideAt);
    end (* If the 'DivideAt' variable is found, add the text to the stringlist: *);
  Result.Add(Copy(StringIn, StartAt, Lop - StartAt + 1));
end;

// ----------------------------------------------------------------------------
function Inttodec(de: Integer; prec: Byte): String;

var
  g, m, s, tmp, sg: Integer;
  sig: char;
  destr: Pchar;
begin

  destr := StrAlloc(100);

  sig := '+';
  sg := 1;
  if (de = 0) then
    sg := 0;
  if (de < 0) then
  begin
    sg := -1;
    de := abs(de);
    sig := '-';
  end;
  g := de DIV 3600;
  tmp := de MOD 3600;
  m := tmp DIV 60;
  s := tmp MOD 60;
  case prec of
    0:
      StrFmt(destr, '%s%0.2d°%0.2d''%0.2d"', [sig, g, m, s]);
    1:
      StrFmt(destr, '%s%0.2dß%0.2d''%0.2d#', [sig, g, m, s]);
    2:
      StrFmt(destr, '%s%0.2dß%0.2d#', [sig, g, m]);
    3:
      StrFmt(destr, '%0.3dß%0.2d''%0.2d#', [g, m, s]);
    4:
      StrFmt(destr, '%0.3dß%0.2d#', [g, m]); // ß
  end;

  Inttodec := String(destr);
  StrDispose(destr);
end;

// ------------------------------------------------------------------------
function IntToAr(ar: Integer; prec: Byte): String;

var
  h, m, s, tmp, de: Integer;
  arstr: Pchar;
begin
  arstr := StrAlloc(100);
  // de:=abs(ar mod 150);
  if prec = 0 then
  begin
    de := abs(ar MOD 150);
    ar := ar DIV 10;
  end;
  ar := ar DIV 15;
  ar := ar MOD (24 * 3600);
  if (ar < 0) then
    ar := (24 * 3600) + ar;

  h := (ar DIV 3600);
  tmp := ar MOD 3600;
  m := tmp DIV 60;
  s := tmp MOD 60;
  case prec of
    0:
      StrFmt(arstr, '%0.2dh%0.2dm%0.2ds.%0.3ds', [h, m, s, de]);
    1:
      StrFmt(arstr, '%0.2d:%0.2d:%0.2d#', [h, m, s]);
    2:
      begin
        s := s DIV 6;
        StrFmt(arstr, '%0.2d:%0.2d.%0.1d#', [h, m, s])
      end;
    3:
      StrFmt(arstr, '%0.2dh%0.2dm%0.2ds', [h, m, s]);
  end;
  IntToAr := String(arstr);
  StrDispose(arstr);
end;

procedure GoSleepp(SleepSecs: Integer);

var
  StartValue: Longint;
begin
  StartValue := GetTickCount;
  while ((GetTickCount - StartValue) <= (SleepSecs)) do
    // Aplication.ProcessMessages;
end;

function LX200Dectoint(dec: String; prec: boolean): Integer;

var
  temp, Signo: Integer;
begin
  if (dec[1] = '-') then
    Signo := -1
  else
    Signo := 1;

  temp := ((ord(dec[2]) - 48) * 10 + (ord(dec[3]) - 48)) * 3600 +
    ((ord(dec[5]) - 48) * 10 + (ord(dec[6]) - 48)) * 60;
  if prec then

    temp := (temp + ((ord(dec[8]) - 48) * 10 + (ord(dec[9]) - 48))) * Signo;
  LX200Dectoint := temp;
end;

function LX200AZtoint(az: String; prec: boolean): Integer;

var
  temp, Signo: Integer;
begin

  temp := (((ord(az[1]) - 48) * 100) + (ord(az[2]) - 48) * 10 +
    (ord(az[3]) - 48)) * 3600 +
    ((ord(az[5]) - 48) * 10 + (ord(az[6]) - 48)) * 60;
  if prec then

    temp := (temp + ((ord(az[8]) - 48) * 10 + (ord(az[9]) - 48)));
  LX200AZtoint := temp;
end;

function LX200Artoint(ar: String; prec: boolean): Integer;

var
  temp: Integer;
begin

  if prec then
  // temp := (strtoint(Copy(ar, 1, 2)) * 3600 + strtoint(Copy(ar, 4, 2)) * 60 +
  // strtoint(Copy(ar, 7, 2))) * 15
  begin
    temp := (((ord(ar[1]) - 48) * 10 + (ord(ar[2]) - 48)) * 3600 +
      ((ord(ar[4]) - 48) * 10 + (ord(ar[5]) - 48)) * 60 +
      ((ord(ar[7]) - 48) * 10 + (ord(ar[8]) - 48))) * 15
  end
  else
    temp := (strtoint(Copy(ar, 4, 2)) * 3600 + strtoint(Copy(ar, 7,
      2) + Copy(ar, 10, 1)) * 6) * 15;
  LX200Artoint := temp;
end;

function Artoint(ar: String): Integer;

var
  temp: Integer;
begin

  temp := 15 * (strtoint(Copy(ar, 1, 2)) * 3600 + strtoint(Copy(ar, 4, 2)) * 60
    + strtoint(Copy(ar, 7, 2))) + strtoint(Copy(ar, 11, 2));
  Artoint := temp;
end;

function longitudetohr(ar: String): Extended;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 3)) * 3600 + strtoint(Copy(ar, 6, 2)) * 60 +
    strtoint(Copy(ar, 9, 2)));
  longitudetohr := (temp / (3600.00 * 15.0));
end;

function longitudetodeg(ar: String): Extended;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 3)) * 3600 + strtoint(Copy(ar, 6, 2)) * 60);
  // +    strtoint(Copy(ar, 9, 2)));
  if ar[1] = '-' then
    temp := -temp;
  longitudetodeg := (temp / (3600.00));
end;

function latitudetodeg(ar: String): Extended;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 2)) * 3600 + strtoint(Copy(ar, 5, 2)) * 60);
  // +strtoint(Copy(ar, 8, 2)));
  if ar[1] = '-' then
    temp := -temp;
  latitudetodeg := (temp / (3600.00));
end;

function Signo;
begin
  if n = 0 then
    Signo := 0
  else if n < 0 then
    Signo := -1
  else
    Signo := 1;
end;

function Signof;
begin
  if f = 0 then
    Signof := 0.0
  else if f < 0.0 then
    Signof := -1.0
  else
    Signof := 1.0;
end;

function Signof1;
begin
  if f = 0 then
    Signof1 := 0
  else if f < 0.0 then
    Signof1 := -1
  else
    Signof1 := 1;
end;

// Function
// #:Sr 11:46.3#:Sd +50ß33#
// #:Sr 12:24:11#:Sd +51ß32:41#
function DoubletoLXdec(de: Double; prec: Byte): string;

var
  g, m, s, sg: Integer;
  tmp: Double;
  sig: char;
  destr: Pchar;
begin

  destr := StrAlloc(15);

  sig := '+';
  // sg:=1;
  // if (de=0.0)then  sg:=0 ;
  if (de < 0.0) then
  begin
    // sg:=-1;
    de := -de;
    sig := '-';
  end;
  g := trunc(de);
  tmp := (de - g);
  m := trunc(tmp * 60);
  tmp := (tmp * 60.0 - m);
  s := trunc(tmp * 60);
  case prec of
    0:
      StrFmt(destr, '%s%0.2d°%0.2d''%0.2d"', [sig, g, m, s]);
    1:
      StrFmt(destr, '%s%0.2d:%0.2d''%0.2d#', [sig, g, m, s]);
    2:
      StrFmt(destr, '%s%0.2dß%0.2d#', [sig, g, m]);
    3:
      StrFmt(destr, '%0.3dß%0.2d''%0.2d#', [g, m, s]);
    4:
      StrFmt(destr, '%0.3dß%0.2d#', [g, m]); // ß
  end;

  DoubletoLXdec := string(destr);
  StrDispose(destr);
End;

function DoubleToLXAr(ra: Double; prec: Byte): string;

var
  h, m, s, de: Integer;
  tmp: Double;
  arstr: Pchar;
begin
  arstr := StrAlloc(15);

  h := trunc(ra);
  tmp := (ra - h);
  m := trunc(tmp * 60);
  tmp := (tmp * 60.0 - m);
  s := trunc(tmp * 60);
  case prec of
    // 0:  StrFmt(arstr,'%0.2dh%0.2dm%0.2ds.%0.3ds',[h,m,s,de]);
    1:
      StrFmt(arstr, '%0.2d:%0.2d:%0.2d#', [h, m, s]);
    2:
      begin
        s := s div 6;
        StrFmt(arstr, '%0.2d:%0.2d.%0.1d#', [h, m, s])
      end;
    3:
      StrFmt(arstr, '%0.2dh%0.2dm%0.2ds', [h, m, s]);
  end;
  DoubleToLXAr := string(arstr);
  StrDispose(arstr);
end;

function GetEnvVarValue(const VarName: string): string;

var
  BufSize: Integer; // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(Pchar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    setlength(Result, BufSize - 1);
    GetEnvironmentVariable(Pchar(VarName), Pchar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

function check_connection: boolean;

var
  str: string;
  n, s, count: Integer;

begin
  s := 0;
  if (ComPortBT_USB.connected) or (ClientSocket1.active) then
  begin
    clearBuff(true, false);
    send('#:GD#');
    while (inbuff < dec_pack) and (s < 10) do
    begin
      sleep(5);
      inc(s);
    end;
    Result := (recv(str, dec_pack) = dec_pack) and (char(str[dec_pack]) = '#')

  end
  else
    Result := false;
end;

Function get_coords(var focus, count: Integer): string;

var
  str, coord_str: string;

  n: Integer;
begin
  clearBuff(true, false);
  send(':GR#:GD#');
  n := 0;
  while (inbuff < coor_pack) and (n < 100) do
  begin
    sleep(20);
    inc(n);
  end;
  // Label2.caption := inttostr(inbuff) + '   ' + inttostr(n);
  count := inbuff;
  if recv(str, coor_pack) >= coor_pack then
  begin

    str := StringReplace(str, '#', #10#13 + 'DE:', [rfIgnoreCase]);
    str := StringReplace(str, '#', '', [rfIgnoreCase]);
    // labelAR.caption := 'RA:' + StringReplace(str, 'á', 'º',
    coord_str := 'RA:' + StringReplace(str, 'á', 'º',
      [rfReplaceAll, rfIgnoreCase]);
  end;
  count := n;
  if true then
  begin
    n := 0;
    if (inbuff) > 0 then
      clearBuff(true, false);
    send(':Fp#');
    while (inbuff < 6) and (n < 100) do
    begin
      sleep(20);
      inc(n);
    end;
    // count := n;
    if recv(str, 6) >= 0 then
    begin
      str := StringReplace(str, '#', '', [rfReplaceAll]);
      focus := StrToIntDef(str, 0);

      // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
      // LabelFocusCount.caption := Format('%0.5d', [n]);
    end
    else
      count := 8888;
  end;
  // focus := n;
  Result := coord_str;
end;

Function get_focuspos(): Integer;
var
  temp, n: Integer;
  str: string;
begin
  if fullconnect then
  begin
    n := 0;
    if (inbuff) > 0 then
      clearBuff(true, false);
    send(':Fp#');
    while (inbuff < 6) and (n < 100) do
    begin
      sleep(20);
      inc(n);
    end;
    // count := n;
    if recv(str, 6) >= 0 then
    begin
      str := StringReplace(str, '#', '', [rfReplaceAll]);
      temp := StrToIntDef(str, 0);

      // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
      // LabelFocusCount.caption := Format('%0.5d', [n]);
    end
    else
      temp := 0;
    Result := temp;
  end;
  Result := 0;
end;

Function get_focusmoving(): Integer;
var
  temp, n: Integer;
  str: string;
begin
  n := 0;
  if (inbuff) > 0 then
    clearBuff(true, false);
  send(':FB#');
  while (inbuff < 2) and (n < 100) do
  begin
    sleep(20);
    inc(n);
  end;
  // count := n;
  if recv(str, 6) >= 0 then
  begin
    str := StringReplace(str, '#', '', [rfReplaceAll]);
    temp := StrToIntDef(str, 0);

    // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
    // LabelFocusCount.caption := Format('%0.5d', [n]);
  end
  else
    temp := 0;
  Result := temp;
end;

Function get_track(): Integer;
var
  temp, n: Integer;
  str: string;
begin
  if fullconnect then
  begin
    n := 0;
    if (inbuff) > 0 then
      clearBuff(true, false);
    send(':Gk#');
    while (inbuff < 1) and (n < 100) do
    begin
      sleep(1);
      inc(n);
    end;
    // count := n;
    if recv(str, 1) > 0 then
    begin
      // str := StringReplace(str, '#', '', [rfReplaceAll]);
      temp := StrToIntDef(str, 0);

      // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
      // LabelFocusCount.caption := Format('%0.5d', [n]);
    end
    else
      temp := 0;
    Result := temp;
  end
  else
    Result := 0;
end;

Function get_coordstpc(var focus, count: Integer): string;

var
  str, coord_str: string;
  n, coo: Integer;
begin
  clearbufftcp(true, false);
  sendtcp('#:GD#');
  n := 0;

  while (inputcounttcp() < dec_pack) and (n < 100) do
  begin
    sleep(1);
    inc(n);
  end;
  // sleep(10);
  if recvtcp(coord_str, dec_pack) >= dec_pack then
  begin
    // coo := LX200Dectoint(coord_str, true);
    clearBuff(true, false);
    // lastdec := coo / (3600.0);
    // coord_str := StringReplace(coord_str, '#', #10#13 + 'DE:', [rfIgnoreCase]);
    coord_str := StringReplace(coord_str, '#', '',
      [rfReplaceAll, rfIgnoreCase]);
    // labelAR.caption := 'RA:' + StringReplace(str, 'á', 'º',
    // coord_str := 'RA:' + StringReplace(coord_str, 'á', 'º',
    // [rfReplaceAll, rfIgnoreCase]);
  end;
  count := inputcounttcp;
  clearbufftcp(true, false);

  sendtcp(':GR#');
  // clientSocket1.socket.SendText(':Fp#');
  // count:= inputcounttcp;
  str := '';
  n := 0;
  while (inputcounttcp() < ra_pack) and (n < 100) do
  begin
    sleep(1);
    inc(n);
  end;
  // sleep(10);
  n := recvtcp(str, ra_pack);
  // count:= inputcounttcp;
  if n >= ra_pack then
  begin
    // coo := LX200Artoint(str, true);
    // lastar := (coo / (15 * 3600.0));
    str := StringReplace(str, '#', '', [rfReplaceAll]);
    n := StrToIntDef(str, 0);

    // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
    // LabelFocusCount.caption := Format('%0.5d', [n]);
  end
  else
    n := 8888;
  focus := n;
  Result := coord_str + #10#13 + str;
end;

function Get_Dec(): Double;

var
  str: string;
  n, s: Integer;
begin

  // if fullconnect then
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send(':GD#');
    send(str);
    while (inbuff < dec_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, dec_pack) >= dec_pack) and (char(str[dec_pack]) = '#') then
    begin
      n := LX200Dectoint(str, true);
      clearBuff(true, false);
      lastdec := (n / (3600.0));

    end;
  end;
  Result := lastdec;
end;

function get_sideral: Double;
var
  str: string;
  n, s: Integer;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send('#:GS#');
    while (inbuff < ra_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;
    If (recv(str, ra_pack) >= ra_pack) then
    begin
      n := LX200Artoint(str, true);
      lastar := (n / (15 * 3600.0));

    end;
  end;
  Result := lastar;

end;

function Get_RA: Double;

var
  str: string;
  n, s: Integer;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send(':GR#');
    while (inbuff < ra_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;
    If (recv(str, ra_pack) >= ra_pack) then
    begin
      n := LX200Artoint(str, true);
      lastar := (n / (15 * 3600.0));

    end;
  end;
  Result := lastar;

end;

function Get_Alt(): Double;

var
  str: string;
  n, s: Integer;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send('#:GA#');
    while (inbuff < dec_pack) and (s < 10) do
    begin
      sleep(1);
      inc(s);
    end;
    // sleep(30);
    If (recv(str, dec_pack) = dec_pack) and (char(str[dec_pack]) = '#') then
    begin
      n := LX200Dectoint(str, true);
      clearBuff(true, false);
      lastalt := (n / (3600.0));

    end;
  end;
  Result := lastalt;
end;

function Get_Az(): Double;

var

  str: string;
  n, s: Integer;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send('#:GZ#');
    while (inbuff < dec_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, dec_pack) = dec_pack) and (char(str[dec_pack]) = '#') then
    begin
      n := LX200AZtoint(str, true);
      clearBuff(true, false);
      lastaz := (n / (3600.0));
    end;
  end;
  Result := lastaz;
end;

procedure Set_TargetDec(value: Double);

var
  response: string;

begin
  send(':Sd' + DoubletoLXdec(value, 1));
  recv(response, 1);
end;

procedure Set_TargetRA(value: Double);

var
  response: string;

begin
  send(':Sr' + DoubleToLXAr(value, 1));
  recv(response, 1);
end;

procedure Set_offset(offset: Integer);

begin

  if offset > 0 then
    send(':SG-' + inttostr(offset) + '.0#')
  else
    send(':SG+' + inttostr(-offset) + '.0#');

end;

procedure Set_date(date_time: tdatetime);
var
  lxdate, response: string;

begin
  DateTimeToString(lxdate, 'mm/dd/yy#', date_time);
  send(':SC' + lxdate);
  // showmessage(lxdate);
  recv(response, 50);
end;

procedure Set_localtime(date_time: tdatetime);
var
  lxtime, response: string;
begin

  DateTimeToString(lxtime, 'hh:nn:ss#', date_time);
  send(':SL' + lxtime);
  // showmessage(lxtime);
  recv(response, 1);
end;

procedure Set_latitude(lat: Extended);
var
  response: string;
begin
  send(':St' + DoubletoLXdec(lat, 1));
  recv(response, 1);
end;

procedure Set_longitude(lon: Extended);
var
  response: string;
begin
  send(':Sg' + DoubletoLXdec(-lon, 1));
  recv(response, 1);
end;

procedure Abort_Slew();
begin
  send('#:Qn#:Qw#');
end;

procedure Pulse_Guide(StrCommand: string);
begin
  send(StrCommand);
end;

procedure Command_Blind(const Command: WideString; Raw: WordBool);
begin
  send(Command);
end;

procedure SyncTo_Coord(RightAscension, Declination: Double);
begin
  Set_TargetDec(Declination);
  Set_TargetRA(RightAscension);
  send(':CM#');
end;

procedure SyncTo_Coord();
begin
  send(':CM#');
end;

procedure Slew_ToCoor(RightAscension, Declination: Double);
begin
  Set_TargetDec(Declination);
  Set_TargetRA(RightAscension);
  send(':MS#');
end;

procedure Slew_ToCoor();
begin
  send(':MS#');
end;

function Get_Lat(): Extended;
var

  str: string;
  n, s: Integer;
  lat: Extended;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send(':Gt#');
    while (inbuff < lat_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, lat_pack) = lat_pack) and (char(str[lat_pack]) = '#') then
    begin
      lat := latitudetodeg(str);
      clearBuff(true, false);
    end;
  end;
  Result := lat;

end;

function Get_Long(): Extended;
var

  str: string;
  n, s: Integer;
  lon: Extended;
begin
  if fullconnect then
  begin
    s := 0;
    clearBuff(true, false);
    send(':Gg#');
    while (inbuff < long_pack) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, long_pack) = long_pack) and (char(str[long_pack]) = '#') then
    begin
      lon := longitudetodeg(str);
      clearBuff(true, false);
    end;
  end;
  Result := -lon;

end;

function get_alignmode(): char;
var
  str: string;
  c: char;
  n, s: Integer;
begin
  { clearBuff(true, false);
    send(#6);
    if recv(str,1)=1 then
    result :=str[1]
    else result:='P' ; }
  if fullconnect then
  begin
    s := 0;
    c := 'A';
    clearBuff(true, false);
    send(#6);
    while (inbuff < 1) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, 1) = 1) then
    begin
      c := str[1];
      clearBuff(true, false);
    end;
  end;
  Result := c;

end;

function get_gmtoffset(): Integer;
var
  str: string;

  n, s: Integer;
begin
  if fullconnect then
  begin
    n := 50;
    s := 0;
    clearBuff(true, false);
    send(':GG#');
    while (inbuff < 1) and (s < 100) do
    begin
      sleep(1);
      inc(s);
    end;

    If (recv(str, 4) = 4) then
    begin

      n := -strtoint(StringReplace(str, '#', '', [rfReplaceAll]));
      clearBuff(true, false);
    end;
  end;
  Result := n;

end;

function Local_Sideral_Time(localdatetime: tdatetime;
  longitude: Double): Double;
var
  d, lst: Double;
begin
  d := (DateTimeToJulianDate(localdatetime)) - 2451545.0;
  lst := 18.697374558 + 24.06570982441908 * d;
  Local_Sideral_Time := 1.0 * (trunc(lst) MOD 24) + frac(lst) - longitude /
    15.0; // result hours
end;

procedure sconnect;

begin

  connected := OpenCom(Sport, '\\.\' + 'COM5', '115200', 'N', '8', '1', '100',
    '100', false);
  if connected then
    showmessage('connected');

  // fh := sport;
  // PurgeBuffer(sport);

end;

initialization

ComPortBT_USB := TComPort.Create(nil);
ClientSocket1 := TClientSocket.Create(nil);
// sconnect;

end.
