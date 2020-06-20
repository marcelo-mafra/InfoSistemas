unit infosistemas.view.clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, infosistemas.business.address,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 aAddress: TAddressUtils;
begin
 aAddress := TAddressUtils.Create;

 try
   if aAddress.BuscaDadosCep(Edit1.Text) then
    Edit1.Text := aAddress.Logradouro;

 finally
   if Assigned(aAddress) then
     FreeAndNil(aAddress);
 end;
end;

end.
