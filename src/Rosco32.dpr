//********************************************************************************
//* ROSCO32                                                                      *
//* -----------------------------------------------------------------------------*
//* Application to make some fun with past draw results of Loto-Québec 6/49      *
//* lottery draw results.                                                        *
//* May be executed prior build, commmit, backup, etc. to remove unused files.   *
//* Written by Denis Bisson, Drummondville, Québec, 2021-09-16.                  *
//* -----------------------------------------------------------------------------*
//* Originally written by Denis Bisson, Drummondville, Québec, Canada            *
//*   https://github.com/denis-bisson/                                           *
//*   2021-09-16                                                                 *
//* -----------------------------------------------------------------------------*
//* You should not remove these comments.                                        *
//********************************************************************************
//*

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
