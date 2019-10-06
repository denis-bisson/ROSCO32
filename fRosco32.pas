unit fRosco32;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, MyEnhancedRichedit, MyGauges, Vcl.ExtCtrls;

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
    actLoadDatabase: TAction;
    pgMainPageControl: TPageControl;
    tsLog: TTabSheet;
    StatusWindow: TRichEditGlobal6;
    actChercheCetteCombinaison: TAction;
    actValideLeFichierDesNumeros: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Action1: TMenuItem;
    Validelefichierdesnumros1: TMenuItem;
    Cherchecettecombinaison1: TMenuItem;
    MasterGage: TGauge64;
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
    Label1: TLabel;
    cbTypeOfSearch: TComboBox;
    chkComplementaire: TCheckBox;
    cbSearchNumber1: TComboBox;
    cbSearchNumber2: TComboBox;
    cbSearchNumber3: TComboBox;
    cbSearchNumber4: TComboBox;
    cbSearchNumber5: TComboBox;
    cbSearchNumber6: TComboBox;
    cbSearchNumber7: TComboBox;
    cbSearchNumber8: TComboBox;
    cbSearchNumber9: TComboBox;
    cbSearchNumber10: TComboBox;
    cbComplementaire: TComboBox;
    procedure actLoadDatabaseExecute(Sender: TObject);
    procedure actValideLeFichierDesNumerosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actChercheCetteCombinaisonExecute(Sender: TObject);
    procedure cbTypeOfSearchChange(Sender: TObject);
    procedure aeMainApplicationEventIdle(Sender: TObject; var Done: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExitExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure chkComplementaireClick(Sender: TObject);
    procedure actMiseEclairExecute(Sender: TObject);
  private
    { Private declarations }
    bFinalActionResult: boolean;
    iNombreDeTirage: integer;
    pSearchNumber: array[0..9] of ^TComboBox;
    pMemo: array[0..1] of array[0..6] of ^TMemo;
    Tirages: array[0..9999] of TTirage;
    WinningResult: array[0..1] of array[0..MAXSEARCHNUMBER] of integer;
    WantedFinalSheet: TTabSheet;
    bFirstIdle: boolean;
    lbDominicBoule: TStringList;
    procedure DisableToute;
    procedure EnableToute;
    function LoadDatabaseInMemory: boolean;
    function IntegreCesNumeros(sLineNumber: string; var sErrorString: string): boolean;
    function ValidateSearchedNumberAreCorrect: boolean;
    function DoSearchingJob: boolean;
    function ShowResult: boolean;
    function GetALineForThisCombinaison(paramTirage: integer; bGotComplementaire: boolean): string;
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
  Registry, ShellAPI, System.UITypes,

  //Own
  uCommonStuff, MyGlobal6Color;

const
  BASELOCATIONOFREGISTRYINI = 'SOFTWARE\DENISBISSON\ROSCO32';
  MAINCONFIGSECTION = 'MainSection';

procedure TfrmMainForm.actEditExecute(Sender: TObject);
var
  sNomFichierIn: string;
begin
  sNomFichierIn := paramstr(0);
  sNomFichierIn := IncludeTrailingPathDelimiter(ExtractFilePath(sNomFichierIn)) + 'Quebec49.txt';
  StatusWindow.WriteStatus('On vérifie la présence du fichier ' + sNomFichierIn + ' ...', COLORDANGER);
  if FileExists(sNomFichierIn) then
  begin
    ShellExecute(Application.Handle, 'open', PChar(sNomFichierIn), nil, PChar(ExtractFilePath(sNomFichierIn)), SW_SHOWNORMAL); // SW_NORMAL
  end
  else
  begin
    MessageDlg('ERREUR: Je ne trouve pas le fichier des numéro...' + #$0A + #$0A + 'Normalement: ' + sNomFichierIn, mtError, [mbOk], 0);
  end;
end;

procedure TfrmMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainForm.actLoadDatabaseExecute(Sender: TObject);
begin
  DisableToute;
  try
    bFinalActionResult := LoadDatabaseInMemory;
  finally
    EnableToute;
  end;
end;

procedure TfrmMainForm.actMiseEclairExecute(Sender: TObject);
var
  iNumber, iNbAttempt: integer;
  slAlreadyChosen: TStringList;
  sNumber: string;
  FreezeTime: Dword;
begin
  DisableToute;
  try
    Randomize;
    iNbAttempt:=0;
    slAlreadyChosen := TStringList.Create;
    StatusWindow.Lines.Add('Go!');
    try
      FreezeTime := GetTickCount;

      repeat
        slAlreadyChosen.Clear;

        sNumber := Format('%.2d', [Random(49)]);
        slAlreadyChosen.Add(sNumber);
        cbComplementaire.ItemIndex := StrToIntDef(slAlreadyChosen.Strings[0], 0);

        for iNumber := 0 to (cbTypeOfSearch.ItemIndex - 1) do
        begin
          repeat
            sNumber := Format('%.2d', [Random(49)]);
          until slAlreadyChosen.IndexOf(sNumber) = -1;
          slAlreadyChosen.Add(sNumber);
        end;

        slAlreadyChosen.Delete(0);
        slAlreadyChosen.Sort;

        for iNumber := 0 to (cbTypeOfSearch.ItemIndex - 1) do
          pSearchNumber[iNumber]^.ItemIndex := StrToIntDef(slAlreadyChosen.Strings[iNumber], 0);

        inc(iNbAttempt);
        StatusWindow.Lines.Strings[0]:=IntToStr(iNbAttempt);

        Application.ProcessMessages

      until GetTickCount > (FreezeTime + 1000);

      StatusWindow.Lines.Add('Nombre de combinaisons pondu en 1 seconde: '+IntToStr(iNbAttempt));

      bFinalActionResult := True;
    finally
      FreeAndNil(slAlreadyChosen);
    end;
  finally
    EnableToute;
  end;
end;

procedure TfrmMainForm.actValideLeFichierDesNumerosExecute(Sender: TObject);
begin
  DisableToute;
  try
    bFinalActionResult := LoadDatabaseInMemory;
  finally
    EnableToute;
  end;
end;

procedure TfrmMainForm.aeMainApplicationEventIdle(Sender: TObject;
  var Done: Boolean);
begin
  if bFirstIdle then
  begin
    bFirstIdle := FALSE;
    LoadConfiguration;
  end;
end;

procedure TfrmMainForm.DisableToute;
var
  iAction, iResult: integer;
begin
  for iAction := 0 to pred(alMainActionList.ActionCount) do alMainActionList.Actions[iAction].Enabled := FALSE;
  bFinalActionResult := FALSE;
  WantedFinalSheet := nil;
  StatusWindow.Clear;
  StatusWindow.Color := COLORWINDOW_WORKING;
  pgMainPageControl.ActivePage := tsLog;
  for iResult := 0 to pred(MAXSEARCHNUMBER) do
  begin
    WinningResult[0][iResult] := 0;
    WinningResult[1][iResult] := 0;
  end;
  for iResult := 0 to 6 do
  begin
    pMemo[0][iResult]^.Clear;
    pMemo[1][iResult]^.Clear;
    pMemo[0][iResult]^.ScrollBars := ssVertical;
    pMemo[1][iResult]^.ScrollBars := ssVertical;
    pMemo[0][iResult]^.ReadOnly := True;
    pMemo[1][iResult]^.ReadOnly := True;
  end;
  memoSommaire.Clear;
end;

procedure TfrmMainForm.EnableToute;
var
  iAction: integer;
begin
  for iAction := 0 to pred(alMainActionList.ActionCount) do alMainActionList.Actions[iAction].Enabled := TRUE;

  if bFinalActionResult then
  begin
    StatusWindow.WriteStatus('L''opération a été un succès!', COLORSUCCESS);
    StatusWindow.Color := COLORWINDOW_SUCCESS;
    if WantedFinalSheet <> nil then
      pgMainPageControl.ActivePage := WantedFinalSheet;
  end
  else
  begin
    StatusWindow.WriteStatus('L''opération a échouée...', COLORERROR);
    StatusWindow.Color := COLORWINDOW_ERROR;

  end;
end;

procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveConfiguration;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
var
  iNo, iNumber: integer;
begin
  lbDominicBoule := TStringList.Create;
  lbDominicBoule.Sorted := True;
  lbDominicBoule.Duplicates := dupIgnore;
  bFirstIdle := True;
  Caption := 'ROSCO32 v1.1';
  pSearchNumber[0] := addr(cbSearchNumber1);
  pSearchNumber[1] := addr(cbSearchNumber2);
  pSearchNumber[2] := addr(cbSearchNumber3);
  pSearchNumber[3] := addr(cbSearchNumber4);
  pSearchNumber[4] := addr(cbSearchNumber5);
  pSearchNumber[5] := addr(cbSearchNumber6);
  pSearchNumber[6] := addr(cbSearchNumber7);
  pSearchNumber[7] := addr(cbSearchNumber8);
  pSearchNumber[8] := addr(cbSearchNumber9);
  pSearchNumber[9] := addr(cbSearchNumber10);
  pMemo[0][0] := addr(memo06);
  pMemo[1][0] := addr(memo06p);
  pMemo[0][1] := addr(memo16);
  pMemo[1][1] := addr(memo16p);
  pMemo[0][2] := addr(memo26);
  pMemo[1][2] := addr(memo26p);
  pMemo[0][3] := addr(memo36);
  pMemo[1][3] := addr(memo36p);
  pMemo[0][4] := addr(memo46);
  pMemo[1][4] := addr(memo46p);
  pMemo[0][5] := addr(memo56);
  pMemo[1][5] := addr(memo56p);
  pMemo[0][6] := addr(memo66);
  pMemo[1][6] := addr(memo66p);

  for iNumber := 0 to pred(MAXSEARCHNUMBER) do
  begin
    pSearchNumber[iNumber]^.Items.Clear;
    for iNo := 1 to 49 do
      pSearchNumber[iNumber]^.Items.Add(Format('%.2d', [iNo]));

    pSearchNumber[iNumber]^.ItemIndex := iNumber;
  end;
  cbComplementaire.Clear;

  for iNo := 1 to 49 do
    cbComplementaire.Items.Add(Format('%.2d', [iNo]));
end;

procedure TfrmMainForm.cbTypeOfSearchChange(Sender: TObject);
var
  iNumber: integer;
begin
  for iNumber := 0 to pred(MAXSEARCHNUMBER) do
    pSearchNumber[iNumber].Visible := (iNumber < cbTypeOfSearch.ItemIndex);
end;

procedure TfrmMainForm.chkComplementaireClick(Sender: TObject);
begin
  cbComplementaire.Visible := chkComplementaire.Checked;
end;

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
    StatusWindow.WriteStatus('On vérifie la présence du fichier ' + sNomFichierIn + ' ...', COLORDANGER);
    if FileExists(sNomFichierIn) then
    begin
      StatusWindow.WriteStatus('Le fichier a été trouvé!', COLORSUCCESS);

      StatusWindow.WriteStatus('On charge en mémoire le fichier des numéros...', COLORDANGER);
      slLocalList.LoadFromFile(sNomFichierIn);
      StatusWindow.WriteStatus('Le fichier a été chargé!', COLORSUCCESS);

      StatusWindow.WriteStatus('On valide l''intégrité du fichier...', COLORDANGER);
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
              StatusWindow.WriteStatus('Erreur avec la ligne #' + IntToStr(iLineNumber + 1) + ': ' + slLocalList.Strings[iLineNumber], COLORERROR);
              StatusWindow.WriteStatus(sErrorString, COLORERROR);
              StatusWindow.JumpOneLine;
              inc(NbError);
            end;
          end
          else
          begin
            StatusWindow.WriteStatus('Erreur avec la ligne #' + IntToStr(iLineNumber + 1) + ': ' + slLocalList.Strings[iLineNumber], COLORERROR);
            StatusWindow.JumpOneLine;
            inc(NbError);
          end;
        end;
      end;

      if NbError = 0 then
      begin
        StatusWindow.WriteStatus('Nombre total de tirage importés: ' + IntToStr(iNombreDeTirage), COLORSUCCESS);
        result := True;
      end;
    end
    else
    begin
      StatusWindow.WriteStatus('ERREUR: On ne trouve pas le fichier des numéros!', COLORERROR);
      StatusWindow.JumpOneLine;
    end;
  finally
    FreeAndNil(slLocalList);
  end;
end;

procedure TfrmMainForm.actChercheCetteCombinaisonExecute(Sender: TObject);
begin
  DisableToute;
  try
    WantedFinalSheet := tsResults;
    ResultPageControl.ActivePageIndex := 0;
    if LoadDatabaseInMemory then
      if ValidateSearchedNumberAreCorrect then
        if DoSearchingJob then
          bFinalActionResult := ShowResult;
  finally
    EnableToute;
  end;
end;

function TfrmMainForm.ValidateSearchedNumberAreCorrect: boolean;
var
  iNumber, jNumber: integer;
  bKeepGoing: boolean;
begin
  result := False;
  StatusWindow.WriteStatus('On valide que tes numéros demandés sont corrects...', COLORDANGER);
  iNumber := 0;
  bKeepGoing := True;
  while (iNumber <= pred(cbTypeOfSearch.ItemIndex)) and (bKeepGoing) do
  begin
    jNumber := iNumber + 1;
    while (jNumber <= pred(cbTypeOfSearch.ItemIndex)) do
    begin
      if pSearchNumber[iNumber]^.ItemIndex = pSearchNumber[jNumber]^.ItemIndex then
      begin
        StatusWindow.WriteStatus('ERREUR: Tu as deux numéros pareils: ' + pSearchNumber[iNumber]^.Items[pSearchNumber[iNumber]^.ItemIndex] + ' et ' + pSearchNumber[jNumber]^.Items[pSearchNumber[jNumber]^.ItemIndex], COLORERROR);
        bKeepGoing := False;
      end;
      inc(jNumber);
    end;

    if chkComplementaire.Checked then
    begin
      if (cbTypeOfSearch.ItemIndex > 0) then
      begin
        if pSearchNumber[iNumber]^.ItemIndex = cbComplementaire.ItemIndex then
        begin
          StatusWindow.WriteStatus('ERREUR: Tu as deux numéros pareils (complémentaire): ' + pSearchNumber[iNumber]^.Items[pSearchNumber[iNumber]^.ItemIndex] + ' et ' + cbComplementaire.Items[cbComplementaire.ItemIndex], COLORERROR);
          bKeepGoing := False;
        end;

      end;
    end;

    inc(iNumber);
  end;

  if bKeepGoing then
  begin
    StatusWindow.WriteStatus('C''est beau, on peut continuer!', COLORSUCCESS);
    result := true;
  end;
end;

function GetDashLine(Lg: integer): string;
begin
  result := '-';
  while length(result) < Lg do result := result + '-';
end;

function TfrmMainForm.ShowResult: boolean;
var
  iLocalTotal, iWinning: integer;
  sStatLine: string;
begin
  result := False;
  iLocalTotal := 0;

  for iWinning := 0 to 6 do
  begin
    sStatLine := 'Nombre de ' + IntToStr(iWinning) + '/6 : ' + IntToStr(WinningResult[0][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[0][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[0][iWinning]^.Lines.Insert(0, sStatLine);
    StatusWindow.WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[0][iWinning];

    sStatLine := 'Nombre de ' + IntToStr(iWinning) + '/6+: ' + IntToStr(WinningResult[1][iWinning]);
    memoSommaire.Lines.Add(sStatLine);
    pMemo[1][iWinning]^.Lines.Insert(0, GetDashLine(length(sStatLine)));
    pMemo[1][iWinning]^.Lines.Insert(0, sStatLine);
    StatusWindow.WriteStatus('           ' + sStatLine, COLORSTATUS);
    iLocalTotal := iLocalTotal + WinningResult[1][iWinning];
  end;

  StatusWindow.WriteStatus('                    Total: ' + IntToStr(iLocalTotal), COLORSTATUS);
  StatusWindow.WriteStatus('Tirage dans notre fichier: ' + IntToStr(iNombreDeTirage), COLORSTATUS);

  if iLocalTotal = iNombreDeTirage then
  begin
    StatusWindow.WriteStatus('Succès! Ces résulats correspondant à notre nombre de tirages dans le fichier!', COLORSUCCESS);
    result := True;
  end
  else
  begin
    StatusWindow.WriteStatus('ERREUR: Le nombre de tirages dans notre fichiers ne balance avec ces résultats...', COLORERROR);
  end;

end;

function TfrmMainForm.DoSearchingJob: boolean;
var
  iBoule, iTirage, NbDeBoulePareil: integer;
begin
  lbDominicBoule.Clear;
  for iBoule := 0 to pred(cbTypeOfSearch.ItemIndex) do
    lbDominicBoule.Add(Format('%.2d', [pSearchNumber[iBoule]^.ItemIndex + 1]));

  StatusWindow.WriteStatus('On lance notre recherche...', COLORDANGER);

  MasterGage.MinValue := 0;
  MasterGage.Progress := 0;
  MasterGage.MaxValue := iNombreDeTirage;
  MasterGage.Visible := True;
  iTirage := 0;
  while (iTirage < iNombreDeTirage) do
  begin
    NbDeBoulePareil := 0;
    for iBoule := 0 to 5 do
      if lbDominicBoule.IndexOf(Format('%.2d', [Tirages[iTirage].Numbers[iBoule]])) <> -1 then inc(NbDeBoulePareil);

    if not chkComplementaire.Checked then
    begin
      if (lbDominicBoule.IndexOf(Format('%.2d', [Tirages[iTirage].Numbers[6]])) <> -1) then
      begin
        inc(WinningResult[1][NbDeBoulePareil]);
        pMemo[1][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, True));
      end
      else
      begin
        inc(WinningResult[0][NbDeBoulePareil]);
        pMemo[0][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, False));
      end;
    end
    else
    begin
      if (cbComplementaire.ItemIndex + 1) = Tirages[iTirage].Numbers[6] then
      begin
        inc(WinningResult[1][NbDeBoulePareil]);
        pMemo[1][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, True));
      end
      else
      begin
        inc(WinningResult[0][NbDeBoulePareil]);
        pMemo[0][NbDeBoulePareil]^.Lines.Add(GetALineForThisCombinaison(iTirage, False));
      end;
    end;

    inc(iTirage);
    MasterGage.Progress := MasterGage.Progress + 1;
    if MasterGage.Progress mod 64 = 0 then Application.ProcessMessages;
  end;

  StatusWindow.WriteStatus('La recherche est complétée!', COLORSUCCESS);
  result := True;
end;

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
    cbTypeOfSearch.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbTypeOfSearch', 5);
    cbSearchNumber1.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber1', 5);
    cbSearchNumber2.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber2', 7);
    cbSearchNumber3.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber3', 19);
    cbSearchNumber4.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber4', 23);
    cbSearchNumber5.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber5', 27);
    cbSearchNumber6.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber6', 41);
    cbSearchNumber7.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber7', 42);
    cbSearchNumber8.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber8', 46);
    cbSearchNumber9.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber9', 47);
    cbSearchNumber10.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'cbSearchNumber10', 48);
    cbTypeOfSearchchange(cbTypeOfSearch);
    pgMainPageControl.ActivePageIndex := ReadInteger(MAINCONFIGSECTION, 'pgMainPageControl', 1);
    ResultPageControl.ActivePageIndex := ReadInteger(MAINCONFIGSECTION, 'ResultPageControl', 0);
    chkComplementaire.Checked := ReadBool(MAINCONFIGSECTION, 'chkComplementaire', False);
    cbComplementaire.ItemIndex := ReadInteger(MAINCONFIGSECTION, 'chkComplementaire', 6);
    chkComplementaireClick(chkComplementaire);
    //..Load
  end;
  Rosco32IniRegistry.Free;
end;

procedure TfrmMainForm.SaveConfiguration;
var
  Rosco32IniRegistry: TRegistryIniFile;
begin
  Rosco32IniRegistry := TRegistryIniFile.Create(BASELOCATIONOFREGISTRYINI);
  with Rosco32IniRegistry do
  begin
    SaveWindowRegistryConfig(Rosco32IniRegistry, Self, MAINCONFIGSECTION);
    WriteInteger(MAINCONFIGSECTION, 'cbTypeOfSearch', cbTypeOfSearch.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber1', cbSearchNumber1.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber2', cbSearchNumber2.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber3', cbSearchNumber3.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber4', cbSearchNumber4.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber5', cbSearchNumber5.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber6', cbSearchNumber6.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber7', cbSearchNumber7.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber8', cbSearchNumber8.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber9', cbSearchNumber9.ItemIndex);
    WriteInteger(MAINCONFIGSECTION, 'cbSearchNumber10', cbSearchNumber10.ItemIndex);
    cbTypeOfSearchchange(cbTypeOfSearch);
    WriteInteger(MAINCONFIGSECTION, 'pgMainPageControl', pgMainPageControl.ActivePageIndex);
    WriteInteger(MAINCONFIGSECTION, 'ResultPageControl', ResultPageControl.ActivePageIndex);
    WriteBool(MAINCONFIGSECTION, 'chkComplementaire', chkComplementaire.Checked);
    WriteInteger(MAINCONFIGSECTION, 'chkComplementaire', cbComplementaire.ItemIndex);
    //..SaveC
  end;
  Rosco32IniRegistry.Free;
end;

end.

