unit Thrift_Store;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm_Thrift_Store = class(TForm)
    Label_Title_Register_Animal: TLabel;
    Timer_Anim: TTimer;
    Button_Hide: TButton;
    procedure Button_HideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer_AnimTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Thrift_Store: TForm_Thrift_Store;

implementation

{$R *.dfm}

procedure TForm_Thrift_Store.Button_HideClick(Sender: TObject);
begin
  Form_Thrift_Store.hide;
  Form_Thrift_Store.Width := 0;
end;

procedure TForm_Thrift_Store.FormShow(Sender: TObject);
begin
  Form_Thrift_Store.left := 550;
  Form_Thrift_Store.Width := 0;
  Timer_Anim.Enabled := true;
end;

procedure TForm_Thrift_Store.Timer_AnimTimer(Sender: TObject);
begin
  if Form_Thrift_Store.Width <> 828 then
  begin
    Form_Thrift_Store.Width := Form_Thrift_Store.Width + 36;

  end;

  if Form_Thrift_Store.Width = 828 then
  begin
    Timer_Anim.Enabled := false;

  end;
end;

end.
