unit Esp32goi;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  dialogs, ComObj, ActiveX, Esp32go_TLB, StdVcl, CPort, shared, classes,
  Windows, lxutils;

const
  DRIVER_NAME = 'Esp32go';
  DRIVER_ID = DRIVER_NAME + '.Telescope';

type
  TAxisRates = class(TAutoObject, IAxisRates)
  protected
    function Get_Count: Integer; safecall;
    function Get_Item(Index: Integer): IRate; safecall;
    // function GetEnumerator: IEnumVARIANT; safecall;
    function Get_NewEnum: IEnumVARIANT; safecall;
  end;

type
  TTrackingRates = class(TAutoObject, ITrackingRates)


  private
    lrates: tcollection;
    FList: array of DriveRates;

   // enumerator : Collections.IEnumerator;

  protected

    function Get_Count: Integer; safecall;
    function Get_Item(Index: Integer): DriveRates; safecall;
    function GetEnumerator: IEnumVARIANT; safecall;
    function MoveNext: WordBool; winapi;
    procedure Dispose; safecall;

  end;

type
  TTelescope = class(TAutoObject, ITelescope)
  protected
    function Get_SupportedActions: OleVariant; safecall;
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
    procedure CommandBool(const Command: WideString; Raw: WordBool); safecall;
    procedure CommandString(const Command: WideString; Raw: WordBool); safecall;
    function DestinationSideOfPier(RightAscension, Declination: Double)
      : PierSide;
    winapi;

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
    procedure SlewToCoordinatesAsync(RightAscension,Declination: Double); safecall;
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

  ProfileObject, ASCOMexcept: Variant;
  trackr: TTrackingRates;
  itrackr: ITrackingRates;
  ratearr: array [0 .. 3] of DriveRates;
  enumerator :olevariant;
  lastguideTimestamp: longint;
  drv:driverates;

function TTelescope.CanMoveAxis(Axis: TelescopeAxes): WordBool;

begin
  case Axis of
    axisprimary:
      result := true;
    axissecondary:
      result := true;
    axistertiary:
      result := false;
  end;

end;

function TTelescope.Get_AlignmentMode: AlignmentModes;
var
  al: char;
  alm: AlignmentModes;
begin

  al := get_alignmode();
  case al of
    'P':
      alm := algPolar;
    'L':
      alm := algPolar;
    'A':
      alm := algAltAz;
  end;
  Get_AlignmentMode := alm;
end;

function TTelescope.Get_Altitude: Double;
begin
  result := alt; // Get_Alt();
end;

function TTelescope.Get_ApertureArea: Double;
begin
  result := 100;
end;

function TTelescope.Get_ApertureDiameter: Double;
begin
  result := 1000
end;

function TTelescope.Get_AtHome: WordBool;
begin
  result := false
end;

function TTelescope.Get_AtPark: WordBool;
begin
  result := get_parked();
end;

function TTelescope.Get_Azimuth: Double;
var
  d: Double;
begin
  result := az; // Get_Az;

end;

function TTelescope.Get_CanFindHome: WordBool;
begin
  result := false
end;

function TTelescope.Get_CanPark: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanPulseGuide: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSetDeclinationRate: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSetGuideRates: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSetPark: WordBool;
begin
  result := false;
end;

function TTelescope.Get_CanSetPierSide: WordBool;
begin
  result := true;
end;

function TTelescope.Get_CanSetRightAscensionRate: WordBool;
begin
  result := true;
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
  result :=false;
end;

function TTelescope.Get_CanSlewAltAzAsync: WordBool;
begin
  result := false
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
  result := false;
end;

function TTelescope.Get_CanUnpark: WordBool;
begin
  result := true;
end;

function TTelescope.Get_Connected: WordBool;
begin
  // if  not check_connection() then
  // ShowMessage('Comport not responding');

  result := true;
end;

function TTelescope.Get_Declination: Double;

begin
  result := dec;
  // result :=  Get_Dec();
end;

function TTelescope.Get_DeclinationRate: Double;
begin
  result := declination_rate;
end;

function TTelescope.Get_Description: WideString;
begin
  result := 'ESP32wifi controller';
end;

function TTelescope.Get_DoesRefraction: WordBool;
begin
  result := false;
end;

function TTelescope.Get_DriverInfo: WideString;
begin
  result := 'ESP32wifi controller info';
end;

function TTelescope.Get_DriverVersion: WideString;
begin
  result := '1.0';
end;

function TTelescope.Get_EquatorialSystem: EquatorialCoordinateType;
begin
  result := equLocalTopocentric;
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
  result := guide_de;
end;

function TTelescope.Get_GuideRateRightAscension: Double;
begin
  result := guide_ra;
end;

function TTelescope.Get_InterfaceVersion: SYSINT;
begin
//showmessage('version');
  result := 3;
end;

function TTelescope.Get_IsPulseGuiding: WordBool;
begin
  result := (lastguideTimestamp > GetTickCount);;
end;

function TTelescope.Get_Name: WideString;
begin
  result := 'Esp32go'
end;

function TTelescope.Get_RightAscension: Double;

begin
  result := ra;
  // result := Get_RA();

end;

function TTelescope.Get_RightAscensionRate: Double;
begin
  result := 1;
end;

function TTelescope.Get_SideOfPier: PierSide;
begin

  // if   get_pierside()then
  if piersid then
    result := pierwest
  else
    result := piereast;
end;

function TTelescope.Get_SiderealTime: Double;
var
  strsideral: string;
  n: Integer;
  sid: Double;
begin
  datetimetostring(strsideral, 'hh:nn:ss#', Local_Sideral_Time(UTCnow(),
    -longi) / 24.0);
  n := LX200Artoint(strsideral, true);
  sid := (n / (15.0 * 3600.0));
  result := sid; // get_sideral();
end;

function TTelescope.Get_SiteElevation: Double;
begin
  result := elevation_site;
end;

function TTelescope.Get_SiteLatitude: Double;
var
  lat: Double;
begin
  lat := get_lat();
  if abs(lat) > 90.0 then
    raise EOLEexception.Create('Out of range', $80040400, 'none', '0', 0)
  else
    result := lat;
end;

function TTelescope.Get_SiteLongitude: Double;
var
  long: Double;
begin
  long := get_long();
  if abs(long) > 180.0 then
    raise EOLEexception.Create('Out of range', $80040400, 'none', '0', 0)
  else
    result := long;
end;

function TTelescope.Get_Slewing: WordBool;
begin

end;

function TTelescope.Get_SlewSettleTime: SYSINT;
begin
  result := 1;
end;

function TTelescope.Get_TargetDeclination: Double;
begin
  result := dec_target;
end;

function TTelescope.Get_TargetRightAscension: Double;
begin
  result := ra_target;
end;

function TTelescope.Get_Tracking: WordBool;
var
  str: string;
begin
  result := track = 1; // (get_track() = 1);
  // result:=true;
end;

function TTelescope.Get_TrackingRate: DriveRates;
begin
  result :=trackr.flist[drv];// driveSidereal;
end;

function TTelescope.Get_TrackingRates: ITrackingRates;
var
  tracking_Rates: ITrackingRates;
begin
  // raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);exit;
  // showmessage(inttostr(trackr.Get_Item(1)))  ;
  trackr := TTrackingRates.Create;

  SetLength(trackr.FList, 4);
  trackr.FList[0] := driveSidereal;
  trackr.FList[1] := DriveLunar;
  trackr.FList[2] := DriveSolar;
  trackr.FList[3] := DriveKing;
  // enumerator.next
  // showmessage('gettr');
  // itrackr := trackr.Create();
  // result := tracking_Rates;
  // trackr.lrates.add();
  // trackr.lrates.Items[1]:=
  // trackr.lrates.Items[1]
  // result := itrackr;
  // showmessage('gettr');
  // Result := TTrackingRates.Create;
 result := trackr;
end;

function TTelescope.Get_UTCDate: TDateTime;
var
  ASystemTime: TSystemTime;
  UTCnowDateTime: TDateTime;
begin
  GetSystemTime(ASystemTime);
  UTCnowDateTime := SystemTimeToDateTime(ASystemTime);
  result := UTCnowDateTime;
end;

procedure TTelescope.AbortSlew;
begin
  if not parked then
    abort_slew();
end;

procedure TTelescope.AxisRates(Axis: TelescopeAxes);
begin

end;

procedure TTelescope.CommandBlind(const Command: WideString; Raw: WordBool);
begin
  command_blind(Command, Raw);
end;

procedure TTelescope.CommandBool(const Command: WideString; Raw: WordBool);
begin

end;

procedure TTelescope.CommandString(const Command: WideString; Raw: WordBool);
begin

end;

function TTelescope.DestinationSideOfPier(RightAscension, Declination: Double)
  : PierSide;

begin
if calc_lha(RightAscension)>0.0 then
  result := piereast
  else    result := pierwest;
end;

procedure TTelescope.FindHome;
begin

end;

procedure TTelescope.MoveAxis(Axis: TelescopeAxes; Rate: Double);
begin
  // showmessage(floattostr(rate));
  if Rate = 0 then
  begin
    case Axis of
      axisprimary:
        send('#:Qw#');
      axissecondary:
        send('#:Qn#');

    end;
    exit;
  end;

  if Rate > 0 then
  begin
    case Axis of
      axisprimary:
        send('#:Me#');
      axissecondary:
        send('#:Mn#');
      // axistertiary:send('#:Q#');
    end;

  end
  else

    case Axis of
      axisprimary:
        send('#:Mw#');
      axissecondary:
        send('#:Ms#');
      // axistertiary:send('#');
    end;

end;

procedure TTelescope.Park;
begin
  send(':hP#');
end;

procedure TTelescope.PulseGuide(Direction: GuideDirections; Duration: Integer);
var
  GuideCommand, durStr: string;

begin
  durStr := Format('%0.4d', [Duration]) + '#';

  Case Direction of
    guideNorth:
      GuideCommand := '#:Mgn' + durStr;
    guideSouth:
      GuideCommand := '#:Mgs' + durStr;
    guideEast:
      GuideCommand := '#:Mge' + durStr;
    guideWest:
      GuideCommand := '#:Mgw' + durStr;
  end;
  Pulse_Guide(GuideCommand);
  lastguideTimestamp := GetTickCount + Duration;

end;

procedure TTelescope.Set_Connected(Value: WordBool);
begin

end;

procedure TTelescope.Set_DeclinationRate(Value: Double);
begin
    declination_rate:=value;
end;

procedure TTelescope.Set_DoesRefraction(Value: WordBool);
begin

end;

procedure TTelescope.Set_GuideRateDeclination(Value: Double);
begin
  guide_de := Value;
end;

procedure TTelescope.Set_GuideRateRightAscension(Value: Double);
begin
  guide_ra := Value;
end;

procedure TTelescope.Set_RightAscensionRate(Value: Double);
begin

end;

procedure TTelescope.Set_SideOfPier(Value: PierSide);
begin
  setpierside(Value = pierwest);
end;

procedure TTelescope.Set_SiteElevation(Value: Double);
begin
  if (Value >= -300.0) and (Value < 10000) then
    elevation_site := Value
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
end;

procedure TTelescope.Set_SiteLatitude(Value: Double);
begin
  if abs(Value) > 90.0 then
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
  else

    Set_latitude(Value);
end;

procedure TTelescope.Set_SiteLongitude(Value: Double);
begin

  if abs(Value) > 180.0 then
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
  else

    Set_longitude(Value);
end;

procedure TTelescope.Set_SlewSettleTime(Value: SYSINT);
begin
  if (Value < 1.0) then
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
end;

procedure TTelescope.Set_TargetDeclination(Value: Double);
var
  str: string;
  n: Integer;
begin
  dec_target := Value;
  if abs(Value) <= 90.0 then
  begin
    Set_TargetDec(Value);
  end
  else
    raise EOLEexception.Create('Value Not Set 1', $80040401, 'none', '0', 0);
end;

procedure TTelescope.Set_TargetRightAscension(Value: Double);
var
  str: string;
begin
  ra_target := Value;
  if (Value >= 0) and (Value <= 24.0) then
    Set_TargetRA(Value)
  else
    raise EOLEexception.Create('RA value out ', $80040401, 'none', '0', 0)
end;

procedure TTelescope.Set_Tracking(Value: WordBool);
begin
  if Value then
    send(':Qw#')
  else
    send(':Mh#');
end;

procedure TTelescope.Set_TrackingRate(Value: DriveRates);
var s:string;
begin
s:=inttostr(value);
     drv:=value;
       // showmessage('write trackirates'+s);
  if (value >3) or (value<0)  then
   raise EOLEexception.Create('Not Implemented', $80040401, 'none', '0', 0);

end;

procedure TTelescope.Set_UTCDate(Value: TDateTime);
begin
  Value := Value + gmtoffset / 24.0;
  Set_localtime(Value);
  sleep(20);
  Set_date(Value);
end;

procedure TTelescope.SetPark;
begin
  raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);
end;

procedure TTelescope.SetUpDialog;
begin
  showmessage('Setup done');
end;

procedure TTelescope.SlewToAltAz(Azimut, Altitude: Double);
begin
  raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);
end;

procedure TTelescope.SlewToAltAzAsync(Azimut, Altitude: Double);
begin
  raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);
end;

procedure TTelescope.SlewToCoordinates(RightAscension, Declination: Double);
begin
  ra_target := RightAscension;
  dec_target := Declination;

  if (ra_target <= 24.0) and (ra_target >= 0.0) and (abs(dec_target) <= 90) then
    Slew_ToCoor(RightAscension, Declination)
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)

end;

procedure TTelescope.SlewToCoordinatesAsync(RightAscension,
  Declination: Double);

begin
  ra_target := RightAscension;
  dec_target := Declination;

  if (ra_target <= 24.0) and (ra_target >= 0.0) and (abs(dec_target) <= 90) then
    Slew_ToCoor(RightAscension, Declination)
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)

end;

procedure TTelescope.SlewToTarget;
begin
  if (ra_target <= 24.0) and (ra_target >= 0.0) and (abs(dec_target) <= 90) then
    Slew_ToCoor()
  else
    raise EOLEexception.Create('Out of range', $80040402, 'none', '0', 0)

end;

procedure TTelescope.SlewToTargetAsync;
begin
  if (ra_target <= 24.0) and (ra_target >= 0.0) and (abs(dec_target) <= 90) then
    Slew_ToCoor()
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
end;

procedure TTelescope.SyncToAltAz(Azimuth, Altitude: Double);
begin
  raise EOLEexception.Create('Not Implemented', $80040400, 'none', '0', 0);
end;

procedure TTelescope.SyncToCoordinates(RightAscension, Declination: Double);
begin
  if (RightAscension <= 24.0) and (RightAscension >= 0.0) and
    (abs(Declination) <= 90) then
    SyncTo_Coord(RightAscension, Declination)
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
end;

procedure TTelescope.SyncToTarget;
begin
  if (ra_target <= 24.0) and (ra_target >= 0.0) and (abs(dec_target) <= 90) then
    SyncTo_Coord()
  else
    raise EOLEexception.Create('Out of range', $80040401, 'none', '0', 0)
end;

procedure TTelescope.Unpark;
begin
  if parked then
  begin
    AbortSlew()
  end;

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
    showmessage('Self-Registering: ASCOM ' + DRIVER_ID);
    ProfileObject.Register(DRIVER_ID, 'Esp32go Driver');

  end;
  // ASCOMExcept:=CreateOLEObject('ASCOM.exceptions');

end;

function TTrackingRates.Get_Count: Integer; safecall;
begin
  //result := 4;
   Result := Length(FList);
end;

function TTrackingRates.Get_Item(Index: Integer): DriveRates; safecall;
begin
//showmessage('item '+inttostr(index));
result:=trackr.flist[index-1]   ;
  {case index of
    0:
      result := driveSidereal;
    1:
      result := DriveLunar;
    2:
      result := DriveSolar;
    3:
      result := DriveKing;

  end;
  result:=driveSolar;  }
end;

function TTrackingRates.GetEnumerator: IEnumVARIANT;
var
  UpdateCollection: OleVariant;
begin
//showmessage('enu');

result :=self  as IEnumVARIANT;
//result :=trackr as IEnumVARIANT;

//  result := self
end;

function TAxisRates.Get_Count: Integer; safecall;
begin
  result := 0;
end;

function TAxisRates.Get_Item(Index: Integer): IRate; safecall;
var
  r: IRate;
  r1: Rate;
begin
  // r:=IRate.Create;
  r.Minimum := 0;
  r.Maximum := 0;
  r := r1;

  result := r;
end;

function TAxisRates.Get_NewEnum: IEnumVARIANT;
begin
  result := self as IEnumVARIANT;
end;

function TTelescope.Get_SupportedActions: OleVariant;
var
  capacity: Integer;
  item: Variant;
  dotNetArrayList: Variant;
begin
  { Create object }
  dotNetArrayList := CreateOLEObject('System.Collections.ArrayList');

  { Add an element }
  dotNetArrayList.add('NULL');
  item := dotNetArrayList.item(0);
  result := dotNetArrayList;

end;

function TTrackingRates.MoveNext: WordBool;
begin
showmessage('movenext');
  result:=false;
end;

procedure TTrackingRates.Dispose;
begin
// showmessage('dispose');
end;

initialization

CoInitializeex(nil,  COINIT_APARTMENTTHREADED);
RegisterThySelf;
TAutoObjectFactory.Create(ComServer, TAxisRates, Class_AxisRates,
  cimultiInstance, tmApartment);

TAutoObjectFactory.Create(ComServer, TTrackingRates, Class_TrackingRates,
  cimultiInstance, tmApartment);

TAutoObjectFactory.Create(ComServer, TTelescope, Class_Telescope,
  cimultiInstance, tmApartment);

  //enumerator:=CreateOLEObject('System.Collections.IEnumerator');


end.
