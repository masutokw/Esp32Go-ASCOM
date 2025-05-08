unit Esp32goRi;

interface

uses
  ComObj, ActiveX, Esp32go_TLB, StdVcl, shared;

const
  DRIVER_NAME = 'Esp32go';
  DRIVER_ID = DRIVER_NAME + '.Rotator';

type
  TRotator = class(TAutoObject, IRotator)
  protected
    function Get_CanReverse: WordBool; safecall;
    function Get_IsMoving: WordBool; safecall;
    function Get_Connected: WordBool; safecall;
    function Get_StepSize: Single; safecall;
    function Get_Position: Single; safecall;
    function Get_Reverse: WordBool; safecall;
    function Get_TargetPosition: Single; safecall;
    procedure Halt; safecall;
    procedure Move(val: Single); safecall;
    procedure MoveAbsolute(Position: Single); safecall;
    procedure Set_Connected(pVal: WordBool); safecall;
    procedure Set_Reverse(pVal: WordBool)safecall;
    procedure SetUpDialog; safecall;
    procedure CommandBlind(const Command: WideString; Raw: WordBool); safecall;
    function Get_DriverInfo: WideString; safecall;
    function Get_DriverVersion: WideString; safecall;
    function Get_InterfaceVersion: ShortInt; safecall;
    function Get_Description: WideString; safecall;
    function Get_Name: WideString; safecall;
    function Get_SupportedActions: OleVariant; safecall;
    procedure Set_IsMoving(Value: WordBool); safecall;
    procedure Set_Position(Value: Single); safecall;
    procedure MoveMechanical(Position: Single); safecall;
    function Get_MechanicalPosition: Single; safecall;
    procedure Sync(Position: Single); safecall;
    { Protected declarations }
  end;

implementation

uses ComServ, sysutils, Dialogs, Controls, ShellAPI;

const
  ID = 'D1';

function TRotator.Get_CanReverse: WordBool;
begin
  result := true;
end;

function TRotator.Get_IsMoving: WordBool;
begin
  result := get_focusmoving('X') <> 0;
end;

function TRotator.Get_Connected: WordBool;
begin
  result := true;
end;

function TRotator.Get_StepSize: Single;

begin
  result := 360.0 / aux_max;
end;

function TRotator.Get_Position: Single;
begin
  // rotator.get_angle;
  result := 360.0 / aux_max * aux_counter;
end;

function TRotator.Get_Reverse: WordBool;
begin
  result := false;
end;

function TRotator.Get_TargetPosition: Single;
begin
  result := 360.0 / aux_max * aux_target;
end;

procedure TRotator.Halt;
begin
  send(':XQ#');
end;

function TRotator.Get_DriverInfo: WideString;
begin
  result := 'Esp32Go Rotator'
end;

function TRotator.Get_DriverVersion: WideString;
begin
  result := 'Esp32Go V1'
end;

function TRotator.Get_InterfaceVersion: ShortInt;
begin
  result := 2
end;

function TRotator.Get_Description: WideString;
begin
  result := 'Esp32Go rotator driver'
end;

function TRotator.Get_Name: WideString;
begin
  result := 'Esp32GoRotator'
end;

function TRotator.Get_SupportedActions: OleVariant;
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
  result := dotNetArrayList;
end;

procedure TRotator.CommandBlind(const Command: WideString; Raw: WordBool);
begin
end;

procedure TRotator.Move(val: Single);
var
  counter: Integer;
begin

   val:=val+(360.0 / aux_max * aux_counter);

 // if (val >= 0.0) and (val<=360.0) then
  if true then
  begin
    counter :=Round( (val / 360.0) * aux_max);

    send(':XA-' + Format('%.5d', [counter]) + '#');
  end
  else
    raise EOLEexception.Create('Invalid Value 1', $80040404, 'none', '0', 0);
   aux_target := round(val / 360.0) * aux_max;
end;

procedure TRotator.MoveAbsolute(Position: Single);
var
  counter: Integer;
begin

  //if (position >= 0.0 )and (position<=360.0) then
  if true then

  begin
    counter := round(Position/ 360.0 * aux_max);

    send(':XA-' + Format('%.5d', [counter]) + '#');
  end
  else
    raise EOLEexception.Create('Invalid Value 1', $80040404, 'none', '0', 0);
  aux_target := round(Position / 360.0) * aux_max;
end;

procedure TRotator.Set_Connected(pVal: WordBool);
begin
  pVal := true;
end;

procedure TRotator.Set_Reverse(pVal: WordBool);
begin

end;

procedure TRotator.SetUpDialog;
begin

end;

procedure RegisterThySelf;
{ -------------------------------------------------------------- }
// Test id this interface is registered int he ASCOM registry area
// If not register it so the Choose can find it and also to store persistent data
var
  ProfileObject: Variant;

begin
  // ProfileObject := CreateOLEObject('ASCOM.Utilities.Profile');
  ProfileObject := CreateOleObject('ASCOM.Utilities.Profile');
  ProfileObject.DeviceType := 'Rotator';
  if (not ProfileObject.IsRegistered(DRIVER_ID)) then
  begin
    ShowMessage('Self-Registering: ASCOM ' + DRIVER_ID);
    ProfileObject.Register(DRIVER_ID, 'Esp32 Field Rotator');
    // set persistent default values if any
  end;
end;

procedure TRotator.Set_IsMoving(Value: WordBool);
begin

end;

procedure TRotator.Set_Position(Value: Single);
var
  counter: Integer;
begin

  counter := round((Value / 360.0) * aux_max);
  send(':XLS1+' + Format('%.5d', [counter]) + '#');
end;

procedure TRotator.MoveMechanical(Position: Single);
var
  counter: Integer;
begin

  if position >= 0 then
  begin
    counter := round(Position/ 360.0) * aux_max;

    send(':XA-' + Format('%.5d', [counter]) + '#');
  end
  else
    raise EOLEexception.Create('Invalid Value 1', $80040404, 'none', '0', 0);
  aux_target := round(Position / 360.0 * aux_max);

end;

function TRotator.Get_MechanicalPosition: Single;
begin
  result := 360.0 / aux_max * aux_counter;
end;

procedure TRotator.Sync(Position: Single);
begin

end;

initialization

CoInitializeex(nil, COINIT_APARTMENTTHREADED);
RegisterThySelf;
TAutoObjectFactory.Create(ComServer, TRotator, Class_Rotator, cimultiInstance,
  tmApartment);

end.
