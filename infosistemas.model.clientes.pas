unit infosistemas.model.clientes;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDMClientes = class(TDataModule)
    CdsClientes: TClientDataSet;
    DsrClientes: TDataSource;
    CdsClientesCPF: TStringField;
    CdsClientesNOME: TStringField;
    CdsClientesIDENTIDADE: TStringField;
    CdsClientesTELEFONE: TStringField;
    CdsClientesMAIL: TStringField;
    CdsClientesCEP: TStringField;
    CdsClientesLOGRADOURO: TStringField;
    CdsClientesNUMERO: TSmallintField;
    CdsClientesCOMPLEMENTO: TStringField;
    CdsClientesBAIRRO: TStringField;
    CdsClientesCIDADE: TStringField;
    CdsClientesUF: TStringField;
    CdsClientesPAIS: TStringField;
    procedure CdsClientesCPFValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMClientes: TDMClientes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses infosistemas.business.clientes;

{$R *.dfm}

procedure TDMClientes.CdsClientesCPFValidate(Sender: TField);
var
 aCliente: TClientesUtils;
begin
  aCliente :=  TClientesUtils.Create;

  try
   if not aCliente.ValidateCPF(Sender.AsString) then
    begin
     Sender.FocusControl;
    end;

  finally
   if Assigned(aCliente) then
    FreeAndNil(aCliente);
  end;
end;

end.
