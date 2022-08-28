unit Register_Procedure;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.ComCtrls, ComObj;

type
  TForm_Register_Procedure = class(TForm)
    Label_Title_Register_Animal: TLabel;
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Panel2: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Panel4: TPanel;
    Panel5: TPanel;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    RichEdit_Medical: TRichEdit;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    procedure Button_HideClick(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure RichEdit_MedicalMouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    iCount: integer;
    sP1: string;
    sP2: string;
    sP3: string;
  end;

var
  Form_Register_Procedure: TForm_Register_Procedure;

implementation

{$R *.dfm}

procedure TForm_Register_Procedure.Button_HideClick(Sender: TObject);
begin
  Form_Register_Procedure.hide;
  Form_Register_Procedure.Width := 0;
end;

procedure TForm_Register_Procedure.FormShow(Sender: TObject);
begin
  Form_Register_Procedure.left := 550;
  Form_Register_Procedure.Width := 0;
  Timer_Anim.Enabled := true;
  iCount := 1;
  Image4.visible := false;

end;

procedure TForm_Register_Procedure.Image3Click(Sender: TObject);
begin
  iCount := iCount + 1;
  Image4.visible := true;
  sP2 := RichEdit1.Text;
  sP3 := RichEdit2.Text;
  if iCount = 2 then
  begin
    Label1.Caption := 'Step 2';
    Label2.Caption := 'Catching the Animal and Getting Help';
    Image2.Picture.LoadFromFile('Retrieve.jpg');
    sP1 := RichEdit_Medical.Text;
    RichEdit_Medical.Text := sP2;
    Image3.visible := true;
  end;
  if iCount = 3 then
  begin
    Label1.Caption := 'Step 3';
    Label2.Caption := 'Trying to Find the Owner';
    Image2.Picture.LoadFromFile('Receiver.jpg');
    RichEdit_Medical.Text := sP3;
    Image3.visible := false;
  end;
  if iCount = 4 then
  begin
    iCount := iCount - 1;
  end;
end;

procedure TForm_Register_Procedure.Image4Click(Sender: TObject);
begin
  iCount := iCount - 1;
  if iCount = 0 then
  begin
    iCount := iCount + 1;
  end;
  if iCount = 1 then
  begin
    Image4.visible := false;
    Label1.Caption := 'Step 1';
    Label2.Caption := 'Making the Animal Feel Safe';
    Image2.Picture.LoadFromFile('Approach.jpg');
    RichEdit_Medical.Text := sP1;
    Image3.visible := true;
  end;
  if iCount = 2 then
  begin
    Label1.Caption := 'Step 2';
    Label2.Caption := 'Catching the Animal and Getting Help';
    Image2.Picture.LoadFromFile('Retrieve.jpg');
    sP1 := RichEdit_Medical.Text;
    RichEdit_Medical.Text := sP2;
    Image3.visible := true;
  end;
  if iCount = 3 then
  begin
    Label1.Caption := 'Step 3';
    Label2.Caption := 'Trying to Find the Owner';
    Image2.Picture.LoadFromFile('Receiver.jpg');
    RichEdit_Medical.Text := sP3;
    Image3.visible := false;
  end;
end;

procedure TForm_Register_Procedure.RichEdit_MedicalMouseEnter(Sender: TObject);
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
      OVRead.speak('Click here to search animal name');
    end;
    if sLine2 = 'DonationMode' then
    begin
      OVRead := CreateOleObject('SAPI.SPVoice');
      OVRead.speak(RichEdit_Medical.Text);
    end;

  end;

end;

procedure TForm_Register_Procedure.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Register_Procedure.Width <> 828 then
  begin
    Form_Register_Procedure.Width := Form_Register_Procedure.Width + 36;

  end;

  if Form_Register_Procedure.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
