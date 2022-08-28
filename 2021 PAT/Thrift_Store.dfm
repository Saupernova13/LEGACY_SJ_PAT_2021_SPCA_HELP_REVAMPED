object Form_Thrift_Store: TForm_Thrift_Store
  Left = 0
  Top = 135
  BorderStyle = bsNone
  Caption = 'Form_Thrift_Store'
  ClientHeight = 650
  ClientWidth = 650
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label_Title_Register_Animal: TLabel
    Left = 230
    Top = 8
    Width = 224
    Height = 43
    Caption = 'Thrift Store'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Georgia'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Button_Hide: TButton
    Left = 296
    Top = 600
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = Button_HideClick
  end
  object Timer_Anim: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer_AnimTimer
    Left = 616
    Top = 8
  end
end
