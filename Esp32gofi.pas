unit Esp32gofi;

interface

uses
  ComObj, ActiveX, Esp32go_TLB ;

const
  DRIVER_NAME = 'Esp32Go';
  DRIVER_ID = DRIVER_NAME + '.Focuser';

type
  TFocuser = class(TAutoObject, IFocuser)
  protected
    function Get_IsMoving: wordbool; safecall;
    function Get_Link: wordbool; safecall;
    Procedure Set_Link(value: wordbool); safecall;
    function Get_MaxIncrement: integer; safecall;
    function Get_Position: integer; safecall;
    function Get_StepSize: double; safecall;
    function Get_TempComp: wordbool; safecall;
    Procedure Set_TempComp(value: wordbool); safecall;
    function Get_Temperature: double; safecall;
    Procedure Set_Temperature(value: double); safecall;
    procedure SetupDialog; safecall;
    procedure Halt; safecall;
    procedure move(val: integer); safecall;
    function Get_Absolute: wordbool; safecall;
    function Get_MaxStep: integer; safecall;
    procedure Set_MaxStep(value: integer); safecall;
    function Get_TempCompAvailable: wordbool; safecall;

  end;

implementation

uses ComServ, sysutils, Dialogs, Controls, ShellAPI;

var
  fCOMPort: integer;
  fMaxStep: integer;
  tempcomp: wordbool;

function TFocuser.Get_IsMoving: wordbool;
begin

end;

function TFocuser.Get_Link: wordbool;
begin
  Get_Link := true;
end;

Procedure TFocuser.Set_Link(value: wordbool);
begin

end;

function TFocuser.Get_MaxIncrement: integer;
begin
  Get_MaxIncrement := 1000;
end;
function TFocuser.Get_Position: integer;
begin

end;

function TFocuser.Get_StepSize: double;
begin

end;

function TFocuser.Get_TempComp: wordbool;
begin

end;

Procedure TFocuser.Set_TempComp(value: wordbool);
begin

end;

function TFocuser.Get_Temperature: double;
begin

end;

Procedure TFocuser.Set_Temperature(value: double);
begin
end;

procedure TFocuser.Halt;
begin

end;

procedure TFocuser.move(val: integer);
begin



end;

{ -------------------------------------------------------------- }
procedure TFocuser.SetupDialog;
{ -------------------------------------------------------------- }
//var
 //fSetupForm: TSetupForm;

begin
  // fSetupForm := TSetupForm.Create(nil);
  // fSetupForm.COMPortCombo.ItemIndex := fCOMPort - 1;
  // normally would use the ASCOM registry area for persistent storage of values
  // fSetupForm.MaxStepEdit.Text := IntToStr(fMaxStep);
  // fSetupForm.ShowModal;
  // if (fSetupForm.ModalResult = mrOK) then
  // begin
  // fMaxStep := StrToInt(fSetupForm.MaxStepEdit.Text);
  // fCOMPort := fSetupForm.COMPortCombo.ItemIndex + 1;
  // end;
  // fSetupForm.Free;
   ShowMessage('Setup done');
end;

{ -------------------------------------------------------------- }
function TFocuser.Get_Absolute: wordbool;
{ -------------------------------------------------------------- }
begin
  result := true;
end;

{ -------------------------------------------------------------- }
function TFocuser.Get_MaxStep: integer;
{ -------------------------------------------------------------- }
begin

end;

{ -------------------------------------------------------------- }
procedure TFocuser.Set_MaxStep(value: integer);
{ -------------------------------------------------------------- }
begin

end;

{ -------------------------------------------------------------- }
function TFocuser.Get_TempCompAvailable: wordbool;
{ -------------------------------------------------------------- }
begin
  result := true;
end;

{ -------------------------------------------------------------- }
procedure RegisterThySelf;
{ -------------------------------------------------------------- }
// Test id this interface is registered int he ASCOM registry area
// If not register it so the Choose can find it and also to store persistent data
var
  ProfileObject: Variant;

begin
  ProfileObject := CreateOLEObject('ASCOM.Utilities.Profile');

 //  ProfileObject := CreateOLEObject('DriverHelper.Profile');
  ProfileObject.DeviceType := 'Focuser';

  if (not ProfileObject.IsRegistered(DRIVER_ID)) then
  begin
    ShowMessage('Self-Registering: ASCOM ' + DRIVER_ID);
    ProfileObject.Register(DRIVER_ID, 'Esp32Go');
    // set persistent default values if any
  end;

end;

initialization

CoInitializeex(nil, COINIT_APARTMENTTHREADED);
RegisterThySelf;
TAutoObjectFactory.Create(ComServer, TFocuser, Class_Focuser,
  cimultiInstance, tmApartment);

end.
