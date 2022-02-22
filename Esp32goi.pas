unit Esp32goi;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  dialogs, ComObj, ActiveX, Esp32go_TLB, StdVcl, CPort, shared, classes,
  Windows;

const
  DRIVER_NAME = 'Esp32go';
  DRIVER_ID = DRIVER_NAME + '.Telescope';

type
  TTrackingRates = class(TAutoObject, ITrackingRates)
  private
    lrates: tcollection;
  protected
    function Get_Count: Integer; safecall;
    function Get_Item(Index: Integer): DriveRates; safecall;
    function GetEnumerator: IEnumVARIANT; safecall;
  end;

type
  TTelescope = class(TAutoObject, ITelescope)
  Public
    function CanMoveAxis(Axis: TelescopeAxes): WordBool; safecall;
    function Get_AlignmentMode: AlignmentModes; safecall;
    function Get_Altitude: Double; safecall;
    function Get_ApertureArea: Double; safecall;
    function Get_ApertureDiameter: Double; safecall;
    function Get_AtHome: WordBool; safecall;
    function Get_AtPark: WordBool; safecall;
    function Get_Azimuth: Double; safecall;
    function Get_CanFindHome: WordBool; safecall;
    function Get_CanPark: WordBool; safecall;
    function Get_CanPulseGuide: WordBool; safecall;
    function Get_CanSetDeclinationRate: WordBool; safecall;
    function Get_CanSetGuideRates: WordBool; safecall;
    function Get_CanSetPark: WordBool; safecall;
    function Get_CanSetPierSide: WordBool; safecall;
    function Get_CanSetRightAscensionRate: WordBool; safecall;
    function Get_CanSetTracking: WordBool; safecall;
    function Get_CanSlew: WordBool; safecall;
    function Get_CanSlewAltAz: WordBool; safecall;
    function Get_CanSlewAltAzAsync: WordBool; safecall;
    function Get_CanSlewAsync: WordBool; safecall;
    function Get_CanSync: WordBool; safecall;
    function Get_CanSyncAltAz: WordBool; safecall;
    function Get_CanUnpark: WordBool; safecall;
    function Get_Connected: WordBool; safecall;
    function Get_Declination: Double; safecall;
    function Get_DeclinationRate: Double; safecall;
    function Get_Description: WideString; safecall;
    function Get_DoesRefraction: WordBool; safecall;
    function Get_DriverInfo: WideString; safecall;
    function Get_DriverVersion: WideString; safecall;
    function Get_EquatorialSystem: EquatorialCoordinateType; safecall;
    function Get_FocalLength: Double; safecall;
    function Get_GuideRateDeclination: Double; safecall;
    function Get_GuideRateRightAscension: Double; safecall;
    function Get_InterfaceVersion: SYSINT; safecall;
    function Get_IsPulseGuiding: WordBool; safecall;
    function Get_Name: WideString; safecall;
    function Get_RightAscension: Double; safecall;
    function Get_RightAscensionRate: Double; safecall;
    function Get_SideOfPier: PierSide; safecall;
    function Get_SiderealTime: Double; safecall;
    function Get_SiteElevation: Double; safecall;
    function Get_SiteLatitude: Double; safecall;
    function Get_SiteLongitude: Double; safecall;
    function Get_Slewing: WordBool; safecall;
    function Get_SlewSettleTime: SYSINT; safecall;
    function Get_TargetDeclination: Double; safecall;
    function Get_TargetRightAscension: Double; safecall;
    function Get_Tracking: WordBool; safecall;
    function Get_TrackingRate: DriveRates; safecall;
    function Get_TrackingRates: ITrackingRates; safecall;
    function Get_UTCDate: TDateTime; safecall;
    procedure AbortSlew; safecall;
    procedure AxisRates(Axis: TelescopeAxes); safecall;
    procedure CommandBlind(const Command: WideString; Raw: WordBool); safecall;
    procedure CommandBool(const Command: WideString; Raw: Integer); safecall;
    procedure CommandString(const Command: WideString; Raw: WordBool); safecall;
    procedure DestinationSideOfPier(RightAscension,
      Declination: Double); safecall;
    procedure FindHome; safecall;
    procedure MoveAxis(Axis: TelescopeAxes; Rate: Double); safecall;
    procedure Park; safecall;
    procedure PulseGuide(Direction: GuideDirections;
      Duration: Integer); safecall;
    procedure Set_Connected(Value: WordBool); safecall;
    procedure Set_DeclinationRate(Value: Double); safecall;
    procedure Set_DoesRefraction(Value: WordBool); safecall;
    procedure Set_GuideRateDeclination(Value: Double); safecall;
    procedure Set_GuideRateRightAscension(Value: Double); safecall;
    procedure Set_RightAscensionRate(Value: Double); safecall;
    procedure Set_SideOfPier(Value: PierSide); safecall;
    procedure Set_SiteElevation(Value: Double); safecall;
    procedure Set_SiteLatitude(Value: Double); safecall;
    procedure Set_SiteLongitude(Value: Double); safecall;
    procedure Set_SlewSettleTime(Value: SYSINT); safecall;
    procedure Set_TargetDeclination(Value: Double); safecall;
    procedure Set_TargetRightAscension(Value: Double); safecall;
    procedure Set_Tracking(Value: WordBool); safecall;
    procedure Set_TrackingRate(Value: DriveRates); safecall;
    procedure Set_UTCDate(Value: TDateTime); safecall;
    procedure SetPark; safecall;
    procedure SetUpDialog; safecall;
    procedure SlewToAltAz(Azimut, Altitude: Double); safecall;
    procedure SlewToAltAzAsync(Azimut, Altitude: Double); safecall;
    procedure SlewToCoordinates(RightAscension, Declination: Double); safecall;
    procedure SlewToCoordinatesAsync(RightAscension,
      Declination: Double); safecall;
    procedure SlewToTarget; safecall;
    procedure SlewToTargetAsync; safecall;
    procedure SyncToAltAz(Azimuth, Altitude: Double); safecall;
    procedure SyncToCoordinates(RightAscension, Declination: Double); safecall;
    procedure SyncToTarget; safecall;
    procedure Unpark; safecall;

  end;

implementation

uses ComServ, sysutils;

var

  // ComPort2: TComPort;
  ProfileObject, ASCOMexcept: Variant;
  trackr: TTrackingRates;
  ratearr: array [0 .. 3] of DriveRates;
  dec: Double;
  lastdec, lastar: Double;
  lastguideTimestamp: longint;

function TTelescope.CanMoveAxis(Axis: TelescopeAxes): WordBool;
begin

end;

function TTelescope.Get_AlignmentMode: AlignmentModes;
begin
 result:=algPolar;
end;

function TTelescope.Get_Altitude: Double;
begin

end;

function TTelescope.Get_ApertureArea: Double;
begin

end;

function TTelescope.Get_ApertureDiameter: Double;
begin
  result := 1000
end;

function TTelescope.Get_AtHome: WordBool;
begin
  result:=false
end;

function TTelescope.Get_AtPark: WordBool;
begin

end;

function TTelescope.Get_Azimuth: Double;
begin

end;

function TTelescope.Get_CanFindHome: WordBool;
begin
   result:=false
end;

function TTelescope.Get_CanPark: WordBool;
begin
     result:=false
end;

function TTelescope.Get_CanPulseGuide: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSetDeclinationRate: WordBool;
begin
    result:=false;
end;

function TTelescope.Get_CanSetGuideRates: WordBool;
begin
   result:=false;
end;

function TTelescope.Get_CanSetPark: WordBool;
begin
    result:=false;
end;

function TTelescope.Get_CanSetPierSide: WordBool;
begin
    result:=false;
end;

function TTelescope.Get_CanSetRightAscensionRate: WordBool;
begin
    result:=false;
end;

function TTelescope.Get_CanSetTracking: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSlew: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSlewAltAz: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSlewAltAzAsync: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSlewAsync: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSync: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSyncAltAz: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanUnpark: WordBool;
begin
  result := true;
end;

function TTelescope.Get_Connected: WordBool;
begin
//if  not check_connection() then
// ShowMessage('Comport not responding');

  result := true;
end;

function TTelescope.Get_Declination: Double;
var
  str: string;
  n, s: Integer;
begin
if fullconnect then begin

  comport2.ClearBuffer(true, false);
  comport2.WriteStr('#:GD#');
  while (comport2.InputCount < dec_pack) and (s < 10) do
  begin
    sleep(5);
    inc(s);
  end;

  If (comport2.ReadStr(str, dec_pack) =dec_pack) and (char(str[dec_pack]) = '#') then
  begin
    n := LX200dectoint(str, true);
    comport2.ClearBuffer(true, false);
    lastdec := (n / (3600.0));

  end;
end;
  result := lastdec;
end;

function TTelescope.Get_DeclinationRate: Double;
begin

end;

function TTelescope.Get_Description: WideString;
begin

end;

function TTelescope.Get_DoesRefraction: WordBool;
begin
  result := false;
end;

function TTelescope.Get_DriverInfo: WideString;
begin

end;

function TTelescope.Get_DriverVersion: WideString;
begin

end;

function TTelescope.Get_EquatorialSystem: EquatorialCoordinateType;
begin

end;

function TTelescope.Get_FocalLength: Double;
var
  str: string;
  n: Integer;
begin
  result := 10000;

end;

function TTelescope.Get_GuideRateDeclination: Double;
begin

end;

function TTelescope.Get_GuideRateRightAscension: Double;
begin

end;

function TTelescope.Get_InterfaceVersion: SYSINT;
begin

end;

function TTelescope.Get_IsPulseGuiding: WordBool;
begin
  result := (lastguideTimestamp > GetTickCount);;
end;

function TTelescope.Get_Name: WideString;
begin

end;

function TTelescope.Get_RightAscension: Double;

var
  str: string;
  n, s: Integer;
begin
if fullconnect then begin
  comport2.ClearBuffer(true, false);
  comport2.WriteStr(':GR#');
  while (comport2.InputCount < ra_pack) and (s < 10) do
  begin
    sleep(5);
    inc(s);
  end;

  If (comport2.ReadStr(str, ra_pack) >= ra_pack) then
  begin
    n := LX200artoint(str, true);
    lastar := (n / (15 * 3600.0));

  end;
end;
  result := lastar;

end;

function TTelescope.Get_RightAscensionRate: Double;
begin

end;

function TTelescope.Get_SideOfPier: PierSide;
begin

end;

function TTelescope.Get_SiderealTime: Double;
begin

end;

function TTelescope.Get_SiteElevation: Double;
begin

end;

function TTelescope.Get_SiteLatitude: Double;
begin

end;

function TTelescope.Get_SiteLongitude: Double;
begin

end;

function TTelescope.Get_Slewing: WordBool;
begin

end;

function TTelescope.Get_SlewSettleTime: SYSINT;
begin

end;

function TTelescope.Get_TargetDeclination: Double;
begin

end;

function TTelescope.Get_TargetRightAscension: Double;
begin

end;

function TTelescope.Get_Tracking: WordBool;
begin
  result := true;
end;

function TTelescope.Get_TrackingRate: DriveRates;
begin

end;

function TTelescope.Get_TrackingRates: ITrackingRates;
begin

end;

function TTelescope.Get_UTCDate: TDateTime;
begin

end;

procedure TTelescope.AbortSlew;
begin

end;

procedure TTelescope.AxisRates(Axis: TelescopeAxes);
begin

end;

procedure TTelescope.CommandBlind(const Command: WideString; Raw: WordBool);
begin
  comport2.WriteStr(Command);
end;

procedure TTelescope.CommandBool(const Command: WideString; Raw: Integer);
begin

end;

procedure TTelescope.CommandString(const Command: WideString; Raw: WordBool);
begin

end;

procedure TTelescope.DestinationSideOfPier(RightAscension, Declination: Double);
begin

end;

procedure TTelescope.FindHome;
begin

end;

procedure TTelescope.MoveAxis(Axis: TelescopeAxes; Rate: Double);
begin

end;

procedure TTelescope.Park;
begin

end;

procedure TTelescope.PulseGuide(Direction: GuideDirections; Duration: Integer);
var
  durStr: string;
  durPchar: PCHAR;

begin
  durPchar := StrAlloc(15);
  StrFmt(durPchar, '%0.4d#', [Duration]);
  durStr := string(durPchar);
  Case Direction of
    guideNorth:
      comport2.WriteStr('#:Mgn' + durStr);
    guideSouth:
      comport2.WriteStr('#:Mgs' + durStr);
    guideEast:
      comport2.WriteStr('#:Mge' + durStr);
    guideWest:
      comport2.WriteStr('#:Mgw' + durStr);
  end;
  lastguideTimestamp := GetTickCount + Duration;
  StrDispose(durPchar);
end;

procedure TTelescope.Set_Connected(Value: WordBool);
begin

  comport2.Parity.Bits := prNone;
  comport2.BaudRate := br115200;
  comport2.Timeouts.ReadInterval := 100;
  comport2.Timeouts.ReadTotalMultiplier := 1;
  comport2.Timeouts.ReadTotalConstant := 100;
  comport2.Timeouts.WriteTotalMultiplier := 1;
  comport2.Timeouts.WriteTotalConstant := 1000;
  comport2.TriggersOnRxChar := false;
  comport2.Connected := true;

end;

procedure TTelescope.Set_DeclinationRate(Value: Double);
begin

end;

procedure TTelescope.Set_DoesRefraction(Value: WordBool);
begin

end;

procedure TTelescope.Set_GuideRateDeclination(Value: Double);
begin

end;

procedure TTelescope.Set_GuideRateRightAscension(Value: Double);
begin

end;

procedure TTelescope.Set_RightAscensionRate(Value: Double);
begin

end;

procedure TTelescope.Set_SideOfPier(Value: PierSide);
begin

end;

procedure TTelescope.Set_SiteElevation(Value: Double);
begin

end;

procedure TTelescope.Set_SiteLatitude(Value: Double);
begin

end;

procedure TTelescope.Set_SiteLongitude(Value: Double);
begin

end;

procedure TTelescope.Set_SlewSettleTime(Value: SYSINT);
begin

end;

procedure TTelescope.Set_TargetDeclination(Value: Double);
var
  str: string;
  n: Integer;
begin
  if abs(Value) < 90 then
  begin
    comport2.WriteStr(':Sd' + DoubletoLXdec(Value, 1));
    // dec_target := Value;
  end
  else
    raise EOLEexception.Create('Value Not Set 1', $80040402, 'none', '0', 0);
end;

procedure TTelescope.Set_TargetRightAscension(Value: Double);
var
  str: string;
  n: Integer;
begin
  comport2.WriteStr(':Sr' + DoubleToLXAr(Value, 1));
  // ra_target := Value;
  raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);
  // raise Exception.Create('Not Implemented');
end;

procedure TTelescope.Set_Tracking(Value: WordBool);
begin

end;

procedure TTelescope.Set_TrackingRate(Value: DriveRates);
begin

end;

procedure TTelescope.Set_UTCDate(Value: TDateTime);
begin

end;

procedure TTelescope.SetPark;
begin

end;

procedure TTelescope.SetUpDialog;
begin

end;

procedure TTelescope.SlewToAltAz(Azimut, Altitude: Double);
begin

end;

procedure TTelescope.SlewToAltAzAsync(Azimut, Altitude: Double);
begin

end;

procedure TTelescope.SlewToCoordinates(RightAscension, Declination: Double);
begin
  comport2.WriteStr(':Sr' + DoubleToLXAr(RightAscension, 1));
  comport2.WriteStr(':Sd' + DoubletoLXdec(Declination, 1));
  comport2.WriteStr(':MS#');
end;

procedure TTelescope.SlewToCoordinatesAsync(RightAscension,
  Declination: Double);

begin
  comport2.WriteStr(':Sr' + DoubleToLXAr(RightAscension, 1));
  comport2.WriteStr(':Sd' + DoubletoLXdec(Declination, 1));
  comport2.WriteStr(':MS#');

end;

procedure TTelescope.SlewToTarget;
begin
  comport2.WriteStr(':MS#');
end;

procedure TTelescope.SlewToTargetAsync;
begin
  comport2.WriteStr(':MS#');
end;

procedure TTelescope.SyncToAltAz(Azimuth, Altitude: Double);
begin

end;

procedure TTelescope.SyncToCoordinates(RightAscension, Declination: Double);
begin
  comport2.WriteStr(':Sr' + DoubleToLXAr(RightAscension, 1));
  comport2.WriteStr(':Sd' + DoubletoLXdec(Declination, 1));
  comport2.WriteStr(':CM#');
end;

procedure TTelescope.SyncToTarget;
begin
  comport2.WriteStr(':CM#');

end;

procedure TTelescope.Unpark;
begin

end;

procedure RegisterThySelf;
{ -------------------------------------------------------------- }
// Test id this interface is registered int he ASCOM registry area
// If not register it so the Choose can find it and also to store persistent data

begin
  ProfileObject := CreateOLEObject('ASCOM.Utilities.Profile');
  // ProfileObject := CreateOLEObject('DriverHelper.Profile');

  ProfileObject.DeviceType := 'Telescope';

  // ASCOM.NotImplementedException("xxx" + e.Message,e);

  if (not ProfileObject.IsRegistered(DRIVER_ID)) then
  begin
    ShowMessage('Self-Registering: ASCOM ' + DRIVER_ID);
    ProfileObject.Register(DRIVER_ID, 'Esp32go Driver');

  end;
  // ASCOMExcept:=CreateOLEObject('ASCOM.exceptions');

end;

function TTrackingRates.Get_Count: Integer; safecall;
begin
  result := 3;
end;

function TTrackingRates.Get_Item(Index: Integer): DriveRates; safecall;
begin
  case index of
    0:
      result := driveSidereal;
    1:
      result := driveLunar;
    2:
      result := driveSolar;
    3:
      result := driveKing;
  end;
end;

function TTrackingRates.GetEnumerator: IEnumVARIANT;
begin
  result := self as IEnumVARIANT;
end;

initialization

CoInitializeex(nil, COINIT_APARTMENTTHREADED);
RegisterThySelf;

TAutoObjectFactory.Create(ComServer, TTrackingRates, Class_TrackingRates,
  cimultiInstance, tmApartment);

TAutoObjectFactory.Create(ComServer, TTelescope, Class_Telescope,
  cimultiInstance, tmApartment);

end.
