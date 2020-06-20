unit infosistemas.view.messages;

interface

uses
 WinAPI.Windows;

type
  //Mensagens exibidas na aplicação.
  TMessagesConst = class
    const
     ClientNotFound = 'Não foi encontrado um cliente com este CPF!';
     NormalUser = 'Usuário regular';
     UserName = 'Nome do usuário';
     Login = 'Login';
  end;

implementation

end.
