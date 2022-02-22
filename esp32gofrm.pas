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
    Button1: TButton;
    Button2: TButton;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TEsp32frm.Button1Click(Sender: TObject);
begin
  WriteSettings;
end;

procedure TEsp32frm.Button2Click(Sender: TObject);
begin
comport2.Connected:=false;
 comport2.Port := ComComboBox1.Text; // 'COM13';//serialport;
  comport2.baudrate := tbaudrate(ComComboBox2.ItemIndex);;
  ComComboBox1.ComPort := comport2;
  comport2.Connected:=true;
 if comport2.Connected then
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
      telescope.CommandBlind(':F+#', TRUE);
    1:
      telescope.CommandBlind(':F-#', TRUE);
  end;
end;

procedure TEsp32frm.ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  comport2.WriteStr(':FQ#');
end;

procedure TEsp32frm.ButtonM1Click(Sender: TObject);
begin
  telescope.CommandBlind(':FA-00300#', TRUE);
end;

procedure TEsp32frm.ButtonM2Click(Sender: TObject);
begin
  telescope.CommandBlind(':FLS1+00900#', TRUE);
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
      telescope.CommandBlind('#:RS#', TRUE);
    1:
      telescope.CommandBlind('#:RM#', TRUE);
    2:
      telescope.CommandBlind('#:RC#', TRUE);
    3:
      telescope.CommandBlind('#:RG#', TRUE);
  end;

  case TButton(Sender).tag of
    0:
      telescope.CommandBlind('#:Mn#', TRUE);
    1:
      telescope.CommandBlind('#:Ms#', TRUE);
    2:
      telescope.CommandBlind('#:Me#', TRUE);
    3:
      telescope.CommandBlind('#:Mw#', TRUE);
    4:
      telescope.CommandBlind('#:Mn#:Me#', TRUE);
    5:
      telescope.CommandBlind('#:Ms#:Me#', TRUE);
    6:
      telescope.CommandBlind('#:Ms#:Mw#', TRUE);
    7:
      telescope.CommandBlind('#:Mn#:Mw#', TRUE);

  end;
  comport2.WriteStr(':RS#');

  ;
end;

procedure TEsp32frm.Button_NMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  case TButton(Sender).tag of
    0:
      telescope.CommandBlind('#:Qn#', TRUE);
    1:
      telescope.CommandBlind('#:Qs#', TRUE);
    2:
      telescope.CommandBlind('#:Qe#', TRUE);
    3:
      telescope.CommandBlind('#:Qw#', TRUE);
    4, 5, 6, 7:
      telescope.CommandBlind('#:Qn#:Qw#', TRUE);
  end;

end;

procedure TEsp32frm.FormCreate(Sender: TObject);
begin
  s_inipath := ExtractFilePath(Application.EXEName);
  inifile_name := 'esp32go.ini';
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
  ReadSettings;
  comport2 := TComPort.Create(nil);
  comport2.Port := ComComboBox1.Text; // 'COM13';//serialport;
  comport2.baudrate := tbaudrate(ComComboBox2.ItemIndex);;
  ComComboBox1.ComPort := comport2;
  telescope := Ttelescope.Create();
  telescope.Set_Connected(TRUE);

  if comport2.Connected then
  begin

    fullconnect := check_connection();
    Timer1.Enabled := fullconnect;
  end;

end;

procedure TEsp32frm.Timer1Timer(Sender: TObject);
var
  str: string;
  n: Integer;
begin
  comport2.ClearBuffer(TRUE, false);
  comport2.WriteStr('#:GR#:GD#');
  n := 0;
  while (comport2.InputCount < coor_pack) and (n < 100) do
  begin
    sleep(5);
    inc(n);
  end;
  Label2.caption := inttostr(comport2.InputCount) + '   ' + inttostr(n);

  if comport2.ReadStr(str, coor_pack) >= coor_pack then
  begin

    str := StringReplace(str, '#', #10#13 + 'DE:', [rfIgnoreCase]);
    str := StringReplace(str, '#', '', [rfIgnoreCase]);
    labelAR.caption := 'RA:' + StringReplace(str, 'á', 'º',
      [rfReplaceAll, rfIgnoreCase]);
  end;
  n := 0;
  if (comport2.InputCount) > 0 then
    comport2.ClearBuffer(TRUE, false);
  comport2.WriteStr(':Fp#');
  while (comport2.InputCount < 6) and (n < 100) do
  begin
    sleep(5);
    inc(n);
  end;
  if comport2.ReadStr(str, 6) >= 6 then
  begin
    str := StringReplace(str, '#', '', [rfReplaceAll]);
    n := StrToIntDef(str, 0);

    // LabelFocusCount.caption := StringReplace(str, '#', '',[rfReplaceAll]);
    LabelFocusCount.caption := Format('%0.5d', [n]);
  end;

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
  end;
end;

end.
