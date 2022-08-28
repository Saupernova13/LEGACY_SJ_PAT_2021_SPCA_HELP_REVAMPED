unit Kennel_InUse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, DataModule, Vcl.ComCtrls;

type
  TForm_Kennel_InUse = class(TForm)
    Button_Hide: TButton;
    Timer_Anim: TTimer;
    Label_Title_Register_Animal: TLabel;
    Image_Deluxe1: TImage;
    Image_Deluxe2: TImage;
    Image_Deluxe3: TImage;
    Image_Deluxe4: TImage;
    Image_Deluxe5: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image_Deluxe6: TImage;
    Image_Deluxe7: TImage;
    Image_Deluxe8: TImage;
    Image_Deluxe9: TImage;
    Image_Deluxe10: TImage;
    Image20: TImage;
    Panel2: TPanel;
    RichEdit_Invisible: TRichEdit;
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Kennel_InUse: TForm_Kennel_InUse;

implementation

{$R *.dfm}

procedure TForm_Kennel_InUse.Button_HideClick(Sender: TObject);
begin
  Form_Kennel_InUse.hide;
  Form_Kennel_InUse.Width := 0;
end;

procedure TForm_Kennel_InUse.FormCreate(Sender: TObject);
begin
  Form_Kennel_InUse.left := 550;
  Form_Kennel_InUse.Width := 0;
end;

procedure TForm_Kennel_InUse.FormShow(Sender: TObject);
var
  ArrInc1, ArrInc2, iNum, i, i2, iMath, iCounterDeluxe,
    iCounterStandard: integer;
  tfile: textfile;
  sString, sLine: string;
  StandardArray: array [1 .. 14] of string;
  DeluxeArray: array [1 .. 10] of string;
begin
  DeleteFile('Deluxe.txt');
  DeleteFile('Standard.txt');
  // If Textfile doesnt exist, create it
  if not FileExists('Deluxe.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('Deluxe.txt');
    AssignFile(tfile, 'Deluxe.txt');
    Rewrite(tfile);
    Writeln(tfile, '');
    CloseFile(tfile);
  end;
  if not FileExists('Standard.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('Standard.txt');
    AssignFile(tfile, 'Standard.txt');
    Rewrite(tfile);
    Writeln(tfile, '');
    CloseFile(tfile);
  end;
  /// ///////////////////////////////////////////////////////////
  iCounterDeluxe := 0;
  iCounterStandard := 0;
  RichEdit_Invisible.Clear;
  ArrInc1 := 0;
  ArrInc2 := 0; // AssignDefaultImages
  Form_Kennel_InUse.left := 550;
  Form_Kennel_InUse.Width := 0;
  Timer_Anim.Enabled := true;
  Image_Deluxe1.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe2.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe3.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe4.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe5.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe6.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe7.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe8.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe9.Picture.LoadFromFile('GreenExclusive.png');
  Image_Deluxe10.Picture.LoadFromFile('GreenExclusive.png');
  Image1.Picture.LoadFromFile('Green.png');
  Image2.Picture.LoadFromFile('Green.png');
  Image3.Picture.LoadFromFile('Green.png');
  Image4.Picture.LoadFromFile('Green.png');
  Image5.Picture.LoadFromFile('Green.png');
  Image6.Picture.LoadFromFile('Green.png');
  Image7.Picture.LoadFromFile('Green.png');
  Image8.Picture.LoadFromFile('Green.png');
  Image9.Picture.LoadFromFile('Green.png');
  Image10.Picture.LoadFromFile('Green.png');
  Image11.Picture.LoadFromFile('Green.png');
  Image12.Picture.LoadFromFile('Green.png');
  Image13.Picture.LoadFromFile('Green.png');
  Image14.Picture.LoadFromFile('Green.png');
  iNum := 0;

  with DataModule.MyDataModule do
  // Loop through database to get names of donators
  begin
    tbl_Kennel.Open;
    tbl_Kennel.First;
    while not tbl_Kennel.Eof do
    begin
      if tbl_Kennel['KennelType'] = 'Standard' then
      begin
        StandardArray[ArrInc1] := 'Standard';
        Inc(ArrInc1);
      end;

      if tbl_Kennel['KennelType'] = 'Deluxe' then
      begin
        DeluxeArray[ArrInc2] := 'Deluxe';
        Inc(ArrInc2);
      end;
      // ShowMessage(IntToStr(ArrInc2));
      tbl_Kennel.Next;
    end;
    tbl_Kennel.Close;
  end;
  // Create Text File That Determines Icons
  AssignFile(tfile, 'Deluxe.txt');
  Reset(tfile);
  for i := 1 to ArrInc2 do
  begin
    RichEdit_Invisible.Lines.Add('Deluxe');
  end;
  iMath := 10 - ArrInc2;
  for i := 1 to iMath do
  begin
    RichEdit_Invisible.Lines.Add('.');
  end;
  Rewrite(tfile);
  Writeln(tfile, RichEdit_Invisible.Text);
  CloseFile(tfile);
  RichEdit_Invisible.Clear;
  AssignFile(tfile, 'Standard.txt');
  Reset(tfile);
  for i := 1 to ArrInc1 do
  begin
    RichEdit_Invisible.Lines.Add('Standard');
  end;
  iMath := 14 - ArrInc2;
  for i := 1 to iMath do
  begin
    RichEdit_Invisible.Lines.Add('.');
  end;
  Rewrite(tfile);
  Writeln(tfile, RichEdit_Invisible.Text);
  CloseFile(tfile);

  AssignFile(tfile, 'Deluxe.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  // Code For Deluxe Kennel Displays
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe1.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe1.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe2.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe2.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe3.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe3.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe4.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe4.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe5.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe5.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe6.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe6.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe7.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe7.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe8.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe8.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe9.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe9.Picture.LoadFromFile('GreenExclusive.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Deluxe' then
  begin
    Image_Deluxe10.Picture.LoadFromFile('RedExclusive.png');
  end
  else
  begin
    Image_Deluxe10.Picture.LoadFromFile('GreenExclusive.png');
  end;
  CloseFile(tfile);
  // Code For Standard Kennel Displays
  AssignFile(tfile, 'Standard.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image1.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image1.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image2.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image2.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image3.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image3.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image4.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image4.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image5.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image5.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image6.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image6.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image7.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image7.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image8.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image8.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image9.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image9.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image10.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image10.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image11.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image11.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image12.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image12.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image13.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image13.Picture.LoadFromFile('Green.png');
  end;
  Readln(tfile, sLine);
  if sLine = 'Standard' then
  begin
    Image14.Picture.LoadFromFile('Red.png');
  end
  else
  begin
    Image14.Picture.LoadFromFile('Green.png');
  end;
  CloseFile(tfile);

end;

procedure TForm_Kennel_InUse.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Kennel_InUse.Width <> 828 then
  begin
    Form_Kennel_InUse.Width := Form_Kennel_InUse.Width + 36;

  end;

  if Form_Kennel_InUse.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;

end;

end.
