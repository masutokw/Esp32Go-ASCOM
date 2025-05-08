unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, CPort, esp32goi, shared, inifiles,
  EnhEdits, CPortCtl, adpInstanceControl, System.Win.ScktComp, serial,
  Joystickex, JvComponentBase, JvHidControllerClass, HidUsage, Vcl.ComCtrls,
  System.Bluetooth, bluetools, tcptools, serialtools, lxutils, Vcl.NumberBox,
  globalvar, Vcl.Samples.Spin;

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
    StaticText8: TStaticText;
    Memo1: TMemo;
    save: TButton;
    Button4: TButton;
    Label6: TLabel;
    TMC: TTabSheet;
    NumberBoxraSt: TNumberBox;
    NumberBoxDecSt: TNumberBox;
    NumberBoxF1St: TNumberBox;
    NumberBoxF2St: TNumberBox;
    NumberBoxF1Cur: TNumberBox;
    NumberBoxF2Cur: TNumberBox;
    NumberBoxDecCur: TNumberBox;
    NumberBoxRACur: TNumberBox;
    NumberBoxdecSp: TNumberBox;
    NumberBoxf1Sp: TNumberBox;
    NumberBoxf2Sp: TNumberBox;
    Label7: TLabel;
    Button5: TButton;
    Button6: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CheckRASp: TCheckBox;
    checkdecsp: TCheckBox;
    checkf1sp: TCheckBox;
    checkf2sp: TCheckBox;
    checkdecpol: TCheckBox;
    Checkf2pol: TCheckBox;
    Checkf1pol: TCheckBox;
    Checkrapol: TCheckBox;
    Label12: TLabel;
    NumberBoxraSp: TNumberBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    TrackBar1: TTrackBar;
    Aux: TTabSheet;
    Panel1: TPanel;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText12: TStaticText;
    NumberBoxFM: TNumberBox;
    NumberBoxAM: TNumberBox;
    StaticText13: TStaticText;
    NumberBoxFS: TNumberBox;
    NumberBoxAs: TNumberBox;
    NumberBoxFF: TNumberBox;
    NumberBoxAF: TNumberBox;
    NumberBoxFpwm: TNumberBox;
    NumberBoxApwm: TNumberBox;
    StaticText15: TStaticText;
    StaticText14: TStaticText;
    ButtonAuxSave: TButton;
    ButtonAuxRead: TButton;
    CheckBoxDCF: TCheckBox;
    GroupRotator: TGroupBox;
    SpinButton3: TSpinButton;
    CCButton: TButton;
    CCWButton: TButton;
    SyncButton3: TButton;
    MoveButton3: TButton;
    CounterFloatEdit: TFloatEdit;
    reverseCheckBox: TCheckBox;
    TargetFloatEdit: TFloatEdit;
    RButton1: TButton;
    RButton2: TButton;
    RButton3: TButton;
    RButton4: TButton;
    RButton5: TButton;
    RButton6: TButton;
    RButton7: TButton;
    RButton8: TButton;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText19: TStaticText;
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
    Checkaltfocus: TCheckBox;
    GroupBoxfilter: TGroupBox;
    Label16: TLabel;
    WButton1: TButton;
    WButton2: TButton;
    WButton3: TButton;
    WButton4: TButton;
    WButton5: TButton;
    WButton6: TButton;
    WButton7: TButton;
    WButton8: TButton;
    WButton9: TButton;
    ComboAux: TComboBox;
    GroupBoxfocus2: TGroupBox;
    counterLongEdit2: TLongEdit;
    SpinButton2: TSpinButton;
    InButton2: TButton;
    outtButton2: TButton;
    SyncButton2: TButton;
    MoveButton2: TButton;
    targetLongEdit2: TLongEdit;
    Button1f: TButton;
    Button2f: TButton;
    Button3f: TButton;
    Button4f: TButton;
    Button5f: TButton;
    Button6f: TButton;
    ButtonM5: TButton;
    ButtonM6: TButton;

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
    procedure ButtonM1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckaltfocusClick(Sender: TObject);
    procedure ButtonAuxSaveClick(Sender: TObject);
    procedure ButtonAuxReadClick(Sender: TObject);
    procedure RButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CCButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CCButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SyncButton3Click(Sender: TObject);
    procedure InButton2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InButton2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1fClick(Sender: TObject);
    procedure Button1fContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  config_lines = 24;

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

    if not get_pierside() then
      Label3.caption := 'East';
    if get_flip() then
      Chkflip.Checked := true;
    Button4Click(self);
  end;
end;

procedure TEsp32frm.btnEClick(Sender: TObject);
begin
  setpierside(false);
  if not get_pierside then
    Label3.caption := 'East';
  LabelAR1.Font.Color := Cllime;
  LabelDec1.Font.Color := Cllime;
end;

procedure TEsp32frm.btnwClick(Sender: TObject);
begin
  setpierside(true);
  if get_pierside then
    Label3.caption := 'West';
  LabelAR1.Font.Color := Clred;
  LabelDec1.Font.Color := Clred;
end;

procedure TEsp32frm.Button1fClick(Sender: TObject);
var
  stpos: string;
begin
  stpos := Format('%0.5d#', [focuspos2[TButton(Sender).tag]]);
  send(':XA-' + stpos);
end;

procedure TEsp32frm.Button1fContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  showmessage('Setting changed');
  focuspos2[TButton(Sender).tag] := counterLongEdit2.Value;
  TButton(Sender).Hint := inttostr(counterLongEdit2.Value);
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
  cstring, str: string;
  lines: Tstringlist;
  cLines: Integer;
begin
  try
    lines := Tstringlist.Create();
  finally

  end;
  cLines := 0;
  Memo1.lines.Clear;
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then

  begin
    // Memo1.lines.Clear;
    Timer1.Enabled := false;
    send(':cA#');

    if imode = 2 then
    begin
      recv(cstring, 100);
      // cstring := stringreplace(cstring,#10,
      // '', [rfReplaceAll]);
      // cstring := stringreplace(cstring,#13,
      // '', [rfReplaceAll]);
      cstring := stringreplace(cstring, '.',
        '' + FormatSettings.DecimalSeparator, [rfReplaceAll]);
      lines.Text := cstring;
      Memo1.lines.add(cstring);

    end
    else
      repeat

        case imode of
          1:
            begin
              readvln(cstring, #13#10);
              cstring := stringreplace(cstring, #13#10, '', [rfReplaceAll])
            end;
          0:
            begin
              readvln(cstring, #10);
              cstring := stringreplace(cstring, #10, '', [rfReplaceAll]);
              cstring := stringreplace(cstring, #13, '', [rfReplaceAll]);
            end;
        end;

        cstring := stringreplace(cstring, '.',
          '' + FormatSettings.DecimalSeparator, [rfReplaceAll]);
        lines.add(cstring);
        Memo1.lines.add(cstring)
      until (inbuff = 0);

    Label1.caption := inttostr(lines.Count) + lines[0];
    Timer1.Enabled := true;
    if lines.Count >= config_lines then
    begin

      NumberBoxcountaz.Text := lines[0];
      NumberBoxcountalt.Text := lines[1];
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
      NumberBoxrampaz.Text := lines[14];
      NumberBoxrampalt.Text := lines[15];
      NumberBoxbackpaz.Text := lines[16];
      NumberBoxbackpalt.Text := lines[17];
      ComboBoxEqmode.ItemIndex := lines[18].tointeger;
      ComboBoxtrack.ItemIndex := strtoint(lines[19]);
      CheckBoxflip.Checked := lines[20] = '1';
      CheckBoxinvaz.Checked := lines[21] = '1';
      CheckBoxinvalt.Checked := lines[22] = '1';
      CheckBoxbackaz.Checked := lines[23] = '1';
      CheckBoxbackalt.Checked := lines[24] = '1';
      str := NumberBoxspgaz.Text;
      guide_ra := str.ToDouble * (15.0 / 3600.0);
      str := NumberBoxspgalt.Text;
      guide_de := str.ToDouble * (15.0 / 3600.0);
    end;
    lines.Destroy
  end;
end;

procedure TEsp32frm.Button5Click(Sender: TObject);
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
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then
  begin

    lines.add(NumberBoxraSt.Text);
    lines.add(NumberBoxRACur.Text);
    lines.add(NumberBoxraSp.Text);
    lines.add(CheckRASp.Checked.tointeger.ToString);
    lines.add(Checkrapol.Checked.tointeger.ToString);
    lines.add(NumberBoxDecSt.Text);
    lines.add(NumberBoxDecCur.Text);
    lines.add(NumberBoxdecSp.Text);
    lines.add(checkdecsp.Checked.tointeger.ToString);
    lines.add(checkdecpol.Checked.tointeger.ToString);
    lines.add(NumberBoxF1St.Text);
    lines.add(NumberBoxF1Cur.Text);
    lines.add(NumberBoxf1Sp.Text);
    lines.add(checkf1sp.Checked.tointeger.ToString);
    lines.add(Checkf1pol.Checked.tointeger.ToString);
    lines.add(NumberBoxF2St.Text);
    lines.add(NumberBoxF2Cur.Text);
    lines.add(NumberBoxf2Sp.Text);
    lines.add(checkf2sp.Checked.tointeger.ToString);
    lines.add(Checkf2pol.Checked.tointeger.ToString);

    // Label17.Text := inttostr(lines.Count);
    Memo1.lines.Clear;
    if true then
    begin
      s := ':ct';
      for I := 0 to 19 do
        s := s + lines[I] + #13#10;

      s := s + '#';
      s := stringreplace(s, FormatSettings.DecimalSeparator, '.',
        [rfReplaceAll]);
      Memo1.lines.add(s);
      send(s);
    end;
  end;

  lines.Destroy;

end;

procedure TEsp32frm.Button6Click(Sender: TObject);

var
  cstring, str: string;
  lines: Tstringlist;
  cLines: Integer;
begin
  try
    lines := Tstringlist.Create();
  finally

  end;
  cLines := 0;
  Memo1.lines.Clear;
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then

  begin
    // Memo1.lines.Clear;
    Timer1.Enabled := false;
    send(':cT#');

    if imode = 2 then
    begin
      recv(cstring, 100);
      // cstring := stringreplace(cstring,#10,
      // '', [rfReplaceAll]);
      // cstring := stringreplace(cstring,#13,
      // '', [rfReplaceAll]);
      lines.Text := cstring;

    end
    else
      repeat

        case imode of
          1:
            begin
              readvln(cstring, #10);
              cstring := stringreplace(cstring, #10, '', [rfReplaceAll])
            end;
          0:
            begin
              readvln(cstring, #10);
              cstring := stringreplace(cstring, #10, '', [rfReplaceAll]);
              cstring := stringreplace(cstring, #13, '', [rfReplaceAll]);
            end;
        end;

        cstring := stringreplace(cstring, '.',
          '' + FormatSettings.DecimalSeparator, [rfReplaceAll]);
        lines.add(cstring);
        Memo1.lines.add(cstring)
      until (inbuff = 0);

    Label1.caption := inttostr(lines.Count) + lines[0];
    Timer1.Enabled := true;
    if lines.Count >= 20 then
    begin
      NumberBoxraSt.Text := lines[0];
      NumberBoxRACur.Text := lines[1];
      NumberBoxraSp.Text := lines[2];
      CheckRASp.Checked := lines[3] = '1';
      Checkrapol.Checked := lines[4] = '1';

      NumberBoxDecSt.Text := lines[5];
      NumberBoxDecCur.Text := lines[6];
      NumberBoxdecSp.Text := lines[7];
      checkdecsp.Checked := lines[8] = '1';
      checkdecpol.Checked := lines[9] = '1';

      NumberBoxF1St.Text := lines[10];
      NumberBoxF1Cur.Text := lines[11];
      NumberBoxf1Sp.Text := lines[12];
      checkf1sp.Checked := lines[13] = '1';
      Checkf1pol.Checked := lines[14] = '1';

      NumberBoxF2St.Text := lines[15];
      NumberBoxF2Cur.Text := lines[16];
      NumberBoxf2Sp.Text := lines[17];
      checkf2sp.Checked := lines[18] = '1';
      Checkf2pol.Checked := lines[19] = '1';

    end;
    lines.Destroy
  end;
end;

procedure TEsp32frm.ButtonAuxReadClick(Sender: TObject);
var
  cstring, str: string;
  lines: Tstringlist;
  cLines: Integer;
begin
  try
    lines := Tstringlist.Create();
  finally

  end;
  cLines := 0;
  Memo1.lines.Clear;
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then

  begin
    // Memo1.lines.Clear;
    Timer1.Enabled := false;
    send(':cF#');

    if imode = 2 then
    begin
      recv(cstring, 100);
      // cstring := stringreplace(cstring,#10,
      // '', [rfReplaceAll]);
      // cstring := stringreplace(cstring,#13,
      // '', [rfReplaceAll]);
      lines.Text := cstring;

    end
    else
      repeat

        case imode of
          1:
            begin
              readvln(cstring, #10);
              cstring := stringreplace(cstring, #10, '', [rfReplaceAll])
            end;
          0:
            begin
              readvln(cstring, #10);
              cstring := stringreplace(cstring, #10, '', [rfReplaceAll]);
              cstring := stringreplace(cstring, #13, '', [rfReplaceAll]);
            end;
        end;

        cstring := stringreplace(cstring, '.',
          '' + FormatSettings.DecimalSeparator, [rfReplaceAll]);
        lines.add(cstring);
        Memo1.lines.add(cstring)
      until (inbuff = 0);

    Label1.caption := inttostr(lines.Count) + lines[0];
    Timer1.Enabled := true;
    if lines.Count >= 8 then
    begin
      NumberBoxFM.Text := lines[0];
      NumberBoxFS.Text := lines[1];
      NumberBoxFF.Text := lines[2];
      NumberBoxFpwm.Text := lines[3];

      NumberBoxAM.Text := lines[4];
      NumberBoxAs.Text := lines[5];
      NumberBoxAF.Text := lines[6];
      NumberBoxApwm.Text := lines[7];
      CheckBoxDCF.Checked := lines[8] = '1';
      ComboAux.ItemIndex := lines[9].tointeger();
      aux_device := lines[9].tointeger();
      aux_max := strtoint(NumberBoxAM.Text);
      GroupRotator.Visible := aux_device = 1;
      GroupBoxfilter.Visible := aux_device = 2;
      GroupBoxfocus2.Visible := aux_device = 0;
      GroupBoxfilter.left := GroupRotator.left;
      GroupBoxfilter.top := GroupRotator.top;
    end;
    lines.Destroy
  end;
end;

procedure TEsp32frm.ButtonAuxSaveClick(Sender: TObject);
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
  if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or (checkBtSock)
  then
  begin

    lines.add(NumberBoxFM.Text);
    lines.add(NumberBoxFS.Text);
    lines.add(NumberBoxFF.Text);
    lines.add(NumberBoxFpwm.Text);
    lines.add(NumberBoxAM.Text);
    lines.add(NumberBoxAs.Text);
    lines.add(NumberBoxAF.Text);
    lines.add(NumberBoxApwm.Text);
    lines.add(CheckBoxDCF.Checked.tointeger.ToString);
    lines.add(ComboAux.ItemIndex.ToString());
    aux_device := ComboAux.ItemIndex;
    GroupBoxfocus2.Visible := aux_device = 0;
    GroupRotator.Visible := aux_device = 1;
    GroupBoxfilter.Visible := aux_device = 2;

    // Label17.Text := inttostr(lines.Count);
    Memo1.lines.Clear;
    if true then
    begin
      s := ':cf';
      for I := 0 to 9 do
        s := s + lines[I] + #13#10;

      s := s + '#';
      s := stringreplace(s, FormatSettings.DecimalSeparator, '.',
        [rfReplaceAll]);
      Memo1.lines.add(s);
      send(s);
    end;
  end;

  lines.Destroy;

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
var
  stpos: string;
begin
  stpos := Format('%0.5d#', [focuspos[TButton(Sender).tag]]);
  send(':FA-' + stpos);
end;

procedure TEsp32frm.ButtonM1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  showmessage('Setting changed');
  focuspos[TButton(Sender).tag] := strtoint(LabelFocusCount.caption);
  TButton(Sender).Hint := LabelFocusCount.caption;
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

procedure TEsp32frm.CCButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  case TButton(Sender).tag of
    0:
      if CheckBox2.Checked then
        send(':X++#')
      else
        send(':X+#');
    1:
      if CheckBox2.Checked then
        send(':X--#')
      else
        send(':X-#');
  end;

end;

procedure TEsp32frm.CCButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  send(':XQ#');
  CounterFloatEdit.Value := 360.0 / aux_max * get_focuspos('X');
end;

procedure TEsp32frm.CheckaltfocusClick(Sender: TObject);
begin
  if Checkaltfocus.Checked and fullconnect then
  begin
    send(':Fs1#');
    Checkaltfocus.caption := 'Focus1';
    aux_active := 1;
    GroupRotator.Visible := true;
  end
  else
  begin
    send(':Fs0#');
    Checkaltfocus.caption := 'Focus0';
    aux_active := 0;
    GroupRotator.Visible := true;
  end;

end;

procedure TEsp32frm.ChkflipClick(Sender: TObject);
begin
  setautoflip(Chkflip.Checked);

end;

procedure TEsp32frm.FormCreate(Sender: TObject);
var
  n: Integer;
begin
  PageControl1.ActivePage := TabSheet1;
  n := 0;
  Joystickex1.EnableJoyStick;
  s_inipath := ExtractFilePath(Application.EXEName);
  inifile_name := 'esp32gocnf.ini';
  SetWindowPos(Handle, HWND_TOPMOST, left, top, Width, Height, 0);
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
    begin
      // showmessage('fullconnect');
      Timer1.Enabled := true;

    end;
  end;
  if fullconnect then
  begin
    CheckBox1.Checked := (get_track() = 1);
    CheckAlt.Checked := get_alignmode() = 'A';

    if not get_pierside() then
    begin
      Label3.caption := 'East';
      LabelAR1.Font.Color := Cllime;
      LabelDec1.Font.Color := Cllime;
    end;
    if get_flip() then
      Chkflip.Checked := true;
    Button4Click(self);
    Button6Click(self);
    ButtonAuxReadClick(self);
    // showmessage('okread');
    Timer1.Enabled := true;
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

procedure TEsp32frm.InButton2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case TButton(Sender).tag of
    0:
      if CheckBox2.Checked then
        send(':X++#')
      else
        send(':X+#');
    1:
      if CheckBox2.Checked then
        send(':X--#')
      else
        send(':X-#');
  end;
end;

procedure TEsp32frm.InButton2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  send(':XQ#');
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
    DevID := lstHidDevices.Items.add(HidDev.ProductName +
      Format('Device VID=%x PID=%x ', [HidDev.Attributes.VendorID,
      HidDev.Attributes.ProductID]))
  else
    DevID := lstHidDevices.Items.add(Format('Device VID=%x PID=%x  %x %s %x',
      [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID, Idx, UsageText,
      HidDev.LinkCollectionNodes[Idx].LinkUsage]));
  // Retrive the device and assign it to the list
  JvHidDeviceController.CheckOutByIndex(Dev, Idx);
  lstHidDevices.Items.Objects[DevID] := Dev;
  Memo1.lines.add(HidDev.ProductName + Format('Device VID=%x PID=%x  %x %s %x',
    [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID, Idx, UsageText,
    HidDev.LinkCollectionNodes[Idx].LinkUsage]));
  // If this device is a joystick then set its OnData property to read  its input
  name := HidDev.ProductName;
  // IF trim(HidDev.ProductName) = 'Generic  USB  Joystick ' then
  IF (trim(HidDev.ProductName) = '') then
  // if  HidDev.LinkCollectionNodes[Idx].LinkUsage= HID_USAGE_GENERIC_GAMEPAD

  begin
    Dev.OnData := ReadJoysticks;

  end;

  // Return true so we can move on to the next device
  result := true;
end;

procedure TEsp32frm.JvHidDeviceControllerDeviceChange(Sender: TObject);
var
  Count: Integer;
  Dev: TJvHidDevice;
begin

  // This procedure clears all the HID items:
  // Check in all items and remove objects from the list
  for Count := 0 to lstHidDevices.Items.Count - 1 do
  begin
    Dev := TJvHidDevice(lstHidDevices.Items.Objects[Count]);
    JvHidDeviceController.CheckIn(Dev);
    lstHidDevices.Items.Objects[Count] := nil;
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

procedure TEsp32frm.RButton1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  counter: Integer;
begin

  if TButton(Sender).tag = 1000 then
    counter := round((TargetFloatEdit.Value / 360.0) * aux_max)
  else
    counter := round((TButton(Sender).tag / 360.0) * aux_max);
  send(':XA-' + Format('%.5d', [counter]) + '#');

end;

procedure TEsp32frm.ReadJoysticks(HidDev: TJvHidDevice; ReportID: Byte;
  const Data: Pointer; Size: Word);
var
  Xaxis, Yaxis, Btn, cur, trackbnt, n: Integer;
begin
  Label6.caption := '';
  for n := 0 to Size do
    Label6.caption := Label6.caption + ' ' +
      inttohex(Cardinal(Pbyte(Data)[n]), 2);
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
  str, coors, strsideral, strangle: string;
  // focus, Count: Integer;
  Count: Integer;
  png: Cardinal;
begin

  if (ClientSocket1.Connected and (imode = 1)) or
    ((imode = 0) and ComPortBT_USB.Connected) or ((imode = 2) and checkBtSock)
  then
  begin
    png := gettickCount();
    // labelAR.caption := get_coords(focus, count);
    coors := get_coords(focus, Count);
    if coors.Length > 40 then
    begin
      labelAR.caption := coors;
    end;

    LabelAR1.caption := DoubletoLXAR(ra, 0);

    LabelDec1.caption := DoubletoLXdec(dec, 0);
    // labelAR.caption := inttostr(count);

    LabelFocusCount.caption := Format('%0.5d', [focus]);
    // if aux_active = 1 then
    // if aux_device=1 then CounterFloatEdit.Value := 360.0 / aux_max * get_focusaux();
    case aux_device of
      0:begin
        aux_counter := get_focuspos('X');counterLongEdit2.Value :=aux_counter;
        end;
      1:
        begin
          aux_counter := get_focuspos('X');
          CounterFloatEdit.Value := (360.0 / aux_max) * aux_counter;
        end;
      2:
      end;

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

      // Label5.caption := Label5.caption + ' ' + inttostr(gettickCount() - png)   ;
      Label5.caption := Label5.caption + ' ' +
        Format('%0.3d', [gettickCount() - png]) + ' ' + inttostr(coors.Length);
      // (inbuff());
      if inbuff > 0 then clearbuff(true, false);
      Label5.Font.Color := Cllime;
      if piersid then begin Label3.caption := 'West';
      LabelAR1.Font.Color := Clred;
      LabelDec1.Font.Color := Clred;
      end else begin Label3.caption := 'East';
      LabelAR1.Font.Color := Cllime;
      LabelDec1.Font.Color := Cllime;
      end;
      end

      else begin Label5.Font.Color := Clred;

      Label5.caption := 'DisConnected';
      end;

      datetimetostring(strsideral, 'hh:nn:ss', Local_Sideral_Time(UTCnow(),
        -FloatEditLong.Value) / 24.0);

      datetimetostring(strangle, 'hh:nn:ss', calc_lha(ra));
      Labelmsg.caption := 'Local:' + timetostr(UTCnow() + (gmtoffset / 24.0)) +
        #13#10 + 'GMT: ' + timetostr(UTCnow()) + #13#10 + 'Sid:' + strsideral;
      Label2.caption := floattostr(calc_lha(ra)) + ' ' + floattostr(ra);
      if (Joystickex1.ButtonSt = 16) then CheckBox1.Checked := true;
      if (Joystickex1.ButtonSt = 32) then CheckBox1.Checked := false;
      end;

      procedure TEsp32frm.TrackBar1Change(Sender: TObject);

      begin AlphaBlend := (TrackBar1.position > 0);
      AlphaBlendValue := (255 - TrackBar1.position * 20);
      // self.ScaleBy(trackbar3.Position*100+10,100);
      end;

      procedure TEsp32frm.ReadSettings;
      var inifile:
        TiniFile;
      I:
        Integer;
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
          for I := 0 to 3 do
            focuspos[I] := ReadInteger('Focus', 'focuspos' + inttostr(I),
              (I + 1) * 1000);
          ButtonM1.Hint := Format('%0.5d', [focuspos[0]]);
          ButtonM2.Hint := Format('%0.5d', [focuspos[1]]);
          ButtonM3.Hint := Format('%0.5d', [focuspos[2]]);
          ButtonM4.Hint := Format('%0.5d', [focuspos[3]]);

          for I := 0 to 6 do
            focuspos[I] := ReadInteger('Focus2', 'focuspos' + inttostr(I),
              (I + 1) * 1000);

          Button1f.Hint := Format('%0.5d', [focuspos2[0]]);
          Button2f.Hint := Format('%0.5d', [focuspos2[1]]);
          Button3f.Hint := Format('%0.5d', [focuspos2[2]]);
          Button4f.Hint := Format('%0.5d', [focuspos2[3]]);
          Button5f.Hint := Format('%0.5d', [focuspos2[4]]);
          Button6f.Hint := Format('%0.5d', [focuspos2[5]]);

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
        if (ClientSocket1.Connected) or (ComPortBT_USB.Connected) or
          (checkBtSock) then
        begin

          lines.add(NumberBoxcountaz.Text);
          lines.add(NumberBoxcountalt.Text);
          lines.add(NumberBoxspgaz.Text);
          lines.add(NumberBoxspcaz.Text);
          lines.add(NumberBoxspfaz.Text);
          lines.add(NumberBoxspsaz.Text);
          lines.add(NumberBoxspgalt.Text);
          lines.add(NumberBoxspcalt.Text);
          lines.add(NumberBoxspfalt.Text);
          lines.add(NumberBoxspsalt.Text);
          lines.add(NumberBoxpresc.Text);
          lines.add(NumberBoxlong.Text);
          lines.add(NumberBoxlat.Text);
          lines.add(NumberBoxgmtoff.Text);
          { lines.add(NumberBoxFmax.Text);
            lines.add(NumberBoxFlow.Text);
            lines.add(NumberBoxfsp.Text); }
          lines.add(NumberBoxrampaz.Text);
          lines.add(NumberBoxrampalt.Text);
          lines.add(NumberBoxbackpaz.Text);
          lines.add(NumberBoxbackpalt.Text);
          lines.add(inttostr(ComboBoxEqmode.ItemIndex));
          lines.add(inttostr(ComboBoxtrack.ItemIndex));
          lines.add(CheckBoxflip.Checked.tointeger.ToString);
          lines.add(CheckBoxinvaz.Checked.tointeger.ToString);
          lines.add(CheckBoxinvalt.Checked.tointeger.ToString);
          { lines.add(NBxVolt.Text); }
          lines.add(CheckBoxbackaz.Checked.tointeger.ToString);
          lines.add(CheckBoxbackalt.Checked.tointeger.ToString);
          { lines.add(CheckBoxDCFocus.Checked.tointeger.ToString); }
          // Label17.Text := inttostr(lines.Count);
          Memo1.lines.Clear;
          if lines.Count > config_lines then
          begin
            s := ':cs';
            for I := 0 to config_lines do
              s := s + lines[I] + #13#10;

            s := s + '#';
            s := stringreplace(s, FormatSettings.DecimalSeparator, '.',
              [rfReplaceAll]);
            Memo1.lines.add(s);
            send(s);
          end;
        end;

        lines.Destroy;
      end;

      procedure TEsp32frm.SyncButton3Click(Sender: TObject);
      var
        counter: Integer;
      begin
        // send(':FLS1+00000#');
        counter := round((TargetFloatEdit.Value / 360.0) * aux_max);
        send(':XLS1+' + Format('%.5d', [counter]) + '#');

      end;

      procedure TEsp32frm.WriteSettings;
      var
        inifile: TiniFile;
        I: Integer;
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
          for I := 0 to 3 do
            writeInteger('Focus', 'focuspos' + inttostr(I), focuspos[I]);
          for I := 0 to 5 do
            writeInteger('Focus2', 'focuspos' + inttostr(I), focuspos2[I]);

        end;
      end;

end.
