program esp32go;

uses
  Vcl.Forms,
  esp32gofrm in 'esp32gofrm.pas' {Esp32frm},
  Esp32go_TLB in 'Esp32go_TLB.pas',
  Esp32goi in 'Esp32goi.pas' {Telescope: CoClass},
  Vcl.Themes,
  Vcl.Styles,
  shared in 'shared.pas',
  Esp32gofi in 'Esp32gofi.pas',
  bluetools in 'bluetools.pas',
  tcptools in 'tcptools.pas',
  Serialtools in 'Serialtools.pas',
  LXUtils in 'LXUtils.pas',
  globalvar in 'globalvar.pas',
  Esp32goRi in 'Esp32goRi.pas',
  FilterWheeli in 'FilterWheeli.pas',
    ComServ,
  ComObj,
  windows;

{$R *.TLB}

{$R *.res}

begin


     //ShowMessage('Self-Registering: ASCOM ' + DRIVER_ID);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cobalt XEMedia');
  Application.CreateForm(TEsp32frm, Esp32frm);
  Application.Run;


end.
