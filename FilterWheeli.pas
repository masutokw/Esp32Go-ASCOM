unit FilterWheeli;

interface

uses
  ComObj, ActiveX, Esp32go_TLB, StdVcl,shared;

const
  DRIVER_NAME = 'Esp32go';
  DRIVER_ID = DRIVER_NAME + '.FilterWheel';

type
  TFilterWheel = class(TAutoObject, IFilterWheel)
  protected
    function Get_Connected: WordBool; safecall;
    procedure Set_Connected(Value: WordBool); safecall;
    function Get_FocusOffsets: PSafeArray; safecall;
    function Get_Position: Smallint; safecall;
    procedure Set_Position(Value: Smallint); safecall;
    function Get_Names: PSafeArray; safecall;
    procedure SetupDialog; safecall;
    function Get_SupportedActions: OleVariant; safecall;
    function Get_DriverInfo: widestring; safecall;
    function Get_DriverVersion: widestring; safecall;
    function Get_InterfaceVersion: ShortInt; safecall;
    function Get_Description: widestring; safecall;
    function Get_Name: widestring; safecall;
    procedure Action(const ActionName, ActionParams: widestring); safecall;
    procedure CommandBlind(const Command: widestring;
      Param2: WordBool); safecall;
    procedure CommandBool(const Command: widestring; raw: WordBool); safecall;
    procedure CommandString(const Command: widestring; raw: WordBool); safecall;
    procedure Dispose; safecall;

    // property Connected: WordBool read Get_Connected write Set_Connected;
    // property FocusOffsets: PSafeArray read Get_FocusOffsets;
    // property Position: Smallint read Get_Position write Set_Position;
    // property Names: PSafeArray read Get_Names;
  public
  end;

implementation

uses ComServ, sysutils, Dialogs, Controls, ShellAPI;

function TFilterWheel.Get_Connected: WordBool;
begin
  //sleep(500);

  Get_Connected := true;

end;

Procedure TFilterWheel.Set_Connected(Value: WordBool);
begin
end;

function TFilterWheel.Get_FocusOffsets: PSafeArray;
begin
SafeArrayunlock(SafeArray);
  result:=SafeArray;

end;

function TFilterWheel.Get_Position: Smallint;
begin
   result:=slotc;
end;

function TFilterWheel.Get_SupportedActions: OleVariant;
var
  capacity: Integer;
  item: Variant;
  dotNetArrayList: Variant;
begin
  { Create object }
  dotNetArrayList := CreateOleObject('System.Collections.ArrayList');

  { Add an element }
  dotNetArrayList.Add('NULL');
  item := dotNetArrayList.item(0);
  Result := dotNetArrayList;
end;

procedure TFilterWheel.Set_Position(Value: Smallint);
begin
   if (value <= 8)and(value>=0 )  then  goto_slot(value)
  else raise  EOLEexception.Create('Invalid Value 1',$80040404,'none','0',0);

end;

function TFilterWheel.Get_Names: PSafeArray;
begin

 // unlock();
   SafeArrayUnlock(SafeArrayNames);
     result:= SafeArrayNames;
   //  showmessage('names '+v[2])  ;
 // result:= PSafeArray(TVarData(v).VArray)  ;
 //  SafeArrayunlock(result);
end;

procedure TFilterWheel.SetupDialog;
begin
end;

function TFilterWheel.Get_DriverInfo: widestring;
begin
  Result := 'Esp32Go FilterWheel'
end;

function TFilterWheel.Get_DriverVersion: widestring;
begin
  Result := '2.3'
end;

function TFilterWheel.Get_InterfaceVersion: ShortInt;
begin
  Result := 2
end;

function TFilterWheel.Get_Description: widestring;
begin
  Result := 'Esp32Go filter driver'
end;

function TFilterWheel.Get_Name: widestring;
begin
  Result := 'Esp32Go Filter Wheel'
end;

{ -------------------------------------------------------------- }
procedure RegisterThySelf;
{ -------------------------------------------------------------- }
// Test id this interface is registered int he ASCOM registry area
// If not register it so the Choose can find it and also to store persistent data
var
  ProfileObject: Variant;

begin

 // ProfileObject := CreateOLEObject('ASCOM.Utilities.Profile');
  ProfileObject := CreateOleObject('DriverHelper.Profile');
  ProfileObject.DeviceType := 'FilterWheel';
  if (not ProfileObject.IsRegistered(DRIVER_ID)) then
  begin
    ShowMessage('Self-Registering: ASCOM ' + DRIVER_ID);
    ProfileObject.Register(DRIVER_ID, 'Esp32go FilterWheel');

  end;
end;

procedure TFilterWheel.Action(const ActionName, ActionParams: widestring);
begin

end;

procedure TFilterWheel.CommandBlind(const Command: widestring;
  Param2: WordBool);

begin

end;

procedure TFilterWheel.CommandBool(const Command: widestring; raw: WordBool);
begin

end;

procedure TFilterWheel.CommandString(const Command: widestring; raw: WordBool);
begin

end;

procedure TFilterWheel.Dispose;
begin
{SafeArrayDestroy(SafeArray);
  SafeArray:=nil;
SafeArrayDestroy( SafeArrayNames);
 SafeArrayNames:=nil;   }

end;

initialization

CoInitializeex(nil, COINIT_APARTMENTTHREADED);
RegisterThySelf;
TAutoObjectFactory.Create(ComServer, TFilterWheel, Class_FilterWheel,
  cimultiInstance, tmApartment);

end.
