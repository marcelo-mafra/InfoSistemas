unit infosistemas.view.messages;

interface

uses
 WinAPI.Windows;

type
  //Mensagens exibidas na aplica��o.
  TMessagesConst = class
    const
     ClientNotFound = 'N�o foi encontrado um cliente com este CPF!';
     InvalidHostMail = 'A caixa de destino da mensagem n�o pode ser vazia!';
     InvalidMailData = 'Os dados do cliente n�o foram recebido para serem enviados ' +
        'na mensagem de email!';
  end;

implementation

end.
