object MyTextForm: TMyTextForm
  Left = 0
  Top = 135
  BorderStyle = bsNone
  Caption = 'MyTextForm'
  ClientHeight = 650
  ClientWidth = 660
  Color = clDefault
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
  object RichEdit1: TRichEdit
    Left = 8
    Top = 8
    Width = 644
    Height = 634
    BevelInner = bvNone
    BorderStyle = bsNone
    Color = 3815994
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Zoom = 100
    OnClick = RichEdit1Click
  end
  object Timer_Anim: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer_AnimTimer
    Left = 616
    Top = 8
  end
end
