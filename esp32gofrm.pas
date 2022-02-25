unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, CPort, esp32goi, shared, inifiles,
  EnhEdits, CPortCtl, adpInstanceControl;

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
    Label2: TLabel;
    ButtonH: TButton;
    ButtonPark: TButton;
    LabelFocusCount: TLabel;
    labelAR: TLabel;
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
    procedure ButtonM4Click(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonReconClick(Sender: TObject);
    procedure ButtonM3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Esp32frm: TEsp32frm;
  telescope: Ttelescope;
  s_inipath: string;
  inifile_name: string;
  Serialport: string;

implementation

{$R *.dfm}

procedure TEsp32frm.ButtonSaveClick(Sender: TObject);
begin
  WriteSettings;
end;

procedure TEsp32frm.ButtonReconClick(Sender: TObject);
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
end;

procedure TEsp32frm.ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case TButton(Sender).tag of
    0:
      telescope.CommandBlind(':F+#', true);
    1:
      telescope.CommandBlind(':F-#', true);
  end;
end;

procedure TEsp32frm.ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  send(':FQ#');
end;

procedure TEsp32frm.ButtonM1Click(Sender: TObject);
begin
  telescope.CommandBlind(':FA-00300#', true);
end;

procedure TEsp32frm.ButtonM2Click(Sender: TObject);
begin
  telescope.CommandBlind(':FLS1+00900#', true);
end;

procedure TEsp32frm.ButtonM3Click(Sender: TObject);
var
focus,count:integer;
begin
count:=7;
  labelar.Caption:=get_coordstpc(focus,count) ;
    LabelFocusCount.caption := Format('%0.5d', [focus]);
   label2.Caption:= inttostr(count);
end;

procedure TEsp32frm.ButtonM4Click(Sender: TObject);
begin
  GroupBoxserial.Visible := not GroupBoxserial.Visible
end;

procedure TEsp32frm.Button_NMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case RadioGroup1.ItemIndex of
    0:
     Command_Blind('#:RS#', true);
    1:
      Command_Blind('#:RM#', true);
    2:
      Command_Blind('#:RC#', true);
    3:
      Command_Blind('#:RG#', true);
  end;

  case TButton(Sender).tag of
    0:
      Command_Blind('#:Mn#', true);
    1:
      Command_Blind('#:Ms#', true);
    2:
      Command_Blind('#:Me#', true);
    3:
      Command_Blind('#:Mw#', true);
    4:
     Command_Blind('#:Mn#:Me#', true);
    5:
      Command_Blind('#:Ms#:Me#', true);
    6:
      Command_Blind('#:Ms#:Mw#', true);
    7:
      Command_Blind('#:Mn#:Mw#', true);

  end;

end;

procedure TEsp32frm.Button_NMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case TButton(Sender).tag of
    0:
      Command_Blind('#:Qn#', true);
    1:
      Command_Blind('#:Qs#', true);
    2:
      Command_Blind('#:Qe#', true);
    3:
      Command_Blind('#:Qw#', true);
    4, 5, 6, 7:
      Command_Blind('#:Qn#:Qw#', true);
  end;

end;

procedure TEsp32frm.FormCreate(Sender: TObject);
begin
  serial:=(true);
  s_inipath := ExtractFilePath(Application.EXEName);
  inifile_name := 'esp32go.ini';
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
  ReadSettings;
   serial:=(true);
  ComPortBT_USB.Port := ComComboBox1.Text; // 'COM13';//serialport;
  ComPortBT_USB.baudrate := tbaudrate(ComComboBox2.ItemIndex);;
  ComComboBox1.ComPort := ComPortBT_USB;
  ComPortBT_USB.Connected := true;
  telescope := Ttelescope.Create();
  telescope.Set_Connected(true);

  if comportbt_usb.Connected then
  begin

    fullconnect:= check_connection();
    Timer1.Enabled :=true;
  end;
    // fullconnect:=true;
    // Timer1.Enabled :=true;
end;

procedure TEsp32frm.Timer1Timer(Sender: TObject);
var
  str: string;
  focus,count: Integer;

begin
    labelar.Caption:=get_coords(focus,count) ;
    LabelFocusCount.caption := Format('%0.5d', [focus]);
   label2.Caption:= inttostr(count);
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
  end;
end;

end.
