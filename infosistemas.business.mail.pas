unit infosistemas.business.mail;

interface

uses
  System.Classes, System.SysUtils, infosistemas.model.exceptions,
  infosistemas.view.messages, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdGlobalProtocols,
  IdAttachmentFile, IdExplicitTLSClientServerBase, XML.XMLDoc, XML.XMLIntf,
  infosistemas.system.winshell;

type

  TMailSender = class(TObject)
  private
    FHost, FUserName, FPassword, FSenderAccount, FSenderName: string;
    FSubject, FAttachmentsFolder: string;
    FPort: integer;

    procedure LoadConfigurations;

  public
    constructor Create(const AttachmentsFolder: string); reintroduce;
    destructor Destroy; override;
    procedure SendMail(const MailData, Email, AttachmentFile: string);

    property Host: string read FHost;
    property Port: integer read FPort;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property SenderAccount: string read FSenderAccount;
    property SenderName: string read FSenderName;
    property Subject: string read FSubject;
  end;

  {Class helper para métodos que extendem a classe TMailSender, que deve permanecer
   focada apenas no envio de mensagens.}
  TMailHelper = class helper for TMailSender
    function CreateAttachmentFile(CustomerData: string): string;
    function IsValidMail(const MailAddress: string): boolean;
  end;


implementation

{ TMailSender }

constructor TMailSender.Create(const AttachmentsFolder: string);
begin
 self.FAttachmentsFolder := AttachmentsFolder;
 inherited Create;

end;

destructor TMailSender.Destroy;
begin
  inherited Destroy;
end;

procedure TMailSender.LoadConfigurations;
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

procedure TMailSender.SendMail(const MailData, Email, AttachmentFile: string);
var
  lSSL: TIdSSLIOHandlerSocketOpenSSL;
  lSMTP: TIdSMTP;
  lMessage: TIdMessage;
  lText: TIdText;
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
        lMessage.ContentType := 'multipart/mixed';  //do not localize!

        lText := TIdText.Create(lMessage.MessageParts);
        lText.ContentType := 'text/plain; charset=iso-8859-1';
        lText.Body.Add('Seguem os seus dados cadastrais:');
        lText.Body.Add(MailData);

        //Anexa o arquivo XML gerado no email que será enviado.

        {ATENÇÃO: esse trecho está dando crash no método "GetMIMETypeFromFile",
                  que faz parte do código do INDY. Pesquisando na WEB vi queo
                  problema não ocorria no INDY9 e foi inserido no INDY10. Não
                  foi possível estudar e resolver o problema. }
        if FileExists(AttachmentFile) then
         begin
          //lMessage.ContentType := GetMIMETypeFromFile(AttachmentFile);
          //TIdAttachmentFile.Create(lMessage.MessageParts, AttachmentFile);
         end;

        try
          //to-do: para testar, descomentar as próximas linhas e usar parâmetros reais.
          //lSMTP.Connect;
          //lSMTP.Authenticate;
          //lSMTP.Send(lMessage);

        except
         begin
           //to-do: mapear nos métodos "Connect", "Authenticate" e "Send" os
           //       exceptions que podem ocorrer e tratar aqui.
           {on E: Exception1 do
            begin

            end;
           on E: Exception2 do
            begin

            end;}
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

{ TMailHelper }

function TMailHelper.CreateAttachmentFile(CustomerData: string): string;
var
 aList: TStringList;
 aFileName: string;
 XMLDocument: TXMLDocument;
 NodeCustomer, NodeData: IXMLNode;
begin
//Cria um arquivo XML com os dados a serem enviados ao cliente.
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

    if TShellFolders.FolderExists(self.FAttachmentsFolder) then
     begin
      aFileName := self.FAttachmentsFolder + aList.Values['CPF'] + '.xml';
      XMLDocument.SaveToFile(aFileName);
      Result := aFileName;
     end;

  finally
    if Assigned(aList) then FreeAndNil(aList);
    if Assigned(XMLDocument) then
     begin
      XMLDocument.Active := False;
      //FreeAndNil(XMLDocument);
     end;
  end;
end;

function TMailHelper.IsValidMail(const MailAddress: string): boolean;
begin
//Valida de forma simples a estrutura do endereço de caixa de email.

 // Caracteres inválidos não existem em MailAddress.
  Result := (MailAddress.Trim <> '') and not (MailAddress.Contains(' ')) and not
    (LowerCase(MailAddress).Contains('ä')) and not (LowerCase(MailAddress).Contains('ö')) and not
    (LowerCase(MailAddress).Contains('ü')) and not (LowerCase(MailAddress).Contains('ß')) and not
    (LowerCase(MailAddress).Contains('[')) and not (LowerCase(MailAddress).Contains(']')) and not
    (LowerCase(MailAddress).Contains('(')) and not (LowerCase(MailAddress).Contains(')')) and not
    (LowerCase(MailAddress).Contains(':')) and not (LowerCase(MailAddress).Contains('ç'));

  if not Result then Exit;

  // @ existe em MailAddress e está em uma "posição" válida.
  Result := (MailAddress.Contains('@')) and not (MailAddress.StartsWith('@'))
             and not (MailAddress.EndsWith('@'));

  if not Result then Exit;

  //"." (ponto) existe em MailAddress e está em uma "posição" válida.
  Result := (MailAddress.Contains('.')) and not (MailAddress.StartsWith('.'))
             and not (MailAddress.EndsWith('.'));
end;

end.
