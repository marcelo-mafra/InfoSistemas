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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMClientes: TDMClientes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
