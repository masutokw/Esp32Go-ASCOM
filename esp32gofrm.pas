unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, CPort, esp32goi, shared, inifiles,
  EnhEdits, CPortCtl, adpInstanceControl, System.Win.ScktComp, serial,
  Joystickex;

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
    procedure Joystickex1Button1_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
    procedure Joystickex1Button2_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
    procedure Joystickex1Button3_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
    procedure Joystickex1Button4_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
    procedure Joystickex1Button5_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
    procedure Joystickex1Button6_Change(Sender: TObject; pressed: Boolean; Xpos,
      YPos: Integer);
   




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
    joyxstatus,  joyystatus  :integer;
     lastpress, errorcount1: Cardinal;
implementation

{$R *.dfm}

procedure TEsp32frm.ButtonSaveClick(Sender: TObject);
begin
  WriteSettings;
end;

procedure TEsp32frm.ButtonReconClick(Sender: TObject);
begin
  if imode = 0 then
  begin
    ComPortBT_USB.Connected := false;
    ComPortBT_USB.Port := ComComboBox1.Text; // 'COM13';//serialport;
    ComPortBT_USB.baudrate := tbaudrate(ComComboBox2.ItemIndex);;
    ComComboBox1.ComPort := ComPortBT_USB;
    ComPortBT_USB.Connected := true;
    if ComPortBT_USB.Connected then
    begin

      fullconnect := check_connection();
      Timer1.Enabled := fullconnect;
    end;
  end
  else
  begin
    if ClientSocket1.active then
      ClientSocket1.active := false;

    sleep(1000);
    ClientSocket1.Host := EditAddr.Text;
    ClientSocket1.Port := LongEditPort.Value;
    ClientSocket1.active := true;

  end;
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

procedure TEsp32frm.ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case TButton(Sender).tag of
    0:
      send(':F+#');
    1:
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
  joystickex1.EnableJoyStick;
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
    { repeat
      sleep(50);
      inc(n);
      until  ClientSocket1.active or (n=100);
      ClientSocket1.active:=n<100; }
  end;

  { if not(ClientSocket1.active) or ComPortBT_USB.Connected then
    begin

    fullconnect := true;//check_connection();
    Timer1.Enabled := true;
    end; }
  fullconnect := true;
  Timer1.Enabled := true;
end;

procedure TEsp32frm.FormDestroy(Sender: TObject);
begin
  if ClientSocket1.active = true then
    ClientSocket1.active := false;
  if ComPortBT_USB.Connected then
    ComPortBT_USB.Connected := false;

end;





procedure TEsp32frm.Joystickex1Button1_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);
begin
  if pressed then

    if CheckBoxJoyF.Checked then
    begin
      CheckBox2.Checked := NOT CheckBox2.Checked;
      //Tele.FocusSeleclSpeed := CheckBox5.Checked

    end
    else if CheckBoxJoyF.Checked then
     send(':FQ#')

    else
     RadioGroup1.ItemIndex:=3;

end;

procedure TEsp32frm.Joystickex1Button2_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);

begin
  if CheckBoxJoyF.Checked then
  begin
    if pressed then
       send(':F+#')

    else
      send(':FQ#');
  end
  else
   RadioGroup1.ItemIndex:=2;

end;

procedure TEsp32frm.Joystickex1Button3_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);
begin
  if CheckBoxJoyF.Checked then
  begin
    if pressed then
      send(':F-#')
         else
     send(':FQ#');
   end
  else
  RadioGroup1.ItemIndex:=1;
  end;


procedure TEsp32frm.Joystickex1Button4_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);
begin
  if pressed then
    lastpress := gettickCount
  else if gettickCount - lastpress > 1000 then
    CheckBoxJoyF.Checked := NOT CheckBoxJoyF.Checked
  else
   RadioGroup1.ItemIndex:=0;
end;

procedure TEsp32frm.Joystickex1Button5_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);
begin
    RadioGroup1.ItemIndex:=1;
end;

procedure TEsp32frm.Joystickex1Button6_Change(Sender: TObject; pressed: Boolean;
  Xpos, YPos: Integer);
begin
    RadioGroup1.ItemIndex:=1;
end;

procedure TEsp32frm.Joystickex1JoyMove(Sender: TObject; XPos, YPos: Integer;
  ButtonStatus: Word; IsCalibrating: Boolean);
var
   n: Integer;
  xyreleased: boolean;
begin

  xyreleased := (Xpos = 1) and (YPos = 1);
  label2.caption:=inttostr(xpos)+' '+inttostr(Ypos);
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
    if (joyxstatus <> Xpos) then
    begin

      case Xpos of
        0:send('#:Me#');

        1:  send('#:Qw#');

        2:
          send('#:Mw#');
      end;

    end;
    if (joyystatus <> YPos) then
    begin
      case YPos of
        0: send('#:Mn#');

        1:
         send('#:Qn#');
        2:
          send('#:Ms#');
      end;

    end;
  end;

  if xyreleased then
    send('#:Qn#:Qw#');

  joyxstatus := Xpos;
  joyystatus := YPos;

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
    labelAR.Caption := get_coords(focus, count);
    LabelFocusCount.Caption := Format('%0.5d', [focus]);
    if imode = 1 then
      Label5.Caption := 'TCP'
    else
      Label5.Caption := 'BT/USB';
    Label5.Caption := Label5.Caption + ' ' + inttostr(count);
    Label5.Font.Color := cllime;
  end

  else
  begin
    Label5.Font.Color := clred;

    Label5.Caption := 'DisConnected';
  end;
   { if (Joystickex1.ButtonSt = 16) then
        checkboxtrack.Checked := TRUE;
      if (Joystickex1.ButtonSt = 32) then
        checkboxtrack.Checked := FALSE;}
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
  end;
end;

end.
