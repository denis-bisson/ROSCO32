program Rosco32;

uses
  Vcl.Forms,
  fRosco32 in 'fRosco32.pas' {frmMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ROSCO32';
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
