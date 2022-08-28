unit Booking_History;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, DataModule, Vcl.Imaging.pngimage, Vcl.WinXCtrls,
  Vcl.DBCtrls, comOBJ;

type
  TForm_Booking_History = class(TForm)
    Button_Hide: TButton;
    Timer_Anim: TTimer;
    Label_Title_Register_Animal: TLabel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Image_SortAlpha: TImage;
    Image_SortAnimalKind: TImage;
    Image_SortCheckIn: TImage;
    Image_SortCost: TImage;
    ImageSortAlphaPet: TImage;
    Timer1: TTimer;
    Image_Up: TImage;
    Image_Down: TImage;
    Image1: TImage;
    Image2: TImage;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Timer5: TTimer;
    Image10: TImage;
    Image11: TImage;
    Timer6: TTimer;
    Image12: TImage;
    Image13: TImage;
    Panel_Title: TPanel;
    Image_Searchbox: TImage;
    Image_Searchbox_Search: TImage;
    Edit_Search: TEdit;
    Image14: TImage;
    Image15: TImage;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image_UpClick(Sender: TObject);
    procedure Image_DownClick(Sender: TObject);
    procedure Image_SortAlphaMouseEnter(Sender: TObject);
    procedure Image_SortAnimalKindMouseEnter(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image_SortAnimalKindClick(Sender: TObject);
    procedure ImageSortAlphaPetClick(Sender: TObject);
    procedure Image_SortCostClick(Sender: TObject);
    procedure Image_SortCheckInClick(Sender: TObject);
    procedure ImageSortAlphaPetMouseEnter(Sender: TObject);
    procedure Image_SortCostMouseEnter(Sender: TObject);
    procedure Image_SortCheckInMouseEnter(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure Image7MouseEnter(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image_Searchbox_SearchClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Edit_SearchChange(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1MouseEnter(Sender: TObject);
    procedure Edit_SearchMouseEnter(Sender: TObject);
    procedure Image_UpMouseEnter(Sender: TObject);
    procedure Image_DownMouseEnter(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image8MouseEnter(Sender: TObject);
    procedure Image9MouseEnter(Sender: TObject);
    procedure Image10MouseEnter(Sender: TObject);
    procedure Image11MouseEnter(Sender: TObject);
    procedure Image12MouseEnter(Sender: TObject);
    procedure Image13MouseEnter(Sender: TObject);
    procedure Image3MouseEnter(Sender: TObject);
    procedure Image4MouseEnter(Sender: TObject);
    procedure Image5MouseEnter(Sender: TObject);
    procedure Image6MouseEnter(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure ResetHiddenElements1;
    procedure ResetHiddenElements2;
    procedure ResetHiddenElements3;
    procedure ResetHiddenElements4;
    procedure ResetHiddenElements5;
    procedure ResetHiddenElements6;

  var
    tfile: textfile;
    sline: string;
    iTrigger: Integer;
  end;

var
  Form_Booking_History: TForm_Booking_History;

implementation

{$R *.dfm}

procedure TForm_Booking_History.Button_HideClick(Sender: TObject);
begin
  Form_Booking_History.hide;
  Form_Booking_History.Width := 0;
  iTrigger := 0;
end;

procedure FitGrid(Grid: TDBGrid);
const
  C_Add = 3;
var
  ds: TDataSet;
  bm: TBookmark;
  i: Integer;
  w: Integer;
  a: array of Integer;
begin
  ds := Grid.DataSource.DataSet;

  if not Assigned(ds) then
    exit;

  if Grid.Columns.Count = 0 then
    exit;

  ds.DisableControls;
  bm := ds.GetBookmark;
  try
    ds.First;
    SetLength(a, Grid.Columns.Count);
    for i := 0 to Grid.Columns.Count - 1 do
      if Assigned(Grid.Columns[i].Field) then
        a[i] := Grid.Canvas.TextWidth(Grid.Columns[i].FieldName);

    while not ds.Eof do
    begin

      for i := 0 to Grid.Columns.Count - 1 do
      begin
        if not Assigned(Grid.Columns[i].Field) then
          continue;

        w := Grid.Canvas.TextWidth
          (ds.FieldByName(Grid.Columns[i].Field.FieldName).DisplayText);

        if a[i] < w then
          a[i] := w;
      end;
      ds.Next;
    end;

    w := 0;
    for i := 0 to Grid.Columns.Count - 1 do
    begin
      Grid.Columns[i].Width := a[i] + C_Add;
      inc(w, a[i] + C_Add);
    end;

    w := (Grid.ClientWidth - w - 20) div (Grid.Columns.Count);

    if w > 0 then
      for i := 0 to Grid.Columns.Count - 1 do
        Grid.Columns[i].Width := Grid.Columns[i].Width + w;

    ds.GotoBookmark(bm);
  finally
    ds.FreeBookmark(bm);
    ds.EnableControls;
  end;
end;

procedure TForm_Booking_History.Edit1Change(Sender: TObject);
begin
  if Edit_Search.text = 'Search Here' then
  begin
    Edit_Search.Clear;
  end;
end;

procedure TForm_Booking_History.Edit1Click(Sender: TObject);
begin
  if Edit1.text = 'Search Here' then
  begin
    Edit1.Clear;
  end;
end;

procedure TForm_Booking_History.Edit1MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
begin
  // if Edit1.text = 'Search Here' then
  // begin
  // Edit1.Clear;
  // end;
  // OVRead := CreateOleObject('SAPI.SPVoice');
  // OVRead.speak('Click here to search animal name');
end;

procedure TForm_Booking_History.Edit_SearchChange(Sender: TObject);
begin
  if Edit_Search.text = 'Search Here' then
  begin
    Edit_Search.Clear;
  end;
end;

procedure TForm_Booking_History.Edit_SearchMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
begin
  // if Edit_Search.text = 'Search Here' then
  // begin
  // Edit_Search.Clear;
  // end;
  // OVRead := CreateOleObject('SAPI.SPVoice');
  // OVRead.speak('search owner name here');
end;

procedure TForm_Booking_History.FormCreate(Sender: TObject);
var
  MyTFILE: textfile;
  MySLine: string;
begin

  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements5;
  ResetHiddenElements6;
  Image_Down.Visible := false;
  Image_Up.Visible := false;
  Form_Booking_History.left := 550;
  Form_Booking_History.Width := 0;
  Timer_Anim.Enabled := true;

  AssignFile(MyTFILE, 'ActiveAccount.txt');
  Reset(MyTFILE);
  Readln(MyTFILE, MySLine);
  if MySLine = 'Admin' then
  begin

  end;
  if MySLine = 'Standard' then
  begin

  end;

  CloseFile(MyTFILE);

end;

procedure TForm_Booking_History.FormMouseEnter(Sender: TObject);
begin
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements5;
  ResetHiddenElements6;
end;

procedure TForm_Booking_History.FormShow(Sender: TObject);
begin
  DBGrid1.DataSource := MyDataModule.DataSource1;
  AssignFile(tfile, 'HistoryMode.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  with MyDataModule.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM tblKennel_History');
    open;
  end;

  FitGrid(DBGrid1);
  Form_Booking_History.left := 550;
  Form_Booking_History.Width := 0;
  Timer_Anim.Enabled := true;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations');
      open;
    end;
    Image15.Hint := 'Search for Donator Name';
    Edit1.Hint := 'Search for Donator Name';
    Edit_Search.Hint := 'Search for Donator Surname';
    Image_Searchbox_Search.Hint := 'Search for Donator Surname';
  end;

  if sline = 'BookingMode' then
  begin
    Label_Title_Register_Animal.Caption := 'Booking History';
    DBGrid1.DataSource := MyDataModule.DataSource_Kennel_History;
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History');
      open;
    end;
    FitGrid(DBGrid1);
    Image_SortAlpha.Picture.LoadFromFile
      ('button_sort-by-alphabetical-name.png');
    Image_SortAnimalKind.Picture.LoadFromFile('button_sort-by-animal-kind.png');
    Image_SortCheckIn.Picture.LoadFromFile('button_sort-by-check-in-date.png');
    Image_SortCost.Picture.LoadFromFile('button_sort-by-cost.png');
    ImageSortAlphaPet.Picture.LoadFromFile
      ('button_sort-by-alphabetical-pet-name.png');
    Image7.Picture.LoadFromFile('button_sort-by-id-order.png');

    Image15.Hint := 'Search for Pet Name';
    Edit1.Hint := 'Search for Pet Name';
    Edit_Search.Hint := 'Search for Owner Name';
    Image_Searchbox_Search.Hint := 'Search for Owner Name';
  end;

  // AssignFile(tfile, 'HistoryMode.txt');
  // Reset(tfile);
  // Readln(tfile, sline);
  // CloseFile(tfile);
  if sline = 'DonationMode' then
  begin
    Label_Title_Register_Animal.Caption := 'Donation History';
    DBGrid1.DataSource := MyDataModule.DataSource_Donations;
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History');
      open;
    end;
    FitGrid(DBGrid1);
    Image_SortAlpha.Picture.LoadFromFile('button_sort-by-donator-name.png');
    Image_SortAnimalKind.Picture.LoadFromFile
      ('button_sort-by-donator-surname.png');
    Image_SortCheckIn.Picture.LoadFromFile('button_sort-by-e-mail-adress.png');
    Image_SortCost.Picture.LoadFromFile('button_sort-by-phone-number.png');
    ImageSortAlphaPet.Picture.LoadFromFile('button_sort-by-amount-donated.png');
    Image7.Picture.LoadFromFile('button_sort-by-purpose-of-donation.png');
  end;

end;

procedure TForm_Booking_History.Image10Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'CheckOutDate ASC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY CheckOutDate ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image10MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort check out date in ascending order');
    end;
  end;
end;

procedure TForm_Booking_History.Image11Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'CheckOUTDate DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY CheckOUTDate DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image11MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort check out date in descending order');
    end;
  end;
end;

procedure TForm_Booking_History.Image12Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'AnimalID ASC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY AnimalID ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY PurposeDonation ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image12MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal ID in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort purpose of donation in ascending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image13Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'AnimalID DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY AnimalID DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY PurposeDonation DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image13MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal ID in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak
        ('Click here to sort purpose of donation in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image15Click(Sender: TObject);
var
  sNewLine, ssearch: string;
  tNewFile: textfile;
begin
  ssearch := Edit1.text;
  AssignFile(tNewFile, 'HistoryMode.txt');
  Reset(tNewFile);
  Readln(tNewFile, sNewLine);
  CloseFile(tNewFile);
  if sNewLine = 'BookingMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource1;
    with DataModule.MyDataModule do
    begin
      ADOQuery1.close;
      ADOQuery1.sql.Clear;
      ADOQuery1.sql.Add('SELECT * from tblKennel_History WHERE PetName LIKE ''%'
        + ssearch + '%''');
      ADOQuery1.open;
    end;
    FitGrid(DBGrid1);
  end;

  if sNewLine = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with DataModule.MyDataModule do
    begin
      ADOQuery2.close;
      ADOQuery2.sql.Clear;
      ADOQuery2.sql.Add('SELECT * from tblDonations WHERE NameDonator LIKE ''%'
        + ssearch + '%''');
      ADOQuery2.open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image1Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetType ASC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetType ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY SurnameDonator ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image1MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal kind in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator surname in ascending order');
    end;

  end;
end;

// Topped Here
procedure TForm_Booking_History.Image2Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetType DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetType DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY SurnameDonator DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image2MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal kind in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator surname in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image3Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetName ASC';

  if sline = 'BookingMode' then
  begin

    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetName ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY AmountDonator ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image3MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort pet name in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort amount donated in ascending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image4Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetName DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetName DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY AmountDonator DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image4MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort pet name in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort amount donated in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image5Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'TotalStayPrice ASC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY TotalStayPrice ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY PhoneDonator ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image5MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort cost of stay in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort phone numbers in ascending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image6Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'TotalStayPrice DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY TotalStayPrice DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY PhoneDonator DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image6MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort cost of stay in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort phone numbers in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image7MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements5;
  Timer6.Enabled := true;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal ID ');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort purpose of donation  ');
    end;

  end;
end;

procedure TForm_Booking_History.Image8Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'CheckInDate ASC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY CheckInDate ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY EmailDonator ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image8MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort check in date in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort e-mail adress in ascending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image9Click(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'CheckInDate DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY CheckInDate DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY EmailDonator DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image9MouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort check in date in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort e-mail adress in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.ImageSortAlphaPetClick(Sender: TObject);
begin
  ResetHiddenElements1;
end;

procedure TForm_Booking_History.ImageSortAlphaPetMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  Timer3.Enabled := true;
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements4;
  ResetHiddenElements5;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort pet name ');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort amount donated ');
    end;

  end;
end;

procedure TForm_Booking_History.Image_DownClick(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetOwnerName DESC';

  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetOwnerName DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY NameDonator DESC');
      open;
    end;
    FitGrid(DBGrid1);
  end;
end;

procedure TForm_Booking_History.Image_DownMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  tfile, tfile2: textfile;
  sline, sLine2: string;
begin
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort owner name in descending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator name in descending order');
    end;

  end;
end;

procedure TForm_Booking_History.Image_Searchbox_SearchClick(Sender: TObject);
var
  sNewLine, ssearch: string;
  tNewFile: textfile;
begin
  ssearch := Edit1.text;
  AssignFile(tNewFile, 'HistoryMode.txt');
  Reset(tNewFile);
  Readln(tNewFile, sNewLine);
  CloseFile(tNewFile);
  if sNewLine = 'BookingMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource1;
    with DataModule.MyDataModule do
    begin
      ADOQuery1.close;
      ADOQuery1.sql.Clear;
      ADOQuery1.sql.Add
        ('SELECT * from tblKennel_History WHERE PetOwnerName LIKE ''%' +
        ssearch + '%''');
      ADOQuery1.open;
    end;
    FitGrid(DBGrid1);
  end;

  if sNewLine = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with DataModule.MyDataModule do
    begin
      ADOQuery2.close;
      ADOQuery2.sql.Clear;
      ADOQuery2.sql.Add
        ('SELECT * from tblDonations WHERE SurnameDonator LIKE ''%' +
        ssearch + '%''');
      ADOQuery2.open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image_SortAlphaMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  Timer1.Enabled := true;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements5;
  ResetHiddenElements6;
  AssignFile(CheckTfile, 'EnableTTS.txt');
  Reset(CheckTfile);
  Readln(CheckTfile, Checksline);
  CloseFile(CheckTfile);
  if Checksline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);
    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort owner name');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator name');
    end;

  end;

end;

procedure TForm_Booking_History.Image_SortAnimalKindClick(Sender: TObject);
begin
  ResetHiddenElements1;
end;

procedure TForm_Booking_History.Image_SortAnimalKindMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  ResetHiddenElements1;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements5;
  ResetHiddenElements6;
  Timer2.Enabled := true;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort animal kind  ');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator surname  ');
    end;

  end;
end;

procedure TForm_Booking_History.Image_SortCheckInClick(Sender: TObject);
begin
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements6;
  Timer5.Enabled := true;
end;

procedure TForm_Booking_History.Image_SortCheckInMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements4;
  ResetHiddenElements6;
  Timer5.Enabled := true;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort check in/ check out date  ');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort e-mail adress  ');
    end;

  end;
end;

procedure TForm_Booking_History.Image_SortCostClick(Sender: TObject);
begin
  ResetHiddenElements1;
end;

procedure TForm_Booking_History.Image_SortCostMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  ResetHiddenElements1;
  ResetHiddenElements2;
  ResetHiddenElements3;
  ResetHiddenElements5;
  ResetHiddenElements6;
  Timer4.Enabled := true;
  AssignFile(tfile, 'EnableTTS.txt');
  Reset(tfile);
  Readln(tfile, sline);
  CloseFile(tfile);
  if sline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);

    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort cost of stay  ');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort phone numbers  ');
    end;

  end;
end;

procedure TForm_Booking_History.Image_UpClick(Sender: TObject);
begin
  DataModule.MyDataModule.tbl_Kennel_History.Sort := 'PetOwnerName ASC';
  if sline = 'BookingMode' then
  begin
    with MyDataModule.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History ORDER BY PetOwnerName ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if sline = 'DonationMode' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource2;
    with MyDataModule.ADOQuery2 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblDonations ORDER BY NameDonator ASC');
      open;
    end;
    FitGrid(DBGrid1);
  end;

end;

procedure TForm_Booking_History.Image_UpMouseEnter(Sender: TObject);
var
  OVRead: OleVariant;
  CheckTfile, tfile2: textfile;
  Checksline, sLine2: string;
begin
  AssignFile(CheckTfile, 'EnableTTS.txt');
  Reset(CheckTfile);
  Readln(CheckTfile, Checksline);
  CloseFile(CheckTfile);
  if Checksline = 'Active' then
  begin
    AssignFile(tfile2, 'HistoryMode.txt');
    Reset(tfile2);
    Readln(tfile2, sLine2);
    CloseFile(tfile2);
    ShowMessage(sLine2);
    if sLine2 = 'BookingMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort owner name in ascending order');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak('Click here to sort donator name in ascending order');
    end;

  end;
end;

procedure TForm_Booking_History.ResetHiddenElements1;
begin
  Image_Up.top := 500;
  Image_Up.left := 300;
  Image_Down.top := 535;
  Image_Down.left := 300;
  Image_Down.Visible := false;
  Image_Up.Visible := false;
  Timer1.Enabled := false;
end;

procedure TForm_Booking_History.ResetHiddenElements2;
begin
  Image1.top := 570;
  Image1.left := 300;
  Image2.top := 600;
  Image2.left := 300;
  Image1.Visible := false;
  Image2.Visible := false;
  Timer2.Enabled := false;
end;

procedure TForm_Booking_History.ResetHiddenElements3;
begin

  Image3.left := 500;
  Image4.left := 500;
  // Image3.top := 399;
  // Image4.top := 430;
  Image3.Visible := false;
  Image4.Visible := false;
  Timer3.Enabled := false;
end;

procedure TForm_Booking_History.ResetHiddenElements4;
begin
  Image5.top := 570;
  Image6.top := 600;
  Image5.left := 500;
  Image6.left := 500;
  Image5.Visible := false;
  Image6.Visible := false;
  Timer4.Enabled := false;
end;

procedure TForm_Booking_History.ResetHiddenElements5;
begin
  Image8.top := 640;
  Image9.top := 670;
  Image8.left := 300;
  Image9.left := 300;

  Image10.top := 640;
  Image11.top := 670;
  Image10.left := 350;
  Image11.left := 350;

  Image8.Visible := false;
  Image9.Visible := false;
  Image10.Visible := false;
  Image11.Visible := false;
  Timer5.Enabled := false;
end;

procedure TForm_Booking_History.ResetHiddenElements6;
begin
  Image12.top := 640;
  Image13.top := 670;
  Image12.left := 500;
  Image13.left := 500;
  Image12.Visible := false;
  Image13.Visible := false;
end;

procedure TForm_Booking_History.Timer1Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if Image_Up.left > 300 then
  begin
    Image_Up.Visible := Enabled;
  end;
  if Image_Up.left > 300 then
  begin
    Image_Down.Visible := Enabled;
  end;
  if Image_Down.left = 360 then
    exit;
  iPos := Image_Up.left;
  iPos := iPos + 10;
  Image_Up.left := iPos;
  if Image_Up.left = 360 then
  begin
    Timer1.Enabled := false;
  end;
  if Image_Down.left = 360 then
    exit;
  iPos := Image_Down.left;
  iPos := iPos + 10;
  Image_Down.left := iPos;
  if Image_Down.left = 360 then
  begin
    Timer1.Enabled := false;
  end;

end;

procedure TForm_Booking_History.Timer2Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if Image1.left > 300 then
  begin
    Image1.Visible := Enabled;
  end;
  if Image1.left > 300 then
  begin
    Image2.Visible := Enabled;
  end;
  if Image2.left = 360 then
    exit;
  iPos := Image1.left;
  iPos := iPos + 10;
  Image1.left := iPos;
  if Image1.left = 360 then
  begin
    Timer2.Enabled := false;
  end;
  if Image2.left = 360 then
    exit;
  iPos := Image2.left;
  iPos := iPos + 10;
  Image2.left := iPos;
  if Image2.left = 360 then
  begin
    Timer2.Enabled := false;
  end;

end;

procedure TForm_Booking_History.Timer3Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if Image3.left > 300 then
  begin
    Image3.Visible := true;
  end;
  if Image4.left > 300 then
  begin
    Image4.Visible := true;
  end;
  if Image4.left = 440 then
    exit;
  iPos := Image3.left;
  iPos := iPos - 10;
  Image3.left := iPos;
  if Image3.left = 440 then
  begin
    Timer3.Enabled := false;
  end;
  if Image4.left = 440 then
    exit;
  iPos := Image4.left;
  iPos := iPos - 10;
  Image4.left := iPos;
  if Image4.left = 440 then
  begin
    Timer3.Enabled := false;
  end;

end;

procedure TForm_Booking_History.Timer4Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if Image5.left > 300 then
  begin
    Image5.Visible := true;
  end;
  if Image6.left > 300 then
  begin
    Image6.Visible := true;
  end;
  if Image6.left = 440 then
    exit;
  iPos := Image5.left;
  iPos := iPos - 10;
  Image5.left := iPos;
  if Image5.left = 440 then
  begin
    Timer4.Enabled := false;
  end;
  if Image6.left = 440 then
    exit;
  iPos := Image6.left;
  iPos := iPos - 10;
  Image6.left := iPos;
  if Image6.left = 440 then
  begin
    Timer4.Enabled := false;
  end;
end;

procedure TForm_Booking_History.Timer5Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if sline = 'BookingMode' then
  begin
    if Image8.left > 300 then
    begin
      Image8.Visible := Enabled;
    end;
    if Image8.left > 300 then
    begin
      Image9.Visible := Enabled;
    end;
    if Image9.left = 360 then
      exit;
    iPos := Image8.left;
    iPos := iPos + 10;
    Image8.left := iPos;
    if Image8.left = 360 then
    begin
      Timer5.Enabled := false;
    end;
    if Image9.left = 360 then
      exit;
    iPos := Image9.left;
    iPos := iPos + 10;
    Image9.left := iPos;
    if Image9.left = 360 then
    begin
      Timer5.Enabled := false;
    end;

    if Image10.left > 300 then
    begin
      Image10.Visible := Enabled;
    end;
    if Image10.left > 300 then
    begin
      Image11.Visible := Enabled;
    end;
    if Image11.left = 390 then
      exit;
    iPos := Image10.left;
    iPos := iPos + 10;
    Image10.left := iPos;
    if Image10.left = 390 then
    begin
      Timer5.Enabled := false;
    end;
    if Image11.left = 390 then
      exit;
    iPos := Image11.left;
    iPos := iPos + 10;
    Image11.left := iPos;
    if Image11.left = 390 then
    begin
      Timer5.Enabled := false;
    end;
  end;

  if sline = 'DonationMode' then
  begin
    if Image8.left > 300 then
    begin
      Image8.Visible := Enabled;
    end;
    if Image8.left > 300 then
    begin
      Image9.Visible := Enabled;
    end;
    if Image9.left = 360 then
      exit;
    iPos := Image8.left;
    iPos := iPos + 10;
    Image8.left := iPos;
    if Image8.left = 360 then
    begin
      Timer5.Enabled := false;
    end;
    if Image9.left = 360 then
      exit;
    iPos := Image9.left;
    iPos := iPos + 10;
    Image9.left := iPos;
    if Image9.left = 360 then
    begin
      Timer5.Enabled := false;
    end;

  end;
end;

procedure TForm_Booking_History.Timer6Timer(Sender: TObject);
var
  iPos: Integer;
begin
  if Image12.left > 300 then
  begin
    Image12.Visible := true;
  end;
  if Image13.left > 300 then
  begin
    Image13.Visible := true;
  end;
  if Image13.left = 440 then
    exit;
  iPos := Image12.left;
  iPos := iPos - 10;
  Image12.left := iPos;
  if Image12.left = 440 then
  begin
    Timer6.Enabled := false;
  end;
  if Image13.left = 440 then
    exit;
  iPos := Image13.left;
  iPos := iPos - 10;
  Image13.left := iPos;
  if Image13.left = 440 then
  begin
    Timer6.Enabled := false;
  end;

end;

procedure TForm_Booking_History.Timer_AnimTimer(Sender: TObject);
begin

  if Form_Booking_History.Width <> 828 then
  begin
    Form_Booking_History.Width := Form_Booking_History.Width + 36;

  end;

  if Form_Booking_History.Width = 828 then
  begin
    Timer_Anim.Enabled := false;
  end;

end;

end.
