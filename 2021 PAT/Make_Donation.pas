unit Make_Donation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage, DataModule, ComObj;

type
  TForm_Make_Donation = class(TForm)
    Timer_Anim: TTimer;
    Label_Title_Register_Animal: TLabel;
    Button_Hide: TButton;
    RichEdit_Medical: TRichEdit;
    Label_Donate: TLabel;
    Image_Button: TImage;
    Image_Button2: TImage;
    Image_Button3: TImage;
    Label_250: TLabel;
    Label_500: TLabel;
    Label_1000: TLabel;
    Edit_Amount: TEdit;
    Label_Target: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Panel1: TPanel;
    Label_Option1: TLabel;
    Label_Option2: TLabel;
    Label_Option3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_FirstName: TEdit;
    Edit_Email: TEdit;
    Edit_Surname: TEdit;
    Edit_Phone: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Button1: TButton;
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label_250Click(Sender: TObject);
    procedure Label_500Click(Sender: TObject);
    procedure Label_1000Click(Sender: TObject);
    procedure Image_ButtonMouseEnter(Sender: TObject);
    procedure Image_Button2MouseEnter(Sender: TObject);
    procedure Image_Button3MouseEnter(Sender: TObject);
    procedure Edit_FirstNameMouseEnter(Sender: TObject);
    procedure Edit_SurnameMouseEnter(Sender: TObject);
    procedure Edit_EmailMouseEnter(Sender: TObject);
    procedure Edit_PhoneMouseEnter(Sender: TObject);
    procedure RadioButton1MouseEnter(Sender: TObject);
    procedure RadioButton2MouseEnter(Sender: TObject);
    procedure RadioButton3MouseEnter(Sender: TObject);
    procedure Button1MouseEnter(Sender: TObject);
    procedure Button_HideMouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    sName, sSurname, sEmail, sPhone, sPurpose: string;
    iAmount: integer;
  end;

var
  Form_Make_Donation: TForm_Make_Donation;

implementation

{$R *.dfm}

procedure TForm_Make_Donation.Button1Click(Sender: TObject);
var
  iRandom, iChecker: integer;
begin
  iChecker := 0;
  if (Edit_FirstName.text <> '') then
  begin
    sName := Edit_FirstName.text;
    Inc(iChecker);
  end;
  if (Edit_Surname.text <> '') then
  begin
    sSurname := Edit_Surname.text;
    Inc(iChecker);
  end;
  if (Edit_Amount.text <> '') or (StrToInt(Edit_Amount.text) > 10000) then
  begin
    sSurname := Edit_Surname.text;
    Inc(iChecker);
  end;
  if (Edit_Email.text <> '') and (Pos('@', Edit_Email.text) <> 0) then
  begin
    sEmail := Edit_Email.text;
    Inc(iChecker);
  end;
  if ((Edit_Phone.text <> '')) and (((Length(Edit_Phone.text) = 10))) then
  begin
    sPhone := Edit_Phone.text;
    Inc(iChecker);
  end;

  if RadioButton1.Checked = true then
  begin
    sPurpose := 'Emergency Food';
    Inc(iChecker);
  end;
  if RadioButton2.Checked = true then
  begin
    sPurpose := 'Preventing Cruelty';
    Inc(iChecker);
  end;
  if RadioButton3.Checked = true then
  begin
    iRandom := random(2);
    if iRandom = 2 then
    begin
      sPurpose := 'Emergency Food';
    end
    else
    begin
      sPurpose := 'Preventing Cruelty';
    end;
    Inc(iChecker);
  end;

  if iChecker = 6 then
  begin
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('INSERT INTO tblDonations (NameDonator, SurnameDonator, EmailDonator, PhoneDonator, AmountDonator, PurposeDonation) VALUES ("'
        + sName + '", "' + sSurname + '", "' + sEmail + '", "' + sPhone + '", '
        + IntToStr(iAmount) + ', "' + sPurpose + '")');
      ExecSQL;
      ShowMessage('Entry added Successfully');
    end;

  end
  else
  begin
    ShowMessage('You may have left a field out or an important character.');
  end;

end;

procedure TForm_Make_Donation.Button1MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Click here to confirm details');
  end;

end;

procedure TForm_Make_Donation.Button_HideClick(Sender: TObject);
begin
  Form_Make_Donation.hide;
  Form_Make_Donation.Width := 0;
end;

procedure TForm_Make_Donation.Button_HideMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Click here to close the form');
  end;

end;

procedure TForm_Make_Donation.Edit_EmailMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Enter in an e-mail');
  end;
end;

procedure TForm_Make_Donation.Edit_FirstNameMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Enter in a name');
  end;
end;

procedure TForm_Make_Donation.Edit_PhoneMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Enter in a phone number');
  end;
end;

procedure TForm_Make_Donation.Edit_SurnameMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Enter in a surname');
  end;
end;

procedure TForm_Make_Donation.FormShow(Sender: TObject);

begin
  if Edit_Amount.text = '' then
  begin
    Edit_Amount.text := '0';
  end;
  Edit_FirstName.ReadOnly := true;
  // Edit_FirstName.Clear;
  Edit_Email.Clear;
  Edit_Surname.Clear;
  Edit_Phone.Clear;
  Form_Make_Donation.left := 550;
  Form_Make_Donation.Width := 0;
  Timer_Anim.Enabled := true;
  sName := InputBox('Enter Name', 'Enter in the name of the donator', '');
  Label_Donate.Caption := sName + ' wants to help animals by donating...';
  Edit_FirstName.text := sName;
  if Edit_FirstName.text = '' then
  begin
    Edit_FirstName.ReadOnly := false;
  end;
end;

procedure TForm_Make_Donation.Image_Button2MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Donate 500 rand');
  end;
end;

procedure TForm_Make_Donation.Image_Button3MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Donate 1000 rand');
  end;
end;

procedure TForm_Make_Donation.Image_ButtonMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Donate 250 rand');
  end;
end;

procedure TForm_Make_Donation.Label_1000Click(Sender: TObject);
begin
  Edit_Amount.text := '1000';
end;

procedure TForm_Make_Donation.Label_250Click(Sender: TObject);
begin
  Edit_Amount.text := '250';
end;

procedure TForm_Make_Donation.Label_500Click(Sender: TObject);
begin
  Edit_Amount.text := '500';
end;

procedure TForm_Make_Donation.RadioButton1MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('This option selects an emergency food');
  end;

end;

procedure TForm_Make_Donation.RadioButton2MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('This option selects an preventing cruelty');
  end;

end;

procedure TForm_Make_Donation.RadioButton3MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: Textfile;
  sLine: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('This option selects what is needed most');
  end;

end;

procedure TForm_Make_Donation.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Make_Donation.Width <> 828 then
  begin
    Form_Make_Donation.Width := Form_Make_Donation.Width + 36;

  end;

  if Form_Make_Donation.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
