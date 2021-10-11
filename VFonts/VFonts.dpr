program VFonts;

uses
  Forms,
  FMainVFonts in 'FMainVFonts.pas' {FormVFonts},
  FAPropos in 'FAPropos.pas' {FormAPropos},
  FEnregSel in 'FEnregSel.pas' {FormEnregSel},
  FAjoutSuppr in 'FAjoutSuppr.pas' {FormAjoutSuppr},
  Windows;

{$R *.RES}

begin
  Application.Title := 'VFonts';
  Application.CreateForm(TFormVFonts, FormVFonts);
  Application.Run;
end.
