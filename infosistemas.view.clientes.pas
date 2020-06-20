unit infosistemas.view.clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, infosistemas.business.address,
  Vcl.StdCtrls, infosistemas.model.clientes, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, System.Actions, Vcl.ActnList, infosistemas.view.messages,
  System.ImageList, Vcl.ImgList;

type
  TFrmMainForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEditCEP: TDBEdit;
    Label6: TLabel;
    DBEditLogradouro: TDBEdit;
    SpeedButton1: TSpeedButton;
    DBEditBairro: TDBEdit;
    DBEditCidade: TDBEdit;
    DBEditUF: TDBEdit;
    DBEditPais: TDBEdit;
    DBEdit10: TDBEdit;
    DBEditComp: TDBEdit;
    ActionList1: TActionList;
    ActLocateClient: TAction;
    ActGetCEPData: TAction;
    EdtCPFFind: TMaskEdit;
    Label7: TLabel;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    procedure ActLocateClientExecute(Sender: TObject);
    procedure ActLocateClientUpdate(Sender: TObject);
    procedure ActGetCEPDataUpdate(Sender: TObject);
    procedure ActGetCEPDataExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainForm: TFrmMainForm;

implementation

{$R *.dfm}
procedure TFrmMainForm.ActGetCEPDataExecute(Sender: TObject);
var
 aAddress: TAddressUtils;
begin
 aAddress := TAddressUtils.Create;

 try
   if aAddress.BuscaDadosCep(DBEditCEP.Text) then
    begin
      DBEditLogradouro.Field.AsString := aAddress.Logradouro;
      DBEditBairro.Field.AsString :=  aAddress.Bairro;
      DBEditCidade.Field.AsString :=  aAddress.Cidade;
      DBEditUF.Field.AsString :=  aAddress.UF;
      DBEditComp.Field.AsString :=  aAddress.Complemento;
    end;

 finally
   if Assigned(aAddress) then
     FreeAndNil(aAddress);
 end;
end;

procedure TFrmMainForm.ActGetCEPDataUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (DMClientes.CdsClientes.Active)
   and (Trim(DBEditCEP.Text) <> '');
end;

procedure TFrmMainForm.ActLocateClientExecute(Sender: TObject);
begin
 //Localiza um cliente pelo seu CPF
 if not DMClientes.CdsClientes.Locate('CPF', EdtCPFFind.Text, []) then
  ShowMessage(TMessagesConst.ClientNotFound);
end;

procedure TFrmMainForm.ActLocateClientUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (DMClientes.CdsClientes.Active)
   and (DMClientes.CdsClientes.State = dsBrowse) and not (DMClientes.CdsClientes.IsEmpty)
   and (Trim(EdtCPFFind.Text) <> '');
end;

end.
