program Project1;

uses
  Vcl.Forms,
  MatPat in 'MatPat.pas' {Form_Main},
  Kennel_Book in 'Kennel_Book.pas' {Form_Kennel_Booking},
  Register_Animal in 'Register_Animal.pas' {Form_Register_Animal},
  Booking_History in 'Booking_History.pas' {Form_Booking_History},
  Kennel_InUse in 'Kennel_InUse.pas' {Form_Kennel_InUse},
  Kennel_Price in 'Kennel_Price.pas' {Form_Kennel_Prices},
  Check_Registered in 'Check_Registered.pas' {Form_Check_Registered},
  Register_Procedure in 'Register_Procedure.pas' {Form_Register_Procedure},
  Overall_Review in 'Overall_Review.pas' {Form_Overall_Review},
  Make_Donation in 'Make_Donation.pas' {Form_Make_Donation},
  Prize_Picker in 'Prize_Picker.pas' {Form_Prize_Picker},
  Leaderboard in 'Leaderboard.pas' {Form_Acceptable_List},
  SPCA_Team in 'SPCA_Team.pas' {Form_SPCA_Team},
  Pet_Owners in 'Pet_Owners.pas' {Form_Pet_Owners},
  Thrift_Store in 'Thrift_Store.pas' {Form_Thrift_Store},
  DataModule in 'DataModule.pas' {MyDataModule: TDataModule},
  Unit_Pet in 'Unit_Pet.pas',
  TextBox_Form in 'TextBox_Form.pas' {MyTextForm},
  Unit_Kennel in 'Unit_Kennel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_Kennel_Booking, Form_Kennel_Booking);
  Application.CreateForm(TForm_Register_Animal, Form_Register_Animal);
  Application.CreateForm(TForm_Booking_History, Form_Booking_History);
  Application.CreateForm(TForm_Kennel_InUse, Form_Kennel_InUse);
  Application.CreateForm(TForm_Kennel_Prices, Form_Kennel_Prices);
  Application.CreateForm(TForm_Check_Registered, Form_Check_Registered);
  Application.CreateForm(TForm_Register_Procedure, Form_Register_Procedure);
  Application.CreateForm(TForm_Overall_Review, Form_Overall_Review);
  Application.CreateForm(TForm_Make_Donation, Form_Make_Donation);
  Application.CreateForm(TForm_Prize_Picker, Form_Prize_Picker);
  Application.CreateForm(TForm_Acceptable_List, Form_Acceptable_List);
  Application.CreateForm(TForm_SPCA_Team, Form_SPCA_Team);
  Application.CreateForm(TForm_Pet_Owners, Form_Pet_Owners);
  Application.CreateForm(TForm_Thrift_Store, Form_Thrift_Store);
  Application.CreateForm(TMyDataModule, MyDataModule);
  Application.CreateForm(TMyTextForm, MyTextForm);
  Application.Run;
end.
