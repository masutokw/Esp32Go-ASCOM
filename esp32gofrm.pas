unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, CPort, esp32goi, shared, inifiles,
  EnhEdits, CPortCtl, adpInstanceControl, System.Win.ScktComp, serial,
  Joystickex, JvComponentBase, JvHidControllerClass, HidUsage, Vcl.ComCtrls,
  System.Bluetooth, bluetools, tcptools, serialtools, lxutils, Vcl.NumberBox;

type
  TEsp32frm = class(TForm)
    Timer1: TTimer;
    RadioGroup1: TRadioGroup;
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
    adpInstanceControl1: TadpInstanceControl;
    Label5: TLabel;
    Button1: TButton;
    Joystickex1: TJoystickex;
    JvHidDeviceController: TJvHidDeviceController;
    PageControl1: TPageControl;
    Tabconfig: TTabSheet;
    cb: TTabSheet;
    ButtonHome: TButton;
    groupboxgeo: TGroupBox;
    Label4: TLabel;
    FloatEditLong: TFloatEdit;
    FloatEditLat: TFloatEdit;
    Button3: TButton;
    Button2: TButton;
    LongEditgmt: TLongEdit;
    Buttongetgeo: TButton;
    lstHidDevices: TListBox;
    Label2: TLabel;
    Align: TTabSheet;
    GroupBox4: TGroupBox;
    ComComboBox2: TComComboBox;
    ComComboBox1: TComComboBox;
    GroupBox6: TGroupBox;
    cbxpaired: TComboBox;
    RadioGroupcom: TRadioGroup;
    GroupBox3: TGroupBox;
    EditAddr: TEdit;
    LongEditPort: TLongEdit;
    GroupBox7: TGroupBox;
    ButtonRecon: TButton;
    Buttondisconnect: TButton;
    ButtonSave: TButton;
    Buttonbtconnect: TButton;
    CheckAlt: TCheckBox;
    CheckBox1: TCheckBox;
    TabSheet1: TTabSheet;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    LabelAltitude: TLabel;
    LabelAzimuth: TLabel;
    StaticText18: TStaticText;
    StaticText33: TStaticText;
    LabelAR1: TLabel;
    LabelDec1: TLabel;
    GroupBox8: TGroupBox;
    labelAR: TLabel;
    GroupBoxFocus: TGroupBox;
    LabelFocusCount: TLabel;
    ButtonIn: TButton;
    ButtonOut: TButton;
    ButtonM1: TButton;
    ButtonM2: TButton;
    ButtonM3: TButton;
    ButtonM4: TButton;
    CheckBoxJoyf: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox5: TGroupBox;
    ButtonSync: TButton;
    Buttonstar1: TButton;
    Buttonstar2: TButton;
    Buttontakireset: TButton;
    Label1: TLabel;
    Labelmsg: TLabel;
    GroupBox11: TGroupBox;
    Chkflip: TCheckBox;
    btnw: TButton;
    btnE: TButton;
    Label3: TLabel;
    NumberBoxcountaz: TNumberBox;
    NumberBoxcountalt: TNumberBox;
    NumberBoxspgaz: TNumberBox;
    NumberBoxspgalt: TNumberBox;
    NumberBoxspcaz: TNumberBox;
    NumberBoxspcalt: TNumberBox;
    NumberBoxspfaz: TNumberBox;
    NumberBoxspfalt: TNumberBox;
    NumberBoxspsaz: TNumberBox;
    NumberBoxspsalt: TNumberBox;
    NumberBoxrampaz: TNumberBox;
    NumberBoxrampalt: TNumberBox;
    NumberBoxbackpaz: TNumberBox;
    NumberBoxbackpalt: TNumberBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    ComboBoxEqmode: TComboBox;
    ComboBoxtrack: TComboBox;
    NumberBoxpresc: TNumberBox;
    StaticText7: TStaticText;
    CheckBoxbackaz: TCheckBox;
    CheckBoxbackalt: TCheckBox;
    CheckBoxflip: TCheckBox;
    CheckBoxinvaz: TCheckBox;
    CheckBoxinvalt: TCheckBox;
    NumberBoxgmtoff: TNumberBox;
    StaticText6: TStaticText;
    NumberBoxlong: TNumberBox;
    NumberBoxlat: TNumberBox;
    NumberBoxFmax: TNumberBox;
    NBxVolt: TNumberBox;
    NumberBoxFlow: TNumberBox;
    NumberBoxfsp: TNumberBox;
    StaticText8: TStaticText;
    Memo1: TMemo;
    save: TButton;
    Button4: TButton;

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
    procedure CheckBox1Click(Sender: TObject);
    procedure ButtonbtconnectClick(Sender: TObject);
    procedure ChkflipClick(Sender: TObject);
    procedure btnwClick(Sender: TObject);
    procedure btnEClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);

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
  send(':a1#');
end;

procedure TEsp32frm.Buttonstar2Click(Sender: TObject);
begin
  send(':a2#');
end;

procedure TEsp32frm.ButtonReconClick(Sender: TObject);
var
  n: Integer;
begin
  n := 0;
  imode := RadioGroupcom.ItemIndex;
  set_interface_mode(imode);

  case imode of

    0:
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
      end;
    1:
      begin
        if ClientSocket1.Connected then
          ClientSocket1.disconnect;

        ClientSocket1.Host := EditAddr.Text;
        ClientSocket1.Port := LongEditPort.Value;
        ClientSocket1.connect;

        fullconnect := check_connection();
        if not(fullconnect) then
          showmessage('No response');
        Timer1.Enabled := fullconnect;
      end;
    2:
      begin
        if checkBtSock then
          exit;

        if connectbt(cbxpaired.Text) then
        begin
          Label2.caption := 'BlueTooth connected.';
          fullconnect := check_connection();
          if not(fullconnect) then
            showmessage('No response');
          Timer1.Enabled := fullconnect;
        end
        else
          Label2.caption := 'Bluetooth not connected.'
      end;

  end;
  if fullconnect then
  begin
   if not get_pierside() then label3.caption:='East';
   if  get_flip() then chkflip.Checked:=true;
  end;
end;

procedure TEsp32frm.btnEClick(Sender: TObject);
begin
 setpierside(false);
 if not get_pierside then label3.Caption:='East';
    labelar1.Font.Color:=Cllime;
    labeldec1.Font.Color:=Cllime;
end;

procedure TEsp32frm.btnwClick(Sender: TObject);
begin
setpierside(true);
  if get_pierside then label3.Caption:='West';
     labelar1.Font.Color:=Clred;
    labeldec1.Font.Color:=Clred;
end;

procedure TEsp32frm.Button2Click(Sender: TObject);
var
  ctime: TdateTime;
begin

  gmtoffset := LongEditgmt.Value;
  set_offset(gmtoffset);
  sleep(20);
  ctime := UTCnow() + (gmtoffset / 24.0);

  Set_localtime(ctime);
  sleep(20);
  Set_date(ctime);
  sleep(20);

end;

procedure TEsp32frm.Button3Click(Sender: TObject);
begin
  set_offset(LongEditgmt.Value);
  Set_latitude(FloatEditLat.Value);
  sleep(20);
  set_longitude(FloatEditLong.Value);
  sleep(20);

end;

procedure TEsp32frm.Button4Click(Sender: TObject);
var
  cstring,str: string;
  lines: Tstringlist;
begin
  try
    lines := Tstringlist.Create();
  finally

  end;
  memo1.Lines.Clear;
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock) then

  begin
    //Memo1.lines.Clear;
    Timer1.Enabled := false;
    send(':cA#');

      if imode=2 then
      begin
       recv(cstring,100);
        //  cstring := stringreplace(cstring,#10,
        //  '', [rfReplaceAll]);
        //   cstring := stringreplace(cstring,#13,
        //  '', [rfReplaceAll]);
        lines.Text:=cstring;
       end
        else
      repeat

        case imode of
        1:
        begin
        readvln(cstring,#13#10);
        cstring := stringreplace(cstring, #13#10,
          '', [rfReplaceAll])
        end;
        0:
          begin
          readvln(cstring,#10);
          cstring := stringreplace(cstring,#10,
          '', [rfReplaceAll]);
           cstring := stringreplace(cstring,#13,
          '', [rfReplaceAll]);
          end;
        end;

           cstring := stringreplace(cstring, '.',
          '' + FormatSettings.DecimalSeparator, [rfReplaceAll]);
        lines.add(cstring);
        memo1.lines.add(cstring);
      until inbuff=0;

      Label1.caption := inttostr(lines.Count)+lines[0];
    Timer1.Enabled := true;
    if lines.Count >28 then
    begin

      NumberBoxcountaz.Text := lines[0];
      Numberboxcountalt.Text := lines[1];
      NumberBoxspgaz.Text := lines[2];
      NumberBoxspcaz.Text := lines[3];
      NumberBoxspfaz.Text := lines[4];
      NumberBoxspsaz.Text := lines[5];
      NumberBoxspgalt.Text := lines[6];
      NumberBoxspcalt.Text := lines[7];
      NumberBoxspfalt.Text := lines[8];
      NumberBoxspsalt.Text := lines[9];
      NumberBoxpresc.Text := lines[10];
      NumberBoxlong.Text := lines[11];
      NumberBoxlat.Text := lines[12];
      NumberBoxgmtoff.Text := lines[13];
      NumberBoxFMax.Text := lines[14];
      NumberBoxFLow.Text := lines[15];
      NumberBoxFsp.Text := lines[16];
      NumberBoxrampaz.Text := lines[17];
      NumberBoxrampalt.Text := lines[18];
      NumberBoxbackpaz.Text := lines[19];
      NumberBoxbackpalt.Text := lines[20];
      ComboBoxEqmode.ItemIndex := lines[21].tointeger;
      ComboBoxtrack.ItemIndex := strtoint(lines[22]);
      CheckBoxflip.Checked := lines[23] = '1';
      CheckBoxinvaz.Checked := lines[24] = '1';
      CheckBoxinvAlt.Checked := lines[25] = '1';
      NBXvolt.Text:=lines[26];
      CheckBoxbackaz.Checked := lines[27] = '1';
      CheckBoxbackalt.Checked := lines[28] = '1';
    end;
    lines.Destroy
  end;
end;

procedure TEsp32frm.ButtonbtconnectClick(Sender: TObject);

begin
  devlist(cbxpaired.Items);
end;

procedure TEsp32frm.ButtonSyncClick(Sender: TObject);
begin
  send(':a0#');
end;

procedure TEsp32frm.ButtontakiresetClick(Sender: TObject);
begin
  send(':a3#');
end;

procedure TEsp32frm.Buttonconfig(Sender: TObject);
begin
  PageControl1.Visible := not PageControl1.Visible;
  GroupBox8.Visible := not PageControl1.Visible;
end;

procedure TEsp32frm.ButtondisconnectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case imode of

    1:
      ClientSocket1.disconnect();
    0:
      ComPortBT_USB.Connected := false;
    2:
      begin
        if checkBtSock then
        begin
          FreeBtSock;
          Label2.caption := 'bt not connected'
        end;
      end;
  end;

  fullconnect := false;
end;

procedure TEsp32frm.ButtongetgeoClick(Sender: TObject);
var
  offset: Integer;
begin
  FloatEditLong.Value := get_long();
  FloatEditLat.Value := get_lat();
  longi := FloatEditLong.Value;
  lat := FloatEditLat.Value;
  offset := get_gmtoffset();
  if offset < 50 then
    LongEditgmt.Value := offset;
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
      send(':RS#');
    1:
      send(':RM#');
    2:
      send(':RC#');
    3:
      send(':RG#');
  end;

  case TButton(Sender).tag of
    0:
      send(':Mn#');
    1:
      send(':Ms#');
    2:
      send(':Me#');
    3:
      send(':Mw#');
    4:
      send(':Mn#:Me#');
    5:
      send(':Ms#:Me#');
    6:
      send(':Ms#:Mw#');
    7:
      send(':Mn#:Mw#');

  end;

end;

procedure TEsp32frm.Button_NMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case TButton(Sender).tag of
    0:
      send(':Qn#');
    1:
      send(':Qs#');
    2:
      send(':Qe#');
    3:
      send(':Qw#');
    4, 5, 6, 7:
      send(':Qn#:Qw#');
  end;

end;

procedure TEsp32frm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    send(':Qw#')
  else
    send(':Mh#');

end;

procedure TEsp32frm.ChkflipClick(Sender: TObject);
begin
setautoflip(chkflip.Checked);

end;

procedure TEsp32frm.FormCreate(Sender: TObject);
var
  n: Integer;
begin
  pagecontrol1.ActivePage:= TabSheet1 ;
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
  case imode of

    0:
      ComPortBT_USB.Connected := true;
    1:
      ClientSocket1.connect;
    2:
      connectbt(cbxpaired.Text);

  end;

  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then
  begin

    fullconnect := check_connection();
    if not(fullconnect) then
      showmessage('No response');
    if fullconnect then
      Timer1.Enabled := true;
  end;
  if fullconnect then
  begin
    CheckBox1.Checked := (get_track() = 1);
    CheckAlt.Checked := get_alignmode() = 'A';
    if not get_pierside() then
    begin
    label3.caption:='East';
    labelar1.Font.Color:=Cllime;
    labeldec1.Font.Color:=Cllime;
    end;
     if  get_flip() then chkflip.Checked:=true;
  end;

end;

procedure TEsp32frm.FormDestroy(Sender: TObject);
begin
  if ClientSocket1.Connected = true then
    ClientSocket1.disconnect;
  if ComPortBT_USB.Connected then
    ComPortBT_USB.Connected := false;
   FreeBtSock;

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
  CheckBox1.Checked := true;
  send(':Mh');
end;

procedure TEsp32frm.Joystickex1Button6_Change(Sender: TObject; pressed: Boolean;
  XPos, YPos: Integer);
begin
  CheckBox1.Checked := false;
  send(':Qw#');
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
      Format('Device VID=%x PID=%x ', [HidDev.Attributes.VendorID,
      HidDev.Attributes.ProductID]))
  else
    DevID := lstHidDevices.Items.Add(Format('Device VID=%x PID=%x  %x %s %x',
      [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID, Idx, UsageText,
      HidDev.LinkCollectionNodes[Idx].LinkUsage]));
  // Retrive the device and assign it to the list
  JvHidDeviceController.CheckOutByIndex(Dev, Idx);
  lstHidDevices.Items.Objects[DevID] := Dev;

  // If this device is a joystick then set its OnData property to read  its input
  name := HidDev.ProductName;
  // IF trim(HidDev.ProductName) = 'Generic  USB  Joystick ' then
  IF (trim(HidDev.ProductName) = 'Gamepad') then
  // if  HidDev.LinkCollectionNodes[Idx].LinkUsage= HID_USAGE_GENERIC_GAMEPAD

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
  lstHidDevices.Items.Clear;
  // Get a list of connected HID items
  JvHidDeviceController.Enumerate;
end;

procedure TEsp32frm.JvHidDeviceControllerDeviceCreateError
  (Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo;
  var Handled, RetryCreate: Boolean);
begin
  Labelmsg.caption := 'Error GP';
end;

function IntToBin8(I: Integer): string;
begin
  result := '';
  while I > 0 do
  begin
    result := Chr(Ord('0') + (I and 1)) + result;
    I := I shr 1;
  end;
  while Length(result) < 8 do
    result := '0' + result;
end;

procedure TEsp32frm.ReadJoysticks(HidDev: TJvHidDevice; ReportID: Byte;
  const Data: Pointer; Size: Word);
var
  Xaxis, Yaxis, Btn, cur, trackbnt, n: Integer;
begin
  { Labelmsg.caption := '';
    for n := 0 to Size do
    Labelmsg.caption := Labelmsg.caption + ' ' +
    inttohex(Cardinal(Pbyte(Data)[n]), 2); }
  // Check the X and Y axis
  Xaxis := Cardinal(Pbyte(Data)[3]);
  Yaxis := Cardinal(Pbyte(Data)[1]);
  // Check the button(s) value
  Btn := Cardinal(Pbyte(Data)[4]);
  trackbnt := Cardinal(Pbyte(Data)[5]);

  cur := Btn and $000F;
  Btn := Btn and $00F0;
  // labelmsg.caption:=labelmsg.caption+' '+ inttobin8(BTN);

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
  str, coors, strsideral: string;
  focus, count: Integer;
  png: Cardinal;
begin

  if (ClientSocket1.Connected and (imode = 1)) or
    ((imode = 0) and ComPortBT_USB.Connected) or ((imode = 2) and checkBtSock)
  then
  begin
    png := gettickCount();
    // labelAR.caption := get_coords(focus, count);
    coors := get_coords(focus, count);
    if coors.Length > 40 then
    begin
      labelAR.caption := coors;
    end;


    LabelAR1.caption := DoubletoLXAR(ra, 0);

    LabelDec1.caption := DoubletoLXdec(dec, 0);
    // labelAR.caption := inttostr(count);
    LabelFocusCount.caption := Format('%0.5d', [focus]);
    if CheckAlt.Checked then
    begin
      // az := get_az();
      // alt := get_alt();

      LabelAzimuth.caption := DoubletoLXdec(az, 0);

      LabelAltitude.caption := DoubletoLXdec(alt, 0);
    end;
    case imode of

      0:
        Label5.caption := 'USB';
      1:
        Label5.caption := 'TCP';
      2:
        Label5.caption := 'BT';
    end;
    Label5.caption := Label5.caption + ' ' +
    inttostr(gettickCount() - png)+ ' '+
    inttostr(inbuff());
    if inbuff>0 then clearbuff(true,false) ;

    Label5.Font.Color := cllime;
  end

  else
  begin
    Label5.Font.Color := clred;

    Label5.caption := 'DisConnected';
  end;
  datetimetostring(strsideral, 'hh:nn:ss', Local_Sideral_Time(UTCnow(),
    -FloatEditLong.Value) / 24.0);
  Labelmsg.caption := 'Local:' + timetostr(UTCnow() + (gmtoffset / 24.0)) +
    #13#10 + 'GMT: ' + timetostr(UTCnow()) + #13#10 + 'Sid:' + strsideral;

  if (Joystickex1.ButtonSt = 16) then
    CheckBox1.Checked := true;
  if (Joystickex1.ButtonSt = 32) then
    CheckBox1.Checked := false;
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
    LongEditgmt.Value := ReadInteger('GEO', 'offset', 1);
    cbxpaired.Text := ReadString('Bluetooth', 'device', 'esp32go');
    gmtoffset := LongEditgmt.Value;
    longi := FloatEditLong.Value;
    lat := FloatEditLat.Value;
  end;
end;

procedure TEsp32frm.saveClick(Sender: TObject);
var
  s: string;
  I: Integer;
  lines: Tstringlist;
  bytes: Tbytes;
begin
  try
    lines := Tstringlist.Create();
  finally

  end;
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock) then
  begin

    lines.Add(NumberBoxcountaz.Text);
    lines.Add(Numberboxcountalt.Text);
    lines.Add(NumberBoxspgaz.Text);
    lines.Add(NumberBoxspcaz.Text);
    lines.Add(NumberBoxspfaz.Text);
    lines.Add(NumberBoxspsaz.Text);
    lines.Add(NumberBoxspgalt.Text);
    lines.Add(NumberBoxspcalt.Text);
    lines.Add(NumberBoxspfalt.Text);
    lines.Add(NumberBoxspsalt.Text);
    lines.Add(NumberBoxpresc.Text);
    lines.Add(NumberBoxlong.Text);
    lines.Add(NumberBoxlat.Text);
    lines.Add(NumberBoxgmtoff.Text);
    lines.Add(NumberBoxFMax.Text);
    lines.Add(NumberBoxFLow.Text);
    lines.Add(NumberBoxFsp.Text);
    lines.Add(NumberBoxrampaz.Text);
    lines.Add(NumberBoxrampalt.Text);
    lines.Add(NumberBoxbackpaz.Text);
    lines.Add(NumberBoxbackpalt.Text);
    lines.Add(inttostr(ComboBoxEqmode.ItemIndex));
    lines.Add(inttostr(ComboBoxtrack.ItemIndex));
    lines.Add(CheckBoxflip.Checked.tointeger.ToString);
    lines.Add(CheckBoxinvaz.Checked.tointeger.ToString);
    lines.Add(CheckBoxinvAlt.Checked.tointeger.ToString);
    lines.Add(NBXvolt.Text);
    lines.Add(CheckBoxbackaz.Checked.tointeger.ToString);
    lines.Add(CheckBoxbackalt.Checked.tointeger.ToString);
    //Label17.Text := inttostr(lines.Count);
    memo1.Lines.Clear;
    if lines.Count = 29 then
    begin
      s := ':cs';
      for I := 0 to 28 do
        s := s + lines[I] + #13#10;

      s := s + '#';
      s := stringreplace(s, FormatSettings.DecimalSeparator, '.',
        [rfReplaceAll]);
      memo1.Lines.Add(s);
      send(s);
    end;
 end;

  lines.Destroy;
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
    writefloat('GEO', 'offset', LongEditgmt.Value);
    writeString('Bluetooth', 'device', cbxpaired.Text);
  end;
end;

end.
