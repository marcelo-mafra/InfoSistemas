unit infosistemas.business.address;

interface

uses
  System.Classes, System.SysUtils, Rest.Client, System.Json;

type

  TAddressUtils = class(TObject)
  private
   const
    sUrl: string = 'https://viacep.com.br/ws/'; //do not localize!
    sCepParam: string = '%s/json'; //do not localize!

   var
    FCep, FLogradouro, FBairro, FCidade, FUF, FComplemento: string;
    function IsValidParam(const cep: string): boolean;
    procedure ClearData;

  public
    constructor Create;
    destructor Destroy; override;

    function BuscaDadosCep(const cep: string): boolean;
    property Cep: string read FCep;
    property Logradouro: string read FLogradouro;
    property Bairro: string read FBairro;
    property Cidade: string read FCidade;
    property UF: string read FUF;
    property Complemento: string read FComplemento;

  end;



implementation

{ TAddressUtils }

function TAddressUtils.BuscaDadosCep(const cep: string): boolean;
var
  RESTClient1: TRESTClient;
  RESTRequest1: TRESTRequest;
  RESTResponse1: TRESTResponse;
  FData: TJSONObject;
begin
{Busca dados do cep no serviço remoto. Os dados são retornado pelo serviço no
padrão JSON.}

  //Verifica o cep informado. Se o cep não está no formato esperado nem vai
  //ao serviço remoto.
  Result := IsValidParam(cep);
  if Result = False then
    Exit;

  RESTClient1 := TRESTClient.Create(nil);
  RESTRequest1 := TRESTRequest.Create(nil);
  RESTResponse1 := TRESTResponse.Create(nil);

  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;
  RESTClient1.BaseURL := sUrl + Format(sCepParam, [cep]);
  self.ClearData;

  try
    RESTRequest1.Execute;
    FData := RESTResponse1.JSONValue as TJSONObject;

    //FData.Count = 1 indica que o cep informado não existe no serviço remoto.
    Result := (Assigned(FData)) and (FData.Count > 1);
    if Result then
      begin
        FCep := cep;
        FLogradouro := FData.Values['logradouro'].Value;
        FBairro := FData.Values['bairro'].Value;
        FCidade := FData.Values['localidade'].Value;
        FUF := FData.Values['uf'].Value;
        FComplemento := FData.Values['complemento'].Value;
      end;

  finally
    FreeAndNil(RESTClient1);
    FreeAndNil(RESTRequest1);
    FreeAndNil(RESTResponse1);
  end;
end;

procedure TAddressUtils.ClearData;
begin
//Limpa as variáveis internas dos dados do endereço.
 FCep := '';
 FLogradouro := '';
 FBairro := '';
 FCidade := '';
 FUF := '';
 FComplemento := '';
end;

constructor TAddressUtils.Create;
begin
  inherited Create;
end;

destructor TAddressUtils.Destroy;
begin
  inherited Destroy;
end;

function TAddressUtils.IsValidParam(const cep: string): boolean;
begin
//Valida se o cep é válido ou possui comandos inválidos a serem passados para
//o serviço remoto. Aqui a validação é apenas um constraint simples.
 Result := (Cep.Trim <> '') and (Cep.Trim.Length = 9) and (Cep.Contains('-'));
end;

end.
