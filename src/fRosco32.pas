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

unit fRosco32;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Gauges;

const
  MAXSEARCHNUMBER = 10;

type
  TTirage = record
    Date: string;
    Numbers: array[0..6] of integer;
  end;

  TfrmMainForm = class(TForm)
    alMainActionList: TActionList;
    mmMainMenu: TMainMenu;
    tbMainToolBar: TToolBar;
    sbMainStatusBar: TStatusBar;
    ilMainImageList: TImageList;
    aeMainApplicationEvent: TApplicationEvents;
    pgMainPageControl: TPageControl;
    tsLog: TTabSheet;
    StatusWindow: TRichEdit;
    actChercheCetteCombinaison: TAction;
    actValideLeFichierDesNumeros: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Action1: TMenuItem;
    Validelefichierdesnumros1: TMenuItem;
    Cherchecettecombinaison1: TMenuItem;
    MasterGage: TGauge;
    tsResults: TTabSheet;
    ResultPageControl: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    memo06: TMemo;
    memo06p: TMemo;
    memo16: TMemo;
    memo16p: TMemo;
    memo26: TMemo;
    memo26p: TMemo;
    memo36: TMemo;
    memo36p: TMemo;
    memo46: TMemo;
    memo46p: TMemo;
    memo56: TMemo;
    memo56p: TMemo;
    memo66: TMemo;
    TabSheet16: TTabSheet;
    memoSommaire: TMemo;
    actExit: TAction;
    N1: TMenuItem;
    Sortie1: TMenuItem;
    pmMain: TPopupMenu;
    Validelefichierdesnumros2: TMenuItem;
    Cherchecettecombinaison2: TMenuItem;
    N2: TMenuItem;
    Sortie2: TMenuItem;
    actEdit: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    TabSheet1: TTabSheet;
    memo66p: TMemo;
    actMiseEclair: TAction;
    ToolButton6: TToolButton;
    Panel1: TPanel;
    edContain: TLabeledEdit;
    edMustNotContain: TLabeledEdit;
    edWantedComplementaire: TLabeledEdit;
    edNotWantedComplementaire: TLabeledEdit;
    TabSheet2: TTabSheet;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet23: TTabSheet;
    TabSheet24: TTabSheet;
    TabSheet25: TTabSheet;
    TabSheet26: TTabSheet;
    TabSheet27: TTabSheet;
    TabSheet28: TTabSheet;
    TabSheet29: TTabSheet;
    MemoR06: TMemo;
    MemoR06p: TMemo;
    MemoR16: TMemo;
    MemoR16P: TMemo;
    MemoR26: TMemo;
    MemoR26p: TMemo;
    MemoR36: TMemo;
    MemoR36p: TMemo;
    MemoR46: TMemo;
    MemoR46p: TMemo;
    MemoR56: TMemo;
    MemoR56p: TMemo;
    MemoR66: TMemo;
    MemoR66p: TMemo;
    pmMiseEclair: TPopupMenu;
    Rechercheavec1numro1: TMenuItem;
    Rechercheavec2numros1: TMenuItem;
    Rechercheavec3numros1: TMenuItem;
    Rechercheavec4numros1: TMenuItem;
    Rechercheavec5numros1: TMenuItem;
    Rechercheavec6numros1: TMenuItem;
    Rechercheavec7numros1: TMenuItem;
    Rechercheavec8numros1: TMenuItem;
    Rechercheavec9numros1: TMenuItem;
    Rechercheavec10numros1: TMenuItem;
    Rechercheavec11numros1: TMenuItem;
    Rechercheavec12numros1: TMenuItem;
    Rechercheavec13numros1: TMenuItem;
    Rechercheavec14numros1: TMenuItem;
    Rechercheavec15numros1: TMenuItem;
    Rechercheavec16numros1: TMenuItem;
    Rechercheavec17numros1: TMenuItem;
    Rechercheavec18numros1: TMenuItem;
    Rechercheavec19numros1: TMenuItem;
    Rechercheavec20numros1: TMenuItem;
    ditelefichierdesnumros1: TMenuItem;
    Miseclair1: TMenuItem;
    ditelefichierdesnumros2: TMenuItem;
    Miseclair2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aeMainApplicationEventIdle(Sender: TObject; var Done: Boolean);
    procedure MiseEclairClick(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actValideLeFichierDesNumerosExecute(Sender: TObject);
    procedure actMiseEclairExecute(Sender: TObject);
    procedure actChercheCetteCombinaisonExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
  private
    { Private declarations }
    bFinalActionResult: boolean;
    iNombreDeTirage: integer;
    pMemo: array[0..1] of array[0..1] of array[0..6] of ^TMemo;
    Tirages: array[0..9999] of TTirage;
    WinningResult: array[0..1] of array[0..1] of array[0..MAXSEARCHNUMBER] of integer;
    WantedFinalSheet: TTabSheet;
    bFirstIdle: boolean;
    lbDominicBoule: TStringList;
    slWantedNumbers, slNonWantedNumbers, slComplemantaireWanted, slComplementaireNonWanted: TStringList;
    procedure WriteStatus(const sMessageToShow: string; const iColorToUse: dword);
    function LoadDatabaseInMemory: boolean;
    function IntegreCesNumeros(sLineNumber: string; var sErrorString: string): boolean;
    function ValidateSearchedNumberAreCorrect: boolean;
    function MakeSureNothingInCommon(slNumbers1, slNumbers2: TStringList): boolean;
    function DoSearchingJob: boolean;
    function ShowResult: boolean;
    function GetALineForThisCombinaison(paramTirage: integer; bGotComplementaire: boolean): string;
    function SanitizeExpression(edExpression: TLabeledEdit; slNumbers: TStringList): boolean;
    function SanitizeAllExpressions: boolean;
    procedure DisableToute;
    procedure EnableToute;
    procedure LoadConfiguration;
    procedure SaveConfiguration;
  public
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.dfm}

uses
  //Delphi
  Registry, ShellAPI, System.UITypes;

const
  BASELOCATIONOFREGISTRYINI = 'SOFTWARE\DENISBISSON\ROSCO32';
  MAINCONFIGSECTION = 'MainSection';

  COLORDANGER = clOlive;
  COLORSUCCESS = clGreen;
  COLORERROR = clRed;
  COLORSTATUS = clBlack;
  COLORWINDOW_WORKING = $D0FFFF;
  COLORWINDOW_SUCCESS = $E0FFE0;
  COLORWINDOW_ERROR = $E0E0FF;

{ TfrmMainForm.FormCreate }
procedure TfrmMainForm.FormCreate(Sender: TObject);
begin
  lbDominicBoule := TStringList.Create;
  lbDominicBoule.Sorted := True;
  lbDominicBoule.Duplicates := dupIgnore;

  slWantedNumbers := TStringList.Create;
  slWantedNumbers.Sorted := True;
  slWantedNumbers.Duplicates := dupIgnore;
  slWantedNumbers.QuoteChar := #0;
  slWantedNumbers.StrictDelimiter := True;
  slWantedNumbers.Delimiter := ',';

  slNonWantedNumbers := TStringList.Create;
  slNonWantedNumbers.Sorted := True;
  slNonWantedNumbers.Duplicates := dupIgnore;
  slNonWantedNumbers.QuoteChar := #0;
  slNonWantedNumbers.StrictDelimiter := True;
  slNonWantedNumbers.Delimiter := ',';

  slComplemantaireWanted := TStringList.Create;
  slComplemantaireWanted.Sorted := True;
  slComplemantaireWanted.Duplicates := dupIgnore;
  slComplemantaireWanted.QuoteChar := #0;
  slComplemantaireWanted.StrictDelimiter := True;
  slComplemantaireWanted.Delimiter := ',';

  slComplementaireNonWanted := TStringList.Create;
  slComplementaireNonWanted.Sorted := False;
  slComplementaireNonWanted.Duplicates := dupIgnore;
  slComplementaireNonWanted.QuoteChar := #0;
  slComplementaireNonWanted.StrictDelimiter := True;
  slComplementaireNonWanted.Delimiter := ',';

  bFirstIdle := True;
  Caption := 'ROSCO32 v2.2';
  pMemo[0][0][0] := addr(memo06);
  pMemo[0][1][0] := addr(memo06p);
  pMemo[0][0][1] := addr(memo16);
  pMemo[0][1][1] := addr(memo16p);
  pMemo[0][0][2] := addr(memo26);
  pMemo[0][1][2] := addr(memo26p);
  pMemo[0][0][3] := addr(memo36);
  pMemo[0][1][3] := addr(memo36p);
  pMemo[0][0][4] := addr(memo46);
  pMemo[0][1][4] := addr(memo46p);
  pMemo[0][0][5] := addr(memo56);
  pMemo[0][1][5] := addr(memo56p);
  pMemo[0][0][6] := addr(memo66);
  pMemo[0][1][6] := addr(memo66p);

  pMemo[1][0][0] := addr(memoR06);
  pMemo[1][1][0] := addr(memoR06p);
  pMemo[1][0][1] := addr(memoR16);
  pMemo[1][1][1] := addr(memoR16p);
  pMemo[1][0][2] := addr(memoR26);
  pMemo[1][1][2] := addr(memoR26p);
  pMemo[1][0][3] := addr(memoR36);
  pMemo[1][1][3] := addr(memoR36p);
  pMemo[1][0][4] := addr(memoR46);
  pMemo[1][1][4] := addr(memoR46p);
  pMemo[1][0][5] := addr(memoR56);
  pMemo[1][1][5] := addr(memoR56p);
  pMemo[1][0][6] := addr(memoR66);
  pMemo[1][1][6] := addr(memoR66p);
end;

{ TfrmMainForm.FormClose }
procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveConfiguration;
end;

{ TfrmMainForm.aeMainApplicationEventIdle }
procedure TfrmMainForm.aeMainApplicationEventIdle(Sender: TObject; var Done: Boolean);
begin
  if bFirstIdle then
  begin
    bFirstIdle := FALSE;
    LoadConfiguration;
  end;
end;

{ TfrmMainForm.MiseEclairClick }
procedure TfrmMainForm.MiseEclairClick(Sender: TObject);
var
  iWantedNumberOfNumbers, iIndex: integer;
  sRemainingNumbers: TStringList;
begin
  iWantedNumberOfNumbers := TComponent(Sender).Tag;

  DisableToute;
  try
    slWantedNumbers.Clear;
    edContain.Text := '';
    WantedFinalSheet := tsResults;
    ResultPageControl.ActivePageIndex := 0;
    if SanitizeAllExpressions then
      if ValidateSearchedNumberAreCorrect then
      begin
        sRemainingNumbers := TStringList.Create;
        try
          sRemainingNumbers.Sorted := True;
          sRemainingNumbers.Duplicates := dupIgnore;
          for iIndex := 1 to 49 do
            if (self.slNonWantedNumbers.IndexOf(IntToStr(iIndex)) = -1) and (self.slComplemantaireWanted.IndexOf(IntToStr(iIndex)) = -1) then
              sRemainingNumbers.Add(IntToStr(iIndex));

          if sRemainingNumbers.Count >= iWantedNumberOfNumbers then
          begin
            randomize;
            while slWantedNumbers.Count < iWantedNumberOfNumbers do
            begin
              iIndex := random(sRemainingNumbers.Count);
              slWantedNumbers.Add(sRemainingNumbers.Strings[iIndex]);
              sRemainingNumbers.Delete(iIndex);
            end;

            edContain.Text := slWantedNumbers.CommaText;

            if LoadDatabaseInMemory then
              if DoSearchingJob then
                bFinalActionResult := ShowResult;
          end
          else
          begin
            WriteStatus('ERREUR: Avec vos critères, il ne me reste pas assez de numéros disponibles pour pondre une combinaison-éclair répondant à' +
              ' vos critères et votre demande!', COLORERROR);
          end;
        finally
          sRemainingNumbers.Free;
        end;
      end;
  finally
    EnableToute;
  end;
end;

{ TfrmMainForm.actEditExecute }
procedure TfrmMainForm.actEditExecute(Sender: TObject);
var
  sNomFichierIn: string;
begin
  sNomFichierIn := paramstr(0);
  sNomFichierIn := IncludeTrailingPathDelimiter(ExtractFilePath(sNomFichierIn)) + 'Quebec49.txt';
  WriteStatus('On vérifie la présence du fichier ' + sNomFichierIn + ' ...', COLORDANGER);
  if FileExists(sNomFichierIn) then
  begin
    ShellExecute(Application.Handle, 'open', PChar(sNomFichierIn), nil, PChar(ExtractFilePath(sNomFichierIn)), SW_SHOWNORMAL); // SW_NORMAL
  end
  else
  begin
    MessageDlg('ERREUR: Je ne trouve pas le fichier des numéro...' + #$0A + #$0A + 'Normalement: ' + sNomFichierIn, mtError, [mbOk], 0);
  end;
end;

{ TfrmMainForm.actValideLeFichierDesNumerosExecute }
procedure TfrmMainForm.actValideLeFichierDesNumerosExecute(Sender: TObject);
begin
  DisableToute;
  try
    bFinalActionResult := LoadDatabaseInMemory;
  finally
    EnableToute;
  end;
end;

{ TfrmMainForm.actMiseEclairExecute }
procedure TfrmMainForm.actMiseEclairExecute(Sender: TObject);
var
  pPopupLocation: TPoint;
begin
  GetCursorPos(pPopupLocation);
  pmMiseEclair.Popup(pPopupLocation.X, pPopupLocation.Y);
end;

{ TfrmMainForm.actChercheCetteCombinaisonExecute }
procedure TfrmMainForm.actChercheCetteCombinaisonExecute(Sender: TObject);
begin
  DisableToute;
  try
    WantedFinalSheet := tsResults;
    ResultPageControl.ActivePageIndex := 0;
    if SanitizeAllExpressions then
      if ValidateSearchedNumberAreCorrect then
        if LoadDatabaseInMemory then
          if DoSearchingJob then
            bFinalActionResult := ShowResult;
  finally
    EnableToute;
  end;
end;

{ TfrmMainForm.actExitExecute }
procedure TfrmMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

{ TfrmMainForm.WriteStatus }
procedure TfrmMainForm.WriteStatus(const sMessageToShow: string; const iColorToUse: dword);
var
  iHour, iMinute, iSec, iMilliSec: word;
begin
  DecodeTime(now, iHour, iMinute, iSec, iMilliSec);
  StatusWindow.SelAttributes.Color := iColorToUse;
  StatusWindow.Lines.Add(Format('%2.2d:%2.2d:%2.2d:%3.3d:%s', [iHour, iMinute, iSec, iMilliSec, sMessageToShow]));
  Application.ProcessMessages;
end;

{ TfrmMainForm.LoadDatabaseInMemory }
function TfrmMainForm.LoadDatabaseInMemory: boolean;
var
  slLocalList: TStringList;
  iLineNumber, NbError: integer;
  sNomFichierIn, sWorkingLine, sErrorString: string;
begin
  result := FALSE;
  iNombreDeTirage := 0;
  slLocalList := TStringList.Create;
  try
    sNomFichierIn := paramstr(0);
    sNomFichierIn := IncludeTrailingPathDelimiter(ExtractFilePath(sNomFichierIn)) + 'Quebec49.txt';
    WriteStatus('On vérifie la présence du fichier ' + sNomFichierIn + ' ...', COLORDANGER);
    if FileExists(sNomFichierIn) then
    begin
      WriteStatus('Le fichier a été trouvé!', COLORSUCCESS);

      WriteStatus('On charge en mémoire le fichier des numéros...', COLORDANGER);
      slLocalList.LoadFromFile(sNomFichierIn);
      WriteStatus('Le fichier a été chargé!', COLORSUCCESS);

      WriteStatus('On valide l''intégrité du fichier...', COLORDANGER);
      NbError := 0;
      for iLineNumber := 0 to pred(slLocalList.Count) do
      begin
        sWorkingLine := StringReplace(slLocalList.Strings[iLineNumber], ' ', '', [rfReplaceAll, rfIgnoreCase]);
        if length(sWorkingLine) > 0 then
        begin
          if length(sWorkingLine) = 23 then
          begin
            if IntegreCesNumeros(sWorkingLine, sErrorString) then
            begin
            end
            else
            begin
              WriteStatus('Erreur avec la ligne #' + IntToStr(iLineNumber + 1) + ': ' + slLocalList.Strings[iLineNumber], COLORERROR);
              WriteStatus(sErrorString, COLORERROR);
              WriteStatus('', COLORSTATUS);
              inc(NbError);
            end;
          end
          else
          begin
            WriteStatus('Erreur avec la ligne #' + IntToStr(iLineNumber + 1) + ': ' + slLocalList.Strings[iLineNumber], COLORERROR);
            WriteStatus('', COLORSTATUS);
            inc(NbError);
          end;
        end;
      end;

      if NbError = 0 then
      begin
        WriteStatus('Nombre total de tirage importés: ' + IntToStr(iNombreDeTirage), COLORSUCCESS);
        result := True;
      end;
    end
    else
    begin
      WriteStatus('ERREUR: On ne trouve pas le fichier des numéros!', COLORERROR);
      WriteStatus('', COLORSTATUS);
    end;
  finally
    FreeAndNil(slLocalList);
  end;
end;

{ TfrmMainForm.IntegreCesNumeros }
//12345678901
//Oct04199704214142464839
function TfrmMainForm.IntegreCesNumeros(sLineNumber: string; var sErrorString: string): boolean;
var
  LocalNumber: array[0..6] of integer;
  i, j: integer;
  bKeepGoing: boolean;
begin
  result := False;

  for i := 0 to 6 do
    LocalNumber[i] := StrToIntDef(copy(sLineNumber, 10 + (i * 2), 2), 0);

  bKeepGoing := True;
  i := 0;
  while (i < 7) and (bKeepGoing) do
  begin
    if (LocalNumber[i] < 1) or (LocalNumber[i] > 49) then
    begin
      bKeepGoing := False;
      sErrorString := 'On détecte un numéro invalide: ' + IntToStr(LocalNumber[i]);
    end;
    inc(i);
  end;

  if bKeepGoing then
  begin
    i := 0;
    while (i < 6) and (bKeepGoing) do
    begin
      j := i + 1;
      while (j < 7) and (bKeepGoing) do
      begin
        if LocalNumber[i] = LocalNumber[j] then
        begin
          bKeepGoing := False;
          sErrorString := 'On détecte un numéro en double: ' + IntToStr(LocalNumber[i]);
        end;
        inc(j);
      end;
      inc(i);
    end;
  end;

  if bKeepGoing then
  begin
    //1234567890
    //Oct04199704214142464839
    Tirages[iNombreDeTirage].Date := copy(sLineNumber, 1, 3) + ' ' + copy(sLineNumber, 4, 2) + ' ' + copy(sLineNumber, 6, 4);
    for i := 0 to 6 do
      Tirages[iNombreDeTirage].Numbers[i] := LocalNumber[i];

    inc(iNombreDeTirage);
    result := True;
  end;
end;

{ TfrmMainForm.ValidateSearchedNumberAreCorrect }
function TfrmMainForm.ValidateSearchedNumberAreCorrect: boolean;
begin
  result := False;

  WriteStatus('Doit contenir: ', COLORSTATUS);
  WriteStatus('    ' + slWantedNumbers.DelimitedText, COLORDANGER);
  WriteStatus('Ne doit pas contenir: ', COLORSTATUS);
  WriteStatus('    ' + slNonWantedNumbers.DelimitedText, COLORDANGER);
  WriteStatus('Complémentaire doit contenir: ', COLORSTATUS);
  WriteStatus('    ' + slComplemantaireWanted.DelimitedText, COLORDANGER);
  WriteStatus('Complémentaire ne doit pas contenir: ', COLORSTATUS);
  WriteStatus('    ' + slComplementaireNonWanted.DelimitedText, COLORDANGER);
  WriteStatus('', COLORSTATUS);

  if MakeSureNothingInCommon(slWantedNumbers, slNonWantedNumbers) then
  begin
    if MakeSureNothingInCommon(slComplemantaireWanted, slComplementaireNonWanted) then
    begin
      if MakeSureNothingInCommon(slWantedNumbers, slComplemantaireWanted) then
      begin
        result := True;
      end
      else
      begin
        WriteStatus('ERREUR: On ne peut pas exigé d''avoir le même numéro dans la combinaison principale et dans le complémentaire...', COLORERROR);
      end;
    end
    else
    begin
      WriteStatus('ERREUR: Votre liste de numéros qui doit être contenu dans le complémentaire ne peut pas contenir un numéro qui ne doit pas être contenu en même temps...', COLORERROR);
    end;
  end
  else
  begin
    WriteStatus('ERREUR: Votre liste de numéros qui doit être contenu ne peut pas contenir un numéro qui ne doit pas être contenu en même temps...', COLORERROR);
  end;
end;

{ TfrmMainForm.MakeSureNothingInCommon }
function TfrmMainForm.MakeSureNothingInCommon(slNumbers1, slNumbers2: TStringList): boolean;
var
  iIndex: integer;
begin
  result := True;
  iIndex := 0;
  while (iIndex < slNumbers1.Count) and (result) do
  begin
    if slNumbers2.IndexOf(slNumbers1.Strings[iIndex]) <> -1 then
    begin
      WriteStatus(Format('ERREUR: Le numéro suivant est contenu dans deux liste: %s', [slNumbers1.Strings[iIndex]]), COLORERROR);
      result := False;
    end;
    inc(iIndex);
  end;
end;

{ TfrmMainForm.DoSearchingJob }
function TfrmMainForm.DoSearchingJob: boolean;
var
  iBoule, iTirage, NbDeBoulePareil, NbUnwantedBall, NbBouleComplementaire: integer;
begin
  WriteStatus('On lance notre recherche...', COLORDANGER);

  MasterGage.MinValue := 0;
  MasterGage.Progress := 0;
  MasterGage.MaxValue := iNombreDeTirage;
  MasterGage.Visible := True;
  iTirage := 0;
  while (iTirage < iNombreDeTirage) do
  begin
    NbDeBoulePareil := 0;
    NbUnwantedBall := 0;
    NbBouleComplementaire := 0;
    for iBoule := 0 to 5 do
    begin
      if slWantedNumbers.IndexOf(IntToStr(Tirages[iTirage].Numbers[iBoule])) <> -1 then
        inc(NbDeBoulePareil);
      if slNonWantedNumbers.IndexOf(IntToStr(Tirages[iTirage].Numbers[iBoule])) <> -1 then
        inc(NbUnwantedBall);
    end;

    if slComplemantaireWanted.IndexOf(IntToStr(Tirages[iTirage].Numbers[6])) <> -1 then
      inc(NbBouleComplementaire);

    if slComplementaireNonWanted.IndexOf(IntToStr(Tirages[iTirage].Numbers[6])) <> -1 then
      inc(NbUnwantedBall);

    if (NbBouleComplementaire > 0) then
    begin
      if NbUnwantedBall = 0 then
      begin
        inc(WinningResult[0][1][NbDeBoulePareil]);
        pMemo[0][1][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, True));
      end
      else
      begin
        inc(WinningResult[1][1][NbDeBoulePareil]);
        pMemo[1][1][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, True));
      end;
    end
    else
    begin
      if NbUnwantedBall = 0 then
      begin
        inc(WinningResult[0][0][NbDeBoulePareil]);
        pMemo[0][0][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, False));
      end
      else
      begin
        inc(WinningResult[1][0][NbDeBoulePareil]);
        pMemo[1][0][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, False));
      end;
    end;

    inc(iTirage);
    MasterGage.Progress := MasterGage.Progress + 1;
    if MasterGage.Progress mod 64 = 0 then
      Application.ProcessMessages;
  end;

  WriteStatus('La recherche est complétée!', COLORSUCCESS);
  result := True;
end;

{ GetDashLine }
function GetDashLine(Lg: integer): string;
begin
  result := '-';
  while length(result) < Lg do
    result := result + '-';
end;

{ TfrmMainForm.ShowResult }
function TfrmMainForm.ShowResult: boolean;
var
  iLocalTotal, iWinning: integer;
  sStatLine: string;
begin
  result := False;
  iLocalTotal := 0;

  for iWinning := 0 to 6 do
  begin
    sStatLine := '      Nombre de ' + IntToStr(iWinning) + '/6 : ' + IntToStr(WinningResult[0][0][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[0][0][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[0][0][iWinning]^.Lines.Insert(0, sStatLine);
    WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[0][0][iWinning];

    sStatLine := '      Nombre de ' + IntToStr(iWinning) + '/6+: ' + IntToStr(WinningResult[0][1][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[0][1][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[0][1][iWinning]^.Lines.Insert(0, sStatLine);
    WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[0][1][iWinning];

    sStatLine := 'Nombre de Rejet ' + IntToStr(iWinning) + '/6 : ' + IntToStr(WinningResult[1][0][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[1][0][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[1][0][iWinning]^.Lines.Insert(0, sStatLine);
    WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[1][0][iWinning];

    sStatLine := 'Nombre de Rejet ' + IntToStr(iWinning) + '/6+: ' + IntToStr(WinningResult[1][1][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[1][1][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[1][1][iWinning]^.Lines.Insert(0, sStatLine);
    WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[1][1][iWinning];
  end;

  memoSommaire.Lines.Add('');
  sStatLine := '                    Total: ' + IntToStr(iLocalTotal);
  memoSommaire.Lines.Add(sStatLine);
  WriteStatus(sStatLine, COLORSUCCESS);
  sStatLine := 'Tirage dans notre fichier: ' + IntToStr(iNombreDeTirage);
  memoSommaire.Lines.Add(sStatLine);
  WriteStatus(sStatLine, COLORSUCCESS);

  if iLocalTotal = iNombreDeTirage then
  begin
    WriteStatus('Succès! Ces résulats correspondant à notre nombre de tirages dans le fichier!', COLORSUCCESS);
    result := True;
  end
  else
  begin
    WriteStatus('ERREUR: Le nombre de tirages dans notre fichiers ne balance avec ces résultats...', COLORERROR);
  end;
end;

{ TfrmMainForm.GetALineForThisCombinaison }
function TfrmMainForm.GetALineForThisCombinaison(paramTirage: integer; bGotComplementaire: boolean): string;
var
  iBoule: integer;
  sBoule: string;
begin
  result := Tirages[paramTirage].Date + ' : ';
  for iBoule := 0 to 5 do
  begin
    sBoule := Format('%.2d', [Tirages[paramTirage].Numbers[iBoule]]);
    if lbDominicBoule.IndexOf(sBoule) <> -1 then
      sBoule := '<' + sBoule + '>'
    else
      sBoule := ' ' + sBoule + ' ';
    result := result + sBoule;
  end;

  sBoule := Format('%.2d', [Tirages[paramTirage].Numbers[6]]);
  if bGotComplementaire then
    sBoule := '<' + sBoule + '>'
  else
    sBoule := ' ' + sBoule + ' ';
  result := result + '  [' + sBoule + ']';
end;

{ TfrmMainForm.SanitizeExpression }
function TfrmMainForm.SanitizeExpression(edExpression: TLabeledEdit; slNumbers: TStringList): boolean;
const
  sLEGALCHARACTERS: string = '0123456789-,';
  sDIGITS: string = '0123456789';
var
  iSeeker, iErrorPosition, iPreviousNumber: integer;
  sMaybeExpression, sCurrentNumber, sArrow: string;
  bKeepGoing, bWeCurrentlyHaveDash: boolean;

  function LocalAddNumber(iLow, iHigh: integer): boolean;
  var
    iIndex: integer;
  begin
    result := False;

    if iLow = 0 then
      iLow := iHigh;

    iIndex := iLow;
    while (iIndex <= iHigh) and (bKeepGoing) do
    begin
      if slNumbers.IndexOf(IntToStr(iIndex)) = -1 then
      begin
        slNumbers.Add(IntToStr(iIndex));
      end
      else
      begin
        WriteStatus('ERREUR: Vous tentez d''incorporer deux fois le numéro ' + IntToStr(iIndex), COLORERROR);
        bKeepGoing := False;
        iErrorPosition := pred(iSeeker);
      end;

      inc(iIndex);
    end;

    if (pred(iIndex) = iHigh) and (bKeepGoing) then
      result := True;
  end;

begin
  result := False;
  sMaybeExpression := edExpression.Text;
  sMaybeExpression := StringReplace(sMaybeExpression, ' ', '', [rfReplaceAll]);
  edExpression.Text := sMaybeExpression;
  slNumbers.Clear;

  bKeepGoing := True;
  sCurrentNumber := '';
  iPreviousNumber := 0;
  bWeCurrentlyHaveDash := False;
  iErrorPosition := 1;
  iSeeker := 1;

  if length(sMaybeExpression) > 0 then
  begin
    while (iSeeker <= length(sMaybeExpression)) and (bKeepGoing) do
    begin
      if pos(sMaybeExpression[iSeeker], sDIGITS) <> 0 then
      begin
        sCurrentNumber := sCurrentNumber + sMaybeExpression[iSeeker];
        inc(iSeeker);
      end
      else
      begin
        if sMaybeExpression[iSeeker] = ',' then
        begin
          if sCurrentNumber <> '' then
          begin
            if (StrToInt(sCurrentNumber) >= 0) and (StrToInt(sCurrentNumber) <= 49) then
            begin
              if bWeCurrentlyHaveDash and (iPreviousNumber >= StrToInt(sCurrentNumber)) then
              begin
                WriteStatus('ERREUR: Le second numéro d''un intervalle doit être plug grand que le premier...', COLORERROR);
                iErrorPosition := pred(iSeeker);
                bKeepGoing := False;
              end
              else
              begin
                if LocalAddNumber(iPreviousNumber, StrToInt(sCurrentNumber)) then
                begin
                  sCurrentNumber := '';
                  iPreviousNumber := 0;
                  bWeCurrentlyHaveDash := False;
                  inc(iSeeker);
                end;
              end;
            end
            else
            begin
              WriteStatus('ERREUR: Valeur de numéro hors norme. Doit être entre 1 et 49 compris.', COLORERROR);
              iErrorPosition := pred(iSeeker);
              bKeepGoing := False;
            end;
          end
          else
          begin
            iErrorPosition := iSeeker;
            bKeepGoing := False;
          end;
        end
        else
        begin
          if sMaybeExpression[iSeeker] = '-' then
          begin
            if (not bWeCurrentlyHaveDash) and (sCurrentNumber <> '') then
            begin
              if (StrToInt(sCurrentNumber) >= 0) and (StrToInt(sCurrentNumber) <= 49) then
              begin
                iPreviousNumber := StrToInt(sCurrentNumber);
                sCurrentNumber := '';
                bWeCurrentlyHaveDash := True;
                inc(iSeeker);
              end
              else
              begin
                WriteStatus('ERREUR: Valeur de numéro hors norme. Doit être entre 1 et 49 compris.', COLORERROR);
                iErrorPosition := pred(iSeeker);
                bKeepGoing := False;
              end;
            end
            else
            begin
              iErrorPosition := iSeeker;
              bKeepGoing := False;
            end
          end
          else
          begin
            iErrorPosition := iSeeker;
            bKeepGoing := False;
          end;
        end;
      end;
    end;

    if bKeepGoing then
    begin
      if sCurrentNumber <> '' then
      begin
        if (StrToInt(sCurrentNumber) >= 0) and (StrToInt(sCurrentNumber) <= 49) then
        begin
          if bWeCurrentlyHaveDash and (iPreviousNumber >= StrToInt(sCurrentNumber)) then
          begin
            WriteStatus('ERREUR: Le second numéro d''un intervalle doit être plug grand que le premier...', COLORERROR);
            iErrorPosition := pred(iSeeker);
            bKeepGoing := False;
          end
          else
          begin
            if LocalAddNumber(iPreviousNumber, StrToInt(sCurrentNumber)) then
            begin
            end;
          end;
        end
        else
        begin
          WriteStatus('ERREUR: Valeur de numéro hors norme. Doit être entre 1 et 49 compris.', COLORERROR);
          iErrorPosition := pred(iSeeker);
          bKeepGoing := False;
        end;
      end
      else
      begin
        WriteStatus('ERREUR: L''expression semble mal se terminée...', COLORERROR);
        iErrorPosition := pred(iSeeker);
        bKeepGoing := False;
      end;
    end;
  end;

  if ((pred(iSeeker) = length(sMaybeExpression)) and (bKeepGoing)) or (length(sMaybeExpression) = 0) then
  begin
    result := True;
  end
  else
  begin
    sArrow := '';
    while length(sArrow) < pred(iErrorPosition) do
      sArrow := sArrow + ' ';
    WriteStatus(Format('ERREUR dans cette expression: "%s"', [StringReplace(edExpression.EditLabel.Caption, '&', '', [rfReplaceAll])]), COLORERROR);
    WriteStatus(sArrow + '|', COLORERROR);
    WriteStatus(edExpression.Text, COLORERROR);
    WriteStatus(sArrow + '|', COLORERROR);
  end;
end;

{ TfrmMainForm.SanitizeAllExpressions }
function TfrmMainForm.SanitizeAllExpressions: boolean;
begin
  result := False;
  if SanitizeExpression(edContain, slWantedNumbers) then
    if SanitizeExpression(edMustNotContain, slNonWantedNumbers) then
      if SanitizeExpression(edWantedComplementaire, slComplemantaireWanted) then
        if SanitizeExpression(edNotWantedComplementaire, slComplementaireNonWanted) then
          result := True;
end;

{ TfrmMainForm.DisableToute }
procedure TfrmMainForm.DisableToute;
var
  iAction, iRejet, iComplementaire, iResult: integer;
begin
  for iAction := 0 to pred(alMainActionList.ActionCount) do
    alMainActionList.Actions[iAction].Enabled := FALSE;
  bFinalActionResult := FALSE;
  WantedFinalSheet := nil;
  StatusWindow.Clear;
  StatusWindow.Color := COLORWINDOW_WORKING;
  pgMainPageControl.ActivePage := tsLog;
  for iRejet := 0 to 1 do
    for iComplementaire := 0 to 1 do
      for iResult := 0 to pred(MAXSEARCHNUMBER) do
        WinningResult[iRejet][iComplementaire][iResult] := 0;

  for iRejet := 0 to 1 do
    for iComplementaire := 0 to 1 do
      for iResult := 0 to 6 do
      begin
        pMemo[iRejet][iComplementaire][iResult]^.Clear;
        pMemo[iRejet][iComplementaire][iResult]^.ScrollBars := ssVertical;
        pMemo[iRejet][iComplementaire][iResult]^.ReadOnly := True;
      end;
  memoSommaire.Clear;
end;

{ TfrmMainForm.EnableToute }
procedure TfrmMainForm.EnableToute;
var
  iAction: integer;
begin
  for iAction := 0 to pred(alMainActionList.ActionCount) do
    alMainActionList.Actions[iAction].Enabled := TRUE;

  if bFinalActionResult then
  begin
    WriteStatus('L''opération a été un succès!', COLORSUCCESS);
    StatusWindow.Color := COLORWINDOW_SUCCESS;
    if WantedFinalSheet <> nil then
      pgMainPageControl.ActivePage := WantedFinalSheet;
  end
  else
  begin
    WriteStatus('L''opération a échouée...', COLORERROR);
    StatusWindow.Color := COLORWINDOW_ERROR;

  end;
end;

{ LoadWindowRegistryConfig }
procedure LoadWindowRegistryConfig(RegistryConfigFile: TRegistryIniFile; WorkingForm: TForm; SectionName: string);
begin
  WorkingForm.WindowState := TWindowState(RegistryConfigFile.ReadInteger(SectionName, 'WindowState', ord(wsNormal)));

  if WorkingForm.WindowState <> wsMaximized then
  begin
    if WorkingForm.WindowState = wsMinimized then
      WorkingForm.WindowState := wsNormal;
    WorkingForm.Width := RegistryConfigFile.ReadInteger(SectionName, 'width', WorkingForm.Constraints.MinWidth);
    WorkingForm.Height := RegistryConfigFile.ReadInteger(SectionName, 'height', WorkingForm.Constraints.MinHeight);
  end;

  WorkingForm.Left := RegistryConfigFile.ReadInteger(SectionName, 'left', (Screen.Width - WorkingForm.Width) div 2);
  WorkingForm.Top := RegistryConfigFile.ReadInteger(SectionName, 'top', (Screen.Height - WorkingForm.Height) div 2);
end;

{ SaveWindowRegistryConfig }
procedure SaveWindowRegistryConfig(RegistryConfigFile: TRegistryIniFile; WorkingForm: TForm; SectionName: string);
begin
  RegistryConfigFile.WriteInteger(SectionName, 'WindowState', ord(WorkingForm.WindowState));
  if WorkingForm.WindowState <> wsMaximized then
  begin
    RegistryConfigFile.WriteInteger(SectionName, 'width', WorkingForm.Width);
    RegistryConfigFile.WriteInteger(SectionName, 'height', WorkingForm.Height);
  end;

  RegistryConfigFile.WriteInteger(SectionName, 'left', WorkingForm.Left);
  RegistryConfigFile.WriteInteger(SectionName, 'top', WorkingForm.Top);
end;

{ TfrmMainForm.LoadConfiguration }
procedure TfrmMainForm.LoadConfiguration;
var
  Rosco32IniRegistry: TRegistryIniFile;
const
  BASELOCATIONOFREGISTRYINI = 'SOFTWARE\DENISBISSON\ROSCO32';

begin
  Rosco32IniRegistry := TRegistryIniFile.Create(BASELOCATIONOFREGISTRYINI);
  with Rosco32IniRegistry do
  begin
    LoadWindowRegistryConfig(Rosco32IniRegistry, Self, MAINCONFIGSECTION);
    pgMainPageControl.ActivePageIndex := ReadInteger(MAINCONFIGSECTION, 'pgMainPageControl', 1);
    ResultPageControl.ActivePageIndex := ReadInteger(MAINCONFIGSECTION, 'ResultPageControl', 0);
    edContain.text := ReadString(MAINCONFIGSECTION, 'edContain2', '1-10');
    edMustNotContain.text := ReadString(MAINCONFIGSECTION, 'edMustNotContain2', '40-49');
    edWantedComplementaire.text := ReadString(MAINCONFIGSECTION, 'edWantedComplementaire2', '');
    edNotWantedComplementaire.text := ReadString(MAINCONFIGSECTION, 'edNotWantedComplementaire2', '1-30,40-49');
    //..LoadConfiguration
  end;
  Rosco32IniRegistry.Free;
end;

{ TfrmMainForm.SaveConfiguration }
procedure TfrmMainForm.SaveConfiguration;
var
  Rosco32IniRegistry: TRegistryIniFile;
begin
  Rosco32IniRegistry := TRegistryIniFile.Create(BASELOCATIONOFREGISTRYINI);
  with Rosco32IniRegistry do
  begin
    SaveWindowRegistryConfig(Rosco32IniRegistry, Self, MAINCONFIGSECTION);
    WriteInteger(MAINCONFIGSECTION, 'pgMainPageControl', pgMainPageControl.ActivePageIndex);
    WriteInteger(MAINCONFIGSECTION, 'ResultPageControl', ResultPageControl.ActivePageIndex);
    WriteString(MAINCONFIGSECTION, 'edContain2', edContain.text);
    WriteString(MAINCONFIGSECTION, 'edMustNotContain2', edMustNotContain.text);
    WriteString(MAINCONFIGSECTION, 'edWantedComplementaire2', edWantedComplementaire.text);
    WriteString(MAINCONFIGSECTION, 'edNotWantedComplementaire2', edNotWantedComplementaire.text);
    //..SaveC
  end;
  Rosco32IniRegistry.Free;
end;

end.

