unit Prize_Picker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage, DataModule, Vcl.ComCtrls, Math,
  ComObj;

type
  TForm_Prize_Picker = class(TForm)
    Timer_Anim: TTimer;
    Label_Title_Register_Animal: TLabel;
    Button_Hide: TButton;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Image3: TImage;
    Panel1: TPanel;
    RichEdit_Invisible: TRichEdit;
    procedure Button_HideClick(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form_Prize_Picker: TForm_Prize_Picker;

implementation

{$R *.dfm}

procedure TForm_Prize_Picker.Button_HideClick(Sender: TObject);
begin
  Form_Prize_Picker.hide;
  Form_Prize_Picker.Width := 0;
end;

procedure TForm_Prize_Picker.FormCreate(Sender: TObject);
begin
  DeleteFile('PrizePickerNames.txt');
  // Delete Existing File to renew file names
  (Image1.Picture.Graphic as TGIFImage).Animate := True;
end;

procedure TForm_Prize_Picker.FormShow(Sender: TObject);
begin
  Form_Prize_Picker.left := 550; // On Form Show Event, Timer is Triggered
  Form_Prize_Picker.Width := 0;
  Timer_Anim.Enabled := True;
end;

procedure TForm_Prize_Picker.Image2Click(Sender: TObject);
var
  irandom, iCount, I, I2: integer;
  sName, sSurname, sFullName, sLine: string;
  tfile: textfile;
begin

  if not FileExists('PrizePickerNames.txt') then
  // If Textfile doesnt exist, create it
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('PrizePickerNames.txt');
    AssignFile(tfile, 'PrizePickerNames.txt');
    Rewrite(tfile);
    Writeln(tfile, '');
    CloseFile(tfile);
  end;
  RichEdit_Invisible.Clear;
  irandom := 0;
  iCount := 0;
  with DataModule.MyDataModule do
  // Loop through database to get names of donators
  begin
    ADO_Donations.First;
    while not ADO_Donations.Eof do
    begin
      sName := ADO_Donations['NameDonator']; // Attatch Surname to Name
      sSurname := ADO_Donations['SurnameDonator'];
      sFullName := sName + ' ' + sSurname;
      RichEdit_Invisible.Lines.Add(sFullName);
      iCount := iCount + 1;
      ADO_Donations.Next;
    end;
  end;
  AssignFile(tfile, 'PrizePickerNames.txt'); // Save Results to Textfile
  Reset(tfile);
  Rewrite(tfile);
  Writeln(tfile, RichEdit_Invisible.text);
  CloseFile(tfile);
  RichEdit_Invisible.Clear; // Read a random name that was written to textfile
  irandom := RandomRange(1, iCount + 1);
  AssignFile(tfile, 'PrizePickerNames.txt');
  Reset(tfile);
  for I := 1 to irandom do
  begin
    Readln(tfile, sLine);
  end;
  CloseFile(tfile);

  ShowMessage('Congratulations to ' + sLine + // Display Winner
    ' they won a free bag of pet food.');

end;

procedure TForm_Prize_Picker.Image2MouseEnter(Sender: TObject);
var
  tfile: textfile;
  sLine: string;
  OVRead: OleVariant;
begin

  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Click here to spin the wheel');
  end;

end;

procedure TForm_Prize_Picker.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Prize_Picker.Width <> 828 then
  // Timer on animation that gives the illusion
  begin // of form appearing
    Form_Prize_Picker.Width := Form_Prize_Picker.Width + 36;

  end;

  if Form_Prize_Picker.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
