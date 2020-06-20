unit infosistemas.business.mail;

interface

uses
  System.Classes, System.SysUtils, System.Json;

type

  TMailUtils = class(TObject)

  public
    class procedure SendMail(const MailData: string);
  end;



implementation

{ TMailUtils }

class procedure TMailUtils.SendMail(const MailData: string);
begin

end;

end.
