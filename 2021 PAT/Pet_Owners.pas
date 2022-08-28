unit Pet_Owners;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, datamodule, Vcl.Imaging.pngimage, Vcl.ComCtrls,
  ComObj;

type
  TForm_Pet_Owners = class(TForm)
    Label_Title_Register_Animal: TLabel;
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Label_Female: TLabel;
    RadioButton_Female: TRadioButton;
    RadioButton_Male: TRadioButton;
    Label_Male: TLabel;
    Label_UI_Gender: TLabel;
    Image1: TImage;
    Image2: TImage;
    RichEdit_Invisible: TRichEdit;
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton_MaleClick(Sender: TObject);
    procedure RadioButton_FemaleClick(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
    procedure RadioButton_MaleMouseEnter(Sender: TObject);
    procedure RadioButton_FemaleMouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    tFile: Textfile;
    sLine: string;
  end;

var
  Form_Pet_Owners: TForm_Pet_Owners;

implementation

{$R *.dfm}

procedure TForm_Pet_Owners.Button_HideClick(Sender: TObject);
begin
  Form_Pet_Owners.hide;
  Form_Pet_Owners.Width := 0;
end;

procedure TForm_Pet_Owners.FormCreate(Sender: TObject);
// var
// tFile: Textfile;
// sLine: string;
begin

  if not FileExists('EnableTTS.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('EnableTTS.txt');
    AssignFile(tFile, 'EnableTTS.txt');
    Reset(tFile);
    Rewrite(tFile);
    Writeln(tFile, 'Unactive');
    CloseFile(tFile);
  end;
  AssignFile(tFile, 'EnableTTS.txt');
  Reset(tFile);
  Readln(tFile, sLine);
  CloseFile(tFile);
  if sLine = 'Active' then
  begin
    RadioButton_Male.Checked := true;
  end;
  if sLine = 'Unactive' then
  begin
    RadioButton_Female.Checked := true;
  end;
end;

procedure TForm_Pet_Owners.FormShow(Sender: TObject);
begin
  Form_Pet_Owners.left := 550;
  Form_Pet_Owners.Width := 0;
  Timer_Anim.Enabled := true;
end;

procedure TForm_Pet_Owners.Image1Click(Sender: TObject);
var
  sOld, sNew: string;
begin
  AssignFile(tFile, 'Admin Password.txt');
  Reset(tFile);
  Readln(tFile, sLine);
  sOld := InputBox('Please enter in the old password to continue.',
    'Enter Old Password', '');
  if sOld = sLine then
  begin
    sNew := InputBox('Please enter in a new password.',
      'Enter New Password', '');
    Reset(tFile);
    Rewrite(tFile);
    Writeln(tFile, sNew);
    ShowMessage('A new password has been set.')
  end
  else
  begin
    ShowMessage('That was the incorrect password. Please try again.');
  end;
  CloseFile(tFile);
end;

procedure TForm_Pet_Owners.Image1MouseEnter(Sender: TObject);
var
  tFileq: Textfile;
  sLineq: string;
  OVRead: OleVariant;
begin

  AssignFile(tFileq, 'EnableTTS.txt');
  Reset(tFileq);
  Readln(tFileq, sLineq);
  CloseFile(tFileq);
  if sLineq = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Change admin password');
  end;

end;

procedure TForm_Pet_Owners.Image2Click(Sender: TObject);
var
  sOld, sNew: string;
begin
  AssignFile(tFile, 'User Password.txt');
  Reset(tFile);
  Readln(tFile, sLine);
  sOld := InputBox('Please enter in the old password to continue.',
    'Enter Old Password', '');
  if sOld = sLine then
  begin
    sNew := InputBox('Please enter in a new password.',
      'Enter New Password', '');
    Reset(tFile);
    Rewrite(tFile);
    Writeln(tFile, sNew);
    ShowMessage('A new password has been set.')
  end
  else
  begin
    ShowMessage('That was the incorrect password. Please try again.');
  end;
  CloseFile(tFile);
end;

procedure TForm_Pet_Owners.Image2MouseEnter(Sender: TObject);
var
  tFileq: Textfile;
  sLineq: string;
  OVRead: OleVariant;
begin

  AssignFile(tFileq, 'EnableTTS.txt');
  Reset(tFileq);
  Readln(tFileq, sLineq);
  CloseFile(tFileq);
  if sLineq = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('Change user password');
  end;

end;

procedure TForm_Pet_Owners.RadioButton_FemaleClick(Sender: TObject);
begin

  if RadioButton_Female.Checked = true then
  begin
    AssignFile(tFile, 'EnableTTS.txt');
    Reset(tFile);
    Rewrite(tFile);
    Writeln(tFile, 'Unactive');
    CloseFile(tFile);
  end;
end;

procedure TForm_Pet_Owners.RadioButton_FemaleMouseEnter(Sender: TObject);
var
  tFile: Textfile;
  sLine: string;
  OVRead: OleVariant;
begin
  AssignFile(tFile, 'EnableTTS.txt');
  Reset(tFile);
  Readln(tFile, sLine);
  CloseFile(tFile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('This option disables text to speech');
  end;

end;

procedure TForm_Pet_Owners.RadioButton_MaleClick(Sender: TObject);

begin
  if RadioButton_Male.Checked = true then
  begin
    AssignFile(tFile, 'EnableTTS.txt');
    Reset(tFile);
    Rewrite(tFile);
    Writeln(tFile, 'Active');
    CloseFile(tFile);
  end;

end;

procedure TForm_Pet_Owners.RadioButton_MaleMouseEnter(Sender: TObject);
var
  tFile: Textfile;
  sLine: string;
  OVRead: OleVariant;
begin
  AssignFile(tFile, 'EnableTTS.txt');
  Reset(tFile);
  Readln(tFile, sLine);
  CloseFile(tFile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak('This option enables text to speech');
  end;

end;

procedure TForm_Pet_Owners.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Pet_Owners.Width <> 828 then
  begin
    Form_Pet_Owners.Width := Form_Pet_Owners.Width + 36;

  end;

  if Form_Pet_Owners.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
