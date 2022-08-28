object MyDataModule: TMyDataModule
  OldCreateOrder = False
  Height = 453
  Width = 757
  object ConCDDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Sauraav Ja' +
      'yrajh\Documents\Embarcadero\Studio\Projects\2021 PAT\Win32\Debug' +
      '\Non_Profit_DB.mdb;Mode=ReadWrite;Persist Security Info=False;Je' +
      't OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:' +
      'Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database ' +
      'Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glo' +
      'bal Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet O' +
      'LEDB:Create System Database=False;Jet OLEDB:Encrypt Database=Fal' +
      'se;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compac' +
      't Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 256
    Top = 168
  end
  object tbl_Kennel: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblKennel_InUse'
    Left = 16
    Top = 8
  end
  object DataSource_Kennel: TDataSource
    DataSet = tbl_Kennel
    Left = 32
    Top = 56
  end
  object tbl_Animal: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tbAnimals'
    Left = 200
    Top = 16
  end
  object DataSource_Animal: TDataSource
    DataSet = tbl_Animal
    Left = 200
    Top = 64
  end
  object tbl_Kennel_History: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblKennel_History'
    Left = 360
    Top = 8
  end
  object DataSource_Kennel_History: TDataSource
    DataSet = tbl_Kennel_History
    Left = 360
    Top = 56
  end
  object tbl_People: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblStaff_Active'
    Left = 16
    Top = 304
  end
  object DataSource_People: TDataSource
    DataSet = tbl_People
    Left = 16
    Top = 352
  end
  object ADO_Donations: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblDonations'
    Left = 352
    Top = 312
  end
  object DataSource_Donations: TDataSource
    DataSet = ADO_Donations
    Left = 352
    Top = 376
  end
  object ADOQuery1: TADOQuery
    Connection = ConCDDB
    DataSource = DataSource_Kennel_History
    Parameters = <>
    Left = 512
    Top = 224
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 520
    Top = 280
  end
  object ADOQuery2: TADOQuery
    Connection = ConCDDB
    DataSource = DataSource_Donations
    Parameters = <>
    Left = 608
    Top = 224
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 616
    Top = 280
  end
  object ADOQuery3: TADOQuery
    Connection = ConCDDB
    DataSource = DataSource_Donations
    Parameters = <>
    Left = 576
    Top = 336
  end
  object DataSource3: TDataSource
    DataSet = ADOQuery3
    Left = 584
    Top = 392
  end
  object tbl_Donations: TADOTable
    Active = True
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblDonations'
    Left = 528
    Top = 24
  end
  object DS_Donations2: TDataSource
    DataSet = tbl_Donations
    Left = 544
    Top = 72
  end
  object tbl_People_History: TADOTable
    Connection = ConCDDB
    CursorType = ctStatic
    TableName = 'tblStaff_History'
    Left = 96
    Top = 320
  end
  object DataSource4: TDataSource
    DataSet = tbl_People_History
    Left = 96
    Top = 368
  end
  object ADOQuery4: TADOQuery
    Connection = ConCDDB
    DataSource = DataSource_Donations
    Parameters = <>
    Left = 664
    Top = 336
  end
  object DataSource5: TDataSource
    DataSet = ADOQuery4
    Left = 672
    Top = 392
  end
end
