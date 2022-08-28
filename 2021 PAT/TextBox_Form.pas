unit TextBox_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TMyTextForm = class(TForm)
    RichEdit1: TRichEdit;
    Timer_Anim: TTimer;
    procedure RichEdit1Click(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyTextForm: TMyTextForm;

implementation

{$R *.dfm}

procedure TMyTextForm.FormShow(Sender: TObject);
begin
  MyTextForm.left := 550;
  MyTextForm.Width := 0;
  Timer_Anim.Enabled := true;
end;

procedure TMyTextForm.RichEdit1Click(Sender: TObject);
begin
  MyTextForm.Hide;
end;

procedure TMyTextForm.Timer_AnimTimer(Sender: TObject);
begin
  if MyTextForm.Width <> 828 then
  begin
    MyTextForm.Width := MyTextForm.Width + 36;

  end;

  if MyTextForm.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
