unit Overall_Review;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, DataModule;

// , DataModule;

type
  TForm_Overall_Review = class(TForm)
    Label_Title_Register_Animal: TLabel;
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ComboBox1: TComboBox;
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Overall_Review: TForm_Overall_Review;

implementation

{$R *.dfm}

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

procedure TForm_Overall_Review.Button_HideClick(Sender: TObject);
begin
  Form_Overall_Review.hide;
  Form_Overall_Review.Width := 0;
end;

procedure TForm_Overall_Review.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Text = 'tblAnimals' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource5;
    DBNavigator1.DataSource := MyDataModule.DataSource5;
    with MyDataModule.ADOQuery4 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tbAnimals');
      open;
    end;
    FitGrid(DBGrid1);
  end;
  /// ///////////
  if ComboBox1.Text = 'tblDonations' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource5;
    DBNavigator1.DataSource := MyDataModule.DataSource5;
    with MyDataModule.ADOQuery4 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM  tblDonations');
      open;
    end;
    FitGrid(DBGrid1);
  end;
  /// ///////////
  ///
  ///
  if ComboBox1.Text = 'tblKennel_InUse' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource5;
    DBNavigator1.DataSource := MyDataModule.DataSource5;
    with MyDataModule.ADOQuery4 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_InUse');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if ComboBox1.Text = 'tblKennel_History' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource5;
    DBNavigator1.DataSource := MyDataModule.DataSource5;
    with MyDataModule.ADOQuery4 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblKennel_History');
      open;
    end;
    FitGrid(DBGrid1);
  end;

  if ComboBox1.Text = 'tblStaff_Active' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource_People;
    DBNavigator1.DataSource := MyDataModule.DataSource_People;
    FitGrid(DBGrid1);
  end;

  if ComboBox1.Text = 'tblStaff_History' then
  begin
    DBGrid1.DataSource := MyDataModule.DataSource5;
    DBNavigator1.DataSource := MyDataModule.DataSource5;
    with MyDataModule.ADOQuery4 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * FROM tblStaff_History');
      open;
    end;
    FitGrid(DBGrid1);
  end;
end;

procedure TForm_Overall_Review.FormShow(Sender: TObject);
var
  tfile: textfile;
  sLine: string;

begin
  Form_Overall_Review.left := 550;
  Form_Overall_Review.Width := 0;
  Timer_Anim.Enabled := true;

//  AssignFile(tfile, 'ActiveAccount.txt');
//  Reset(tfile);
//  Readln(tfile, sLine);
//  CloseFile(tfile);
//  if sLine = 'Standard' then
//  begin
//    ShowMessage('You can not access this form without admin privelages');
//    Form_Overall_Review.hide;
//  end;

end;

procedure TForm_Overall_Review.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Overall_Review.Width <> 828 then
  begin
    Form_Overall_Review.Width := Form_Overall_Review.Width + 36;

  end;

  if Form_Overall_Review.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
