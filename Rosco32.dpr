program Rosco32;

uses
  Vcl.Forms,
  fRosco32 in 'fRosco32.pas' {frmMainForm},
  MyGlobal6Color in '..\..\CompDX\10-BluberiComp\KwashVCL\MyGlobal6Color.pas',
  uCommonStuff in '..\Callidus\Common\uCommonStuff.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ROSCO32';
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
