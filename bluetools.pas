unit bluetools;

interface

uses Sysutils, Strutils, System.Bluetooth, classes,Bluetooth.Components;

const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

var
  Fsocket: Tbluetoothsocket;
  Bluetooth1: TBluetooth;

function sendBT(value: string): Integer;
function readlnBT(var value: string; delimiter: string): Integer;
function readcharbt(var c: char): Integer;
function readcvBT(var value: string; count: Integer): Integer;
function checkBtSock(): boolean;
function FreeBtSock(): boolean;
function connectbt(pdevice: string): boolean;
function inputcountbt():integer;
procedure clearbuffblue(input, output: boolean);
procedure devlist(t: Tstrings);

implementation

var
  inbuffer: string;

procedure devlist(t: Tstrings);
var
  ldevice: Tbluetoothdevice;

begin
  Bluetooth1.Enabled := true;
  t.Clear;
  for ldevice in Bluetooth1.PairedDevices do
  begin
   t.Add(ldevice.DeviceName)
  end;

end;

function connectbt(pdevice: string): boolean;
var
  ldevice: Tbluetoothdevice;

begin
  result := false;
  for ldevice in Bluetooth1.PairedDevices do
  begin

    if ldevice.DeviceName = pdevice then
    begin
      Fsocket := ldevice.CreateClientSocket(stringtoguid(UUID), false);
      if Fsocket <> nil then
      begin
        Fsocket.connect;
        result := Fsocket.Connected

      end;

    end;

  end;
end;

function FreeBtSock(): boolean;
begin
  freeandnil(Fsocket);
  result := true;
end;

function checkBtSock(): boolean;
begin
  result := (Fsocket <> nil) and (Fsocket.Connected);
end;

function sendBT(value: string): Integer;
var
  bytes: Tbytes;
begin
  result := 0;
  bytes := BytesOf(value);
  if checkBtSock then
  begin
    Fsocket.SendData(bytes);
    result := value.length;
  end;

end;

function readlnBT(var value: string; delimiter: string): Integer;
var
  bytes: Tbytes;
  s: string;
begin

  if checkBtSock then
  begin
    bytes := Fsocket.Receivedata(90);
    s := stringof(bytes);
    value := s;
  end;
  result := s.length;
end;

function readcharbt(var c: char): Integer;
var

  bytes: Tbytes;
  s: string;
begin
  c := '0';
  if checkBtSock then
  begin
    bytes := Fsocket.Receivedata(90);
    c := char(bytes[0]);
  end;
  result := 1;

end;

function readcvBT(var value: string; count: Integer): Integer;
var
  bytes: Tbytes;
  s: string;
begin

  if checkBtSock then
  begin
    bytes := Fsocket.Receivedata(90);
    s := stringof(bytes);
    value := s;
  end;
  result := s.length;
end;

function readcvBTbuff(var value: string; count: Integer): Integer;
var
  bytes: Tbytes;
  s: string;
begin

  if checkBtSock then
  begin
    bytes := Fsocket.Receivedata(1);
    inbuffer := stringof(bytes) + inbuffer;
    value := leftstr(inbuffer, count);
    inbuffer := Rightstr(inbuffer, inbuffer.length - count);
  end;
  result := value.length;

end;

function readlnBTbuff(var value: string; delimiter: string): Integer;
var
  bytes: Tbytes;
  s: string;
  count: Integer;
begin

  if checkBtSock then
  begin
    bytes := Fsocket.Receivedata(1);
    inbuffer := stringof(bytes) + inbuffer;
    count := pos(delimiter, inbuffer);
    if count >= 0 then
    begin
      value := leftstr(inbuffer, count);
      inbuffer := Rightstr(inbuffer, inbuffer.length - count);
    end;
  end;
  result := value.length;

end;
function inputcountbt():integer;
begin result:=0;
end;
procedure clearbuffblue(input, output: boolean);

begin

  end;


initialization

Bluetooth1 := TBluetooth.Create(nil);
Bluetooth1.Enabled := true;

end.
