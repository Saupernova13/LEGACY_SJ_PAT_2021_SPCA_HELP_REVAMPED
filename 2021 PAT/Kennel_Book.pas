unit Kennel_Book;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  DataModule, dateutils, comOBJ, Unit_Kennel, TextBox_Form;

type
  TForm_Kennel_Booking = class(TForm)
    Panel_Title: TPanel;
    Label_Title_Kennel: TLabel;
    Button_Exit: TButton;
    ComboBox_AnimalType: TComboBox;
    DateTimePicker_Register: TDateTimePicker;
    Edit_Animal_Name: TEdit;
    Edit_Full_Name: TEdit;
    Image_Centre: TImage;
    Label_Female: TLabel;
    Label_Male: TLabel;
    Label_UI_Age: TLabel;
    Label_UI_Animal_Type: TLabel;
    Label_UI_Full_Name: TLabel;
    Label_UI_Gender: TLabel;
    Label_UI_Name_Animal: TLabel;
    Label_UI_Register: TLabel;
    RadioButton_Female: TRadioButton;
    RadioButton_Male: TRadioButton;
    Image1: TImage;
    DateTimePicker_Deregister: TDateTimePicker;
    Timer_Anim: TTimer;
    RichEdit_Invisible: TRichEdit;
    Button_Enter: TButton;
    procedure Button_ExitClick(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_EnterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image_Searchbox_SearchClick(Sender: TObject);
    procedure Edit_SearchChange(Sender: TObject);
    procedure Edit_SearchClick(Sender: TObject);
    procedure Edit_SearchMouseLeave(Sender: TObject);
    procedure Edit_Full_NameMouseEnter(Sender: TObject);
    procedure Edit_Animal_NameMouseEnter(Sender: TObject);
    procedure RadioButton_MaleMouseEnter(Sender: TObject);
    procedure RadioButton_FemaleMouseEnter(Sender: TObject);
    procedure DateTimePicker_RegisterMouseEnter(Sender: TObject);
    procedure DateTimePicker_DeregisterMouseEnter(Sender: TObject);
    procedure ComboBox_AnimalTypeMouseEnter(Sender: TObject);
    procedure Button_EnterMouseEnter(Sender: TObject);
    procedure Button_ExitMouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AssigningProcedure;
    procedure SQLProcedure;

  var
    tKennel: Textfile;
    sFullName, sPetName, sAnimalType, sCheckIN, sCheckOUT, sKennelType,
      sGender: String;
    tdDate: TDateTime;
    iDays, iPrice: integer;
    objKennel: tMyKennel;

  end;

var
  Form_Kennel_Booking: TForm_Kennel_Booking;

implementation

{$R *.dfm}

procedure TForm_Kennel_Booking.SQLProcedure;
var
  iIDNumber: integer;
begin
  sCheckIN := DateToStr(DateTimePicker_Register.DateTime);
  sCheckOUT := DateToStr(DateTimePicker_Deregister.DateTime);
  with MyDataModule.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('INSERT INTO tblKennel_History (PetOwnerName, PetName, PetType, KennelType, CheckInDate, CheckOutDate, TotalStayPrice) VALUES ("'
      + sFullName + '", "' + sPetName + '", "' + sAnimalType + '", "' +
      sKennelType + '", #' + sCheckIN + '#, #' + sCheckOUT + '#, ' +
      IntToStr(iPrice) + ')');
    ExecSQL;
  end;
  // MyDataModule.tbl_Kennel_History.Last;
  // iIDNumber := StrToInt(MyDataModule.tbl_Kennel_History['AnimalID']);

  with MyDataModule.ADOQuery3 do
  begin
    close;
    sql.Clear;
    sql.Add('INSERT INTO tblKennel_InUse (PetOwnerName, PetName, PetType, KennelType, CheckInDate, CheckOutDate, TotalStayPrice) VALUES ("'
      + sFullName + '", "' + sPetName + '", "' + sAnimalType + '", "' +
      sKennelType + '", #' + sCheckIN + '#, #' + sCheckOUT + '#, ' +
      IntToStr(iPrice) + ')');
    ExecSQL;
  end;
end;

procedure TForm_Kennel_Booking.AssigningProcedure;
begin

  sPetName := Edit_Animal_Name.text;

  sCheckIN := DateToStr(DateTimePicker_Register.DateTime);
  sCheckOUT := DateToStr(DateTimePicker_Deregister.DateTime);
  iDays := DaysBetween(DateTimePicker_Register.DateTime,
    DateTimePicker_Deregister.DateTime);
end;

procedure TForm_Kennel_Booking.Button_EnterClick(Sender: TObject);
var
  iNoStandard, iNoDeluxe, iCountTemp: integer;
  iCountDays: real;

begin
  iNoStandard := 0;
  iNoDeluxe := 0;
  with DataModule.MyDataModule do
  // Loop through database to get names of donators
  begin
    tbl_Kennel.Open;
    tbl_Kennel.First;
    while not tbl_Kennel.Eof do
    begin
      if tbl_Kennel['KennelType'] = 'Standard' then
      begin
        Inc(iNoStandard);
      end;

      if tbl_Kennel['KennelType'] = 'Deluxe' then
      begin
        Inc(iNoDeluxe);
      end;
      tbl_Kennel.Next;
    end;
    tbl_Kennel.close;
  end;

  AssignFile(tKennel, 'Kennel Book.txt'); // Assigns To File
  if not FileExists('Kennel Book.txt') then
  // If the file doesn't exist, this will run to create the file
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('Kennel Book.txt');
    AssignFile(tKennel, 'Kennel Book.txt');
    Rewrite(tKennel);
    CloseFile(tKennel);
  end;

  iCountTemp := 0;
  iDays := 0;
  iPrice := 0;
  iDays := DaysBetween(DateTimePicker_Register.DateTime,
    DateTimePicker_Deregister.DateTime);
  if FileExists('Kennel Book.txt') then
  // If the file exists, this will run to write to the file
  begin
    if RadioButton_Male.Checked = true then
    // If statements get data from Radio Button
    begin
      sKennelType := 'Standard';
      iPrice := iDays * 75;
    end;
    if RadioButton_Female.Checked = true then
    begin
      sKennelType := 'Deluxe';
      iPrice := iDays * 115;
    end;
    /// ///////////////////////////////////////////////////////////
    if ((Edit_Full_Name.text <> '')) then
    begin
      sFullName := Edit_Full_Name.text;
      Inc(iCountTemp);
    end;
    if (ComboBox_AnimalType.text <> '') then
    begin
      sAnimalType := ComboBox_AnimalType.text;
      Inc(iCountTemp);
    end;
    if (Edit_Animal_Name.text <> '') then
    begin
      sPetName := Edit_Animal_Name.text;
      Inc(iCountTemp);
    end;
    if (RadioButton_Male.Checked = true) then
    begin
      sGender := 'Standard';
      Inc(iCountTemp);
    end;
    if (RadioButton_Female.Checked = true) then
    begin
      sGender := 'Deluxe';
      Inc(iCountTemp);
    end;

    if (iNoDeluxe = 10) then
    begin
      ShowMessage('There are no kennels left of this type after this point.');
    end;
    if (iNoStandard = 14) then
    begin
      ShowMessage('There are no kennels left of this type.');
    end;

    if iCountTemp = 4 then
    begin
      // objKennel.Create(Edit_Full_Name.text, Edit_Animal_Name.text, sKennelType,
      // ComboBox_AnimalType.text, DateTimePicker_Register.DateTime,
      // DateTimePicker_Deregister.DateTime);
      // if RadioButton_Male.Checked = true then
      // begin
      // iCountDays := objKennel.CalculateStandardPrice;
      // end;
      // if RadioButton_Female.Checked = true then
      // begin
      // iCountDays := objKennel.CalculateDeluxePrice;
      // end;
      RichEdit_Invisible.Clear; // Code to write to file
      // RichEdit_Invisible.text := objKennel.ToSting;
      RichEdit_Invisible.Lines.Add('Owner''s full name: ' + sFullName);
      RichEdit_Invisible.Lines.Add('');
      RichEdit_Invisible.Lines.Add('Pet''s name: ' + sPetName);
      RichEdit_Invisible.Lines.Add('');
      RichEdit_Invisible.Lines.Add('Pet Type: ' + sAnimalType);
      RichEdit_Invisible.Lines.Add('');
      RichEdit_Invisible.Lines.Add('Kennel Type: ' + sKennelType);
      RichEdit_Invisible.Lines.Add('');
      RichEdit_Invisible.Lines.Add('Kennel Type: ' + sKennelType);
      RichEdit_Invisible.Lines.Add('');
      RichEdit_Invisible.Lines.Add('Date of Check In: ' +
        DateToStr(DateTimePicker_Register.DateTime));
      RichEdit_Invisible.Lines.Add('');
      DateToStr(DateTimePicker_Deregister.DateTime);
      RichEdit_Invisible.Lines.Add('');
      Reset(tKennel);
      Rewrite(tKennel);
      Writeln(tKennel, RichEdit_Invisible.text);
      CloseFile(tKennel);
      TextBox_Form.MyTextForm.RichEdit1.text := RichEdit_Invisible.text;
      RichEdit_Invisible.Clear;
      SQLProcedure;
      MyTextForm.Show;
      ShowMessage('Transaction complete');
    end
    else
    begin
      ShowMessage('You may have left a field blank');
    end;
  end;

end;

procedure TForm_Kennel_Booking.Button_EnterMouseEnter(Sender: TObject);
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

procedure TForm_Kennel_Booking.Button_ExitClick(Sender: TObject);
begin
  Form_Kennel_Booking.close;
  Form_Kennel_Booking.Width := 0;
end;

procedure TForm_Kennel_Booking.Button_ExitMouseEnter(Sender: TObject);
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

procedure TForm_Kennel_Booking.ComboBox_AnimalTypeMouseEnter(Sender: TObject);
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

procedure TForm_Kennel_Booking.DateTimePicker_DeregisterMouseEnter
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
    OVRead.speak('Please select the pet''s check out date');
  end;
end;

procedure TForm_Kennel_Booking.DateTimePicker_RegisterMouseEnter
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
    OVRead.speak('Please select the pet''s check in date');
  end;
end;

procedure TForm_Kennel_Booking.Edit_Animal_NameMouseEnter(Sender: TObject);
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
    OVRead.speak('Please enter in the pet''s name.');
  end;
end;

procedure TForm_Kennel_Booking.Edit_Full_NameMouseEnter(Sender: TObject);
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

procedure TForm_Kennel_Booking.Edit_SearchChange(Sender: TObject);
begin
  // if Edit_Search.text = 'Search Here' then
  // begin
  // Edit_Search.Clear;
  // end;
end;

procedure TForm_Kennel_Booking.Edit_SearchClick(Sender: TObject);
begin
  // if Edit_Search.text = 'Search Here' then
  // begin
  // Edit_Search.Clear;
  // end;
end;

procedure TForm_Kennel_Booking.Edit_SearchMouseLeave(Sender: TObject);
begin
  // if Edit_Search.text = '' then
  // begin
  // Edit_Search.text := 'Search Here';
  // end;
end;

procedure TForm_Kennel_Booking.FormCreate(Sender: TObject);
var
  tfile: Textfile;
  sLine: string;
  myArray: array [1 .. 5] of string;
begin
  if not FileExists('ComboBoxText.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('ComboBoxText.txt');
    AssignFile(tKennel, 'ComboBoxText.txt');
    Reset(tKennel);
    Rewrite(tKennel);
    CloseFile(tKennel);
  end;
  DateTimePicker_Register.DateTime := today;
  DateTimePicker_Deregister.DateTime := today + 1;
end;

procedure TForm_Kennel_Booking.FormShow(Sender: TObject);
begin
  Form_Kennel_Booking.left := 550;
  Form_Kennel_Booking.Width := 0;
  Timer_Anim.Enabled := true
end;

procedure TForm_Kennel_Booking.Image_Searchbox_SearchClick(Sender: TObject);
begin
  // if Edit_Search.text = 'Search Here' then
  // begin
  // Edit_Search.Clear;
  // end;
end;

procedure TForm_Kennel_Booking.RadioButton_FemaleMouseEnter(Sender: TObject);
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
    OVRead.speak('Clicking this will select a deluxe type kennel');
  end;
end;

procedure TForm_Kennel_Booking.RadioButton_MaleMouseEnter(Sender: TObject);
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
    OVRead.speak('Clicking this will select a standard type kennel');
  end;
end;

procedure TForm_Kennel_Booking.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Kennel_Booking.Width <> 828 then
  begin
    Form_Kennel_Booking.Width := Form_Kennel_Booking.Width + 36;

  end;

  if Form_Kennel_Booking.Width = 828 then
  begin
    Timer_Anim.Enabled := false;
  end;
end;

end.
