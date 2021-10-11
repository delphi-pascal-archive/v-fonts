unit FAjoutSuppr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, FMainVFonts;

type
  TFormAjoutSuppr = class(TForm)
    Bevel1: TBevel;
    LabelSel: TLabel;
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    cbSel: TComboBox;
    procedure BitBtnOKClick(Sender: TObject);
    procedure cbSelChange(Sender: TObject);
    procedure cbSelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

    SelectionName : string;
    SelectionIndex : integer;

    procedure DetermineBitBtnOKState;
    
  end;

var
  FormAjoutSuppr: TFormAjoutSuppr;

implementation

{$R *.dfm}

procedure TFormAjoutSuppr.FormShow(Sender: TObject);
begin
     cbSel.Clear;
     cbSel.Items.Assign(FormVFonts.cbSel.Items);
     if cbSel.Items.Count = 1
     then cbSel.ItemIndex := 0
     else cbSel.ItemIndex := -1;
     cbSelChange(nil);
end;

procedure TFormAjoutSuppr.cbSelClick(Sender: TObject);
begin
     DetermineBitBtnOKState;
end;

procedure TFormAjoutSuppr.DetermineBitBtnOKState;
begin
     BitBtnOK.Enabled := (cbSel.ItemIndex > -1);
end;

procedure TFormAjoutSuppr.cbSelChange(Sender: TObject);
begin
     DetermineBitBtnOKState;
end;

procedure TFormAjoutSuppr.BitBtnOKClick(Sender: TObject);
begin
     SelectionName := cbSel.Items[cbSel.ItemIndex];
     SelectionIndex := cbSel.ItemIndex;
     Close;
     FormAjoutSuppr.ModalResult := mrOk;
end;

end.
