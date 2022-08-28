unit Kennel_Price;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, ComObj;

type
  TForm_Kennel_Prices = class(TForm)
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    Label_Title_Register_Animal: TLabel;
    Panel2: TPanel;
    Image_Deluxe: TImage;
    Image_Standard: TImage;
    Panel1: TPanel;
    Panel3: TPanel;
    RichEdit_Medical: TRichEdit;
    RichEdit1: TRichEdit;
    procedure Timer_AnimTimer(Sender: TObject);
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RichEdit_MedicalMouseEnter(Sender: TObject);
    procedure RichEdit1MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Kennel_Prices: TForm_Kennel_Prices;

implementation

{$R *.dfm}

procedure TForm_Kennel_Prices.Button_HideClick(Sender: TObject);
begin
  Form_Kennel_Prices.hide;
  Form_Kennel_Prices.Width := 0;
end;

procedure TForm_Kennel_Prices.FormShow(Sender: TObject);
begin
  Form_Kennel_Prices.left := 550;
  Form_Kennel_Prices.Width := 0;
  Timer_Anim.Enabled := true;
end;

procedure TForm_Kennel_Prices.RichEdit1MouseEnter(Sender: TObject);
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

procedure TForm_Kennel_Prices.RichEdit_MedicalMouseEnter(Sender: TObject);
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
    OVRead.speak(RichEdit_Medical.Text);
  end;

end;

procedure TForm_Kennel_Prices.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Kennel_Prices.Width <> 828 then
  begin
    Form_Kennel_Prices.Width := Form_Kennel_Prices.Width + 36;

  end;

  if Form_Kennel_Prices.Width = 828 then
  begin
    Timer_Anim.Enabled := false;
  end;

end;

end.
