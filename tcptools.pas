unit tcptools;

interface

uses SysUtils, System.Win.ScktComp, IdTCPConnection, IdTCPClient;

var
  ClientSocket1: TidTCPClient;

function sendtcp(value: string): Integer;
function recvtcp(var value: string; count: Integer): Integer;
function readlnTCP(var value: string; delimiter: string): Integer;
function readcharTCP(var c: char): Integer;
function inputcounttcp(): Integer;
procedure clearbufftcp(input, output: boolean);

implementation

function sendtcp(value: string): Integer;
begin
  if ClientSocket1.connected then
  begin
    clearbufftcp(true, true);
    ClientSocket1.Socket.write(value);
    Result := value.length;
  end
  else
    Result := 0;
end;

function inputcounttcp(): Integer;
var
  n: Integer;
begin
  n := 0;
  n := ClientSocket1.Socket.InputBuffer.Size;
  Result := n
end;

procedure clearbufftcp(input, output: boolean);

begin
  if ClientSocket1.connected then
  begin
    while not ClientSocket1.Socket.InputBufferIsEmpty do
      ClientSocket1.Socket.ReadByte();
  end;
end;

function recvtcp(var value: string; count: Integer): Integer;
var
  str: ansistring;
begin
  Result := 0;
  if ClientSocket1.connected then
  begin

    if not ClientSocket1.Socket.InputBufferIsEmpty then
    begin
      value := ClientSocket1.Socket.ReadString(count);
      // setlength(value, count);
    end;
    Result := count;
  end;
end;

function readlnTCP(var value: string; delimiter: string): Integer;
var
  str: string;
begin
  if ClientSocket1.connected then
  begin
    str := ClientSocket1.Socket.readln(delimiter,1000,500);
      if str.length > 0 then
      str := str + delimiter;
  end;
  value := str;
  Result := str.length;
end;

function readcharTCP(var c: char): Integer;
begin
  Result := 0;
  if ClientSocket1.connected then
  begin
    c := ClientSocket1.Socket.readchar();
    Result := 1;
  end;
end;

initialization

ClientSocket1 := TidTCPClient.Create(nil);

end.
