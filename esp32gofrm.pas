unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, CPort, esp32goi, shared, inifiles,
  EnhEdits, CPortCtl, adpInstanceControl, System.Win.ScktComp, serial,
  Joystickex, JvComponentBase, JvHidControllerClass,HidUsage;

type
  TEsp32frm = class(TForm)
    Timer1: TTimer;
    RadioGroup1: TRadioGroup;
    GroupBoxFocus: TGroupBox;
    ButtonIn: TButton;
    ButtonOut: TButton;
    ButtonM1: TButton;
    ButtonM2: TButton;
    ButtonM3: TButton;
    ButtonM4: TButton;
    GroupBox1: TGroupBox;
    ButtonNE: TButton;
    Button_N: TButton;
    ButtonNW: TButton;
    Button_W: TButton;
    ButtonSW: TButton;
    Button_S: TButton;
    ButtonSE: TButton;
    Button_E: TButton;
    GroupBox2: TGroupBox;
    ButtonH: TButton;
    ButtonPark: TButton;
    LabelFocusCount: TLabel;
    adpInstanceControl1: TadpInstanceControl;
    GroupBoxserial: TGroupBox;
    GroupBox4: TGroupBox;
    ComComboBox2: TComComboBox;
    ComComboBox1: TComComboBox;
    Label1: TLabel;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    EditAddr: TEdit;
    LongEditPort: TLongEdit;
    ButtonSave: TButton;
    ButtonRecon: TButton;
    RadioGroupcom: TRadioGroup;
    Buttondisconnect: TButton;
    Label5: TLabel;
    Button1: TButton;
    labelAR: TLabel;
    Label2: TLabel;
    Joystickex1: TJoystickex;
    CheckBoxJoyf: TCheckBox;
    CheckBox2: TCheckBox;
    ButtonHome: TButton;
    Labelmsg: TLabel;
    JvHidDeviceController: TJvHidDeviceController;
    lstHidDevices: TListBox;
    GroupBox5: TGroupBox;
    ButtonSync: TButton;
    Buttonstar1: TButton;
    Buttonstar2: TButton;
    groupboxgeo: TGroupBox;
    FloatEditLong: TFloatEdit;
    FloatEditLat: TFloatEdit;
    Button3: TButton;
    Button2: TButton;
    Buttontakireset: TButton;
    LongEditgmt: TLongEdit;
    Label4: TLabel;
    Buttongetgeo: TButton;

    procedure FormCreate(Sender: TObject);
    procedure Button_NMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button_NMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);

    procedure ReadSettings;
    procedure WriteSettings;
    procedure ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonM1Click(Sender: TObject);
    procedure ButtonM2Click(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonReconClick(Sender: TObject);
    procedure ButtondisconnectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Buttonconfig(Sender: TObject);
    procedure LabelFocusCountDblClick(Sender: TObject);
    procedure Joystickex1JoyMove(Sender: TObject; XPos, YPos: Integer;
      ButtonStatus: Word; IsCalibrating: Boolean);
    procedure Joystickex1Button1_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure Joystickex1Button2_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure Joystickex1Button3_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure Joystickex1Button4_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure Joystickex1Button5_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure Joystickex1Button6_Change(Sender: TObject; pressed: Boolean;
      XPos, YPos: Integer);
    procedure ButtonHomeClick(Sender: TObject);
    procedure ButtonM3Click(Sender: TObject);
    procedure ButtonParkClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonHClick(Sender: TObject);
    procedure JvHidDeviceControllerDeviceChange(Sender: TObject);
    function JvHidDeviceControllerEnumerate(HidDev: TJvHidDevice;
      const Idx: Integer): Boolean;
    procedure ReadJoysticks(HidDev: TJvHidDevice; ReportID: Byte;
      const Data: Pointer; Size: Word);
    procedure JvHidDeviceControllerDeviceCreateError
      (Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo;
      var Handled, RetryCreate: Boolean);
    procedure ButtonSyncClick(Sender: TObject);
    procedure Buttonstar1Click(Sender: TObject);
    procedure Buttonstar2Click(Sender: TObject);
    procedure ButtontakiresetClick(Sender: TObject);
    procedure ButtongetgeoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Esp32frm: TEsp32frm;
  // telescope: Ttelescope;
  s_inipath: string;
  inifile_name: string;
  Serialport: string;
  joyxstatus, joyystatus: Integer;
  lastpress, errorcount1: Cardinal;
  lastgamebutton: Word;
  lastgamedir: Word;

implementation

{$R *.dfm}

procedure TEsp32frm.ButtonSaveClick(Sender: TObject);
begin
  WriteSettings;
end;

procedure TEsp32frm.Buttonstar1Click(Sender: TObject);
begin
 send(':a1#') ;
end;

procedure TEsp32frm.Buttonstar2Click(Sender: TObject);
begin
send(':a2#') ;
end;

procedure TEsp32frm.ButtonReconClick(Sender: TObject);
var
  n: Integer;
begin
  n := 0;
  imode := RadioGroupcom.ItemIndex;
  set_interface_mode(imode);
  if imode = 0 then
  begin
    ComPortBT_USB.Connected := false;
    ComPortBT_USB.Port := ComComboBox1.Text;
    ComPortBT_USB.baudrate := tbaudrate(ComComboBox2.ItemIndex);;
    ComComboBox1.ComPort := ComPortBT_USB;
    ComPortBT_USB.Connected := true;
    if ComPortBT_USB.Connected then
    begin

      fullconnect := check_connection();
      Timer1.Enabled := fullconnect;
      if not(fullconnect) then
        showmessage('No response');
    end;
  end
  else
  begin
    if ClientSocket1.active then
      ClientSocket1.active := false;

    ClientSocket1.Host := EditAddr.Text;
    ClientSocket1.Port := LongEditPort.Value;
    ClientSocket1.active := true;
    repeat
      sleep(100);
      inc(n);
      Application.ProcessMessages;
    until (ClientSocket1.active) or (n >= 50);
    /// ClientSocket1.active:=(n<5);
    fullconnect := check_connection();
    if not(fullconnect) then
      showmessage('No response');
    Timer1.Enabled := fullconnect;
  end;
end;

procedure TEsp32frm.Button2Click(Sender: TObject);
var ctime:TdateTime;
begin

  gmtoffset:=LongEditgmt.value;
  set_offset(gmtoffset);
  sleep(20);
  ctime:=UTCnow()+(gmtoffset/24.0);

  Set_localtime(ctime);
  sleep(20);
  Set_date(ctime);
  sleep(20);

end;

procedure TEsp32frm.Button3Click(Sender: TObject);
begin
  set_offset(LongEditgmt.value);
  Set_latitude(FloatEditLat.Value);
  sleep(20);
  set_longitude(FloatEditLong.Value);
  sleep(20);


end;

procedure TEsp32frm.ButtonSyncClick(Sender: TObject);
begin
    send(':a0#') ;
end;

procedure TEsp32frm.ButtontakiresetClick(Sender: TObject);
begin
   send(':a3#') ;
end;

procedure TEsp32frm.Buttonconfig(Sender: TObject);
begin
  GroupBoxserial.Visible := not GroupBoxserial.Visible;
end;

procedure TEsp32frm.ButtondisconnectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (imode = 1) then
    ClientSocket1.active := false
  else
    ComPortBT_USB.Connected := false;
end;

procedure TEsp32frm.ButtongetgeoClick(Sender: TObject);
var offset:integer;
begin
      floateditlong.value:=get_long();
      floateditlat.value:=get_lat();
      offset:=get_gmtoffset();
      if offset<>50 then longeditgmt.value:=offset;
end;

procedure TEsp32frm.ButtonHClick(Sender: TObject);
begin
  send(':Mh#');
end;

procedure TEsp32frm.ButtonHomeClick(Sender: TObject);
begin
  send(':pH#');
end;

procedure TEsp32frm.ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case TButton(Sender).tag of
    0:
      if CheckBox2.Checked then
        send(':F++#')
      else
        send(':F+#');
    1:
      if CheckBox2.Checked then
        send(':F--#')
      else
        send(':F-#');
  end;
end;

procedure TEsp32frm.ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  send(':FQ#');
end;

procedure TEsp32frm.ButtonM1Click(Sender: TObject);
begin
  send(':FA-00300#');
end;

procedure TEsp32frm.ButtonM2Click(Sender: TObject);
begin
  send(':FLS1+00900#');
end;

procedure TEsp32frm.ButtonM3Click(Sender: TObject);
begin
  send(':FA-04000#');
end;

procedure TEsp32frm.ButtonParkClick(Sender: TObject);
begin
  send(':hP#');
end;

procedure TEsp32frm.Button_NMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case RadioGroup1.ItemIndex of
    0:
      send('#:RS#');
    1:
      send('#:RM#');
    2:
      send('#:RC#');
    3:
      send('#:RG#');
  end;

  case TButton(Sender).tag of
    0:
      send('#:Mn#');
    1:
      send('#:Ms#');
    2:
      send('#:Me#');
    3:
      send('#:Mw#');
    4:
      send('#:Mn#:Me#');
    5:
      send('#:Ms#:Me#');
    6:
      send('#:Ms#:Mw#');
    7:
      send('#:Mn#:Mw#');

  end;

end;

procedure TEsp32frm.Button_NMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case TButton(Sender).tag of
    0:
      send('#:Qn#');
    1:
      send('#:Qs#');
    2:
      send('#:Qe#');
    3:
      send('#:Qw#');
    4, 5, 6, 7:
      send('#:Qn#:Qw#');
  end;

end;

procedure TEsp32frm.FormCreate(Sender: TObject);
var
  n: Integer;
begin
  n := 0;
  Joystickex1.EnableJoyStick;
  s_inipath := ExtractFilePath(Application.EXEName);
  inifile_name := 'esp32gocnf.ini';
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
  ReadSettings;
  imode := RadioGroupcom.ItemIndex;
  set_interface_mode(imode);
  initserial(ComComboBox1.Text, tbaudrate(ComComboBox2.ItemIndex));
  init_tcp(EditAddr.Text, LongEditPort.Value);
  ComComboBox1.ComPort := ComPortBT_USB;
  if imode = 0 then
    ComPortBT_USB.Connected := true
  else
  begin
    ClientSocket1.active := true;
    repeat
      sleep(100);
      inc(n);
      Application.ProcessMessages;
    until (ClientSocket1.active) or (n >= 50);
    ClientSocket1.active := (n < 50)
  end;

  if (ClientSocket1.active) or ComPortBT_USB.Connected then
  begin

    fullconnect := check_connection();
    if not(fullconnect) then
      showmessage('No response');
    if fullconnect then
      Timer1.Enabled := true;
  end;

end;

procedure TEsp32frm.FormDestroy(Sender: TObject);
begin
  if ClientSocket1.active = true then
    ClientSocket1.active := false;
  if ComPortBT_USB.Connected then
    ComPortBT_USB.Connected := false;

end;

procedure TEsp32frm.Joystickex1Button1_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  if pressed then

    if CheckBoxJoyf.Checked then
    begin
      CheckBox2.Checked := NOT CheckBox2.Checked;
      // Tele.FocusSeleclSpeed := CheckBox5.Checked

    end
    else if CheckBoxJoyf.Checked then
      send(':FQ#')

    else
      RadioGroup1.ItemIndex := 3;

end;

procedure TEsp32frm.Joystickex1Button2_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);

begin
  if CheckBoxJoyf.Checked then
  begin
    if pressed then
    begin
      if CheckBox2.Checked then
        send(':F++#')
      else
        send(':F+#');
    end

    else
      send(':FQ#');
  end
  else
    RadioGroup1.ItemIndex := 2;

end;

procedure TEsp32frm.Joystickex1Button3_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  if CheckBoxJoyf.Checked then
  begin
    if pressed then
    begin
      if CheckBox2.Checked then
        send(':F--#')
      else
        send(':F-#');
    end
    else
      send(':FQ#');
  end
  else
    RadioGroup1.ItemIndex := 1;
end;

procedure TEsp32frm.Joystickex1Button4_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  if pressed then
    lastpress := gettickCount
  else if gettickCount - lastpress > 1000 then
    CheckBoxJoyf.Checked := NOT CheckBoxJoyf.Checked
  else
    RadioGroup1.ItemIndex := 0;
end;

procedure TEsp32frm.Joystickex1Button5_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  RadioGroup1.ItemIndex := 1;
end;

procedure TEsp32frm.Joystickex1Button6_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  RadioGroup1.ItemIndex := 1;
end;

procedure TEsp32frm.Joystickex1JoyMove(Sender: TObject; XPos, YPos: Integer;
  ButtonStatus: Word; IsCalibrating: Boolean);
var
  n: Integer;
  xyreleased: Boolean;
begin

  xyreleased := (XPos = 1) and (YPos = 1);
  Label2.caption := inttostr(XPos) + ' ' + inttostr(YPos);
  case RadioGroup1.ItemIndex of
    0:
      send('#:RS#');
    1:
      send('#:RM#');
    2:
      send('#:RC#');
    3:
      send('#:RG#');
  end;
  begin
    if (joyxstatus <> XPos) then
    begin

      case XPos of
        0:
          send('#:Me#');

        1:
          send('#:Qw#');

        2:
          send('#:Mw#');
      end;

    end;
    if (joyystatus <> YPos) then
    begin
      case YPos of
        0:
          send('#:Mn#');

        1:
          send('#:Qn#');
        2:
          send('#:Ms#');
      end;

    end;
  end;

  if xyreleased then
    send('#:Qn#:Qw#');

  joyxstatus := XPos;
  joyystatus := YPos;

end;

function TEsp32frm.JvHidDeviceControllerEnumerate(HidDev: TJvHidDevice;
  const Idx: Integer): Boolean;

var
  Dev: TJvHidDevice;
  DevID, idxb: Integer;
  UsagePageText, UsageText, name: string;
begin

  // This procedure gets all the HID items:
  // add a descriptive entry to the listbox for the device
  // UsageAndUsagePageText(HidDev.LinkCollectionNodes[Idx].LinkUsagePage,
  // HidDev.LinkCollectionNodes[Idx].LinkUsage, UsagePageText, UsageText);
  if HidDev.ProductName <> '' then
    DevID := lstHidDevices.Items.Add(HidDev.ProductName +
      Format('Device VID=%x PID=%x ',[HidDev.Attributes.VendorID,
      HidDev.Attributes.ProductID]))
  else
    DevID := lstHidDevices.Items.Add(Format('Device VID=%x PID=%x  %x %s %x',
      [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID, Idx,
      UsageText,HidDev.LinkCollectionNodes[Idx].LinkUsage]));
  // Retrive the device and assign it to the list
  JvHidDeviceController.CheckOutByIndex(Dev, Idx);
  lstHidDevices.Items.Objects[DevID] := Dev;

  // If this device is a joystick then set its OnData property to read  its input
  name := HidDev.ProductName;
 // IF trim(HidDev.ProductName) = 'Generic  USB  Joystick ' then
 IF HidDev.Attributes.VendorID = $790 then
//if  HidDev.LinkCollectionNodes[Idx].LinkUsage= HID_USAGE_GENERIC_GAMEPAD

  begin
    Dev.OnData := ReadJoysticks;

  end;

  // Return true so we can move on to the next device
  result := true;
end;

procedure TEsp32frm.JvHidDeviceControllerDeviceChange(Sender: TObject);
var
  count: Integer;
  Dev: TJvHidDevice;
begin

  // This procedure clears all the HID items:
  // Check in all items and remove objects from the list
  for count := 0 to lstHidDevices.Items.count - 1 do
  begin
    Dev := TJvHidDevice(lstHidDevices.Items.Objects[count]);
    JvHidDeviceController.CheckIn(Dev);
    lstHidDevices.Items.Objects[count] := nil;
  end;
  // Clear the listbox
  lstHidDevices.Items.clear;
  // Get a list of connected HID items
  JvHidDeviceController.Enumerate;
end;

procedure TEsp32frm.JvHidDeviceControllerDeviceCreateError
  (Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo;
  var Handled, RetryCreate: Boolean);
begin
  Labelmsg.caption := 'Error GP';
end;
function IntToBin8(I: integer): string;
begin
  Result := '';
  while I > 0 do begin
    Result := Chr(Ord('0') + (I and 1)) + Result;
    I := I shr 1;
  end;
  while Length(Result) < 8 do
    Result := '0' + Result;
end;

procedure TEsp32frm.ReadJoysticks(HidDev: TJvHidDevice; ReportID: Byte;
  const Data: Pointer; Size: Word);
var
  Xaxis, Yaxis, Btn, cur, trackbnt, n: Integer;
begin
   labelmsg.caption:='';
   for n := 0 to size do
   labelmsg.caption:=labelmsg.caption+' '+inttohex(Cardinal(Pbyte(Data)[n]),2);
  // Check the X and Y axis
  Xaxis := Cardinal(Pbyte(Data)[3]);
  Yaxis := Cardinal(Pbyte(Data)[1]);
  // Check the button(s) value
  Btn := Cardinal(Pbyte(Data)[4]);
  trackbnt := Cardinal(Pbyte(Data)[5]);

  cur := Btn and $000F;
  Btn := Btn and $00F0;
   //labelmsg.caption:=labelmsg.caption+' '+ inttobin8(BTN);

  if lastgamebutton <> Btn then
  begin
    case Btn of

      64:
        Joystickex1Button4_Change(Joystickex1, true, 0, 0);
      128:
        Joystickex1Button1_Change(Joystickex1, true, 0, 0);
      32:
        Joystickex1Button2_Change(Joystickex1, true, 0, 0);
      16:
        Joystickex1Button3_Change(Joystickex1, true, 0, 0);
      0:
        begin
          case lastgamebutton of
            64:
              Joystickex1Button4_Change(Joystickex1, false, 0, 0);

            128:
              Joystickex1Button1_Change(Joystickex1, false, 0, 0);
            32:
              Joystickex1Button2_Change(Joystickex1, false, 0, 0);
            16:
              Joystickex1Button3_Change(Joystickex1, false, 0, 0);
          end;
        end;
    end;
  end;
  lastgamebutton := Btn;
  if lastgamedir <> cur then
  begin
    case cur of

      6:
        Joystickex1JoyMove(Joystickex1, 1, 0, 0, false);
      7:
        Joystickex1JoyMove(Joystickex1, 2, 0, 0, false);
      0:
        Joystickex1JoyMove(Joystickex1, 2, 1, 0, false);
      1:
        Joystickex1JoyMove(Joystickex1, 2, 2, 0, false);
      2:
        Joystickex1JoyMove(Joystickex1, 1, 2, 0, false);
      3:
        Joystickex1JoyMove(Joystickex1, 0, 2, 0, false);
      4:
        Joystickex1JoyMove(Joystickex1, 0, 1, 0, false);
      5:
        Joystickex1JoyMove(Joystickex1, 0, 0, 0, false);
      15:
        Joystickex1JoyMove(Joystickex1, 1, 1, 0, false);

    end;
  end;
  lastgamedir := cur;
end;

procedure TEsp32frm.LabelFocusCountDblClick(Sender: TObject);
begin
  send(':FLS1+00000#');
end;

procedure TEsp32frm.Timer1Timer(Sender: TObject);
var
  str: string;
  focus, count: Integer;

begin
  if (ClientSocket1.active and (imode = 1)) or
    ((imode = 0) and ComPortBT_USB.Connected) then
  begin
    labelAR.caption := get_coords(focus, count);
    LabelFocusCount.caption := Format('%0.5d', [focus]);
    if imode = 1 then
      Label5.caption := 'TCP'
    else
      Label5.caption := 'BT/USB';
    Label5.caption := Label5.caption + ' ' + inttostr(count);
    Label5.Font.Color := cllime;
  end

  else
  begin
    Label5.Font.Color := clred;

    Label5.caption := 'DisConnected';
  end;
  { if (Joystickex1.ButtonSt = 16) then
    checkboxtrack.Checked := TRUE;
    if (Joystickex1.ButtonSt = 32) then
    checkboxtrack.Checked := FALSE; }
end;

procedure TEsp32frm.ReadSettings;
var
  inifile: TiniFile;
begin
  inifile := TiniFile.Create(s_inipath + inifile_name);
  with inifile do
  begin
    ComComboBox1.Text := ReadString('Serial_Port', 'Port', 'com14');
    ComComboBox2.Text := ReadString('Serial_Port', 'BaudRate', '57600');
    EditAddr.Text := ReadString('Host', 'Address', '192.168.1.1');
    LongEditPort.Value := ReadInteger('Host', 'Port', 10001);
    RadioGroupcom.ItemIndex := ReadInteger('Interface', 'TCP', 0);
    FloatEditLat.Value := readfloat('GEO', 'lat', 36.7);
    FloatEditLong.Value := readfloat('GEO', 'long', -4.12);
    LongEditgmt.value:=  readinteger('GEO','offset',1);
    gmtoffset:=LongEditgmt.value;
  end;
end;

procedure TEsp32frm.WriteSettings;
var
  inifile: TiniFile;
begin
  inifile := TiniFile.Create(s_inipath + inifile_name);
  with inifile do
  begin
    writeString('Serial_Port', 'Port', ComComboBox1.Text);
    writeString('Serial_Port', 'BaudRate', ComComboBox2.Text);
    writeString('Host', 'Address', EditAddr.Text);
    writeInteger('Host', 'Port', LongEditPort.Value);
    writeInteger('Interface', 'TCP', RadioGroupcom.ItemIndex);
    writefloat('GEO', 'lat', FloatEditLat.Value);
    writefloat('GEO', 'long', FloatEditLong.Value);
    writefloat('GEO','offset',LongEditgmt.value);
  end;
end;

end.
