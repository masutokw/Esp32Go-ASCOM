unit conFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPortCtl,shared;

type
  TCnfrm = class(TForm)
    ComComboBox1: TComComboBox;
    ComComboBox2: TComComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cnfrm: TCnfrm;

implementation

{$R *.dfm}

procedure TCnfrm.FormCreate(Sender: TObject);
begin
   comcombobox1.ComPort:=comport2;

end;

end.
