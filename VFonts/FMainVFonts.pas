unit FMainVFonts;

(* Visualiseur des polices de caractères
 *
 * Copyright (C) 1998-2006 Olivier Cado
 * http://www.chez.com/ocado - ocado@chez.com
 *
 * Copyright (C) 2008 BlueMan
 * http://www.blueman.name
 *
 *
 * Historique :
 * ------------
 *
 * Version 2.8.0 : 16/04/2008 -> Correction de texte et ajout de fonctionnalité par BlueMan
 *                               - Correction d'une coquille : texte "GNU" en "GPL".
 *                               - Ajout d'une constante de date de version : kDateVersion
 *                               - Ajout de la fonctionnalité de mémorisations de sélections personnalisées avec :
 *                                      - Sauvegarde automatique dans le fichier VFonts.ini (dans le même rep. que l'application),
 *                                      - Chargement automatique lors du lancement de VFonts,
 *                                      - Possibilité d'enrichissement d'une sélection mémorisée,
 *                                      - Possibilité de supression de certaines polices d'une sélection mémorisée,
 *                                      - Possibilité de supression d'une sélection mémorisée.
 *                                      - Support de l'ajout et surtout de la suppression de polices dans le dossier C:\Windows\Fonts :
 *                                        VFonts détecte les polices retirées, vous en informe, et met à jour les sélections mémorisées.
 *                               - Modification de la présentation de l'aide par découpage en sections et ajout de titres pour celles-ci.
 *                               - Modification du champs "Contient :" : agrandissement pour lisibilité + fond en couleur +
 *                                 affichage en MAJUSCULES pour meilleure lisibilité + limitation à 10 caractères (pas de débordement)
 *                               - Ajout d'un caractère 'Joker' « * » pour le champs contient afin de permettre des recherches
 *                                 de type 'XYZ*' sur le nom des polices.
 *                               - Le bouton [Afficher] n'est plus 'par défaut' et la touche [Entrée] vide le champ "Contient :".
 *                               - Rajout d'une StatusBar associée à un timer afin d'informer l'utilisateur des résultats des
 *                                 différentes opérations qu'il a demandé.
 *                               - Redisposition de l'interface par la définition de panels imbriqués (afin d'optimiser la place).
 *                               - Implémentation d'un code évitant le lancement d'instances multiples de VFonts (indispensable depuis
 *                                 l'implémentation des sélections mémorisables).
 *
 * Version 2.7.0 : 08/04/2008 -> Ajout de fonctionnalité par BlueMan
 *                               Utilisation de Delphi 2005 édition personnelle (gratuit)
 *                               - Détection des touches [UP] et [DOWN] dans l'Edit "Contient" afin de permettre une navigation
 *                                 facile dans la liste des polices.
 *                               - Suppression du numéro de version et du nom des auteurs de la barre de titre de l'application
 *
 *                               - Correction du bug d'affichage du nombre de polices sélectionnées lorsqu'on les sélectionne par
 * Version 2.6.0 : 07/04/2008 -> Correction de bugs par BlueMan
 *                               Utilisation de Delphi 2005 édition personnelle (gratuit)
 *
 *                               - Correction du bug d'affichage du nombre de polices sélectionnées lorsqu'on les sélectionne par
 *                                 le filtre "Contient :"
 *                               - Ajout d'un composant TXPManifest pour rendre le look de l'application aux normes XP
 *                               - Ajout d'un TShape dans le PanelNbSel à cause du XPManisfest de façon à conserver un fond vert
 *                               - Ajout d'un TShape dans le PanelEnCours à cause du XPManisfest de façon à conserver un fond rouge
 *                               - Ajout de mots clés supplémentaires d'exemple dans l'aide principale du Rich Text
 *                               - kNbMaxPolices passe à 7000 polices supportées.
 *                               - Ajout d'un nom de fichier par défaut dans le TSaveDialog : "Rendu de polices"
 *                               - Transfert intégral de l'aide et enrichissement de celle-ci dans un fichier externe qui est
 *                                 chargé dans un nouveau Rich text, et en couleur !
 *                               - Création d'une fenêtre "à propos de cette application" avec liens URL vers les sites Web des auteurs
 *                                 (nécessite le composant freeware "TURLLabel" qui est fourni avec les sources)
 *                               - Ajout de la constante kNbPolicesMinPourAffichagePanneau
 *                               - Ajout d'un menu contextuel au Rich Edit : Couper, Copier, Coller, Gras, Italique, Souligné et Biffé
 *                                 permettant d'appliquer des styles sur tout morceau de texte du RichEdit
 *                               - Modification du glyphe pour le bouton lancant CharMap.exe par reprise du logo original de CharMap
 *                               - Test de l'exitence d'une instance de ChartMap avant de la lancer et activation au premier plan de
 *                                 celle-ci, si l'utilisateur tente d'en lancer une autre. Ne fonctionne que pour le Francais.
 *
 * Version 2.5.1 : 02/04/2008 -> Correction de bugs et enrichissements par BlueMan
 *                               Utilisation de Delphi 2005 édition personnelle (gratuit)
 *
 *                               - Correction du bug d'affichage pour les polices de type Wingdings ou autre polices graphiques
 *                                 par récupération du CharSet par défaut pour chaque police, et stockage de ceux-c dans un tableau.
 *                               - Rajout dans les exemples de la phrase : 'Portez ce vieux whisky au juge blond qui fume
 *                                 afin de rester conforme à la version d'origine.
 *                               - Rajout dans les exemples des ":" et de 2 autres exemples.
 *                               - Modification des exemples exitants et uniformisation.
 *                               - Rajout d'une constante pour la gestion du numéro de version qui update tous les endroits où
 *                                 elle est affichée.
 *                               - Rajout des informations de version dans les options du projet
 *                               - Taille par défaut des polices mis à 22.
 *                               - Optimisation de la rapidité d'affichage par masquage du RichEdit pendant l'affichage des polices
 *                               - Affichage d'un panneau "Construction en cours..." pour informer l'utilisateur (utilise lorsque le
 *                                 nombre de polices à afficher dépasse les 22 polices.
 *                               - Ajout de l'afficheur comptabilisant le nombre de polices sélectionnées
 *                               - Suppression de l'afficheur du numéro de polices (celui-ci est disponible par le bouton [N°]
 *
 * Version 2.5.0 : 30/03/2008 -> Amélioration de l'interface, automatisation, et ajout de nouvelles fonctionnalités par BlueMan
 *                               Utilisation de Delphi 2005 édition personnelle (gratuit)
 *
 *                               - Affichage automatique sur simple click sur le nom d'une ou plusieurs polices
 *                               - Ajout du bouton [Toutes]
 *                               - Ajout du bouton [Aucune]
 *                               - Ajout de la possibité d'interruption lors de l'affichage
 *                               - Ajout d'un EDIT "Contient :" de saisie, afin de pouvoir filtrer les polices sur tout ou partie de leur nom
 *                               - Ajout du bouton [Enreg. Fichier] pour sauvegarder le résultat des polices sélectionnées
 *                               - Ajout d'une dropdownliste de choix du texte à afficher avec plusieurs smaples + les codes ASCII
 *                               - Ajout de la touche [ESCAPE] pour plus simplement quitter l'application
 *                               - Ajout d'une drownDownList pour choisir les tailles de polices (au lieu d'un EDIT)
 *
 * Version 2.0.2 : 22/01/2006 -> correction du bug Windows 2000/XP
 * Version 2.0.1 : 20/02/2000 -> TRichEdit
 * Version 1.5.1 : 16/01/1999 -> TDrawGrid
 * Version 1.0.1 : 30/08/1998 -> TextOut

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 * Borland Delphi 5.0 ou supérieur est nécessaire pour compiler ce programme
 *)

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Graphics, StdCtrls, Buttons,
  StrUtils, Dialogs, Gauges, ExtCtrls, ComCtrls, XPMan, ImgList, Menus, Clipbrd,
  Inifiles;

Const
   kVersion = '2.8.0';
   kDateVersion = '16 Avril 2008';
   kNbMaxPolices = 7000;
   kNbPolicesMinPourAffichagePanneau = 22;
   kToutes = 'Sélection : TOUTES les polices';
   kAucune = 'Aucune police n''est sélectionnée';

type
  TFormVFonts = class(TForm)
    SaveDialog: TSaveDialog;
    TimerFind: TTimer;
    PanelEnCours: TPanel;
    LabelEnCours: TLabel;
    ShapeConst: TShape;
    XPManifest1: TXPManifest;
    PopupMenu: TPopupMenu;
    Couper: TMenuItem;
    Copier: TMenuItem;
    Coller: TMenuItem;
    ImageList: TImageList;
    Gras: TMenuItem;
    Italique: TMenuItem;
    Souligne: TMenuItem;
    N2: TMenuItem;
    Biffe: TMenuItem;
    pmSel: TPopupMenu;
    Enregristrercetteslectionsous: TMenuItem;
    N1: TMenuItem;
    Supprimerlaslection: TMenuItem;
    StatusBar: TStatusBar;
    TimerStatusBar: TTimer;
    N3: TMenuItem;
    SupprPolicesDeSel: TMenuItem;
    AjoutePol: TMenuItem;
    PanelGauche: TPanel;
    PanelSel: TPanel;
    sbToutes: TSpeedButton;
    sbAucune: TSpeedButton;
    Label1: TLabel;
    LabelSel: TLabel;
    ApplyButton: TButton;
    EditFind: TEdit;
    cbSel: TComboBox;
    FontList: TListBox;
    PanelMain: TPanel;
    PaneHautDroit: TPanel;
    Label2: TLabel;
    BoldButton: TSpeedButton;
    ItalicButton: TSpeedButton;
    UnderButton: TSpeedButton;
    NbrButton: TSpeedButton;
    BorderButton: TSpeedButton;
    WordwrapButton: TSpeedButton;
    sbSave: TSpeedButton;
    NameButton: TSpeedButton;
    SpeedButton1: TSpeedButton;
    sbAide: TSpeedButton;
    PrintButton: TButton;
    CopyButton: TButton;
    ButtonAPropos: TButton;
    cbSample: TComboBox;
    cbSize: TComboBox;
    PanelNbSel: TPanel;
    ShapeNbSel: TShape;
    LabelNbSel: TLabel;
    RichEditRendu: TRichEdit;
    RichEditHelp: TRichEdit;
    procedure SupprPolicesDeSelClick(Sender: TObject);
    procedure AjoutePolClick(Sender: TObject);
    procedure cbSelClick(Sender: TObject);
    procedure EditFindKeyPress(Sender: TObject; var Key: Char);
    procedure TimerStatusBarTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmSelPopup(Sender: TObject);
    procedure SupprimerlaslectionClick(Sender: TObject);
    procedure EnregristrercetteslectionsousClick(Sender: TObject);
    procedure EditFindKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbAideClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BiffeClick(Sender: TObject);
    procedure SouligneClick(Sender: TObject);
    procedure ItaliqueClick(Sender: TObject);
    procedure GrasClick(Sender: TObject);
    procedure CouperClick(Sender: TObject);
    procedure CopierClick(Sender: TObject);
    procedure CollerClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure cbCharSetClick(Sender: TObject);
    procedure NbrButtonClick(Sender: TObject);
    procedure NameButtonClick(Sender: TObject);
    procedure cbSampleClick(Sender: TObject);
    procedure TimerFindTimer(Sender: TObject);
    procedure EditFindChange(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sbAucuneClick(Sender: TObject);
    procedure sbToutesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure FontListClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure BorderButtonClick(Sender: TObject);
    procedure WordwrapButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonAProposClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    FIsCreating : boolean;
    FIsFirstTime : boolean;
    FStop : boolean;
    FAsciiCodes : string;
    FCharSets : array [0..kNbMaxPolices-1] of TFontCharset;
    FIniFile : TInifile;

    procedure ResetEditFind;
    procedure LoadFCharSets;
    procedure ShowPanelEnCours;
    procedure ToggleRichEdit;
    procedure FontListMove(Step:integer);
    procedure ChargeCbSel;
    procedure AddNewSelection(SelName:string;IsAfterMessage:boolean);
    procedure ReplaceSelection(SelName:string);
    procedure SayStatus(aText:string);
    procedure UpdateStatusBarPanel1;
    procedure ResetCbSel;
    procedure AddFontsToSel(aSel:string;IdxSel:integer);
    procedure RemoveFontsToSel(aSel:string;IdxSel:integer);
    procedure UpdateAffichages;
    procedure DeleteSelection(IdxSel:integer);

  end;

var
  FormVFonts: TFormVFonts;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;
function GetFontCharset(const Name: String): integer;
function AllTrim(aString:string;aChar:Char = ' '):string;
function CutTextUsingSep(aString:string;EveryCar:integer;Sep:String = #13):string;

implementation

uses FAPropos, FEnregSel, FAjoutSuppr;

{$R *.DFM}

//----------------------------- F O N C T I O N S ------------------------------

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;
begin
     Integer(Data^) := LogFont.lfCharSet;
     Result := 1;
end;

function GetFontCharset(const Name: String): integer;
var
   DC: HDC;
   LFont: TLogFont;
   pFontName: PChar;
begin
     DC := GetDC(0);
     try
        FillChar(LFont, sizeof(LFont), 0);
        LFont.lfCharset := DEFAULT_CHARSET;
        pFontName := @(LFont.lfFaceName[0]);
        StrCopy(pFontName, PChar(Name));
        EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, integer(@Result), 0);
     finally
        ReleaseDC(0, DC);
     end;
end;

function AllTrim(aString:string;aChar:Char = ' '):string;
var
   i : Integer;
begin
     Result := '';

     for i:=1 to Length(aString) do
     begin
          if (aString[i] <> aChar) then Result := Result + aString[i];
     end;
end;

function CutTextUsingSep(aString:string;EveryCar:integer;Sep:String = #13):string;
var
     i:integer;
begin
     if EveryCar < 1
     then ERangeError.CreateFmt('CutTextUsingSep(aString:string;EveryCar:integer;Sep:String = #13):string;'#13#13+
                                'La paramètre EveryCar a une valeur incorrecte : %d',[EveryCar]);
     Result := '';
     for i:=1 to Length(aString) do
     begin
          Result := Result + aString[i];
          if (i mod EveryCar = 0) then Result := Result + Sep;
     end;
     if (Length(aString) mod EveryCar = 0) then Result := RightStr(Result, Length(Result)-Length(Sep));
end;
//------------------------------- C L A S S E S --------------------------------

procedure TFormVFonts.FormCreate(Sender: TObject);
begin
  FIsCreating := True;
  FIsFirstTime := True;
  cbSel.Clear;
  try
     if Screen.Fonts.Count > kNbMaxPolices
     then Raise Exception.CreateFmt( 'Le nombre de polices installées sur votre système (%d)'#13#13+
                                     'dépasse le nombre maximum géré par cette application : %d' ,[FontList.Count,kNbMaxPolices]);
     FontList.Items.Assign(Screen.Fonts);
     FontList.Items.Delete(27);FontList.Items.Delete(58);FontList.Items.Delete(72);
     LoadFCharSets;

     // On choisi de stocker le .ini dans le répertoire de lapplication afin de
     // ne pas polluer le répertoire Windows ou pire, le Registre
     FIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'VFonts.ini');

     ApplyButtonClick(Sender);
     FontList.SelectAll();
     Caption := Caption + ' (' + IntToStr(FontList.Items.Count) + ' polices installées)';
     FIsCreating := False;
  except
     on e:exception do
     begin
          MessageDlg(e.Message, mtError, [mbOk],0);
          Halt;
     end;
  end;
end;

procedure TFormVFonts.LoadFCharSets;
var
     i:integer;
begin
     for i:=0 to FontList.Count-1 do FCharSets[i] := GetFontCharset(FontList.Items[i]);
end;

procedure TFormVFonts.ApplyButtonClick(Sender: TObject);
var
  i : integer;
  SampleText : string;
  aStyle : TFontStyles;
begin
  FStop := False;

  if FIsFirstTime then FIsFirstTime := False
  else
  begin
       sbAide.Down := False;
       sbAideClick(nil);
  end;

  with RichEditRendu do begin
    Lines.Clear;
    RichEditRendu.Visible := false;
    RichEditRendu.Refresh;

    if (FontList.SelCount > kNbPolicesMinPourAffichagePanneau) and not PanelEnCours.Visible then
    begin
         ShowPanelEnCours;
    end;
    // Attributs communs à toutes les lignes
    // Ajout de chaque ligne ({N°}+{Nom}+Phrase)
    for i := 0 to FontList.Items.Count-1 do
    begin
      // Toutes les 33 polices, on permet à l'utilisateur d'intervenir que ce
      // soit pour un changement d'avis et/ou le lancement d'une autre fonction.
      if i mod 33 = 0 then Application.ProcessMessages;
      if FStop then
      begin
          Break;
      end;

      if FontList.Selected[i] then begin
        // Bien que ces attributs soient communs, depuis Windows 2000/XP
        // l'ajout d'une ligne désactive ces attributs
        aStyle := SelAttributes.Style;
        if BoldButton.Down then aStyle := aStyle + [fsBold]
                           else aStyle := aStyle - [fsBold];
        if ItalicButton.Down then aStyle := aStyle + [fsItalic]
                             else aStyle := aStyle - [fsItalic];
        if UnderButton.Down then aStyle := aStyle + [fsUnderline]
                            else aStyle := aStyle - [fsUnderline];
        with SelAttributes do begin
          Style := aStyle;
          Size := StrToInt(cbSize.Items[cbSize.itemIndex]);
          Color := clBlack;
          // Récupération du CharSet (pour les polices à symboles et autres)
          CharSet := FCharSets[i];
        end;
        SelAttributes.Name := FontList.Items[i];
        if NbrButton.Down then SampleText := IntToStr(i+1) + ' ' else SampleText := '';
        if NameButton.Down then SampleText := SampleText + '[ ' + SelAttributes.Name + ' ] : ';

        if cbSample.itemindex = cbSample.Items.Count - 1
        then SampleText := SampleText + FAsciiCodes
        else SampleText := SampleText + cbSample.Items[cbSample.itemindex];
        Lines.Add( SampleText );
      end;
    end;
  end;
  PanelEnCours.Visible := False;
  RichEditRendu.Visible := True;
  UpdateAffichages;
  if not FIsCreating then EditFind.SetFocus;
end;

procedure TFormVFonts.ShowPanelEnCours;
begin
         PanelEnCours.Left := PanelGauche.Width + RichEditRendu.Left + (RichEditRendu.Width div 2) - (PanelEnCours.Width div 2);
         PanelEnCours.Top := RichEditRendu.Top + (RichEditRendu.Height div 2) - (PanelEnCours.Height div 2);
         PanelEnCours.Visible := True;
         PanelEnCours.Refresh;
end;

procedure TFormVFonts.FontListClick(Sender: TObject);
begin
     ResetEditFind;
     ResetCbSel;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.UpdateAffichages;
begin
     if (FontList.SelCount = 0) then
     begin
          LabelNbSel.Caption := kAucune;
     end
     else
     begin
          if (FontList.SelCount = 1) then
          begin
               LabelNbSel.Caption := 'Selection : '+IntToStr(FontList.SelCount)+' police (#'+IntToStr(FontList.ItemIndex)+')';
          end
          else
          begin
               if (FontList.SelCount = FontList.Count) then
               begin
                    LabelNbSel.Caption := kToutes;
                    SayStatus('Toutes les polices sélectionnées');
               end
               else
               begin
                    LabelNbSel.Caption := 'Selection : '+IntToStr(FontList.SelCount)+' polices';
               end;
          end;
     end;
     LabelNbSel.Refresh;
     SayStatus(LabelNbSel.Caption);
end;

procedure TFormVFonts.PrintButtonClick(Sender: TObject);
begin
     FStop := True;
  if Application.MessageBox('Souhaitez-vous vraiment imprimer, sur l''imprimante par défaut ?',
     'Imprimer', MB_ICONQUESTION or MB_YESNO) = IDYES then
    RichEditRendu.Print('Visualiseur des polices de caractères');
end;

procedure TFormVFonts.CopyButtonClick(Sender: TObject);
begin
  with RichEditRendu do begin
    SelectAll;
    CopyToClipboard;
    SelLength := 0;
  end;
  SayStatus('Le texte a été recopié dans le Presse-Papiers');
end;

procedure TFormVFonts.BorderButtonClick(Sender: TObject);
begin
  with RichEditRendu do begin
    if BorderStyle=bsNone then begin
      BorderStyle := bsSingle;
      Color := clWindow;
    end else begin
      BorderStyle := bsNone;
      Color := clBtnFace;
    end;
  end;
end;

procedure TFormVFonts.WordwrapButtonClick(Sender: TObject);
begin
     RichEditRendu.Wordwrap := not RichEditRendu.Wordwrap;
end;

procedure TFormVFonts.FormResize(Sender: TObject);
begin
  ButtonAPropos.Left := PaneHautDroit.Width - ButtonAPropos.Width-5;
  sbAide.Left := ButtonAPropos.Left - sbAide.Width-5;
  StatusBar.Panels[0].Width := Width-100;
end;

procedure TFormVFonts.ButtonAProposClick(Sender: TObject);
begin
     if not Assigned(FormAPropos) then FormAPropos := TFormAPropos.Create(self);
     try
        FormAPropos.LabelVersion.Caption := 'Version '+KVersion;
        FormAPropos.LabelDateVersion.Caption := kDateVersion;
        FormAPropos.ShowModal;
     finally
          FormAPropos.Free;
          FormAPropos := nil;
     end;
end;

procedure TFormVFonts.FormShow(Sender: TObject);
var
     i : integer;
begin
  FormVFonts.caption := 'VFonts: Fonts Visualizer - '+
                    IntToStr(FontList.Count) + ' fonts installed';
  FormResize(Sender);
  FontList.Selected[0]:= true;
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyz' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyz0123456789' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyzÇçáààäâÀÁÄÂéèëêÉÈËÊíìïîÍÌÏÎóòöôÓÒÖÔúùüûÚÙÜÛ' );
  cbSample.Items.Add( 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' );
  cbSample.Items.Add( 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÉÈéèëêÇçàäâûîïöô.,;:!?-_()[]{}'''+'«»"' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÇçáààäâÀÁÄÂéèëêÉÈËÊíìïîÍÌÏÎóòöôÓÒÖÔúùüûÚÙÜÛ.,;:!?' );
  cbSample.Items.Add( 'abcdefghijklmnopqrstuvwxyz.,;:!?' +
                      '''"\|ÉÈéêèë ÇçÀàâÛÙùûüÎÏîïÔÖôö ABCDEFGHIJKLMNOPQRSTUVWXYZ #01234567890+-*/=±¼½¾$£%&()[]{}_~°<>«»µ§¶' );
  cbSample.Items.Add( 'ÇçáààäâÀÁÄÂéèëêÉÈËÊíìïîÍÌÏÎóòöôÓÒÖÔúùüûÚÙÜÛ.,;:?!@&-_''''«»"|°()[]{}§¶' );
  cbSample.Items.Add( 'Portez ce vieux whisky au juge blond qui fume ÀÄÂÉÈËÊÖÔÜÛÇçéèëêàäâüûïîöô.,;:!?-_()[]{}'''+'«»"' );
  cbSample.Items.Add('Tous les carcatères du Code ASCII');// Doit absolument être ajouté en DERNIER !
  cbSample.ItemIndex := 2;

  for i:=32 to 255 do FAsciiCodes := FAsciiCodes+Chr(i);

  i:=8;
  repeat
        cbSize.Items.Add(IntToStr(i));
        Inc(i,2);
  until i>98;
  cbSize.ItemIndex := 7;// Taille 22
  LabelNbSel.Caption := kToutes;
  try
     RichEditHelp.Lines.LoadFromFile('VFonts_Aide_Francais.rtf');
  except
     on e:exception do
     begin
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('  L''AIDE est inaccessible.');
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('  Cause :');
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('  ' + CutTextUsingSep(e.Message,120,#13'  '));
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('  Suggestion :');
          RichEditHelp.Lines.Add('');
          RichEditHelp.Lines.Add('  Allez sur le site de l''auteur afin d''y télécharger une version complète, et non adultérée.');
     end;
  end;

  ChargeCbSel;
  cbSel.ItemIndex := -1;
  UpdateStatusBarPanel1;
  EditFind.SetFocus;
end;

procedure TFormVFonts.ChargeCbSel;
var
     SelList, SelFonts, MissingList :TStringList;
     i, j, IdxPolice, p : integer;
     List : TList;
     SelName, Chaine, NomPolice : string;
     IsAtLeastOneMissing : boolean;
begin
     //Exit;
     SelList := TStringList.Create;
     SelFonts := TStringList.Create;
     MissingList := TStringList.Create;
     IsAtLeastOneMissing := False;
     try
          FiniFile.ReadSections(SelList);
          for i:=0 to SelList.Count-1 do
          begin
               SelName := SelList[i];
               FiniFile.ReadSectionValues(SelName,SelFonts);
               // Supression des Clés
               for j:=0 to SelFonts.Count-1 do
               begin
                    p := Pos('=',SelFonts[j]);
                    NomPolice := MidStr(SelFonts[j],p+1,Length(SelFonts[j])-p);
                    SelFonts[j] := NomPolice;
               end;

               List := TList.Create;
               for j:=0 to SelFonts.Count-1 do
               begin
                    // On cherche l'index de cette police
                    IdxPolice := FontList.Items.IndexOf(SelFonts[j]);
                    if IdxPolice = -1 then
                    begin
                         IsAtLeastOneMissing := True;
                         MissingList.Add(SelFonts[j]);
                    end
                    // Si la police est trouvée, alors on son indice stocke
                    else List.Add(Pointer(IdxPolice));
               end;
               cbSel.AddItem(SelName,List);

               // Information de l'utilisateur et Suppression des polices non trouvées
               // pour cette sélection
              if IsAtLeastOneMissing then
              begin
                   // Information de l'utilisateur
                   if MissingList.Count = 1
                   then Chaine := 'La police suivante n''existe'
                   else Chaine := 'Les polices suivantes n''existent';
                   Chaine := Chaine + ' plus sur votre ordinateur :'#13;
                   NomPolice := '';
                   for j:=0 to MissingList.Count-1 do
                   begin
                        NomPolice := NomPolice + #13 + '- '+ MissingList[j];
                   end;
                   if MissingList.Count =1
                   then Chaine := Chaine + NomPolice + #13#13 + 'Elle va donc être supprimée'
                   else Chaine := Chaine + NomPolice + #13#13 + 'Elles vont donc être supprimées';
                   Chaine := Chaine + ' de la sélection mémorisée <'+SelName+'>.';
                   MessageDlg(Chaine, mtWarning, [mbOK], 0);

                   // On restocke la liste corrigée des polices pour cette sélection
                   FiniFile.EraseSection(SelName);
                   for j:=0 to List.Count-1 do
                   begin
                         FiniFile.WriteString(SelName,IntToStr(j+1), FontList.Items[ Cardinal(List[j]) ]);
                   end;

                   // On réinitialise pour la prochaine sélection
                   IsAtLeastOneMissing := False;
                   MissingList.Clear;
              end;
          end;
     finally
          MissingList.Free;
          SelList.Free;
          SelFonts.Free;
     end;
end;

procedure TFormVFonts.sbToutesClick(Sender: TObject);
begin
     FStop := True;
     UpdateAffichages;
     ResetEditFind;
     ResetCbSel;
     ShowPanelEnCours;
     FontList.SelectAll;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.sbAucuneClick(Sender: TObject);
begin
     FStop := True;
     ResetEditFind;
     ResetCbSel;
     FontList.ClearSelection;
     ApplyButtonClick(nil);
     UpdateAffichages;
end;

procedure TFormVFonts.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if (key = Chr(VK_ESCAPE)) then
     begin
          Key := Chr(0);
          Close;
     end;
end;

procedure TFormVFonts.sbSaveClick(Sender: TObject);
begin
     FStop := True;
     if SaveDialog.Execute then
     begin
          RichEditRendu.Lines.SaveToFile(SaveDialog.FileName);
     end;
     SayStatus('Le Texte a été sauvegardé sous : '+ ExtractFileName(SaveDialog.FileName));
end;

procedure TFormVFonts.EditFindChange(Sender: TObject);
var
     i, LgFind, p :integer;
     sFind, sDebut: string;
begin
     if TimerFind.Enabled then TimerFind.Enabled := False;

     sFind := EditFind.Text;
     LgFind := Length(sFind);
     RichEditRendu.Clear;
     RichEditRendu.Refresh;
     ResetCBSel;

     if LgFind = 0 then
     begin
          for i:=0 to FontList.Count-1 do
          begin
               FontList.Selected[i] := False;
          end;

     end
     else
     begin
          p := Pos('*',sFind);
          if p > 1 then
          begin
               sDebut := LeftStr(sFind,p-1);
               for i:=0 to FontList.Count-1 do
               begin
                    FontList.Selected[i] := AnsiStartsText(sDebut,FontList.Items[i]);
               end;
          end
          else
          begin
               for i:=0 to FontList.Count-1 do
               begin
                    FontList.Selected[i] := AnsiContainsText(FontList.Items[i], sFind);
               end;
          end;
     end;
     UpdateAffichages;
     TimerFind.Enabled := True;
end;

procedure TFormVFonts.TimerFindTimer(Sender: TObject);
begin
     TimerFind.Enabled := False;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.ResetEditFind;
begin
     EditFind.OnChange:= nil;
     EditFind.Text := '';
     EditFind.OnChange:= EditFindChange;
end;

procedure TFormVFonts.cbSampleClick(Sender: TObject);
begin
     FStop := True;
     EditFind.SetFocus;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.NameButtonClick(Sender: TObject);
begin
     FStop := True;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.NbrButtonClick(Sender: TObject);
begin
     FStop := True;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.cbCharSetClick(Sender: TObject);
begin
     FStop := True;
     EditFind.SetFocus;
     ApplyButtonClick(nil);
end;

procedure TFormVFonts.PopupMenuPopup(Sender: TObject);
begin
     // Pour Couper
     Couper.Enabled := RichEditRendu.SelLength > 0;

     // Pour Copier
     Copier.Enabled := RichEditRendu.SelLength > 0;

     // Pour Coller
     Coller.Enabled := Clipboard.HasFormat(CF_TEXT) and (Length(Clipboard.AsText)>0);

     // Pour Gras
     Gras.Checked := (fsBold in RichEditRendu.SelAttributes.Style);

     // Pour Italique
     Italique.Checked := fsItalic in RichEditRendu.SelAttributes.Style;

     // Pour souligné
     Souligne.Checked := fsUnderline in RichEditRendu.SelAttributes.Style;

     // Biffe
     Biffe.Checked := fsStrikeOut in RichEditRendu.SelAttributes.Style;
end;

procedure TFormVFonts.CollerClick(Sender: TObject);
begin
     RichEditRendu.PasteFromClipboard;
end;

procedure TFormVFonts.CopierClick(Sender: TObject);
begin
     RichEditRendu.CopyToClipboard;
end;

procedure TFormVFonts.CouperClick(Sender: TObject);
begin
     RichEditRendu.CutToClipboard;
end;

procedure TFormVFonts.GrasClick(Sender: TObject);
begin
     if Gras.Checked then RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style - [fsBold]
     else RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style + [fsBold];
end;

procedure TFormVFonts.ItaliqueClick(Sender: TObject);
begin
     if Italique.Checked then RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style - [fsItalic]
     else RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style + [fsItalic];
end;

procedure TFormVFonts.SouligneClick(Sender: TObject);
begin
     if Souligne.Checked then RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style - [fsUnderline]
     else RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style + [fsUnderline];
end;

procedure TFormVFonts.BiffeClick(Sender: TObject);
begin
     if Biffe.Checked then RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style - [fsStrikeOut]
     else RichEditRendu.SelAttributes.Style := RichEditRendu.SelAttributes.Style + [fsStrikeOut];
end;

procedure TFormVFonts.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (key = VK_F1) then
     begin
          ToggleRichEdit;
     end;
end;

procedure TFormVFonts.SpeedButton1Click(Sender: TObject);
var
     h:Hwnd;
begin
     h := FindWindow(PAnsiChar('MyDlgClass'),PAnsiChar('Table des caractères') );
     // renvoie le Handle de la première fenêtre de Class (type) ClassName (0 s'il n'y en a pas)/

     // Une instance existante trouvée
     if h <> 0 then
       begin
         ShowWindow(h, SW_RESTORE);
         SetForegroundWindow(h);
       end
     else // Première création
     begin
        if WinExec('charmap.exe',SW_SHOW) < 32 // Lance la table des caractères
        then Application.MessageBox('Impossible d''exécuter le programme CHARMAP.EXE','Erreur',mb_IconStop+mb_Ok);
     end;
     ApplyButton.SetFocus;
end;

procedure TFormVFonts.sbAideClick(Sender: TObject);
begin
     RichEditHelp.Visible := sbAide.Down;
     RichEditHelp.Refresh;
     UpdateStatusBarPanel1;
end;

procedure TFormVFonts.ToggleRichEdit;
begin
     sbAide.Down := not sbAide.Down;
     UpdateStatusBarPanel1;
     sbAideClick(nil);
end;

procedure TFormVFonts.UpdateStatusBarPanel1;
begin
     Case sbAide.Down of
     True  : StatusBar.Panels[1].Text := '[AIDE]';
     False : StatusBar.Panels[1].Text := '[F1] pour l''aide';
     end;
end;

procedure TFormVFonts.EditFindKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     Case Key of
     VK_UP   : FontListMove(-1);
     VK_DOWN : FontListMove(1);
     end;
end;

procedure TFormVFonts.FontListMove(Step:integer);
begin
     if (Length(EditFind.Text) > 0) then Exit;
     if (FontList.SelCount < 0) or (FontList.SelCount > 1) Then Exit;
     if (Step=0) or ((Step <-1) and (Step>1))
     then Raise ERangeError.CreateFmt('FontListMove : Step n''est pas dans l''ensemble [-1,1] : %d',[Step]);

     FontList.Selected[FontList.ItemIndex]:=False;
     FontList.ItemIndex := FontList.ItemIndex+Step;
     FontList.Selected[FontList.ItemIndex]:=True;
     FontListClick(nil);
end;

procedure TFormVFonts.EnregristrercetteslectionsousClick(Sender: TObject);
begin
     // L'utilisateur doit choisir s'il veut créer un nouveau nom pour la sélection ou
     // s'il veut en créer une nouvelle
     if not Assigned(FormEnregSel) then FormEnregSel:= TFormEnregSel.Create(nil);
     try
        FormEnregSel.ShowModal;
        if FormEnregSel.ModalResult = mrOk then
        begin
             if Length(FormEnregSel.EditNouveauNom.Text) > 0 then
             begin
                  // C'est un nouveau nom valide
                  AddNewSelection(FormEnregSel.SelectionName,True);
             end
             else
             begin
                  // L'utilisateur souhaite remplacer une sélection existante
                  ReplaceSelection(FormEnregSel.SelectionName);
             end;
             UpdateAffichages;
        end;
     finally
            FormEnregSel.Free;
            FormEnregSel := nil;
     end;
end;

procedure TFormVFonts.SupprimerlaslectionClick(Sender: TObject);
begin
     if MessageDlg('Êtes-vous sûr de vouloir supprimer la sélection mémorisée <'+cbSel.Items[cbSel.ItemIndex]+'> ?',
                    mtConfirmation, [mbCancel,mbOk],0) = mrOk then
     begin
          DeleteSelection(cbSel.ItemIndex);
          UpdateAffichages;
     end;
end;

procedure TFormVFonts.DeleteSelection(IdxSel:integer);
begin
     FIniFile.EraseSection(cbSel.Items[IdxSel]);
     TList(cbSel.Items.Objects[IdxSel]).Free;
     cbSel.Items.Delete(IdxSel);
end;

procedure TFormVFonts.pmSelPopup(Sender: TObject);
begin
     AjoutePol.Enabled := (cbSel.Items.Count>0) and (FontList.SelCount > 0) and (FontList.SelCount < FontList.Count);
     if FontList.SelCount=1
     then AjoutePol.Caption := 'Ajouter cette police à une sélection déjà existante...'
     else AjoutePol.Caption := 'Ajouter ces polices à une sélection déjà existante...';

     Enregristrercetteslectionsous.Enabled := (FontList.SelCount > 0) and (FontList.SelCount < FontList.Count);

     Supprimerlaslection.Enabled := (cbSel.ItemIndex>-1) and (cbSel.Items.Count > 0);

     SupprPolicesDeSel.Enabled := (cbSel.Items.Count>0) and (cbSel.ItemIndex=-1) and (FontList.SelCount > 0) and (FontList.SelCount < FontList.Count);
     if FontList.SelCount=1
     then SupprPolicesDeSel.Caption := 'Retirer cette police d''une sélection mémorisée...'
     else SupprPolicesDeSel.Caption := 'Retirer ces polices d''une sélection mémorisée...'
end;

procedure TFormVFonts.FormDestroy(Sender: TObject);
var
     i:integer;
begin
     for i:=0 to cbSel.Items.Count-1 do
     begin
          TList(cbSel.Items.Objects[i]).Free;
     end;
     FIniFile.Free;
end;

procedure TFormVFonts.AddNewSelection(SelName:string;IsAfterMessage:boolean);
var
     i, NbPol : Cardinal;
     List : TList;
begin
     List := TList.Create;
     NbPol := 0;
     for i:=0 to FontList.Count-1 do
     begin
          if FontList.Selected[i] then
          begin
               Inc(NbPol);
               FiniFile.WriteString(SelName,IntToStr(NbPol),FontList.Items[i]);
               List.Add(Pointer(i));
          end;
     end;
     cbSel.Items.AddObject(SelName,List);
     cbSel.ItemIndex := cbSel.Items.Count-1;
     if IsAfterMessage then
     begin
          if NbPol = 1
          then SayStatus(IntToStr(NbPol)+' police mémorisée dans la sélection '+SelName)
          else SayStatus(IntToStr(NbPol)+' polices mémorisées dans la sélection '+SelName);
     end;
end;

procedure TFormVFonts.ReplaceSelection(SelName:string);
var
     n, i, NbPol : Cardinal;
     Pre_n : integer;// Pour préserver la nature de cardinal de n, compatible avec Pointer
     List : TList;
begin
     Pre_n := cbSel.Items.IndexOf(SelName);
     if (Pre_n = -1) then Raise Exception.Create('Erreur de programmation dans TFormVFonts.UpdateSelection(SelName:string)');
     n := Pre_n;
     List := TList(cbSel.Items.Objects[n]);
     List.Clear;
     FiniFile.EraseSection(SelName);
     NbPol := 0;
     for i:=0 to FontList.Count-1 do
     begin
          if FontList.Selected[i] then
          begin
               Inc(NbPol);
               FiniFile.WriteString(SelName,IntToStr(NbPol),FontList.Items[i]);
               List.Add(Pointer(i));
          end;
     end;
     cbSel.ItemIndex := n;
     if NbPol = 1
     then SayStatus(IntToStr(NbPol)+' police mémorisée dans la sélection '+SelName)
     else SayStatus(IntToStr(NbPol)+' polices mémorisées dans la sélection '+SelName);
end;

procedure TFormVFonts.SayStatus(aText:string);
begin
     StatusBar.Panels[0].Text := ' ' + aText;
     StatusBar.Refresh;
     // On repart à 0 dans le cas où le timer serait déjà en marche
     if TimerStatusBar.Enabled then TimerStatusBar.Enabled := False;
     TimerStatusBar.Enabled := True;
end;


procedure TFormVFonts.TimerStatusBarTimer(Sender: TObject);
begin
     StatusBar.Panels[0].Text := '';
     StatusBar.Refresh;
end;

procedure TFormVFonts.EditFindKeyPress(Sender: TObject; var Key: Char);
begin
     if Key =Chr(VK_RETURN) then
     begin
          EditFind.Text := '';
          UpdateAffichages;
          Key := Chr(0);
       end;
end;

procedure TFormVFonts.cbSelClick(Sender: TObject);
var
     List:TList;
     i : integer;
begin
     ResetEditFind;
     FontList.ClearSelection;
     List := TList(cbSel.Items.Objects[cbSel.ItemIndex]);
     for i:=0 to List.Count-1 do
     begin
          FontList.Selected[Cardinal(List[i])] := True;
     end;
     ApplyButtonClick(nil);
     UpdateAffichages;
end;

procedure TFormVFonts.ResetCbSel;
begin
     cbSel.ItemIndex := -1;
     cbSel.Repaint;
end;

procedure TFormVFonts.AddFontsToSel(aSel:string;IdxSel:integer);
var
     i, NbAdd : integer;
     List : TList;
     Chaine : string;
begin
     NbAdd := 0;
     List := TList(cbSel.Items.Objects[IdxSel]);
     for i:=0 to FontList.Count-1 do
     begin
          if FontList.Selected[i] then
          begin
               if List.IndexOf(Pointer(Cardinal(i))) = -1 then
               begin
                    // C'est que la police n'est pas encore dans cette sélection
                    Inc(NbAdd);
                    List.Add(Pointer(Cardinal(i)));
                    FIniFile.WriteString(aSel,IntToStr(List.Count),FontList.Items[i]);
               end;
          end;
     end;
     if NbAdd = 0 then
     begin
          if FontList.SelCount = 1 then
          begin
               MessageDlg('La police sélectionnée n''a été ajoutée dans la sélection <'+aSel+'>'#13 +
                          'car celle-ci est déjà présente dans cette sélection.',mtInformation,[mbOk],0)
          end
          else
          begin
               MessageDlg('Aucune des polices sélectionnées n''a été ajoutée dans la sélection <'+aSel+'>'#13 +
                          'car celles-ci sont déjà présentes dans cette sélection.',mtInformation,[mbOk],0)
          end;
     end
     else
     begin
          if FontList.SelCount > 1
          then Chaine := ' polices sélectionnées.'
          else Chaine := ' police sélectionnée.';
          if NbAdd = 1 then
          begin
               MessageDlg('1 police a été ajoutée à la sélection <'+aSel+'> '+
                          'sur un total de '+IntToStr(FontList.SelCount)+Chaine, mtInformation, [mbOk], 0);
          end
          else
          begin
               MessageDlg(IntToStr(NbAdd)+' polices ont été ajoutées à la sélection <'+aSel+'> '+
                          'sur un total de '+IntToStr(FontList.SelCount)+Chaine, mtInformation, [mbOk], 0)
          end;
     end;
end;

procedure TFormVFonts.AjoutePolClick(Sender: TObject);
begin
     if not Assigned(FormAjoutSuppr) then FormAjoutSuppr:=TFormAjoutSuppr.Create(nil);
     try
        FormAjoutSuppr.Caption := RightStr(AjoutePol.Caption,Length(AjoutePol.Caption)-1);
        FormAjoutSuppr.LabelSel.Caption := 'Dans la sélection :';
        FormAjoutSuppr.ShowModal;
        if FormAjoutSuppr.ModalResult = mrOk then
        begin
             AddFontsToSel(FormAjoutSuppr.SelectionName,FormAjoutSuppr.SelectionIndex);
             UpdateAffichages;
        end;
     finally
          FormAjoutSuppr.Free;
          FormAjoutSuppr := nil;
     end;
end;

procedure TFormVFonts.SupprPolicesDeSelClick(Sender: TObject);
begin
     if not Assigned(FormAjoutSuppr) then FormAjoutSuppr:=TFormAjoutSuppr.Create(nil);
     try
        FormAjoutSuppr.Caption := RightStr(SupprPolicesDeSel.Caption,Length(SupprPolicesDeSel.Caption)-1);
        FormAjoutSuppr.LabelSel.Caption := 'De la sélection :';
        FormAjoutSuppr.ShowModal;
        if FormAjoutSuppr.ModalResult = mrOk then
        begin
             RemoveFontsToSel(FormAjoutSuppr.SelectionName,FormAjoutSuppr.SelectionIndex);
        end;
        UpdateAffichages;
     finally
          FormAjoutSuppr.Free;
          FormAjoutSuppr := nil;
     end;
end;

procedure TFormVFonts.RemoveFontsToSel(aSel:string;IdxSel:integer);
var
     i, NbSuppr, IdxToRemove : integer;
     List : TList;
     Chaine, ChaineFin : string;
begin
     NbSuppr := 0;
     List := TList(cbSel.Items.Objects[IdxSel]);
     for i:=0 to FontList.Count-1 do
     begin
          if FontList.Selected[i] then
          begin
               IdxToRemove := List.IndexOf(Pointer(Cardinal(i)));
               if IdxToRemove > -1 then
               begin
                    // C'est que la police a bien été dans cette sélection
                    Inc(NbSuppr);
                    List.Delete(IdxToRemove);
                    // Contrairement à l'ajout, on ne peut pas détruire la référence
                    // dans le fichier .INI ici.
               end;
          end;
     end;
     if NbSuppr = 0 then
     begin
          if FontList.SelCount = 1 then
          begin
               MessageDlg('La police sélectionnée n''a pas été retirée de la sélection <'+aSel+'>'#13 +
                          'car cette police n''appartient pas à cette sélection.',mtInformation,[mbOk],0);
          end
          else
          begin
               MessageDlg('Aucune des polices sélectionnées n''ont été retirées de la sélection <'+aSel+'>'#13 +
                          'car celles-ci n''appartiennent pas à cette sélection.',mtInformation,[mbOk],0);
          end;
     end
     else
     begin
          ChaineFin := '';
          // On ne peut pas utiliser les indexes ici, à cause de leur volatilité
          // durant l'exécution, due aux possibles remaniements demandés par l'utilisateur,
          // et on est OBLIGÉ de regénérer entièrement la liste dur le disque pour cette sélection
          FIniFile.EraseSection(aSel);
          if List.Count > 0 then
          begin
               for i:=0 to List.Count-1 do
               begin
                    FiniFile.WriteString(aSel,IntToStr(i+1),FontList.Items[Cardinal(List.Items[i])]);
               end;
          end
          else
          begin
               // On détruit la liste qui est vide (il ne reste plus de polices après la suppression demandée)
               // et on retire la sélection devenue vide
               TList(cbSel.Items.Objects[IdxSel]).Free;
               cbSel.Items.Delete(IdxSel);
               ChaineFin := #13#13'==> Comme il ne reste désormais plus aucune police dans cette sélection, celle-ci a été supprimée définitivement.';
          end;

          if FontList.SelCount > 1
          then Chaine := ' polices sélectionnées.'
          else Chaine := ' police sélectionnée.';
          if NbSuppr = 1 then
          begin
               MessageDlg('1 police a été retirée de la sélection <'+aSel+'> '+
                          'sur un total de '+IntToStr(FontList.SelCount)+Chaine+ChaineFin, mtInformation, [mbOk], 0);
          end
          else
          begin
               MessageDlg(IntToStr(NbSuppr)+' polices ont été retirées de la sélection <'+aSel+'> '+
                          'sur un total de '+IntToStr(FontList.SelCount)+Chaine+ChaineFin, mtInformation, [mbOk], 0)
          end;
     end;
end;

end.
