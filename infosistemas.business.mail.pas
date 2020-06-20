unit infosistemas.business.mail;

interface

uses
  System.Classes, System.SysUtils, infosistemas.model.exceptions,
  infosistemas.view.messages, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdGlobalProtocols,
  IdAttachmentFile, IdExplicitTLSClientServerBase, XML.XMLDoc, XML.XMLIntf;

type

  TMailUtils = class(TObject)
  private
    FHost, FUserName, FPassword, FSenderAccount, FSenderName: string;
    FSubject, FAttachmentsFolder: string;
    FPort: integer;

    function CreateAttachmentFile(CustomerData: string): string;
    procedure LoadConfigurations;

  public
    constructor Create(const AttachmentsFolder: string); reintroduce;
    destructor Destroy; override;

    procedure SendMail(const MailData, Email: string);

    property Host: string read FHost;
    property Port: integer read FPort;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property SenderAccount: string read FSenderAccount;
    property SenderName: string read FSenderName;
    property Subject: string read FSubject;
  end;



implementation

{ TMailUtils }

constructor TMailUtils.Create(const AttachmentsFolder: string);
begin
 self.FAttachmentsFolder := AttachmentsFolder;
 inherited Create;

end;

function TMailUtils.CreateAttachmentFile(CustomerData: string): string;
var
 aList: TStringList;
 aFileName: string;
 XMLDocument: TXMLDocument;
 NodeCustomer, NodeData: IXMLNode;

begin
//Cria um arquivo XML com os dados a serem enviados em anexo ao cliente.
 Result := '';
 aList := TStringList.Create;
 XMLDocument := TXMLDocument.Create(nil);

 aList.Text := CustomerData;

  try
    XMLDocument.Active := True;
    NodeCustomer := XMLDocument.AddChild('Cliente');
    NodeData := NodeCustomer.AddChild('Dados');
    NodeData.ChildValues['CPF'] := aList.Values['CPF'];
    NodeData.ChildValues['Identidade'] := aList.Values['Identidade'];
    NodeData.ChildValues['Nome'] := aList.Values['Nome'];
    NodeData.ChildValues['Telefone'] := aList.Values['Telefone'];
    NodeData.ChildValues['Email'] := aList.Values['Email'];
    NodeData.ChildValues['CEP'] := aList.Values['CEP'];
    NodeData.ChildValues['Logradouro'] := aList.Values['Logradouro'];
    NodeData.ChildValues['Numero'] := aList.Values['Numero'];
    NodeData.ChildValues['Bairro'] := aList.Values['Bairro'];
    NodeData.ChildValues['Cidade'] := aList.Values['Cidade'];
    NodeData.ChildValues['UF'] := aList.Values['UF'];
    NodeData.ChildValues['PAIS'] := aList.Values['PAIS'];
    NodeData.ChildValues['Complemento'] := aList.Values['Complemento'];

    if System.SysUtils.DirectoryExists(self.FAttachmentsFolder) then
     begin
      aFileName := self.FAttachmentsFolder + aList.Values['CPF'] + '.xml';
      XMLDocument.SaveToFile(aFileName);
      Result := aFileName;
     end;

  finally
    FreeAndNil(aList);
    XMLDocument.Free;
  end;
end;

destructor TMailUtils.Destroy;
begin
  inherited Destroy;
end;

procedure TMailUtils.LoadConfigurations;
begin
//Carrega as configurações necessária para o envio de emails.
//to-do: carregar isso a partir de um repositório externo: arquivo, registry etc.
 FHost := 'smtp.gmail.com';
 FPort := 465;
 FuserName := 'EmailDeEnvio@gmail.com';
 FPassword := 'Senha do e-mail';
 FSenderAccount := 'EmailDeEnvio@gmail.com';
 FSenderName := 'Nome do remetente';
 FSubject :=  'Assunto no envio de e-mail';
end;

procedure TMailUtils.SendMail(const MailData, Email: string);
var
  lSSL: TIdSSLIOHandlerSocketOpenSSL;
  lSMTP: TIdSMTP;
  lMessage: TIdMessage;
  lText: TIdText;
 // lAnexoFile: TIdAttachmentFile;
  lAnexo: string;
begin
 //Envia um email para um cliente com os seus dados cadastrados.
  if Email.Trim = '' then
   raise EInvalidMailInfo.Create(TMessagesConst.InvalidHostMail);

  if MailData.Trim = '' then
   raise EInvalidMailInfo.Create(TMessagesConst.InvalidMailData);


  lSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    self.LoadConfigurations;
    lSMTP := TIdSMTP.Create(nil);
    lMessage := TIdMessage.Create(nil);

      try
        lSSL.SSLOptions.Method := sslvSSLv23;
        lSSL.SSLOptions.Mode := sslmClient;
        lSMTP.IOHandler := lSSL;
        lSMTP.AuthType := satDefault;
        lSMTP.UseTLS := utUseImplicitTLS;
        lSMTP.Host := self.Host;
        lSMTP.Port := self.FPort;
        lSMTP.Username := self.UserName;
        lSMTP.Password := self.Password;
        lMessage.From.Address := self.SenderAccount;
        lMessage.From.Name := self.SenderName;
        lMessage.ReplyTo.EMailAddresses := lMessage.From.Address;
        lMessage.Recipients.Add.Text := Email;

        //to-do: implementar na classe a capacidade de múltiplos destinatários.
        {lMessage.Recipients.Add.Text := 'QuemIraReceber02@email.com';
        lMessage.Recipients.Add.Text := 'QuemIraReceber03@email.com';}
        lMessage.Subject := self.Subject;
        lMessage.Encoding := meMIME;
        lMessage.ContentType := 'multipart/mixed';

        lText := TIdText.Create(lMessage.MessageParts);
        lText.ContentType := 'text/plain; charset=iso-8859-1';
        lText.Body.Add('Seguem os seus dados cadastrais:');
        lText.Body.Add(MailData);

        lAnexo := CreateAttachmentFile(MailData);

        if FileExists(lAnexo) then
         begin
          //lMessage.ContentType := GetMIMETypeFromFile(lAnexo);
          //lAnexoFile :=  TIdAttachmentFile.Create(lMessage.MessageParts, lAnexo);
          //lAnexoFile.ContentType := GetMIMETypeFromFile(lAnexo) ;
          //TIdAttachmentFile.Create(lMessage.MessageParts, lAnexo);
         end;

        try
          //to-do: para testar, descomentar as próximas linhas e usar parâmetros reais.
          //lSMTP.Connect;
          //lSMTP.Authenticate;
          //lSMTP.Send(lMessage);

        except
          on E:Exception do
          begin
            Exit;
          end;
        end;


      finally
        lSMTP.Free;
        lMessage.Free;
      end;

  finally
    lSSL.Free;
    UnLoadOpenSSLLibrary;
  end;
end;

end.
