unit esp32gofrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, CPort,esp32goi,shared,inifiles,
  EnhEdits;

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
    procedure FormCreate(Sender: TObject);
    procedure Button_NMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button_NMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ReadSettings;
    procedure ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Esp32frm: TEsp32frm;
  telescope:Ttelescope;
   s_inipath: string;
  inifile_name:string;
  Serialport:string;
implementation

{$R *.dfm}

procedure TEsp32frm.Button5Click(Sender: TObject);
var n:integer ;
str:string;

begin
 //comport2.ClearBuffer(true,false);
 //gosleepp(50);
  comport2.WriteStr(':GR#');
while (comport2.InputCount< 12) and (n<100)  do
begin
  sleep(5);
  inc(n);
  // Application.ProcessMessages;
 end;


   label2.caption:=inttostr(comport2.InputCount)+'   '+inttostr(n);
  // comport2.ReadStr(str,12)   ;
  //  label2.caption:=inttostr(comport2.InputCount);
 If  comport2.ReadStr(str,12)=12 then begin
  labelAR.Caption:=str;
  // n:=LX200artoint(str,true);
  // label2.Caption:=inttostr( n div (15*3600))

end;
end;

procedure TEsp32frm.Button6Click(Sender: TObject);
var n:integer ;
str:string;
begin
 //comport2.ClearBuffer(true,false);
 //gosleepp(50);
  comport2.WriteStr(':GD#');
while (comport2.InputCount< 10) and (n<100)  do
begin
  sleep(5);
  inc(n);
  // Application.ProcessMessages;
 end;



  // comport2.ReadStr(str,12)   ;
  //  label2.caption:=inttostr(comport2.InputCount);
 If  comport2.ReadStr(str,10)=10 then begin

  // n:=LX200artoint(str,true);
  // label2.Caption:=inttostr( n div (15*3600))

end;
end;

procedure TEsp32frm.Button7Click(Sender: TObject);
begin
 {comport2.WriteStr(':Sr' + DoubleToLXAr(18, 1));
   comport2.WriteStr(':Sd' + DoubletoLXdec(12, 1));
   comport2.WriteStr(':MS#');}
   comport2.WriteStr('#:Mgn9000#')
end;

procedure TEsp32frm.ButtonInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 case TButton(Sender).tag  of
  0:telescope.CommandBlind(':F+#',TRUE);
  1:telescope.CommandBlind(':F-#',TRUE);
 end;
end;

procedure TEsp32frm.ButtonInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  comport2.writestr(':FQ#');
end;

procedure TEsp32frm.Button_NMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var str:string;
begin


case radiogroup1.ItemIndex of
0:telescope.CommandBlind('#:RS#',TRUE);
1:telescope.CommandBlind('#:RM#',TRUE);
2:telescope.CommandBlind('#:RC#',TRUE);
3:telescope.CommandBlind('#:RG#',TRUE);
end;

  case TButton(Sender).tag  of
  0:telescope.CommandBlind('#:Mn#',TRUE);
  1:telescope.CommandBlind('#:Ms#',TRUE);
  2:telescope.CommandBlind('#:Me#',TRUE);
  3:telescope.CommandBlind('#:Mw#',TRUE);
  4:telescope.CommandBlind('#:Mn#:Me#',TRUE);
  5:telescope.CommandBlind('#:Ms#:Me#',TRUE);
  6:telescope.CommandBlind('#:Ms#:Mw#',TRUE);
  7:telescope.CommandBlind('#:Mn#:Mw#',TRUE);

   end;
   comport2.WriteStr(':RS#');


;
end;



procedure TEsp32frm.Button_NMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var str:string;
 n:integer;
 begin


  case TButton(Sender).tag  of
  0:telescope.CommandBlind('#:Qn#',TRUE);
  1:telescope.CommandBlind('#:Qs#',TRUE);
  2:telescope.CommandBlind('#:Qe#',TRUE);
  3:telescope.CommandBlind('#:Qw#',TRUE);
  4,5,6,7:telescope.CommandBlind('#:Qn#:Qw#',TRUE);
   end;


end;

procedure TEsp32frm.FormCreate(Sender: TObject);
begin
 s_inipath := ExtractFilePath(Application.EXEName);
 inifile_name:='esp32go.ini' ;
 SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
 readSettings;

ComPort2 := TComPort.Create(nil);
comport2.Port:='COM13';//serialport;
 telescope:=Ttelescope.Create();
 telescope.Set_Connected(true);
 timer1.Enabled:=true;
 //label1.Caption:=s_inipath + inifile_name;

end;

procedure TEsp32frm.Timer1Timer(Sender: TObject);
 var str:string;
   n:integer;
begin
 comport2.ClearBuffer(true,false);
 comport2.WriteStr('#:GR#:GD#');

while (comport2.InputCount< 19) and (n<100)  do
begin
  sleep(5);
  inc(n);
  end;
  label2.caption:=inttostr(comport2.InputCount)+'   '+inttostr(n);


 if  comport2.ReadStr(str,19)>=19 then
 begin

   str:=StringReplace(Str, '#',#10#13+'DE:', [ rfIgnoreCase]);
    str:=StringReplace(Str, '#','', [ rfIgnoreCase]);
  labelAr.Caption:='RA:'+StringReplace(Str, 'á', 'º', [rfReplaceAll, rfIgnoreCase]);
  end;
  n:=0;
 if(comport2.InputCount)>0 then comport2.ClearBuffer(true,false);
   comport2.WriteStr(':Fp#');
   while (comport2.InputCount< 7) and (n<100)  do
begin
  sleep(5);
  inc(n);
  end;
  if  comport2.ReadStr(str,7)>=7 then
 begin
  str:=StringReplace(Str,':', '', [rfReplaceAll, rfIgnoreCase]);

  labelfocuscount.Caption:=StringReplace(Str,'#', '', [rfReplaceAll, rfIgnoreCase]);
  end;

end;
 procedure TEsp32frm.ReadSettings;
var
  inifile: TiniFile;
  temp:integer;
begin
  inifile := TiniFile.create(s_inipath + inifile_name);
  with inifile do
  begin
     serialport:=ReadString('Serial_Port', 'Port', 'com14');
  end;
  end;
end.
