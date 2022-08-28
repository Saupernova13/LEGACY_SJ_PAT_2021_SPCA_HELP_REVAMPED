unit Check_Registered;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, DataModule, Vcl.Imaging.pngimage, Vcl.ComCtrls, Math,
  SPCA_Team, System.IOUtils;

type
  TForm_Check_Registered = class(TForm)
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    RadioButton_Male: TRadioButton;
    RadioButton_Female: TRadioButton;
    Label_Female: TLabel;
    Label_Male: TLabel;
    RadioButton1: TRadioButton;
    Label1: TLabel;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton4: TRadioButton;
    Label4: TLabel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label5: TLabel;
    Label6: TLabel;
    RadioButton7: TRadioButton;
    Label7: TLabel;
    Label8: TLabel;
    RadioButton8: TRadioButton;
    Label9: TLabel;
    Label10: TLabel;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    OpenDialog1: TOpenDialog;
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure LoadFromMyDB;
    { Private declarations }
  public
    { Public declarations }
  var
    tFile: textfile;
    sLine: string;
  end;

var
  Form_Check_Registered: TForm_Check_Registered;

implementation

{$R *.dfm}

procedure TForm_Check_Registered.LoadFromMyDB;
begin
  SPCA_Team.Form_SPCA_Team.RichEdit1.Clear;
  SPCA_Team.Form_SPCA_Team.RichEdit2.Clear;
  SPCA_Team.Form_SPCA_Team.RichEdit3.Clear;
  SPCA_Team.Form_SPCA_Team.RichEdit4.Clear;
  with DataModule.MyDataModule do
  begin
    tbl_People.Open;
    tbl_People.First;
    SPCA_Team.Form_SPCA_Team.RichEdit1.Lines.Add
      ('Name:  ' + tbl_People['EmployeeName']);
    SPCA_Team.Form_SPCA_Team.RichEdit1.Lines.Add
      ('Gender:  ' + tbl_People['Gender']);
    SPCA_Team.Form_SPCA_Team.RichEdit1.Lines.Add
      ('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    SPCA_Team.Form_SPCA_Team.RichEdit1.Lines.Add
      ('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    SPCA_Team.Form_SPCA_Team.DisplayImages[1] := tbl_People['ImageName'];
    SPCA_Team.Form_SPCA_Team.Image2.Picture.LoadFromFile
      (SPCA_Team.Form_SPCA_Team.DisplayImages[1]);
    tbl_People.next;
    SPCA_Team.Form_SPCA_Team.RichEdit2.Lines.Add
      ('Name:  ' + tbl_People['EmployeeName']);
    SPCA_Team.Form_SPCA_Team.RichEdit2.Lines.Add
      ('Gender:  ' + tbl_People['Gender']);
    SPCA_Team.Form_SPCA_Team.RichEdit2.Lines.Add
      ('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    SPCA_Team.Form_SPCA_Team.RichEdit2.Lines.Add
      ('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    SPCA_Team.Form_SPCA_Team.DisplayImages[2] := tbl_People['ImageName'];
    SPCA_Team.Form_SPCA_Team.Image4.Picture.LoadFromFile
      (SPCA_Team.Form_SPCA_Team.DisplayImages[2]);
    tbl_People.next;
    SPCA_Team.Form_SPCA_Team.RichEdit3.Lines.Add
      ('Name:  ' + tbl_People['EmployeeName']);
    SPCA_Team.Form_SPCA_Team.RichEdit3.Lines.Add
      ('Gender:  ' + tbl_People['Gender']);
    SPCA_Team.Form_SPCA_Team.RichEdit3.Lines.Add
      ('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    SPCA_Team.Form_SPCA_Team.RichEdit3.Lines.Add
      ('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    SPCA_Team.Form_SPCA_Team.DisplayImages[3] := tbl_People['ImageName'];
    SPCA_Team.Form_SPCA_Team.Image3.Picture.LoadFromFile
      (SPCA_Team.Form_SPCA_Team.DisplayImages[3]);
    tbl_People.next;
    SPCA_Team.Form_SPCA_Team.RichEdit4.Lines.Add
      ('Name:  ' + tbl_People['EmployeeName']);
    SPCA_Team.Form_SPCA_Team.RichEdit4.Lines.Add
      ('Gender:  ' + tbl_People['Gender']);
    SPCA_Team.Form_SPCA_Team.RichEdit4.Lines.Add
      ('Date Joined:  ' + DateToStr(tbl_People['DateJoined']));
    SPCA_Team.Form_SPCA_Team.RichEdit4.Lines.Add
      ('Birthday:  ' + DateToStr(tbl_People['Birthday']));
    SPCA_Team.Form_SPCA_Team.DisplayImages[4] := tbl_People['ImageName'];
    SPCA_Team.Form_SPCA_Team.Image1.Picture.LoadFromFile
      (SPCA_Team.Form_SPCA_Team.DisplayImages[4]);
    tbl_People.Close;
  end;
end;

procedure TForm_Check_Registered.Button1Click(Sender: TObject);
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
  iRandom := RandomRange(0, 99999);
  sfinalString := '';
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Low)) + 1);
  sfinalString := sfinalString + IntToStr(Random(Length(letras_Up)) + 1);
  sfinalString := sfinalString + IntToStr(iRandom);

//  if OpenDialog1.Execute then
//  begin
//    if FileExists(OpenDialog1.FileName) then
//    begin
//      tFile.Copy(OpenDialog1.FileName, GetCurrentDir + '/' + sfinalString
//        + '.png');
//      // to add new recruit into database
//
//      sDay := '';
//      sGender := '';
//      sTemp := '';
//      sFullName := InputBox('Input', 'Input a Name and Surname',
//        'Name Surname');
//
//      sBirthday :=
//        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
//        '01/01/2021'));
//
//      try
//        StrToDateTime(sBirthday);
//      except
//        ShowMessage('That was not a valid date.');
//        (InputBox('Input', 'Input birthday in the format :(MM/DD/YYYY)) ',
//          '01/01/2021'));
//      end;
//
//      sGender := InputBox('Input',
//        'Input a Gender (Male, Female, Non-Binary/Other)', 'Male');
//
//      with DataModule.MyDataModule do
//      begin
//        tbl_People.Open;
//        tbl_People.First;
//        tbl_People.Edit;
//        tbl_People['EmployeeName'] := sFullName;
//        tbl_People['DateJoined'] := date;
//        tbl_People['Birthday'] := StrToDate(sBirthday);
//        tbl_People['Gender'] := sGender;
//        tbl_People['ImageName'] := sfinalString + '.png';
//        tbl_People.Post;
//        tbl_People.Close;
//      end;
//      with DataModule.MyDataModule do
//      begin
//        tbl_People_History.Open;
//        tbl_People_History.First;
//        tbl_People_History.Insert;
//        tbl_People_History['EmployeeName'] := sFullName;
//        tbl_People_History['DateJoined'] := date;
//        tbl_People_History['Birthday'] := StrToDate(sBirthday);
//        tbl_People_History['Gender'] := sGender;
//        tbl_People_History['ImageName'] := sfinalString + '.png';
//        tbl_People_History.Post;
//        tbl_People_History.Close;
//      end;
//
//      Image2.Picture.LoadFromFile(sfinalString + '.png');
//      LoadFromMyDB;
//
//    end
//    else
//    begin
//      ShowMessage('No new recruit was added');
//    end;
//
//  end;

end;

procedure TForm_Check_Registered.Button_HideClick(Sender: TObject);
begin
  Form_Check_Registered.hide;
  Form_Check_Registered.Width := 0;
end;

procedure TForm_Check_Registered.FormShow(Sender: TObject);
begin
  Form_Check_Registered.left := 550;
  Form_Check_Registered.Width := 0;
  Timer_Anim.Enabled := true;
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
end;

procedure TForm_Check_Registered.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Check_Registered.Width <> 828 then
  begin
    Form_Check_Registered.Width := Form_Check_Registered.Width + 36;

  end;

  if Form_Check_Registered.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;

end;

end.
