unit infosistemas.view.messages;

interface

uses
 WinAPI.Windows;

type
  //Mensagens exibidas na aplica��o.
  TMessagesConst = class
    const
     ClientNotFound = 'N�o foi encontrado um cliente com este CPF!';
     NormalUser = 'Usu�rio regular';
     UserName = 'Nome do usu�rio';
     Login = 'Login';
  end;

implementation

end.
