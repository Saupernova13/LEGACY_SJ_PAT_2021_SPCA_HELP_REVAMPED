unit MatPat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Kennel_Book, Register_Animal,
  Booking_History, Kennel_InUse, Check_Registered, Register_Procedure,
  Kennel_Price, Overall_Review, Make_Donation, Donation_History, Prize_Picker,
  Leaderboard, SPCA_Team, Pet_Owners, Thrift_Store, ShellAPI, Vcl.Buttons,
  DataModule, comOBJ;

type
  TForm_Main = class(TForm)
    Timer_Start: TTimer;
    Panel_Title: TPanel;
    Image_Logo: TImage;
    Panel_Logo: TPanel;
    Panel_Click_Kennel: TPanel;
    Label_Kennel_Line_1: TLabel;
    Label_Kennel_Line_2: TLabel;
    Label_Kennel_Line_3: TLabel;
    Image_Kennel_Click: TImage;
    Panel_Click_Rescue: TPanel;
    Label_Rescue_Line_1: TLabel;
    Label_Rescue_Line_2: TLabel;
    Label_Rescue_Line_3: TLabel;
    Image_Kennel_Rescue: TImage;
    Panel_Click_Donation: TPanel;
    Label_Donation_Line_1: TLabel;
    Label_Donation_Line_2: TLabel;
    Label_Donation_Line_3: TLabel;
    Image_Donation_Click: TImage;
    Panel_Click_Community: TPanel;
    Label_Community_Line_1: TLabel;
    Label_Community_Line_2: TLabel;
    Label_Community_Line_3: TLabel;
    Image_Community_Click: TImage;
    Panel_Expand_Select: TPanel;
    Image_Cursor_1: TImage;
    Label_Expand_1: TLabel;
    Label_Expand_2: TLabel;
    Label_Expand_3: TLabel;
    Label_Expand_4: TLabel;
    Panel_Content: TPanel;
    Timer_Menu: TTimer;
    Timer_Reverse: TTimer;
    Image1: TImage;
    Panel_Login: TPanel;
    Image2: TImage;
    RichEdit_Invisible: TRichEdit;
    BitBtn1: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    procedure Timer_StartTimer(Sender: TObject);
    procedure Edit_edSearchClick(Sender: TObject);
    procedure Panel_LogoClick(Sender: TObject);
    procedure Panel_TitleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image_SearchboxClick(Sender: TObject);
    procedure Panel_Click_CommunityClick(Sender: TObject);
    procedure Timer_MenuTimer(Sender: TObject);
    procedure Timer_ReverseTimer(Sender: TObject);
    procedure Panel_Click_RescueClick(Sender: TObject);
    procedure Panel_Click_KennelClick(Sender: TObject);
    procedure Panel_Click_DonationClick(Sender: TObject);
    procedure Label_Expand_2Click(Sender: TObject);
    procedure Label_Expand_1Click(Sender: TObject);
    procedure Label_Expand_3Click(Sender: TObject);
    procedure Label_Expand_4Click(Sender: TObject);
    procedure Image_Kennel_ClickClick(Sender: TObject);
    procedure Image_Kennel_RescueClick(Sender: TObject);
    procedure Image_Donation_ClickClick(Sender: TObject);
    procedure Image_Community_ClickClick(Sender: TObject);
    procedure CommunityClick;
    procedure DonationClick;
    procedure RescueClick;
    procedure KennelCLick;
    procedure SelectionPicker;
    procedure Label_Expand_2MouseEnter(Sender: TObject);
    procedure Label_Expand_1MouseEnter(Sender: TObject);
    procedure Label_Expand_3MouseEnter(Sender: TObject);
    procedure Label_Expand_4MouseEnter(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    tfile, tfile2: textfile;

  var
    sLine: string;

  var

  end;

var
  Form_Main: TForm_Main;

implementation

{$R *.dfm}

procedure TForm_Main.Button1Click(Sender: TObject);
begin
  with DataModule.MyDataModule do
  begin
    tbl_Kennel.Open;

    tbl_Kennel.Sort := 'CheckOutDate ASC';
    tbl_Kennel.first;
    while not tbl_Kennel.Eof do
    begin
      if (tbl_Kennel['CheckOutDate'] < date) or
        (tbl_Kennel['CheckOutDate'] = date) then
      begin
        tbl_Kennel.Delete;
      end;
      tbl_Kennel.Next;
    end;
    tbl_Kennel.Sort := 'CheckOutDate ASC';
    tbl_Kennel.first;
    while not tbl_Kennel.Eof do
    begin
      if (tbl_Kennel['CheckOutDate'] < now) or (tbl_Kennel['CheckOutDate'] = now)
      then
      begin
        tbl_Kennel.Delete;
      end;
      tbl_Kennel.Next;
    end;
    tbl_Kennel.Close;
  end;
end;

procedure TForm_Main.CommunityClick;
begin
  Label_Expand_1.Caption := 'SPCA Team';
  Label_Expand_2.Caption := 'Admin Settings';
  Label_Expand_3.Caption := 'Thrift Store';
  Label_Expand_4.Caption := 'Public Site';
  Label_Expand_1.Left := 10;
  Label_Expand_2.Left := 10;
  Label_Expand_3.Left := 10;
  Label_Expand_4.Left := 10;
  Panel_Expand_Select.Left := 440;
  Panel_Expand_Select.Top := 314;
  Timer_Menu.Enabled := True;
  if Panel_Expand_Select.Left = 690 then
  begin
    Timer_Menu.Enabled := false;
  end;

end;

procedure TForm_Main.DonationClick;
begin
  Label_Expand_1.Caption := 'Make Donation';
  Label_Expand_2.Caption := 'Donation History';
  Label_Expand_3.Caption := 'Prize Picker';
  Label_Expand_4.Caption := 'Leaderboard';
  Label_Expand_1.Left := 10;
  Label_Expand_2.Left := 10;
  Label_Expand_3.Left := 10;
  Label_Expand_4.Left := 10;
  Panel_Expand_Select.Left := 140;
  Panel_Expand_Select.Top := 313;
  Timer_Reverse.Enabled := True;
end;

procedure TForm_Main.Edit_edSearchClick(Sender: TObject);
begin
  // Edit_Search.Text := '';
end;

procedure TForm_Main.FormCreate(Sender: TObject);

begin // So that the History From Can Change
  if not FileExists('HistoryMode.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('HistoryMode.txt');
    AssignFile(tfile, 'HistoryMode.txt');
    Reset(tfile);
    Rewrite(tfile);
    Writeln(tfile, 'Booking');
    CloseFile(tfile);
  end;
  // Textfile that stores password
  Panel_Login.Left := 0;
  Panel_Login.Top := 0;
  if not FileExists('Admin Password.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('Admin Password.txt');
    AssignFile(tfile, 'Admin Password.txt');
    Rewrite(tfile);
    Writeln(tfile, 'Admin');
    CloseFile(tfile);
  end;

  if not FileExists('ActiveAccount.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('ActiveAccount.txt');
    AssignFile(tfile, 'ActiveAccount.txt');
    Rewrite(tfile);
    Writeln(tfile, 'Standard');
    CloseFile(tfile);
  end;

  if not FileExists('User Password.txt') then
  begin
    RichEdit_Invisible.Clear;
    RichEdit_Invisible.Lines.SaveToFile('User Password.txt');
    AssignFile(tfile, 'User Password.txt');
    Rewrite(tfile);
    Writeln(tfile, 'User');
    CloseFile(tfile);
  end;

  Image_Logo.Left := 350;
  Image_Logo.Top := 8;
  Image_Logo.height := 95;
  Image_Logo.Width := 95;
  // Edit_Search.Text := 'Search Here';
  Panel_Title.Left := 0;
  Panel_Title.Top := 113;
  Panel_Logo.Left := 0;
  Panel_Logo.Top := 0;
  Panel_Expand_Select.Left := 440;
  Panel_Expand_Select.Top := 314;
  Panel_Content.Left := 0;
  Panel_Content.Top := 225;
  Panel_Click_Rescue.Left := 430;
  Panel_Click_Rescue.Top := 7;
  Panel_Click_Kennel.Top := 15;
  Panel_Click_Donation.Left := 140;
  Panel_Click_Kennel.Left := 140;
  Panel_Click_Community.Left := 430;
  Panel_Click_Donation.Top := 313;
  Panel_Click_Community.Top := 314;
  Label_Expand_1.Top := 25;
  Label_Expand_2.Top := 75;
  Label_Expand_3.Top := 125;
  Label_Expand_4.Top := 175;

end;

procedure TForm_Main.Image1Click(Sender: TObject);
begin
  // Form_Main.Destroy;
  BitBtn1.Click;
end;

procedure TForm_Main.Image1MouseEnter(Sender: TObject);
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
    OVRead.speak('Close the program');
  end;

end;

procedure TForm_Main.Image2Click(Sender: TObject);
var
  sPass, slineAdmin, sLineUser: String;
begin
  sPass := InputBox('SPCA Project',
    'Do you have a special account key? Enter it down Below.', '');
  AssignFile(tfile, 'Admin Password.txt');
  Reset(tfile);
  Readln(tfile, slineAdmin);
  CloseFile(tfile);
  if sPass = slineAdmin then
  begin
    ShowMessage('You are logged in as an admin.');
    AssignFile(tfile, 'ActiveAccount.txt');
    Reset(tfile);
    Rewrite(tfile);
    Writeln(tfile, 'Admin');
    Panel_Login.Destroy;
    CloseFile(tfile);
  end;

  AssignFile(tfile, 'User Password.txt');
  Reset(tfile);
  Readln(tfile, sLineUser);
  CloseFile(tfile);
  if sPass = sLineUser then
  begin
    ShowMessage('You are logged in as an standard user.');
    AssignFile(tfile, 'ActiveAccount.txt');
    Reset(tfile);
    Rewrite(tfile);
    Writeln(tfile, 'Standard');
    CloseFile(tfile);
    Panel_Login.Destroy;
  end;

  if not((sPass = slineAdmin) or (sPass = sLineUser)) then
  begin
    ShowMessage('You have entered in an incorect password. Please try again.')
  end;

  with DataModule.MyDataModule do
  begin
    tbl_Kennel.Open;

    tbl_Kennel.Sort := 'CheckOutDate ASC';
    tbl_Kennel.first;
    while not tbl_Kennel.Eof do
    begin
      if (tbl_Kennel['CheckOutDate'] < date) or
        (tbl_Kennel['CheckOutDate'] = date) then
      begin
        tbl_Kennel.Delete;
      end;
      tbl_Kennel.Next;
    end;
    tbl_Kennel.Sort := 'CheckOutDate ASC';
    tbl_Kennel.first;
    while not tbl_Kennel.Eof do
    begin
      if (tbl_Kennel['CheckOutDate'] < now) or (tbl_Kennel['CheckOutDate'] = now)
      then
      begin
        tbl_Kennel.Delete;
      end;
      tbl_Kennel.Next;
    end;
    tbl_Kennel.Close;
  end;
  Button1.Click;;
end;

procedure TForm_Main.Image_Community_ClickClick(Sender: TObject);
var
  OVRead: OleVariant;
begin
  CommunityClick;
end;

procedure TForm_Main.Image_Donation_ClickClick(Sender: TObject);
var
  OVRead: OleVariant;
begin
  DonationClick;
end;

procedure TForm_Main.Image_Kennel_ClickClick(Sender: TObject);

begin
  KennelCLick;
end;

procedure TForm_Main.Image_Kennel_RescueClick(Sender: TObject);
var
  OVRead: OleVariant;
begin
  RescueClick;

  // OVRead := CreateOleObject('SAPI.SPVoice');
  // OVRead.speak('Open Rescue Tab');

end;

procedure TForm_Main.Image_SearchboxClick(Sender: TObject);
begin
  // Edit_Search.Text := 'Search Here';
end;

procedure TForm_Main.KennelCLick;
begin
  Label_Expand_1.Caption := 'Book Kennel';
  Label_Expand_2.Caption := 'Booking History';
  Label_Expand_3.Caption := 'Kennels In Use';
  Label_Expand_4.Caption := 'Kennel Prices';
  Label_Expand_1.Left := 10;
  Label_Expand_2.Left := 10;
  Label_Expand_3.Left := 10;
  Label_Expand_4.Left := 10;
  Panel_Expand_Select.Left := 120;
  Panel_Expand_Select.Top := 15;
  Timer_Reverse.Enabled := True;
end;

procedure TForm_Main.Label_Expand_1Click(Sender: TObject);

begin
  Image_Cursor_1.Top := 0;
  if Label_Expand_1.Caption = 'Book Kennel' then
  begin
    Form_Kennel_Booking.Show;
  end;
  if Label_Expand_1.Caption = 'Register Animal' then
  begin
    Form_Register_Animal.Show;
  end;

  if Label_Expand_1.Caption = 'Make Donation' then
  begin
    Form_Make_Donation.Show;
  end;

  if Label_Expand_1.Caption = 'SPCA Team' then
  begin
    Form_SPCA_Team.Show;
  end;

end;

procedure TForm_Main.Label_Expand_1MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: textfile;
  sLine: string;
begin
  Image_Cursor_1.Top := 0;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak(Label_Expand_1.Caption);
  end;

end;

procedure TForm_Main.Label_Expand_2Click(Sender: TObject);
var
  tfile, testfile: textfile;
  sLine, testline: string;
  OVRead: OleVariant;

begin
  Image_Cursor_1.Top := 50;
  if Label_Expand_2.Caption = 'Booking History' then
  begin

    AssignFile(tfile, 'HistoryMode.txt');
    Rewrite(tfile);
    Writeln(tfile, 'BookingMode');
    CloseFile(tfile);
    Form_Booking_History.Show;

  end;
  if Label_Expand_2.Caption = 'Check Registered' then
  begin
    Form_Check_Registered.Show;
  end;
  if Label_Expand_2.Caption = 'Donation History' then
  begin
    AssignFile(tfile, 'HistoryMode.txt');
    Rewrite(tfile);
    Writeln(tfile, 'DonationMode');
    CloseFile(tfile);
    Form_Booking_History.Show;

  end;
  if Label_Expand_2.Caption = 'Admin Settings' then
  begin

    AssignFile(tfile, 'ActiveAccount.txt');
    Reset(tfile);
    Readln(tfile, sLine);
    if sLine = 'Admin' then
    begin
      Form_Pet_Owners.Show;
    end
    else
    begin
      ShowMessage
        ('You are not logged in as an admin. This tab may only be accessed by an admin.');
    end;
    CloseFile(tfile);

  end;

end;

procedure TForm_Main.Label_Expand_2MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: textfile;
  sLine: string;
begin
  Image_Cursor_1.Top := 50;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak(Label_Expand_2.Caption);
  end;

end;

procedure TForm_Main.Label_Expand_3Click(Sender: TObject);
var
  OVRead: OleVariant;
  URL: String;
begin
  Image_Cursor_1.Top := 100;
  if Label_Expand_3.Caption = 'Kennels In Use' then
  begin
    Form_Kennel_InUse.Show;
  end;
  if Label_Expand_3.Caption = 'Rescue Procedure' then
  begin
    Form_Register_Procedure.Show;
  end;
  if Label_Expand_3.Caption = 'Prize Picker' then
  begin
    Form_Prize_Picker.Show;
  end;
  if Label_Expand_3.Caption = 'Thrift Store' then
  begin
    URL := 'https://www.spcadbn.org.za/shop.php';
    ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);

  end;
end;

procedure TForm_Main.Label_Expand_3MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: textfile;
  sLine: string;
begin
  Image_Cursor_1.Top := 100;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak(Label_Expand_3.Caption);
  end;

end;

procedure TForm_Main.Label_Expand_4Click(Sender: TObject);
var
  testfile: textfile;
  testline: string;
  OVRead: OleVariant;
  URL: string;
begin
  Image_Cursor_1.Top := 150;
  if Label_Expand_4.Caption = 'Kennel Prices' then
  begin
    Form_Kennel_Prices.Show;
  end;
  if Label_Expand_4.Caption = 'Overall Review' then
  begin

    AssignFile(testfile, 'ActiveAccount.txt');
    Reset(testfile);
    Readln(testfile, testline);
    CloseFile(testfile);
    if testline = 'Standard' then
    begin
      ShowMessage('You can not access this form without admin privelages');
      Form_Overall_Review.hide;
    end;
    if testline = 'Admin' then
    begin

      Form_Overall_Review.Show;
    end;

  end;
  if Label_Expand_4.Caption = 'Leaderboard' then
  begin
    Form_Acceptable_List.Show;
  end;
  if Label_Expand_4.Caption = 'Public Site' then
  begin
    URL := 'https://www.spcadbn.org.za/';
    ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm_Main.Label_Expand_4MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile: textfile;
  sLine: string;
begin
  Image_Cursor_1.Top := 150;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sLine);
  CloseFile(tfile);
  if sLine = 'Active' then
  begin
    OVRead := CreateOleObject('SAPI.SPVoice');
    OVRead.speak(Label_Expand_4.Caption);
  end;

end;

procedure TForm_Main.Panel_Click_CommunityClick(Sender: TObject);
begin
  CommunityClick;
end;

procedure TForm_Main.Panel_Click_DonationClick(Sender: TObject);
begin
  DonationClick;
end;

procedure TForm_Main.Panel_Click_KennelClick(Sender: TObject);
begin
  KennelCLick;
end;

procedure TForm_Main.Panel_Click_RescueClick(Sender: TObject);
begin
  RescueClick;
end;

procedure TForm_Main.Panel_LogoClick(Sender: TObject);
begin
  // Edit_Search.Text := 'Search Here';
end;

procedure TForm_Main.Panel_TitleClick(Sender: TObject);
begin
  // Edit_Search.Text := 'Search Here';
end;

procedure TForm_Main.RescueClick;
begin
  Label_Expand_1.Caption := 'Register Animal';
  Label_Expand_2.Caption := 'Check Registered';
  Label_Expand_3.Caption := 'Rescue Procedure';
  Label_Expand_4.Caption := 'Overall Review';
  Label_Expand_1.Left := 10;
  Label_Expand_2.Left := 10;
  Label_Expand_3.Left := 5;
  Label_Expand_4.Left := 15;
  Panel_Expand_Select.Left := 440;
  Panel_Expand_Select.Top := 7;
  Timer_Menu.Enabled := True;
end;

procedure TForm_Main.SelectionPicker;
var
  iPos: integer;
begin
  iPos := Image_Cursor_1.Top;
  iPos := iPos + 50;
  Image_Cursor_1.Top := iPos;
end;

procedure TForm_Main.Timer_MenuTimer(Sender: TObject);
var
  iPos: integer;
begin

  iPos := Panel_Expand_Select.Left;
  iPos := iPos + 10;
  Panel_Expand_Select.Left := iPos;
  if Panel_Expand_Select.Left = 690 then
  begin
    Timer_Menu.Enabled := false;
  end;

end;

procedure TForm_Main.Timer_ReverseTimer(Sender: TObject);
var
  iPos: integer;
begin

  iPos := Panel_Expand_Select.Left;
  iPos := iPos - 10;
  Panel_Expand_Select.Left := iPos;
  if Panel_Expand_Select.Left = 0 then
  begin
    Timer_Reverse.Enabled := false;
  end;

end;

procedure TForm_Main.Timer_StartTimer(Sender: TObject);
var
  iABVal: integer;

begin
  iABVal := Form_Main.AlphaBlendValue;
  iABVal := iABVal + 5;
  Form_Main.AlphaBlendValue := iABVal;
  if iABVal = 255 then
  begin
    iABVal := 250;
    Form_Main.AlphaBlendValue := iABVal;
  end;
end;

end.
