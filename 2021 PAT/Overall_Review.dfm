object Form_Overall_Review: TForm_Overall_Review
  Left = 0
  Top = 135
  BorderStyle = bsNone
  Caption = 'Form_Overall Review'
  ClientHeight = 650
  ClientWidth = 704
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
    Left = 198
    Top = 8
    Width = 286
    Height = 43
    Caption = 'Overall Review'
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
  object Panel2: TPanel
    Left = 24
    Top = 57
    Width = 618
    Height = 3
    BevelOuter = bvNone
    Color = clMedGray
    ParentBackground = False
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 66
    Width = 611
    Height = 408
    Color = clWhite
    DataSource = MyDataModule.DataSource_Kennel_History
    FixedColor = clWhite
    GradientEndColor = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Georgia'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 24
    Top = 480
    Width = 610
    Height = 25
    DataSource = MyDataModule.DataSource_Kennel_History
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 527
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 4
    Text = 'tblAnimals'
    OnChange = ComboBox1Change
    Items.Strings = (
      'tblAnimals'
      'tblDonations'
      'tblKennel_InUse'
      'tblKennel_History'
      'tblStaff_Active'
      'tblStaff_History')
  end
  object Timer_Anim: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer_AnimTimer
    Left = 616
    Top = 8
  end
end
