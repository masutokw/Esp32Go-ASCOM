unit Serialtools;

interface

uses SysUtils, cport,dialogs,globalvar;
const READ_DELAY =20;
var
  ComPortBT_USB: TComPort;
function sendserial(value: string): Integer;
function recvserial(var value: string; count: Integer): Integer;
function readlnSerial(var value: string; delimiter: string): Integer;
function readcharserial(var c: char): Integer;
function inputcountserial(): Integer;
procedure clearbuffSerial(input, output: boolean);
function wait_read(mili:integer):integer;

implementation

function sendserial(value: string): Integer;
var
  count: Integer;
begin
  Result := 0;
  if ComPortBT_USB.connected then
  begin

     count := length(value);
     try
    Result := ComPortBT_USB.writestr(value) ;

      EXCEPT
       on E : Exception do
     begin
       ShowMessage('Exception class name = '+E.ClassName);
       ShowMessage('Exception message = '+E.Message);
       ComPortBT_USB.close;
       fullconnect := false;
     end;

     end;
  end;

end;

function recvserial(var value: string; count: Integer): Integer;

var
  n: cardinal;
begin
  Result := 0;

  if ComPortBT_USB.connected then
  begin
   // if inputcountserial =0 then sleep(READ_DELAY);
   //    if inputcountserial =0 then sleep(READ_DELAY);
    wait_read(2) ;
    n := ComPortBT_USB.Readstr(value, count);
    Result := n;
  end;
end;

function inputcountserial(): Integer;
var n:integer;
begin
  n := 0;
  if ComPortBT_USB.connected then
  begin
    n := ComPortBT_USB.InputCount
  end;
    result:=n;
end;

function readlnSerial(var value: string; delimiter: string): Integer;
var
  ch: string;
begin
  Result := 0;
  value := '';
  if ComPortBT_USB.connected then
  begin
    //  if inputcountserial =0 then sleep(READ_DELAY);
     // if inputcountserial =0 then sleep(READ_DELAY);
     wait_read(2) ;
    while ComPortBT_USB.InputCount > 0 do
    begin
        if ComPortBT_USB.Readstr(ch, 1) = 1 then
      begin
        value := value + ch;
        if ch = delimiter then
          break;
      end
      // else
      // break
    end;
    Result := value.length
  end;
end;

function readcharserial(var c: char): Integer;
var
  n: Integer;
  str:string;
begin
  Result := 0;
  if ComPortBT_USB.connected then
  begin
  // if inputcountserial =0 then sleep(READ_DELAY);
  // if inputcountserial =0 then sleep(READ_DELAY);
    wait_read(2) ;
    n := ComPortBT_USB.read(c, 1);
    //c:=str[1];
    Result := n;
  end;
end;

procedure clearbuffSerial(input, output: boolean);
 var str:string;
begin
  // ComPortBT_USB.ClearBuffer(input, output)  ;
  if (ComPortBT_USB.connected) and (ComPortBT_USB.InputCount > 0) then
     ComPortBT_USB.ReadStr(str, ComPortBT_USB.InputCount);
    //ComPortBT_USB.ClearBuffer(input, output);
end;
function wait_read(mili:integer):integer;
var count:integer;
begin
count:=0;
  while  (count<mili) do
  begin
  if inputcountserial>0 then break;

  sleep(16);inc(count)
  end;
  result:=count;
end;

initialization

ComPortBT_USB := TComPort.Create(nil);

end.
