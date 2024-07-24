﻿unit shared;

interface

uses Windows, SysUtils, Classes, Controls, Cport, dialogs, serial,
 DateUtils, bluetools, tcptools,serialtools,lxutils;

const
  ra_pack = 11;
  dec_pack = 10;
  lat_pack = 7;
  long_pack = 8;
  coor_pack = ra_pack + dec_pack;


  TIMEOUTBT = 60;

var


  fullconnect: boolean;
  lastdec, lastar, lastaz, lastalt: Double;
  gmtoffset: Integer;
  imode: Integer;
  Sport: THandle;
  connected: boolean;
  alt, ra, dec, az, longi, lat: Double;
  track: Integer;
  send: function(values: String): Integer;
  recv: function(var value: string; count: Integer): Integer;
  readvln: function(var value: string; delimiter: string): Integer;
  readchar: function(var c: char): Integer;
  inbuff: function: Integer;
  clearBuff: procedure(input, output: boolean);
  focuspos:array[0..3] of cardinal  ;

procedure set_interface_mode(mode: Integer);
procedure initserial(port: string; baudrate: tbaudrate);
procedure init_tcp(host: string; port: Integer);
Function get_coords(var focus, count: Integer): string;

Function get_focuspos(): Integer;
Function get_focusmoving(): Integer;

function Check_Connection(): boolean;
procedure Set_Date(date_time: tdatetime);
procedure Set_localtime(date_time: tdatetime);
function Get_Dec(): Double;
function Get_RA: Double;
procedure Pulse_Guide(StrCommand: string);
function Get_Alt(): Double;
function Get_Az(): Double;
function Get_Lat(): Double;
function Get_Long(): Double;
procedure Set_TargetDec(value: Double);
procedure Set_TargetRA(value: Double);
procedure Abort_Slew();
procedure Command_Blind(const Command: WideString; Raw: WordBool);
procedure SyncTo_Coord(RightAscension, Declination: Double); overload;
procedure SyncTo_Coord(); overload;
procedure Slew_ToCoor(RightAscension, Declination: Double); overload;
procedure Slew_ToCoor();overload
procedure Set_longitude(lon: Extended);
procedure Set_latitude(lat: Extended);
procedure Set_offset(offset: Integer);
function Get_Alignmode(): char;
Function Get_track(): Integer;
function Get_sideral(): Double;
function Get_gmtoffset(): Integer;
function UTCNow: tdatetime;
function Local_Sideral_Time(localdatetime: tdatetime;longitude: Double): Double;
procedure setautoflip(b:boolean);
procedure setpierside(b:boolean);
function get_pierside():boolean;
function get_flip():boolean;
implementation

function UTCNow: tdatetime;
var
  ASystemTime: TSystemTime;
  UTCnowDateTime: tdatetime;
begin
  GetSystemTime(ASystemTime);
  UTCnowDateTime := SystemTimeToDateTime(ASystemTime);
  Result := UTCnowDateTime;
end;

procedure set_interface_mode(mode: Integer);
begin

  case mode of

    0:
      begin
        send := sendserial;
        recv := recvserial;
        readvln := readlnSerial;
        inbuff := inputcountserial;
        clearBuff := clearbuffSerial;
        readchar := readcharserial;
      end;
    1:
      begin

        send := sendtcp;
        recv := recvtcp;
        readvln := readlnTCP;
        inbuff := inputcounttcp;
        clearBuff := clearbufftcp;
        readchar := readcharTCP;
      end;
    2:
      begin
        send := sendBT;
        recv := readcvBT;
        readvln := readlnBT;
        readchar := readcharbt;
        inbuff:= inputcountbt;
         clearBuff :=clearbuffblue;
      end;
  end;
end;

procedure initserial(port: string; baudrate: tbaudrate);
begin
   ComPortBT_USB.port := port;
  ComPortBT_USB.baudrate := baudrate;
  ComPortBT_USB.Events := [];
  ComPortBT_USB.Parity.Bits := prNone;

  ComPortBT_USB.Timeouts.ReadInterval := 30;
  ComPortBT_USB.Timeouts.ReadTotalMultiplier := 2;
  ComPortBT_USB.Timeouts.ReadTotalConstant := 3;
  ComPortBT_USB.Timeouts.WriteTotalMultiplier := 0;
  ComPortBT_USB.Timeouts.WriteTotalConstant := 100;
  ComPortBT_USB.TriggersOnRxChar := false;

  ComPortBT_USB.SyncMethod := smWindowSync;//smNone;
end;

procedure init_tcp(host: string; port: Integer);
begin

  ClientSocket1.host := host;
  ClientSocket1.port := port;
  ClientSocket1.readtimeout := -1;
  ClientSocket1.ConnectTimeout := 1000;

end;

function Check_Connection: boolean;

var
  str: string;
  n, s, count: Integer;

begin
  s := 0;

  if (ComPortBT_USB.connected) or checkBtSock or
    (ClientSocket1.connected) then
  begin

    send(':GD#');
    sleep(100);
    readvln(str, '#');


    Result := str.length > 1;
    // showmessage(str);
  end
  else
    Result := false;
end;
Function get_coords(var focus, count: Integer): string;

var
  str, str1, coord_str: string;

  n: Integer;
  sl: TStringList;
  c: char;
begin
  sl := TStringList.Create();
  sl.delimiter := '#';
  //send(':Ga#:Fp#');


  send(':GR#:GD#:GZ#:GA#:Gk#:Fp#');
  readvln(str, '#');
  if str.length <13 then
  begin
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
   // readvln(str1, '#');
   // str := str + str1;
  end;
  sl.DelimitedText := str;
  if (sl.count > 4) and (str.Length>47) then
  begin
   ra := LX200Artoint(sl.Strings[0] + '#', true) / (3600.0 * 15.0);
    dec := LX200Dectoint(sl.Strings[1] + '#', true) / (3600.0);
    az := LX200AZtoint(sl.Strings[2] + '#', true) / (3600.0);
    alt := LX200Dectoint(sl.Strings[3] + '#', true) / (3600.0);
   // track := strtoint (sl.Strings[4]);
   // focus := strtoint(sl.Strings[5]);

    str1:=sl.Strings[4];
    track:=strtointdef(Copy(sl.Strings[4], 1, 1),0);
   focus := strtointdef(Copy(sl.Strings[4], 2,str1.length ),0);
  end;
  // readvln(str0, '#');

  // str0:=str;
  if str.length > 40 then
  begin
    coord_str := StringReplace(sl.text, '�', 'º', [rfReplaceAll]);
    coord_str := StringReplace(sl.text, 'á', 'º', [rfReplaceAll]);
  end
  else
    coord_str := str.length.ToString();

  Result := coord_str;
  sl.Free;
end;

{Function get_coords(var focus, count: Integer): string;

var
  str, str1, coord_str: string;

  n: Integer;
  sl: TStringList;
  c: char;
begin
  sl := TStringList.Create();
  sl.delimiter := '#';
  send(':Ga#:Fp#');


 // send(':GR#:GD#:GZ#:GA#:Gk#:Fp#');
  readvln(str, '#');
  if str.length < 13 then
  begin
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
    readvln(str1, '#');
    str := str + str1;
  end;
  sl.DelimitedText := str;
  if (sl.count > 4) and (str.Length>47) then
  begin
   ra := LX200Artoint(sl.Strings[0] + '#', true) / (3600.0 * 15.0);
    dec := LX200Dectoint(sl.Strings[1] + '#', true) / (3600.0);
    az := LX200AZtoint(sl.Strings[2] + '#', true) / (3600.0);
    alt := LX200Dectoint(sl.Strings[3] + '#', true) / (3600.0);
    track := strtoint (sl.Strings[4]);
    focus := strtoint(sl.Strings[5]);

  //  str1:=sl.Strings[4];
   // track:=strtointdef(Copy(sl.Strings[4], 1, 1),0);
   //focus := strtointdef(Copy(sl.Strings[4], 2,str1.length ),0);
  end;
  // readvln(str0, '#');

  // str0:=str;
  if str.length > 40 then
  begin
    coord_str := StringReplace(sl.text, '�', 'º', [rfReplaceAll]);
    coord_str := StringReplace(sl.text, 'á', 'º', [rfReplaceAll]);
  end
  else
    coord_str := str.length.ToString();

  Result := coord_str;
  sl.Free;
end;
}
Function get_focuspos(): Integer;
var
  temp, n: Integer;
  str: string;
begin
  if fullconnect then
  begin
    n := 0;

    send(':Fp#');
    if readvln(str, '#') = 6 then
    begin
      str := StringReplace(str, '#', '', [rfReplaceAll]);
      temp := StrToIntDef(str, 0);
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
  c: char;
  str: string;
begin
  if fullconnect then
  begin
    n := 0;
    Result := 1;
    send(':Gk#');
    if readchar(c) > 0 then
    begin

      temp := ord(c) - 48;

    end
    else
      temp := 0;
    Result := temp;
  end
  else
    Result := 0;
end;


function Get_Dec(): Double;

var
  str: string;
  n, s: Integer;
begin

  if fullconnect then
  begin
    s := 0;

    send(':GD#');

    If readvln(str, '#') = dec_pack then
    begin
      n := LX200Dectoint(str, true);
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
    // clearbuff(true,true);
    send(':GS#');

    If readvln(str, '#') >= 9 then
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

    send(':GR#');
    If (readvln(str, '#') = ra_pack) then
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
    send(':GA#');
    If (readvln(str, '#') = dec_pack) then
    begin
      n := LX200Dectoint(str, true);
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
    n := 0;

    send(':GZ#');
    If (readvln(str, '#') = dec_pack) then
    begin
      n := LX200AZtoint(str, true);
      lastaz := (n / (3600.0));
    end;
  end;
  Result := lastaz;
end;

procedure Set_TargetDec(value: Double);

var
  response: char;

begin
  send(':Sd' + DoubletoLXdec(value, 1));

  readchar(response);
end;

procedure Set_TargetRA(value: Double);

var
  response: char;

begin
  send(':Sr' + DoubleToLXAr(value, 1));

  readchar(response);
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
  readvln(response, '#');
  readvln(response, '#');
end;

procedure Set_localtime(date_time: tdatetime);
var
  lxtime: string;
  response: char;
begin

  DateTimeToString(lxtime, 'hh:nn:ss#', date_time);
  send(':SL' + lxtime);
  // showmessage(lxtime);
  readchar(response);
end;

procedure Set_latitude(lat: Extended);
var
  response: char;
begin
  send(':St' + DoubletoLXdec(lat, 1));
  readchar(response);
end;

procedure Set_longitude(lon: Extended);
var
  response: char;
begin
  send(':Sg' + DoubletoLXdec(-lon, 1));
  readchar(response);
end;

procedure Abort_Slew();
begin
  send(':Qn#:Qw#');
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
var
  str: string;
begin


  Set_TargetDec(Declination);
  Set_TargetRA(RightAscension);
  send(':CM#');
   readvln(str, '#');
// clearbuff(true,true);
end;

procedure SyncTo_Coord();
var
  str: string;
begin
  send(':CM#');
  readvln(str, '#');
end;

procedure Slew_ToCoor(RightAscension, Declination: Double);
var
  c: char;
begin
  Set_TargetDec(Declination);
  Set_TargetRA(RightAscension);
  send(':MS#');
  if readchar(c)=0 then readchar(c) ;
   //clearbuff(true,true);
end;

procedure Slew_ToCoor();
var
  c: char;
begin
  send(':MS#');
  readchar(c);
end;

function Get_Lat(): Double;
var

  str: string;
  n, s: Integer;
  lati: Double;
begin
  Result := lat;
  if fullconnect then
  begin

    send(':Gt#');

    If readvln(str, '#') >= lat_pack then
    begin
      lati := latitudetodeg(str);
      Result := lati;
    end;
  end;

end;

function Get_Long(): Double;
var

  str: string;
  n, s: Integer;
  lon: Double;
begin
  Result := longi;
  if fullconnect then
  begin

    send(':Gg#');

    If readvln(str, '#') >= long_pack then
    begin
      lon := longitudetodeg(str);
      Result := -lon;
    end;
  end

end;

function get_alignmode(): char;
var
  str: string;
  c: char;
  n, s: Integer;
begin
  c := 'P';
  if fullconnect then
  begin
    s := 0;
    send(#6);
    readchar(c);
  end;
  Result := c;

end;


function get_gmtoffset(): Integer;
var
  str: string;

  n, s: Integer;
begin
n:=0;
  if fullconnect then
  begin
    send(':GG#');

    If readvln(str, '#') = 4 then
    begin

      n := -strtoint(StringReplace(str, '#', '', [rfReplaceAll]));

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

procedure setautoflip(b:boolean);
var
  c: char;
begin
c:='0';
if b then c:='1' ;

  send(':pa' +c+'#');

end;
procedure setpierside(b:boolean);
begin
if b then

 send(':psw#')
 else
 send(':pse#');
// sendstr(':pS#');
 // Label28.Text := readstr('#');

 // sendstr(#6);
  //Label28.Text := Label28.Text + readchar;

end;
function get_pierside():boolean;
var str:string;
begin
  send(':pS#');
 readvln(str,'#');
 result :=(Str='WEST#');

end;
function get_flip():boolean;
var str:string;
begin
  send(':pF#');
 readvln(str,'#');
 result :=(Str='1#');

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

//ComPortBT_USB := TComPort.Create(nil);

// sconnect;

end.
