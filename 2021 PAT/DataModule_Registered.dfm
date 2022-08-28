object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 369
  Width = 574
  object DataSourceCD: TDataSource
    DataSet = tblCD
    Left = 232
    Top = 216
  end
  object ConCDDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Sauraav Ja' +
      'yrajh\Documents\Non_Profit_DB.mdb;Mode=ReadWrite;Persist Securit' +
      'y Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 104
    Top = 112
  end
  object tblCD: TADOTable
    Active = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Sauraav Ja' +
      'yrajh\Documents\Non_Profit_DB.mdb;Mode=ReadWrite;Persist Securit' +
      'y Info=False'
    CursorType = ctStatic
    TableName = 'tbAnimals'
    Left = 400
    Top = 96
  end
end
