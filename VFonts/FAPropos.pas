unit FAPropos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, URLLabel, StdCtrls, Buttons, jpeg;

type
  TFormAPropos = class(TForm)
    Label1: TLabel;
    LabelVersion: TLabel;
    ImageBlueMan: TImage;
    BitBtn1: TBitBtn;
    URLLabelBlueMan: TURLLabel;
    URLLabelOlivierCado: TURLLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    LabelDateVersion: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormAPropos: TFormAPropos;

implementation

{$R *.dfm}

procedure TFormAPropos.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if (key = Chr(VK_ESCAPE)) then
     begin
          Key := Chr(0);
          Close;
     end;
end;

end.
