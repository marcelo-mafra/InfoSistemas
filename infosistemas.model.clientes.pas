unit infosistemas.model.clientes;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  infosistemas.business.mail, infosistemas.system.winshell;

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
    procedure CdsClientesAfterPost(DataSet: TDataSet);
    procedure CdsClientesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FSendMessage: boolean;

  public
    { Public declarations }
  end;

var
  DMClientes: TDMClientes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses infosistemas.business.clientes;

{$R *.dfm}

procedure TDMClientes.CdsClientesAfterPost(DataSet: TDataSet);
var
 Mailer: TMailUtils;
 aCustomerData: TStringList;
begin
//Somente envia email quando os dados do cliente são inseridos.
 if not FSendMessage then
  Exit;

  //to-do: alterar para trabalhar apenas de forma assíncrona. Esse processo deveria
  //apenas registrar que um cliente foi inserido. Outro processo, de forma
  //assíncrona, deveria se encarregar do envio do email.
 Mailer := TMailUtils.Create(TShellFolders.GetCommonAppDataFolder + '\');
 aCustomerData := TStringList.Create;

 try
   aCustomerData.NameValueSeparator := '=';
   aCustomerData.AddPair('CPF', Dataset.FindField('CPF').AsString);
   aCustomerData.AddPair('Identidade', Dataset.FindField('IDENTIDADE').AsString);
   aCustomerData.AddPair('Nome', Dataset.FindField('NOME').AsString);
   aCustomerData.AddPair('Telefone', Dataset.FindField('TELEFONE').AsString);
   aCustomerData.AddPair('Email', Dataset.FindField('MAIL').AsString);
   aCustomerData.AddPair('CEP', Dataset.FindField('CEP').AsString);
   aCustomerData.AddPair('Logradouro', Dataset.FindField('LOGRADOURO').AsString);
   aCustomerData.AddPair('Numero', Dataset.FindField('NUMERO').AsString);
   aCustomerData.AddPair('Bairro', Dataset.FindField('BAIRRO').AsString);
   aCustomerData.AddPair('Cidade', Dataset.FindField('CIDADE').AsString);
   aCustomerData.AddPair('UF', Dataset.FindField('UF').AsString);
   aCustomerData.AddPair('Pais', Dataset.FindField('PAIS').AsString);
   if not Dataset.FindField('COMPLEMENTO').IsNull then
      aCustomerData.AddPair('Complemento', Dataset.FindField('COMPLEMENTO').AsString)
   else
       aCustomerData.AddPair('Complemento', '');

   Mailer.SendMail(aCustomerData.Text, ACustomerData.Values['Email']);

 finally
   if Assigned(aCustomerData) then
     FreeAndNil(aCustomerData);

   if Assigned(Mailer) then
     FreeAndNil(Mailer);
 end;

end;

procedure TDMClientes.CdsClientesBeforePost(DataSet: TDataSet);
begin
//Indica que o envio de email será feito apenas para clientes novos.
 FSendMessage := Dataset.State = dsInsert;
end;

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
