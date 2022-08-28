unit Unit_Kennel;

interface

uses
  System.SysUtils, dateutils;

type
  tMyKennel = class(TObject)
  private
    fOwnerFullName: string;
    fPetName: string;
    fKennelType: string;
    fPetType: string;
    fCheckInDate: TDateTime;
    fCheckOutDate: TDateTime;
  public
    constructor Create(sOwnerFullName: string; sPetName: string;
      sKennelType: string; sPetType: string; tdCheckInDate: TDateTime;
      tdCheckOutDate: TDateTime);
    function ToSting: string;
    function CalculateStandardPrice: real;
    function CalculateDeluxePrice: real;

  end;

implementation

{ tMyKennel }

function tMyKennel.CalculateDeluxePrice: real;
var
  iDBT: integer;
begin
  Result := DaysBetween(fCheckInDate, fCheckOutDate) * 115;
end;

function tMyKennel.CalculateStandardPrice: real;
var
  iDBT: integer;
begin
  Result := DaysBetween(fCheckInDate, fCheckOutDate) * 75;
end;

constructor tMyKennel.Create(sOwnerFullName, sPetName, sKennelType,
  sPetType: string; tdCheckInDate, tdCheckOutDate: TDateTime);
begin
  fOwnerFullName := sOwnerFullName;
  fPetName := sPetName;
  fKennelType := sKennelType;
  fPetType := sPetType;
  fCheckInDate := tdCheckInDate;
  fCheckOutDate := tdCheckOutDate;
end;

function tMyKennel.ToSting: string;
begin
  Result := 'Owner''s full name: ' + fOwnerFullName + #13 + 'Pet''s name: ' + fPetName + #13 + 'Pet Type: ' + fPetType + #13 + 'Kennel Type: '
    + fKennelType + #13 + 'Date of Check In: ' + DateToStr(fCheckInDate) + #13 +
    'Date of Check Out: ' + #13 + DateToStr(fCheckOutDate) + #13 +
    'Time of transaction: ' + DateToStr(date) + #13;
end;

end.
