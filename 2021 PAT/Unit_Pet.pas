unit Unit_Pet;

interface

uses
  System.SysUtils;

type
  tPet = class(TObject)
  private
    fOwnerFullName: string;
    fPetName: string;
    fPetGender: string;
    fPetType: string;
    fRegisterDate: TDateTime;
    fAnimalAge: integer;
    fAnimalDescription: string;
    fAnimalMedical: string;
    fStayPrice: integer;

  public
    constructor Create(sOwnerFullName: string; sPetName: string;
      sPetGender: string; sPetType: string; tdRegisterDate: TDateTime;
      iAnimalAge: integer; sAnimalDescription: string; sAnimalmedical: string);
    function ToSting: string;

  end;

implementation

{ tPet }

constructor tPet.Create(sOwnerFullName, sPetName, sPetGender, sPetType: string;
  tdRegisterDate: TDateTime; iAnimalAge: integer;
  sAnimalDescription, sAnimalmedical: string);
begin
  fOwnerFullName := sOwnerFullName;
  fPetName := sPetName;
  fPetGender := sPetGender;
  fPetType := sPetType;
  fRegisterDate := tdRegisterDate;
  fAnimalAge := iAnimalAge;
  fAnimalDescription := sAnimalDescription;
  fAnimalMedical := sAnimalmedical;
end;

function tPet.ToSting: string;
var
  sSub: string;
begin

  Result := 'Owner Full Name: ' + fOwnerFullName + #13 + 'Pet Name: ' + fPetName
    + #13 + 'Pet Gender: ' + fPetGender + #13 + 'Pet Type: ' + fPetType + #13 +
    'Register Date: ' + DateToStr(fRegisterDate) + #13 + 'Animal Age: ' +
    IntToStr(fAnimalAge) + #13 + #13 + 'Animal Descriptopn: ' +
    fAnimalDescription + #13 + #13 + 'Animal Medical Info: ' + fAnimalMedical;
end;

end.
