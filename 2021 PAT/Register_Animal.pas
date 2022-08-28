unit Register_Animal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin, datamodule, Unit_Pet,
  TextBox_Form, comOBJ;

type
  TForm_Register_Animal = class(TForm)
    Button_Exit: TButton;
    Panel_Title: TPanel;
    Label_Title_Register_Animal: TLabel;
    Label_UI_Name_Animal: TLabel;
    Label_UI_Register: TLabel;
    Label_UI_Full_Name: TLabel;
    Label_UI_Age: TLabel;
    Label_UI_Animal_Type: TLabel;
    Label_UI_Gender: TLabel;
    DateTimePicker_Register: TDateTimePicker;
    Edit_Animal_Name: TEdit;
    ComboBox_AnimalType: TComboBox;
    Edit_Full_Name: TEdit;
    Image_Centre: TImage;
    SpinEdit_Age: TSpinEdit;
    RadioButton_Male: TRadioButton;
    RadioButton_Female: TRadioButton;
    Label_Male: TLabel;
    Label_Female: TLabel;
    RichEdit_Description: TRichEdit;
    RichEdit_Medical: TRichEdit;
    Label_Animal_Description: TLabel;
    Label_Medical_Information: TLabel;
    Timer_Anim: TTimer;
    Button_Enter: TButton;
    RichEdit_Invisible: TRichEdit;
    procedure Button_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_EnterClick(Sender: TObject);
    procedure SQLProcedure;
    procedure Edit_Full_NameMouseEnter(Sender: TObject);
    procedure Edit_Animal_NameMouseEnter(Sender: TObject);
    procedure RadioButton_MaleMouseEnter(Sender: TObject);
    procedure RadioButton_FemaleMouseEnter(Sender: TObject);
    procedure ComboBox_AnimalTypeMouseEnter(Sender: TObject);
    procedure DateTimePicker_RegisterMouseEnter(Sender: TObject);
    procedure Label_UI_AgeMouseEnter(Sender: TObject);
    procedure RichEdit_DescriptionMouseEnter(Sender: TObject);
    procedure RichEdit_MedicalMouseEnter(Sender: TObject);
    procedure Button_EnterMouseEnter(Sender: TObject);
    procedure Button_ExitMouseEnter(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    // procedure AssigningProcedure;

  var
    tRegister: Textfile;
    sFullName, sPetName, sGender, sAnimalType, sAnimalDescription,
      sMedicalInfo: String;
    tdDate: TDateTime;
    iAge: integer;
  end;

var
  Form_Register_Animal: TForm_Register_Animal;

implementation

{$R *.dfm}
// procedure TForm_Register_Animal.AssigningProcedure;
// begin
// sFullName := Edit_Full_Name.text;
// sPetName := Edit_Animal_Name.text;
// sAnimalType := ComboBox_AnimalType.text;
// sAnimalDescription := RichEdit_Description.text;
// sMedicalInfo := RichEdit_Medical.text;
// iAge := SpinEdit_Age.Value;
// tdDate := DateTimePicker_Register.DateTime;
// end;

procedure TForm_Register_Animal.Button_EnterClick(Sender: TObject);
var
  sLine: String;
  PetObject: tPet;
  iPosArray: array [1 .. 5] of integer;
begin

  AssignFile(tRegister, 'Register.txt'); // Assigns To File
  if not FileExists('Register.txt') then
  // If the file doesn't exist, this will run to create the file
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('Register.txt');
    AssignFile(tRegister, 'Register.txt');
    Rewrite(tRegister);
    Writeln(tRegister, 'User');
    CloseFile(tRegister);
  end;

  if FileExists('Register.txt') then
  // If the file exists, this will run to write to the file
  begin
    if RadioButton_Male.Checked = true then
    // If statements get data from Radio Button
    begin
      sGender := 'Male';
    end;
    if RadioButton_Female.Checked = true then
    begin
      sGender := 'Female';
    end;
    // This ensures no empty fields are processed
    if ((Edit_Full_Name.text <> '') and (Edit_Animal_Name.text <> '') and
      (ComboBox_AnimalType.text <> '')) and
      (((RadioButton_Male.Checked = false) or
      (RadioButton_Female.Checked = false))) and
      (RichEdit_Description.text <> '') and (RichEdit_Medical.text <> '') then
    begin
      iPosArray[1] := Pos('"', Edit_Animal_Name.text);
      iPosArray[2] := Pos('"', Edit_Full_Name.text);
      iPosArray[3] := Pos('"', ComboBox_AnimalType.text);
      iPosArray[4] := Pos('"', RichEdit_Description.text);
      iPosArray[5] := Pos('"', RichEdit_Medical.text);
      if (iPosArray[1] = 0) and (iPosArray[2] = 0) and (iPosArray[3] = 0) and
        (iPosArray[4] = 0) and (iPosArray[5] = 0) then
      begin
        // Assign Data to Custom Object
        PetObject := tPet.Create(Edit_Full_Name.text, Edit_Animal_Name.text,
          sGender, ComboBox_AnimalType.text, DateTimePicker_Register.DateTime,
          SpinEdit_Age.Value, RichEdit_Description.text, RichEdit_Medical.text);
        /// //////////////////
        MyTextForm.RichEdit1.Clear;
        MyTextForm.RichEdit1.Lines.Add(PetObject.ToSting);
        MyTextForm.Show;
        Reset(tRegister);
        Rewrite(tRegister);
        Writeln(tRegister, MyTextForm.RichEdit1.text);
        CloseFile(tRegister);
        // MyTextForm.RichEdit1.Clear;
        SQLProcedure;
      end
      else
      begin
        ShowMessage
          ('You have entered an invalid character on the form. Please remove any unatural characters.')
      end;
    end
    else
    begin
      ShowMessage('Sorry. Please try again. You may have left a field empty.')
    end;

  end;

end;

procedure TForm_Register_Animal.Button_EnterMouseEnter(Sender: TObject);
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

procedure TForm_Register_Animal.Button_ExitClick(Sender: TObject);
begin

  Form_Register_Animal.Hide;
  Form_Register_Animal.Width := 0;

end;

procedure TForm_Register_Animal.Button_ExitMouseEnter(Sender: TObject);
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
    OVRead.speak('Click here to close this form');
  end;
end;

procedure TForm_Register_Animal.ComboBox_AnimalTypeMouseEnter(Sender: TObject);
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
    OVRead.speak('Please select the type of  pet');
  end;
end;

procedure TForm_Register_Animal.DateTimePicker_RegisterMouseEnter
  (Sender: TObject);
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
    OVRead.speak('Please select the registration date');
  end;
end;

procedure TForm_Register_Animal.Edit_Animal_NameMouseEnter(Sender: TObject);
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
    OVRead.speak('Please enter in the pet''s name');
  end;
end;

procedure TForm_Register_Animal.Edit_Full_NameMouseEnter(Sender: TObject);
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
    OVRead.speak('Please enter in the owner name and surname.');
  end;
end;

procedure TForm_Register_Animal.FormCreate(Sender: TObject);
begin
  Form_Register_Animal.left := 550;
  Form_Register_Animal.top := 135;
  Form_Register_Animal.Width := 0;
  RichEdit_Description.Clear;
  RichEdit_Medical.Clear;
end;

procedure TForm_Register_Animal.FormShow(Sender: TObject);
begin
  Form_Register_Animal.left := 550;
  Timer_Anim.Enabled := true;
end;

procedure TForm_Register_Animal.Label_UI_AgeMouseEnter(Sender: TObject);
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
    OVRead.speak('Please enter the pet''s age');
  end;
end;

procedure TForm_Register_Animal.RadioButton_FemaleMouseEnter(Sender: TObject);
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
    OVRead.speak('Clicking this will select the female option');
  end;
end;

procedure TForm_Register_Animal.RadioButton_MaleMouseEnter(Sender: TObject);
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
    OVRead.speak('Clicking this will select the male option');
  end;
end;

procedure TForm_Register_Animal.RichEdit_DescriptionMouseEnter(Sender: TObject);
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
    OVRead.speak('Enter a visual description of the animal');
  end;
end;

procedure TForm_Register_Animal.RichEdit_MedicalMouseEnter(Sender: TObject);
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
    OVRead.speak('Enter a medical description of the animal');
  end;
end;

procedure TForm_Register_Animal.SQLProcedure;
var
  iIDNumber: integer;
  sGender: string;
begin
  if RadioButton_Male.Checked = true then
  begin
    sGender := 'Male';
  end;
  if RadioButton_Female.Checked = true then
  begin
    sGender := 'Female';
  end;
  with MyDataModule.ADOQuery4 do
  begin
    close;
    sql.Clear;
    sql.Add('INSERT INTO tbAnimals (OwnerFullName, AnimalName, AnimalGender, AnimalType, AnimalRegisterDate, AnimalAge, AnimalDescription, AnimalMedical) VALUES ("'
      + Edit_Full_Name.text + '", "' + Edit_Animal_Name.text + '", "' + sGender
      + '", "' + ComboBox_AnimalType.text + '", #' +
      DateToStr(DateTimePicker_Register.DateTime) + '#, "' +
      IntToStr(SpinEdit_Age.Value) + '", "' + RichEdit_Description.text + '", "'
      + RichEdit_Medical.text + '")');
    ExecSQL;
  end;
  MyDataModule.tbl_Animal.Last;
  iIDNumber := StrToInt(MyDataModule.tbl_Kennel_History['AnimalID']);
end;

procedure TForm_Register_Animal.Timer_AnimTimer(Sender: TObject);
begin

  if Form_Register_Animal.Width <> 828 then
  begin
    Form_Register_Animal.Width := Form_Register_Animal.Width + 36;

  end;

  if Form_Register_Animal.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;

end;

end.
