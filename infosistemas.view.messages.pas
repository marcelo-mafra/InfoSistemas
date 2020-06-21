unit infosistemas.view.messages;

interface

uses
 WinAPI.Windows;

type
  //Mensagens exibidas na aplicação.
  TMessagesConst = class
    const
     ClientNotFound = 'Não foi encontrado um cliente com este CPF!';
     InvalidHostMail = 'A caixa de destino da mensagem não pode ser vazia!';
     InvalidMailData = 'Os dados do cliente não foram recebido para serem enviados ' +
        'na mensagem de email!';
     InvalidMail = 'O email informado não é válido!';
     InvalidCEP = 'O cep informado não é válido e não pode ter seus dados obtidos.';
  end;


implementation


end.
