unit FEnregSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, FMainVFonts;

type
  TFormEnregSel = class(TForm)
    EditNouveauNom: TEdit;
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    Bevel1: TBevel;
    cbSel: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    LabelOU: TLabel;
    procedure BitBtnOKClick(Sender: TObject);
    procedure cbSelChange(Sender: TObject);
    procedure EditNouveauNomChange(Sender: TObject);
    procedure cbSelClick(Sender: TObject);
    procedure EditNouveauNomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }

    procedure DetermineBitBtnOKState;
    function CheckIfDoublons:boolean;

  public
    { Déclarations publiques }
    SelectionName : string;
  end;

var
  FormEnregSel: TFormEnregSel;

implementation

{$R *.dfm}

procedure TFormEnregSel.FormShow(Sender: TObject);
begin
     EditNouveauNom.Text := '';
     cbSel.Clear;
     cbSel.Items.Assign(FormVFonts.cbSel.Items);
     cbSel.ItemIndex := -1;
end;

procedure TFormEnregSel.EditNouveauNomClick(Sender: TObject);
begin
     cbSel.ItemIndex := -1;
     DetermineBitBtnOKState;
end;

procedure TFormEnregSel.cbSelClick(Sender: TObject);
begin
     EditNouveauNom.Text := '';
     DetermineBitBtnOKState;
end;

procedure TFormEnregSel.DetermineBitBtnOKState;
begin
     BitBtnOK.Enabled := (Length(EditNouveauNom.Text) > 0) xor (cbSel.ItemIndex > -1);
end;

procedure TFormEnregSel.EditNouveauNomChange(Sender: TObject);
begin
     DetermineBitBtnOKState;
end;

procedure TFormEnregSel.cbSelChange(Sender: TObject);
begin
     DetermineBitBtnOKState;
end;

procedure TFormEnregSel.BitBtnOKClick(Sender: TObject);
begin
     if not CheckIfDoublons then
     begin
          if cbSel.ItemIndex = -1
          then SelectionName := EditNouveauNom.Text
          else SelectionName := cbSel.Items[cbSel.ItemIndex];
          Close;
          FormEnregSel.ModalResult := mrOk;
     end
     else
     begin
          MessageDlg( 'Le nom "'+EditNouveauNom.Text+'" existe déjà dans la liste des sélections mémorisées.'#13#13+
                      'Veuillez entrer un nouveau nom.',mtWarning,[mbOk],0);
          EditNouveauNom.Text := '';
          EditNouveauNom.SetFocus;
     end;
end;

function TFormEnregSel.CheckIfDoublons:boolean;
var
     i:integer;
begin
     Result := False;
     for i:=0 to cbSel.Items.Count-1 do
     begin
          if UpperCase(EditNouveauNom.Text) = UpperCase(cbSel.Items[i]) then
          begin
               Result := True;
               Break;
          end;
     end;
end;

end.
