program infotest;

uses
  Vcl.Forms,
  infosistemas.view.clientes in 'infosistemas.view.clientes.pas' {FrmMainForm},
  infosistemas.model.clientes in 'infosistemas.model.clientes.pas' {DMClientes: TDataModule},
  infosistemas.business.clientes in 'infosistemas.business.clientes.pas',
  infosistemas.business.address in 'infosistemas.business.address.pas',
  infosistemas.business.mail in 'infosistemas.business.mail.pas',
  infosistemas.view.messages in 'infosistemas.view.messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMClientes, DMClientes);
  Application.CreateForm(TFrmMainForm, FrmMainForm);
  Application.Run;
end.
