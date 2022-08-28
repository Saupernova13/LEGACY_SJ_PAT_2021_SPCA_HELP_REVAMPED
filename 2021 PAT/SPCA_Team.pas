unit SPCA_Team;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.IOUtils, Math, DataModule, Vcl.Imaging.pngimage, ComObj;

type
  TForm_SPCA_Team = class(TForm)
    Label_Title_Register_Animal: TLabel;
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    RichEdit3: TRichEdit;
    RichEdit4: TRichEdit;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Panel2: TPanel;
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure LoadFromMyDB;
    procedure Image2Click(Sender: TObject);
    procedure RichEdit4MouseEnter(Sender: TObject);
    procedure RichEdit3MouseEnter(Sender: TObject);
    procedure RichEdit1MouseEnter(Sender: TObject);
    procedure RichEdit2MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DisplayImages: array [1 .. 4] of string;
  end;

var
  Form_SPCA_Team: TForm_SPCA_Team;

implementation

{$R *.dfm}

procedure TForm_SPCA_Team.Button1Click(Sender: TObject);
begin
  LoadFromMyDB;
end;

procedure TForm_SPCA_Team.Button_HideClick(Sender: TObject);
begin
  Form_SPCA_Team.hide;
  Form_SPCA_Team.Width := 0;
end;

procedure TForm_SPCA_Team.FormCreate(Sender: TObject);
begin
  RichEdit1.Clear;
  RichEdit2.Clear;
  RichEdit3.Clear;
  RichEdit4.Clear;

end;

procedure TForm_SPCA_Team.FormShow(Sender: TObject);
begin
  Form_SPCA_Team.left := 550;
  Form_SPCA_Team.Width := 0;
  Timer_Anim.Enabled := true;
  Button1.Click;
end;

procedure TForm_SPCA_Team.Image1Click(Sender: TObject);
var
  iRandom, iPos, iLen, iLen2, iPos2, iPos3, iPos4: integer;
  sfinalString, sFinalFileName, sFullName, sGender, sTemp, sDay, sMonth, sTemp2,
    sDay2, sMonth2, sBirthday, sAddDate: string;
  tdAddDate, tdBirthday: TDateTime;
const
  letras_Low = 'abcdefghijklmnopqrstuvwxyz';
const
  letras_Up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

begin
  // To get file path and generate random file name
  iRandom := RandomRange(0, 99999);
  sfinalString := '';
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Low)) + 1);
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Up)) + 1);
  sfinalString := sfinalString + IntToStr(iRandom);

  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      tfile.Copy(OpenDialog1.FileName, GetCurrentDir + '/' + sfinalString
        + '.png');
      // to add new recruit into database

      sDay := '';
      sGender := '';
      sTemp := '';
      sFullName := InputBox('Input', 'Input a Name and Surname',
        'Name Surname');

      sBirthday :=
        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
        '01/01/2021'));;

      iPos := Pos('/', sBirthday);
      sMonth := Copy(sBirthday, 0, iPos - 1);
      Delete(sBirthday, 0, iPos);
      iPos := Pos('/', sBirthday);
      sDay := Copy(sBirthday, 0, iPos - 1);
      Delete(sBirthday, 0, iPos);
      ShowMessage(sMonth + '/' + sDay + '/' + sBirthday);

      sGender := InputBox('Input',
        'Input a Gender (Male, Female, Non-Binary/Other)', 'Male');
      //

      // Validation of Dates
      // iPos3 := Pos('/', (sBirthday));
      // iLen2 := Length(sBirthday);
      // sMonth2 := Copy(sBirthday, 0, iPos3 - 1);
      // sTemp2 := Copy(sBirthday, iPos3 + 1, iLen2);
      // Delete(sTemp2, 0, iPos3);
      // sDay2 := sTemp;
      // iPos4 := Pos('/', sDay2);
      // sDay2 := Copy(sDay, 0, iPos4);
      //
      // if (iPos3 <> 3) or (StrToInt(sDay2) > 31) or (StrToInt(sMonth2) > 12) or
      // (iPos4 <> 0) then
      // begin
      // ShowMessage(' That was not a valid birthday. Please try again');
      // end;
      // if (iPos3 = 3) and (iPos4 = 0) then
      // begin
      with DataModule.MyDataModule do
      begin
        while not tbl_People.Eof do
        begin
          tbl_People.Open;
          tbl_People.First;
          tbl_People.next;
          tbl_People.next;
          tbl_People.next;
          tbl_People.Edit;
          tbl_People['EmployeeName'] := sFullName;
          tbl_People['DateJoined'] := date;
          tbl_People['Birthday'] := StrToDate(sBirthday);
          tbl_People['Gender'] := sGender;
          tbl_People['ImageName'] := sfinalString + '.png';
          tbl_People.Post;
          tbl_People.Close;
        end;

      end;
      /// /
      // end;

      with DataModule.MyDataModule do
      begin
        tbl_People_History.Open;
        tbl_People_History.First;
        tbl_People_History.Insert;
        tbl_People_History['EmployeeName'] := sFullName;
        tbl_People_History['DateJoined'] := date;
        tbl_People_History['Birthday'] := StrToDate(sBirthday);
        tbl_People_History['Gender'] := sGender;
        tbl_People_History['ImageName'] := sfinalString + '.png';
        tbl_People_History.Post;
        tbl_People_History.Close;
      end;

      Image1.Picture.LoadFromFile(sfinalString + '.png');
      LoadFromMyDB;
    end
    else
    begin
      ShowMessage('No new recruit was added');
    end;

  end;

end;

procedure TForm_SPCA_Team.Image3Click(Sender: TObject);
var
  iRandom, iPos, iLen, iLen2, iPos2, iPos3, iPos4: integer;
  sfinalString, sFinalFileName, sFullName, sGender, sTemp, sDay, sMonth, sTemp2,
    sDay2, sMonth2, sBirthday, sAddDate: string;
  tdAddDate, tdBirthday: TDateTime;
const
  letras_Low = 'abcdefghijklmnopqrstuvwxyz';
const
  letras_Up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

begin
  // To get file path and generate random file name
  iRandom := RandomRange(0, 99999);
  sfinalString := '';
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Low)) + 1);
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Up)) + 1);
  sfinalString := sfinalString + IntToStr(iRandom);

  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      tfile.Copy(OpenDialog1.FileName, GetCurrentDir + '/' + sfinalString
        + '.png');
      // to add new recruit into database

      sDay := '';
      sGender := '';
      sTemp := '';
      sFullName := InputBox('Input', 'Input a Name and Surname',
        'Name Surname');

      sBirthday :=
        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
        '01/01/2021'));;

      sGender := InputBox('Input',
        'Input a Gender (Male, Female, Non-Binary/Other)', 'Male');
      //

      // Validation of Dates
      // iPos3 := Pos('/', (sBirthday));
      // iLen2 := Length(sBirthday);
      // sMonth2 := Copy(sBirthday, 0, iPos3 - 1);
      // sTemp2 := Copy(sBirthday, iPos3 + 1, iLen2);
      // Delete(sTemp2, 0, iPos3);
      // sDay2 := sTemp;
      // iPos4 := Pos('/', sDay2);
      // sDay2 := Copy(sDay, 0, iPos4);
      //
      // if (iPos3 <> 3) or (StrToInt(sDay2) > 31) or (StrToInt(sMonth2) > 12) or
      // (iPos4 <> 0) then
      // begin
      // ShowMessage(' That was not a valid birthday. Please try again');
      // end;
      // if (iPos3 = 3) and (iPos4 = 0) then
      // begin
      with DataModule.MyDataModule do
      begin
        tbl_People.Open;
        tbl_People.First;
        tbl_People.next;
        tbl_People.next;
        tbl_People.Edit;
        tbl_People['EmployeeName'] := sFullName;
        tbl_People['DateJoined'] := date;
        tbl_People['Birthday'] := StrToDate(sBirthday);
        tbl_People['Gender'] := sGender;
        tbl_People['ImageName'] := sfinalString + '.png';
        tbl_People.Post;
        tbl_People.Close;
      end;
      /// /
      // end;

      with DataModule.MyDataModule do
      begin
        tbl_People_History.Open;
        tbl_People_History.First;
        tbl_People_History.Insert;
        tbl_People_History['EmployeeName'] := sFullName;
        tbl_People_History['DateJoined'] := date;
        tbl_People_History['Birthday'] := StrToDate(sBirthday);
        tbl_People_History['Gender'] := sGender;
        tbl_People_History['ImageName'] := sfinalString + '.png';
        tbl_People_History.Post;
        tbl_People_History.Close;
      end;

      Image1.Picture.LoadFromFile(sfinalString + '.png');
      LoadFromMyDB;
    end
    else
    begin
      ShowMessage('No new recruit was added');
    end;

  end;

end;

procedure TForm_SPCA_Team.Image4Click(Sender: TObject);
var
  iRandom, iPos, iLen, iLen2, iPos2, iPos3, iPos4: integer;
  sfinalString, sFinalFileName, sFullName, sGender, sTemp, sDay, sMonth, sTemp2,
    sDay2, sMonth2, sBirthday, sAddDate: string;
  tdAddDate, tdBirthday: TDateTime;
const
  letras_Low = 'abcdefghijklmnopqrstuvwxyz';
const
  letras_Up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

begin
  // To get file path and generate random file name
  iRandom := RandomRange(0, 99999);
  sfinalString := '';
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Low)) + 1);
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Up)) + 1);
  sfinalString := sfinalString + IntToStr(iRandom);
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      tfile.Copy(OpenDialog1.FileName, GetCurrentDir + '/' + sfinalString
        + '.png');
      sDay := '';
      sGender := '';
      sTemp := '';
      sFullName := InputBox('Input', 'Input a Name and Surname',
        'Name Surname');

      sBirthday :=
        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
        '01/01/2021'));;
      sGender := InputBox('Input',
        'Input a Gender (Male, Female, Non-Binary/Other)', 'Male');
      with DataModule.MyDataModule do
      begin
        tbl_People.Open;
        tbl_People.First;
        tbl_People.next;
        tbl_People.Edit;
        tbl_People['EmployeeName'] := sFullName;
        tbl_People['DateJoined'] := date;
        tbl_People['Birthday'] := StrToDate(sBirthday);
        tbl_People['Gender'] := sGender;
        tbl_People['ImageName'] := sfinalString + '.png';
        tbl_People.Post;
        tbl_People.Close;
      end;
      with DataModule.MyDataModule do
      begin
        tbl_People_History.Open;
        tbl_People_History.First;
        tbl_People_History.Insert;
        tbl_People_History['EmployeeName'] := sFullName;
        tbl_People_History['DateJoined'] := date;
        tbl_People_History['Birthday'] := StrToDate(sBirthday);
        tbl_People_History['Gender'] := sGender;
        tbl_People_History['ImageName'] := sfinalString + '.png';
        tbl_People_History.Post;
        tbl_People_History.Close;
      end;

      Image4.Picture.LoadFromFile(sfinalString + '.png');
      LoadFromMyDB;

      /// ///////////////
    end
    else
    begin
      ShowMessage('No new recruit was added');
    end;

  end;

end;

procedure TForm_SPCA_Team.LoadFromMyDB;
begin
  RichEdit1.Clear;
  RichEdit2.Clear;
  RichEdit3.Clear;
  RichEdit4.Clear;
  with DataModule.MyDataModule do
  begin
    tbl_People.Open;
    tbl_People.First;
    RichEdit1.Lines.Add('Name:  ' + tbl_People['EmployeeName']);
    RichEdit1.Lines.Add('Gender:  ' + tbl_People['Gender']);
    RichEdit1.Lines.Add('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    RichEdit1.Lines.Add('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    DisplayImages[1] := tbl_People['ImageName'];
    Image2.Picture.LoadFromFile(DisplayImages[1]);
    tbl_People.next;
    RichEdit2.Lines.Add('Name:  ' + tbl_People['EmployeeName']);
    RichEdit2.Lines.Add('Gender:  ' + tbl_People['Gender']);
    RichEdit2.Lines.Add('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    RichEdit2.Lines.Add('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    DisplayImages[2] := tbl_People['ImageName'];
    Image4.Picture.LoadFromFile(DisplayImages[2]);
    tbl_People.next;
    RichEdit3.Lines.Add('Name:  ' + tbl_People['EmployeeName']);
    RichEdit3.Lines.Add('Gender:  ' + tbl_People['Gender']);
    RichEdit3.Lines.Add('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    RichEdit3.Lines.Add('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    DisplayImages[3] := tbl_People['ImageName'];
    Image3.Picture.LoadFromFile(DisplayImages[3]);
    tbl_People.next;
    RichEdit4.Lines.Add('Name:  ' + tbl_People['EmployeeName']);
    RichEdit4.Lines.Add('Gender:  ' + tbl_People['Gender']);
    RichEdit4.Lines.Add('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    RichEdit4.Lines.Add('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    DisplayImages[4] := tbl_People['ImageName'];
    Image1.Picture.LoadFromFile(DisplayImages[4]);
    tbl_People.Close;
  end;
end;

procedure TForm_SPCA_Team.RichEdit1MouseEnter(Sender: TObject);
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
    OVRead.speak(RichEdit1.Text);
  end;

end;

procedure TForm_SPCA_Team.RichEdit2MouseEnter(Sender: TObject);
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
    OVRead.speak(RichEdit2.Text);
  end;

end;

procedure TForm_SPCA_Team.RichEdit3MouseEnter(Sender: TObject);
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
    OVRead.speak(RichEdit3.Text);
  end;

end;

procedure TForm_SPCA_Team.RichEdit4MouseEnter(Sender: TObject);
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
    OVRead.speak(RichEdit4.Text);
  end;

end;

procedure TForm_SPCA_Team.Timer_AnimTimer(Sender: TObject);
begin
  if Form_SPCA_Team.Width <> 828 then
  begin
    Form_SPCA_Team.Width := Form_SPCA_Team.Width + 36;

  end;

  if Form_SPCA_Team.Width = 828 then
  begin
    Timer_Anim.Enabled := false;
  end;
end;

procedure TForm_SPCA_Team.Image2Click(Sender: TObject);
var
  iRandom, iPos, iLen, iLen2, iPos2, iPos3, iPos4: integer;
  sfinalString, sFinalFileName, sFullName, sGender, sTemp, sDay, sMonth, sTemp2,
    sDay2, sMonth2, sBirthday, sAddDate: string;
  tdAddDate, tdBirthday: TDateTime;
const
  letras_Low = 'abcdefghijklmnopqrstuvwxyz';
const
  letras_Up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

begin
  // To get file path and generate random file name
  iRandom := RandomRange(0, 99999);
  sfinalString := '';
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Low)) + 1);
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Up)) + 1);
  sfinalString := sfinalString + IntToStr(iRandom);

  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      tfile.Copy(OpenDialog1.FileName, GetCurrentDir + '/' + sfinalString
        + '.png');
      // to add new recruit into database

      sDay := '';
      sGender := '';
      sTemp := '';
      sFullName := InputBox('Input', 'Input a Name and Surname',
        'Name Surname');

      sBirthday :=
        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
        '01/01/2021'));

      try
        StrToDateTime(sBirthday);
      except
        ShowMessage('That was not a valid date.');
        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
          '01/01/2021'));
      end;
      // iPos := Pos('/', sBirthday);
      // sMonth := Copy(sBirthday, 0, iPos - 1);
      // Delete(sBirthday, 0, iPos);
      // iPos := Pos('/', sBirthday);
      // sDay := Copy(sBirthday, 0, iPos - 1);
      // Delete(sBirthday, 0, iPos);
      // ShowMessage(sMonth + '/' + sDay + '/' + sBirthday);

      sGender := InputBox('Input',
        'Input a Gender (Male, Female, Non-Binary/Other)', 'Male');
      //

      // Validation of Dates
      // iPos3 := Pos('/', (sBirthday));
      // iLen2 := Length(sBirthday);
      // sMonth2 := Copy(sBirthday, 0, iPos3 - 1);
      // sTemp2 := Copy(sBirthday, iPos3 + 1, iLen2);
      // Delete(sTemp2, 0, iPos3);
      // sDay2 := sTemp;
      // iPos4 := Pos('/', sDay2);
      // sDay2 := Copy(sDay, 0, iPos4);
      //
      // if (iPos3 <> 3) or (StrToInt(sDay2) > 31) or (StrToInt(sMonth2) > 12) or
      // (iPos4 <> 0) then
      // begin
      // ShowMessage(' That was not a valid birthday. Please try again');
      // end;
      // if (iPos3 = 3) and (iPos4 = 0) then
      // begin
      with DataModule.MyDataModule do
      begin
        tbl_People.Open;
        tbl_People.First;
        tbl_People.Edit;
        tbl_People['EmployeeName'] := sFullName;
        tbl_People['DateJoined'] := date;
        tbl_People['Birthday'] := StrToDate(sBirthday);
        tbl_People['Gender'] := sGender;
        tbl_People['ImageName'] := sfinalString + '.png';
        tbl_People.Post;
        tbl_People.Close;
      end;
      /// /
      // end;

      with DataModule.MyDataModule do
      begin
        tbl_People_History.Open;
        tbl_People_History.First;
        tbl_People_History.Insert;
        tbl_People_History['EmployeeName'] := sFullName;
        tbl_People_History['DateJoined'] := date;
        tbl_People_History['Birthday'] := StrToDate(sBirthday);
        tbl_People_History['Gender'] := sGender;
        tbl_People_History['ImageName'] := sfinalString + '.png';
        tbl_People_History.Post;
        tbl_People_History.Close;
      end;

      Image2.Picture.LoadFromFile(sfinalString + '.png');
      LoadFromMyDB;

    end
    else
    begin
      ShowMessage('No new recruit was added');
    end;

  end;

end;

end.
