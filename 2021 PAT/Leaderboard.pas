unit Leaderboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, DataModule, ComObj;

type
  TForm_Acceptable_List = class(TForm)
    Timer_Anim: TTimer;
    Label_Title_Register_Animal: TLabel;
    Button_Hide: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image2: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image3: TImage;
    procedure Button_HideClick(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel3Enter(Sender: TObject);
    procedure Panel1MouseEnter(Sender: TObject);
    procedure Panel4MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Acceptable_List: TForm_Acceptable_List;

implementation

{$R *.dfm}

procedure TForm_Acceptable_List.Button_HideClick(Sender: TObject);
begin
  Form_Acceptable_List.hide;
  Form_Acceptable_List.Width := 0;
end;

procedure TForm_Acceptable_List.FormShow(Sender: TObject);
begin
  Form_Acceptable_List.left := 550;
  Form_Acceptable_List.Width := 0;
  Timer_Anim.Enabled := true;

  with DataModule.MyDataModule do
  begin
    ADO_Donations.Open;
    ADO_Donations.Sort := 'AmountDonator DESC';
    ADO_Donations.First;
    Label1.Caption := ADO_Donations['NameDonator'] + ' ' + ADO_Donations
      ['SurnameDonator'];
    Label2.Caption := 'R' + (IntToStr(ADO_Donations['AmountDonator']));
    ADO_Donations.Next;
    Label7.Caption := ADO_Donations['NameDonator'] + ' ' + ADO_Donations
      ['SurnameDonator'];
    Label8.Caption := 'R' + (IntToStr(ADO_Donations['AmountDonator']));
    ADO_Donations.Next;
    Label11.Caption := ADO_Donations['NameDonator'] + ' ' + ADO_Donations
      ['SurnameDonator'];
    Label12.Caption := 'R' + (IntToStr(ADO_Donations['AmountDonator']));
    ADO_Donations.Close;
  end;

end;

procedure TForm_Acceptable_List.Panel1MouseEnter(Sender: TObject);
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
    OVRead.speak('In second place is ' + Label7.Caption + '. They donated ' +
      Label8.Caption + ' rands');
  end;

end;

procedure TForm_Acceptable_List.Panel3Enter(Sender: TObject);
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
    OVRead.speak('In first place is ' + Label1.Caption + '. They donated ' +
      Label2.Caption + ' rands');
  end;

end;

procedure TForm_Acceptable_List.Panel4MouseEnter(Sender: TObject);
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
    OVRead.speak('In third place is ' + Label11.Caption + '. They donated ' +
      Label12.Caption + ' rands');
  end;

end;

procedure TForm_Acceptable_List.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Acceptable_List.Width <> 828 then
  begin
    Form_Acceptable_List.Width := Form_Acceptable_List.Width + 36;

  end;

  if Form_Acceptable_List.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
