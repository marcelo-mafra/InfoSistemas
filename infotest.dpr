program infotest;

uses
  Vcl.Forms,
  infosistemas.view.clientes in 'infosistemas.view.clientes.pas' {Form1},
  infosistemas.model.clientes in 'infosistemas.model.clientes.pas' {DMClientes: TDataModule},
  infosistemas.business.clientes in 'infosistemas.business.clientes.pas',
  infosistemas.business.address in 'infosistemas.business.address.pas',
  infosistemas.business.mail in 'infosistemas.business.mail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMClientes, DMClientes);
  Application.Run;
end.
