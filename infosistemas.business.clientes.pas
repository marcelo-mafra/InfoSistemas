unit infosistemas.business.clientes;

interface

uses
  System.Classes, System.SysUtils;

type
  TClientesUtils = class(TObject)

  public
    constructor Create;
    destructor Destroy; override;
    function ValidateCPF(const CPF: string): boolean;
  end;

implementation

{ TClientes }

constructor TClientesUtils.Create;
begin
  inherited Create;
end;

destructor TClientesUtils.Destroy;
begin
  inherited Destroy;
end;

function TClientesUtils.ValidateCPF(const CPF: string): boolean;
 var
 dig10, dig11: string;
 s, i, r, peso: integer;
begin
 //Valida se o CPF do cliente possui um formato v�lido.
// Valida��o b�sica inicial: n�o pode ser n�meros iguais ou ter comprimento
//diferente do esperado (11).
  Result := not
     ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11)) ;

  if Result = False then
   Exit;

// Protege o c�digo para eventuais erros de convers�o de tipo na fun��o StrToInt
  try
{ *-- C�lculo do 1o. D�gito Verificador --* }
    s := 0;
    peso := 10;

    for i := 1 to 9 do
     begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
     end;

    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig10 := '0'
    else
      str(r:1, dig10); // converte um n�mero no respectivo caractere num�rico

{ *-- C�lculo do 2o. D�gito Verificador --* }
    s := 0;
    peso := 11;

    for i := 1 to 10 do
     begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
     end;

    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
     dig11 := '0'
    else
     str(r:1, dig11);

{ Verifica se os d�gitos calculados conferem com os d�gitos informados. }
    Result := ((dig10 = CPF[10]) and (dig11 = CPF[11]));

  except
    Result := false
  end;
end;


end.
