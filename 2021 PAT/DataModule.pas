unit DataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TMyDataModule = class(TDataModule)
    ConCDDB: TADOConnection;
    tbl_Kennel: TADOTable;
    DataSource_Kennel: TDataSource;
    tbl_Animal: TADOTable;
    DataSource_Animal: TDataSource;
    tbl_Kennel_History: TADOTable;
    DataSource_Kennel_History: TDataSource;
    tbl_People: TADOTable;
    DataSource_People: TDataSource;
    ADO_Donations: TADOTable;
    DataSource_Donations: TDataSource;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    ADOQuery3: TADOQuery;
    DataSource3: TDataSource;
    tbl_Donations: TADOTable;
    DS_Donations2: TDataSource;
    tbl_People_History: TADOTable;
    DataSource4: TDataSource;
    ADOQuery4: TADOQuery;
    DataSource5: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyDataModule: TMyDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
